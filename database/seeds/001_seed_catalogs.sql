USE portugues_app;

INSERT INTO levels (code,name,description,order_index) VALUES
('A1','A1 Iniciante','Fundamentos básicos',1),
('A2','A2 Básico','Expansión básica',2),
('B1','B1 Intermediário','Nivel intermedio',3),
('B2','B2 Intermediário avançado','Nivel intermedio alto',4);

INSERT INTO pronouns (code,display_name,person_number,sort_order) VALUES
('eu','eu','1s',1),
('tu','tu','2s',2),
('ele','ele/ela/você','3s',3),
('nos','nós','1p',4),
('vos','vós','2p',5),
('eles','eles/elas/vocês','3p',6);

INSERT INTO tenses (name,code,mood,level_id,description) VALUES
('Presente do Indicativo','presente_indicativo','indicativo',1,'Acciones actuales'),
('Pretérito Perfeito','preterito_perfeito','indicativo',2,'Acciones terminadas');