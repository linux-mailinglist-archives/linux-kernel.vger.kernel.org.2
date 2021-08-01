Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3347F3DCB04
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 12:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhHAKH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 06:07:26 -0400
Received: from mail-4325.protonmail.ch ([185.70.43.25]:17119 "EHLO
        mail-4325.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhHAKHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 06:07:25 -0400
Date:   Sun, 01 Aug 2021 10:07:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1627812435;
        bh=jXKkzmZpopMrfwdn/qitIFnaNpqFQxbDy1ioD8KKHc4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=YEe6dcScz4EUN+91FEecKmk7Yvcr3se2Q8q5LqVXV8CPBuW/F+kiKX2qJWdBNxDT6
         0efw1n0YgG0QH6IgjG1tzX5ZSc1XQgMsNjwrdZ0wvKPhQmPupMLyFoVK1+IAjT9lD9
         ArmcCRtetiTrmlRuik67tpImiLBfrmsSC0cSw48Q=
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Michael Auchter <michael.auchter@ni.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v3 1/3] extcon: usbc-tusb320: Add support for mode setting and reset
Message-ID: <20210801100519.440574-2-y.oudjana@protonmail.com>
In-Reply-To: <20210801100519.440574-1-y.oudjana@protonmail.com>
References: <20210801100519.440574-1-y.oudjana@protonmail.com>
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

Changes since v2:
 - Read state before setting default mode, then update it again after reset=
ting.
 - Remove mode tracing from irq handler
 - Add a delay after reset to handle tSOFT_RESET

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/extcon/extcon-usbc-tusb320.c | 92 ++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-u=
sbc-tusb320.c
index 805af73b4152..867fb2bf2bdc 100644
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
@@ -62,6 +86,53 @@ static int tusb320_check_signature(struct tusb320_priv *=
priv)
 =09return 0;
 }
=20
+static int tusb320_set_mode(struct tusb320_priv *priv, enum tusb320_mode m=
ode)
+{
+=09int ret;
+
+=09/* Mode cannot be changed while cable is attached */
+=09if (priv->state !=3D TUSB320_ATTACHED_STATE_NONE)
+=09=09return -EBUSY;
+
+=09/* Write mode */
+=09ret =3D regmap_write_bits(priv->regmap, TUSB320_REGA,
+=09=09TUSB320_REGA_MODE_SELECT_MASK << TUSB320_REGA_MODE_SELECT_SHIFT,
+=09=09mode << TUSB320_REGA_MODE_SELECT_SHIFT);
+=09if (ret) {
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
+=09if (ret && ret !=3D -EBUSY) {
+=09=09dev_err(priv->dev,
+=09=09=09"failed to set mode to PORT: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09/* Perform soft reset */
+=09ret =3D regmap_write_bits(priv->regmap, TUSB320_REGA,
+=09=09=09TUSB320_REGA_I2C_SOFT_RESET, 1);
+=09if (ret) {
+=09=09dev_err(priv->dev,
+=09=09=09"failed to write soft reset bit: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09/* Wait for chip to go through reset */
+=09msleep(95);
+
+=09return 0;
+}
+
 static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
 {
 =09struct tusb320_priv *priv =3D dev_id;
@@ -96,6 +167,8 @@ static irqreturn_t tusb320_irq_handler(int irq, void *de=
v_id)
 =09extcon_sync(priv->edev, EXTCON_USB);
 =09extcon_sync(priv->edev, EXTCON_USB_HOST);
=20
+=09priv->state =3D state;
+
 =09regmap_write(priv->regmap, TUSB320_REG9, reg);
=20
 =09return IRQ_HANDLED;
@@ -145,6 +218,17 @@ static int tusb320_extcon_probe(struct i2c_client *cli=
ent,
 =09/* update initial state */
 =09tusb320_irq_handler(client->irq, priv);
=20
+=09/* Reset chip to its default state */
+=09ret =3D tusb320_reset(priv);
+=09if (ret)
+=09=09dev_warn(priv->dev, "failed to reset chip: %d\n", ret);
+=09else
+=09=09/*
+=09=09 * State and polarity might change after a reset, so update
+=09=09 * them again and make sure the interrupt status bit is cleared.
+=09=09 */
+=09=09tusb320_irq_handler(client->irq, priv);
+
 =09ret =3D devm_request_threaded_irq(priv->dev, client->irq, NULL,
 =09=09=09=09=09tusb320_irq_handler,
 =09=09=09=09=09IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
--=20
2.32.0


