Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955883C89FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239897AbhGNRqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:46:31 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:39227 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbhGNRqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:46:30 -0400
Date:   Wed, 14 Jul 2021 17:43:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1626284615;
        bh=ghdzLw5nNk6WU4afMAbQyDVjIhUI3UOUgC9mmicHAps=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=OeOUsJJHvIwt85leWHkb0WaqziX+WiBxSfbv05PioOO/esW+XCFBeV87mxHgIdXEN
         pyb+uFMrLW0uJiETLqEOCCFOmz+u3z5hXE50b4gyo/8DfqpNBPwzCeQD+YaLZx4qo0
         ehiz1+gPIahEuF++9wEaTRiyPWBfOBQ9bZeGqicU=
To:     Michael Auchter <michael.auchter@ni.com>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH 1/2] extcon: usbc-tusb320: Add support for TUSB320L
Message-ID: <Tpxz1duGadcCGUuPx9JHqz3HwOY5B3viYWEP3jC1Kk@cp4-web-030.plabs.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TUSB320L is a newer chip with additional features. Add support for resettin=
g
and setting its and TUSB320's mode, and reset it during probe to make sure =
it starts in the
default mode (maintain mode according to PORT pin selection).

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/extcon/extcon-usbc-tusb320.c | 172 ++++++++++++++++++++++++---
 1 file changed, 156 insertions(+), 16 deletions(-)

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-u=
sbc-tusb320.c
index 805af73b4152..a6741eff60cc 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -13,21 +13,47 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
-
+=20
 #define TUSB320_REG9=09=09=09=090x9
 #define TUSB320_REG9_ATTACHED_STATE_SHIFT=096
 #define TUSB320_REG9_ATTACHED_STATE_MASK=090x3
 #define TUSB320_REG9_CABLE_DIRECTION=09=09BIT(5)
 #define TUSB320_REG9_INTERRUPT_STATUS=09=09BIT(4)
-#define TUSB320_ATTACHED_STATE_NONE=09=090x0
-#define TUSB320_ATTACHED_STATE_DFP=09=090x1
-#define TUSB320_ATTACHED_STATE_UFP=09=090x2
-#define TUSB320_ATTACHED_STATE_ACC=09=090x3
+
+#define TUSB320_REGA=09=09=09=090xa
+#define TUSB320L_REGA_DISABLE_TERM=09=09BIT(0)
+#define TUSB320_REGA_I2C_SOFT_RESET=09=09BIT(3)
+#define TUSB320_REGA_MODE_SELECT_SHIFT=09=094
+#define TUSB320_REGA_MODE_SELECT_MASK=09=090x3
+
+#define TUSB320L_REGA0_REVISION=09=09=090xa0
+
+enum tusb320_attached_state {
+=09TUSB320_ATTACHED_STATE_NONE,
+=09TUSB320_ATTACHED_STATE_DFP,
+=09TUSB320_ATTACHED_STATE_UFP,
+=09TUSB320_ATTACHED_STATE_ACC,
+};
+
+enum tusb320_mode {
+=09TUSB320_MODE_PORT,
+=09TUSB320_MODE_UFP,
+=09TUSB320_MODE_DFP,
+=09TUSB320_MODE_DRP,
+};
+
+enum tusb320_type {
+=09TYPE_TUSB320,
+=09TYPE_TUSB320L,
+};
=20
 struct tusb320_priv {
 =09struct device *dev;
 =09struct regmap *regmap;
+=09enum tusb320_type type;
 =09struct extcon_dev *edev;
+
+=09enum tusb320_attached_state state;
 };
