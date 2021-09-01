Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628DC3FDF8E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245149AbhIAQPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:15:36 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:39500 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245146AbhIAQPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:15:35 -0400
Date:   Wed, 01 Sep 2021 16:14:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630512846;
        bh=kZUkDeNVhDcdsiKcnexNEz0gr02E4umhFCmGn5kgRTk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=NkZMFPyYW3JnnzzA5RXXraIlyW/yvppHqHoi/6OZXv7HxtWTavOEQN5u8zYp/la1j
         s/WIuQPilZKXQnyT3j/f5erh5m7jsVX9bubTAR+pDkEDpxGMcg8DhJcqjVCH4z1gVq
         PRhRRfcF7nzIWI523prq+Vbs1qTS0J86VRXsNVks=
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Michael Auchter <michael.auchter@ni.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v4 1/3] extcon: usbc-tusb320: Add support for mode setting and reset
Message-ID: <20210901161339.223973-2-y.oudjana@protonmail.com>
In-Reply-To: <20210901161339.223973-1-y.oudjana@protonmail.com>
References: <20210901161339.223973-1-y.oudjana@protonmail.com>
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

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
Changes since v3:
 - Remove unused tusb_modes.
Changes since v2:
 - Read state before setting default mode, then update it again after reset=
ting.
 - Remove mode tracing from irq handler
 - Add a delay after reset to handle tSOFT_RESET
Changes since v1:
 - Split first patch into two patches, one adding support for mode setting =
and reset on TUSB320,
   and the other adding support for TUSB320L.

 drivers/extcon/extcon-usbc-tusb320.c | 85 ++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-u=
sbc-tusb320.c
index 805af73b4152..1ed1dfe54206 100644
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
@@ -62,6 +79,53 @@ static int tusb320_check_signature(struct tusb320_priv *=
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
@@ -96,6 +160,8 @@ static irqreturn_t tusb320_irq_handler(int irq, void *de=
v_id)
 =09extcon_sync(priv->edev, EXTCON_USB);
 =09extcon_sync(priv->edev, EXTCON_USB_HOST);
=20
+=09priv->state =3D state;
+
 =09regmap_write(priv->regmap, TUSB320_REG9, reg);
=20
 =09return IRQ_HANDLED;
@@ -145,6 +211,17 @@ static int tusb320_extcon_probe(struct i2c_client *cli=
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
2.33.0


