Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139743D726E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 11:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbhG0J4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 05:56:48 -0400
Received: from mail-4324.protonmail.ch ([185.70.43.24]:41223 "EHLO
        mail-4324.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbhG0J4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 05:56:47 -0400
Date:   Tue, 27 Jul 2021 09:56:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1627379805;
        bh=k+nXG6fksLIfF31Ks5JX5STD90M6/LH19lhVkQ2G9dE=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=XVPJNkOqSELQMQ5N2sEyaRM5D3JwCy8hl5Fn5Q9U0zmDvAMha3yYudr9yWZbFBIrs
         q+BDltB0vZW61Jjo4GoFbNeeDanwwsIzOaM5tpBWfFVLifCuGzIbwcSLOveZrYq1dK
         LWd+oQht7hD+kCc+DcTUu4D1MAS6avFW/0zWK0vg=
To:     Michael Auchter <michael.auchter@ni.com>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v2 1/3] extcon: usbc-tusb320: Add support for mode setting and reset
Message-ID: <Fz2Ehjftp2eVDCxfgd4j3TYcrmSf5ForizOdT7rngo@cp7-web-042.plabs.ch>
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

Reset the chip and set its mode to default (maintain mode set by PORT pin)
during probe to make sure it comes up in the default state.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/extcon/extcon-usbc-tusb320.c | 111 +++++++++++++++++++++++----
 1 file changed, 97 insertions(+), 14 deletions(-)

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-u=
sbc-tusb320.c
index 805af73b4152..c8d931abbf9f 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -19,15 +19,32 @@
 #define TUSB320_REG9_ATTACHED_STATE_MASK=090x3
 #define TUSB320_REG9_CABLE_DIRECTION=09=09BIT(5)
 #define TUSB320_REG9_INTERRUPT_STATUS=09=09BIT(4)
-#define TUSB320_ATTACHED_STATE_NONE=09=090x0
-#define TUSB320_ATTACHED_STATE_DFP=09=090x1
-#define TUSB320_ATTACHED_STATE_UFP=09=090x2
-#define TUSB320_ATTACHED_STATE_ACC=09=090x3
+
+#define TUSB320_REGA=09=09=09=090xa
+#define TUSB320_REGA_I2C_SOFT_RESET=09=09BIT(3)
+#define TUSB320_REGA_MODE_SELECT_SHIFT=09=094
+#define TUSB320_REGA_MODE_SELECT_MASK=09=090x3
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
=20
 struct tusb320_priv {
 =09struct device *dev;
 =09struct regmap *regmap;
 =09struct extcon_dev *edev;
+
+=09enum tusb320_attached_state state;
 };
=20
 static const char * const tusb_attached_states[] =3D {
@@ -37,6 +54,13 @@ static const char * const tusb_attached_states[] =3D {
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
@@ -62,26 +86,77 @@ static int tusb320_check_signature(struct tusb320_priv =
*priv)
 =09return 0;
 }
=20
+static int tusb320_set_mode(struct tusb320_priv *priv, enum tusb320_mode m=
ode)
+{
+=09int ret;
+
+=09/* Mode cannot be changed while cable is attached */
+=09if(priv->state !=3D TUSB320_ATTACHED_STATE_NONE)
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
+
+=09if (regmap_read(priv->regmap, TUSB320_REG9, &reg9)) {
+=09=09dev_err(priv->dev, "error during register 0x9 i2c read!\n");
+=09=09return IRQ_NONE;
+=09}
=20
-=09if (regmap_read(priv->regmap, TUSB320_REG9, &reg)) {
-=09=09dev_err(priv->dev, "error during i2c read!\n");
+=09if (regmap_read(priv->regmap, TUSB320_REGA, &rega)) {
+=09=09dev_err(priv->dev, "error during register 0xa i2c read!\n");
 =09=09return IRQ_NONE;
 =09}
=20
-=09if (!(reg & TUSB320_REG9_INTERRUPT_STATUS))
+=09if (!(reg9 & TUSB320_REG9_INTERRUPT_STATUS))
 =09=09return IRQ_NONE;
=20
-=09state =3D (reg >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
+=09state =3D (reg9 >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
 =09=09TUSB320_REG9_ATTACHED_STATE_MASK;
-=09polarity =3D !!(reg & TUSB320_REG9_CABLE_DIRECTION);
+=09polarity =3D !!(reg9 & TUSB320_REG9_CABLE_DIRECTION);
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
@@ -96,7 +171,10 @@ static irqreturn_t tusb320_irq_handler(int irq, void *d=
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
@@ -137,6 +215,11 @@ static int tusb320_extcon_probe(struct i2c_client *cli=
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
--=20
2.32.0