=20
 static const char * const tusb_attached_states[] =3D {
@@ -37,6 +63,13 @@ static const char * const tusb_attached_states[] =3D {
 =09[TUSB320_ATTACHED_STATE_ACC]  =3D "accessory",
 };
=20
+static const char * const tusb_modes[] =3D {
+=09[TUSB320_MODE_PORT] =3D "maintain mode set by PORT pin",
+=09[TUSB320_MODE_UFP]  =3D "upstream facing port",
+=09[TUSB320_MODE_DFP]  =3D "downstream facing port",
+=09[TUSB320_MODE_DRP]  =3D "dual role port",
+};
+
 static const unsigned int tusb320_extcon_cable[] =3D {
 =09EXTCON_USB,
 =09EXTCON_USB_HOST,
@@ -62,26 +95,106 @@ static int tusb320_check_signature(struct tusb320_priv=
 *priv)
 =09return 0;
 }
=20
+static int tusb320_set_mode(struct tusb320_priv *priv, enum tusb320_mode m=
ode)
+{
+=09int ret;
+
+=09if(priv->type =3D=3D TYPE_TUSB320)
+=09=09goto write_mode;
+
+=09/* Disable CC state machine */
+=09ret =3D regmap_write_bits(priv->regmap, TUSB320_REGA,
+=09=09TUSB320L_REGA_DISABLE_TERM, 1);
+=09if(ret) {
+=09=09dev_err(priv->dev,
+=09=09=09"failed to disable CC state machine: %d\n", ret);
+=09=09return ret;
+=09}
+
+write_mode:
+=09/* Mode cannot be changed on TUSB320 while cable is attached */
+=09if(priv->type =3D=3D TYPE_TUSB320 && priv->state !=3D TUSB320_ATTACHED_=
STATE_NONE)
+=09=09return -EBUSY;
+
+=09/* Write mode */
+=09ret =3D regmap_write_bits(priv->regmap, TUSB320_REGA,
+=09=09TUSB320_REGA_MODE_SELECT_MASK << TUSB320_REGA_MODE_SELECT_SHIFT,
+=09=09mode << TUSB320_REGA_MODE_SELECT_SHIFT);
+=09if(ret) {
+=09=09dev_err(priv->dev, "failed to write mode: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09if(priv->type =3D=3D TYPE_TUSB320)
+=09=09return 0;
+
+=09msleep(5);
+
+=09/* Re-enable CC state machine */
+=09ret =3D regmap_write_bits(priv->regmap, TUSB320_REGA,
+=09=09TUSB320L_REGA_DISABLE_TERM, 0);
+=09if(ret) {
+=09=09dev_err(priv->dev,
+=09=09=09"failed to re-enable CC state machine: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09return 0;
+}
+
+static int tusb320_reset(struct tusb320_priv *priv)
+{
+=09int ret;
+
+=09/* Set mode to default (follow PORT pin) */
+=09ret =3D tusb320_set_mode(priv, TUSB320_MODE_PORT);
+=09if(ret && ret !=3D -EBUSY) {
+=09=09dev_err(priv->dev,
+=09=09=09"failed to set mode to PORT: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09/* Perform soft reset */
+=09ret =3D regmap_write_bits(priv->regmap, TUSB320_REGA,
+=09=09=09TUSB320_REGA_I2C_SOFT_RESET, 1);
+=09if(ret) {
+=09=09dev_err(priv->dev,
+=09=09=09"failed to write soft reset bit: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09return 0;
+}
+
 static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
 {
 =09struct tusb320_priv *priv =3D dev_id;
-=09int state, polarity;
-=09unsigned reg;
+=09int state, polarity, mode;
+=09unsigned reg9, rega;
=20
-=09if (regmap_read(priv->regmap, TUSB320_REG9, &reg)) {
-=09=09dev_err(priv->dev, "error during i2c read!\n");
+=09if (regmap_read(priv->regmap, TUSB320_REG9, &reg9)) {
+=09=09dev_err(priv->dev, "error during register 0x9 i2c read!\n");
 =09=09return IRQ_NONE;
 =09}
=20
-=09if (!(reg & TUSB320_REG9_INTERRUPT_STATUS))
+=09if (regmap_read(priv->regmap, TUSB320_REGA, &rega)) {
+=09=09dev_err(priv->dev, "error during register 0xa i2c read!\n");
 =09=09return IRQ_NONE;
+=09}
=20
-=09state =3D (reg >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
+=09if (!(reg9 & TUSB320_REG9_INTERRUPT_STATUS))
+=09=09return IRQ_NONE;
+
+=09state =3D (reg9 >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
 =09=09TUSB320_REG9_ATTACHED_STATE_MASK;
-=09polarity =3D !!(reg & TUSB320_REG9_CABLE_DIRECTION);
+=09polarity =3D !!(reg9 & TUSB320_REG9_CABLE_DIRECTION);
+
+=09mode =3D (rega >> TUSB320_REGA_MODE_SELECT_SHIFT) &
+=09=09TUSB320_REGA_MODE_SELECT_MASK;
=20
-=09dev_dbg(priv->dev, "attached state: %s, polarity: %d\n",
-=09=09tusb_attached_states[state], polarity);
+=09dev_dbg(priv->dev, "mode: %s, attached state: %s, polarity: %d\n",
+=09=09tusb_modes[mode], tusb_attached_states[state], polarity);
=20
 =09extcon_set_state(priv->edev, EXTCON_USB,
 =09=09=09 state =3D=3D TUSB320_ATTACHED_STATE_UFP);
@@ -96,7 +209,10 @@ static irqreturn_t tusb320_irq_handler(int irq, void *d=
ev_id)
 =09extcon_sync(priv->edev, EXTCON_USB);
 =09extcon_sync(priv->edev, EXTCON_USB_HOST);
=20
-=09regmap_write(priv->regmap, TUSB320_REG9, reg);
+=09priv->state =3D state;
+
+=09regmap_write(priv->regmap, TUSB320_REG9, reg9);
+=09regmap_write(priv->regmap, TUSB320_REGA, rega);
=20
 =09return IRQ_HANDLED;
 }
@@ -110,6 +226,8 @@ static int tusb320_extcon_probe(struct i2c_client *clie=
nt,
 =09=09=09=09const struct i2c_device_id *id)
 {
 =09struct tusb320_priv *priv;
+=09const void *match_data;
+=09unsigned int revision;
 =09int ret;
=20
 =09priv =3D devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
@@ -125,6 +243,22 @@ static int tusb320_extcon_probe(struct i2c_client *cli=
ent,
 =09if (ret)
 =09=09return ret;
=20
+=09match_data =3D device_get_match_data(&client->dev);
+=09if (!match_data)
+=09=09return -EINVAL;
+
+=09priv->type =3D (enum tusb320_type)match_data;
+
+=09if(priv->type =3D=3D TYPE_TUSB320L) {
+=09=09ret =3D regmap_read(priv->regmap, TUSB320L_REGA0_REVISION, &revision=
);
+
+=09=09if(ret < 0)
+=09=09=09dev_warn(priv->dev,
+=09=09=09=09"failed to read revision register: %d\n", ret);
+=09=09else
+=09=09=09dev_info(priv->dev, "chip revision %d\n", revision);
+=09}
+
 =09priv->edev =3D devm_extcon_dev_allocate(priv->dev, tusb320_extcon_cable=
);
 =09if (IS_ERR(priv->edev)) {
 =09=09dev_err(priv->dev, "failed to allocate extcon device\n");
@@ -137,6 +271,11 @@ static int tusb320_extcon_probe(struct i2c_client *cli=
ent,
 =09=09return ret;
 =09}
=20
+=09/* Reset chip to its default state */
+=09ret =3D tusb320_reset(priv);
+=09if(ret)
+=09=09dev_warn(priv->dev, "failed to reset chip: %d\n", ret);
+
 =09extcon_set_property_capability(priv->edev, EXTCON_USB,
 =09=09=09=09       EXTCON_PROP_USB_TYPEC_POLARITY);
 =09extcon_set_property_capability(priv->edev, EXTCON_USB_HOST,
@@ -154,7 +293,8 @@ static int tusb320_extcon_probe(struct i2c_client *clie=
nt,
 }
=20
 static const struct of_device_id tusb320_extcon_dt_match[] =3D {
-=09{ .compatible =3D "ti,tusb320", },
+=09{ .compatible =3D "ti,tusb320", .data =3D (void *)TYPE_TUSB320, },
+=09{ .compatible =3D "ti,tusb320l", .data =3D (void *)TYPE_TUSB320L, },
 =09{ }
 };
 MODULE_DEVICE_TABLE(of, tusb320_extcon_dt_match);
--=20
2.32.0


