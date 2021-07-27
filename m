Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF4A3D7271
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 11:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbhG0J5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 05:57:11 -0400
Received: from mail-40140.protonmail.ch ([185.70.40.140]:12415 "EHLO
        mail-40140.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbhG0J5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 05:57:09 -0400
Date:   Tue, 27 Jul 2021 09:56:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1627379828;
        bh=UoFaFn7CI5LmCyhvpyEHHihYjSbBhepbsJvBI1oaf/A=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=JFwiLbAdB7CjM/zdSlFNgpVcLw3tT0DGmaa/0DfpX5S0r6V6mGiYlIqP7XkjEZu32
         tY90wRdMuYyqtEwg0jN15om86yn9S9dg0UIQ6Zm37fjfGoDhASz14fop0yHxYsTP/W
         kAG/b7m7/za8nmg89jK8dZg+sR8tzuNj9pbLJ3ig=
To:     Michael Auchter <michael.auchter@ni.com>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v2 2/3] extcon: usbc-tusb320: Add support for TUSB320L
Message-ID: <W4cbBtSKsvNY8PoUe5j75MtKCqkxYop7f0WBuSsjnM@cp4-web-038.plabs.ch>
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

TUSB320L is a newer chip with additional features, and it has additional st=
eps
in its mode changing sequence:
 - Disable CC state machine,
 - Write to mode register,
 - Wait for 5 ms,
 - Re-enable CC state machine.
It also has an additional register that a revision number can be read from.

Add support for the mode changing sequence, and read the revision number du=
ring
probe and print it as info.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/extcon/extcon-usbc-tusb320.c | 61 +++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-u=
sbc-tusb320.c
index c8d931abbf9f..994c661bb675 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -21,10 +21,13 @@
 #define TUSB320_REG9_INTERRUPT_STATUS=09=09BIT(4)
=20
 #define TUSB320_REGA=09=09=09=090xa
+#define TUSB320L_REGA_DISABLE_TERM=09=09BIT(0)
 #define TUSB320_REGA_I2C_SOFT_RESET=09=09BIT(3)
 #define TUSB320_REGA_MODE_SELECT_SHIFT=09=094
 #define TUSB320_REGA_MODE_SELECT_MASK=09=090x3
=20
+#define TUSB320L_REGA0_REVISION=09=09=090xa0
+
 enum tusb320_attached_state {
 =09TUSB320_ATTACHED_STATE_NONE,
 =09TUSB320_ATTACHED_STATE_DFP,
@@ -39,9 +42,16 @@ enum tusb320_mode {
 =09TUSB320_MODE_DRP,
 };
=20
+enum tusb320_type {
+=09TYPE_TUSB320,
+=09TYPE_TUSB320L,
+};
+
+
 struct tusb320_priv {
 =09struct device *dev;
 =09struct regmap *regmap;
+=09enum tusb320_type type;
 =09struct extcon_dev *edev;
=20
 =09enum tusb320_attached_state state;
@@ -90,8 +100,19 @@ static int tusb320_set_mode(struct tusb320_priv *priv, =
enum tusb320_mode mode)
 {
 =09int ret;
=20
-=09/* Mode cannot be changed while cable is attached */
-=09if(priv->state !=3D TUSB320_ATTACHED_STATE_NONE)
+=09if(priv->type =3D=3D TYPE_TUSB320L) {
+=09=09/* Disable CC state machine */
+=09=09ret =3D regmap_write_bits(priv->regmap, TUSB320_REGA,
+=09=09=09TUSB320L_REGA_DISABLE_TERM, 1);
+=09=09if(ret) {
+=09=09=09dev_err(priv->dev,
+=09=09=09=09"failed to disable CC state machine: %d\n", ret);
+=09=09=09return ret;
+=09=09}
+=09}
+
+=09/* Mode cannot be changed on TUSB320 while cable is attached */
+=09if(priv->type =3D=3D TYPE_TUSB320 && priv->state !=3D TUSB320_ATTACHED_=
STATE_NONE)
 =09=09return -EBUSY;
=20
 =09/* Write mode */
@@ -100,10 +121,21 @@ static int tusb320_set_mode(struct tusb320_priv *priv=
, enum tusb320_mode mode)
 =09=09mode << TUSB320_REGA_MODE_SELECT_SHIFT);
 =09if(ret) {
 =09=09dev_err(priv->dev, "failed to write mode: %d\n", ret);
-=09=09return ret;
+=09=09goto err;
 =09}
=20
-=09return 0;
+=09msleep(5);
+err:
+=09if(priv->type =3D=3D TYPE_TUSB320L) {
+=09=09/* Re-enable CC state machine */
+=09=09ret =3D regmap_write_bits(priv->regmap, TUSB320_REGA,
+=09=09=09TUSB320L_REGA_DISABLE_TERM, 0);
+=09=09if(ret)
+=09=09=09dev_err(priv->dev,
+=09=09=09=09"failed to re-enable CC state machine: %d\n", ret);
+=09}
+
+=09return ret;
 }
=20
 static int tusb320_reset(struct tusb320_priv *priv)
@@ -188,6 +220,8 @@ static int tusb320_extcon_probe(struct i2c_client *clie=
nt,
 =09=09=09=09const struct i2c_device_id *id)
 {
 =09struct tusb320_priv *priv;
+=09const void *match_data;
+=09unsigned int revision;
 =09int ret;
=20
 =09priv =3D devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
@@ -203,12 +237,28 @@ static int tusb320_extcon_probe(struct i2c_client *cl=
ient,
 =09if (ret)
 =09=09return ret;
=20
+=09match_data =3D device_get_match_data(&client->dev);
+=09if (!match_data)
+=09=09return -EINVAL;
+
+=09priv->type =3D (enum tusb320_type)match_data;
+
 =09priv->edev =3D devm_extcon_dev_allocate(priv->dev, tusb320_extcon_cable=
);
 =09if (IS_ERR(priv->edev)) {
 =09=09dev_err(priv->dev, "failed to allocate extcon device\n");
 =09=09return PTR_ERR(priv->edev);
 =09}
=20
+=09if(priv->type =3D=3D TYPE_TUSB320L) {
+=09=09ret =3D regmap_read(priv->regmap, TUSB320L_REGA0_REVISION, &revision=
);
+
+=09=09if(ret)
+=09=09=09dev_warn(priv->dev,
+=09=09=09=09"failed to read revision register: %d\n", ret);
+=09=09else
+=09=09=09dev_info(priv->dev, "chip revision %d\n", revision);
+=09}
+
 =09ret =3D devm_extcon_dev_register(priv->dev, priv->edev);
 =09if (ret < 0) {
 =09=09dev_err(priv->dev, "failed to register extcon device\n");
@@ -237,7 +287,8 @@ static int tusb320_extcon_probe(struct i2c_client *clie=
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


