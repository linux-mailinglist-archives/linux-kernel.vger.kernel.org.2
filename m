Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC6D35F9FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351162AbhDNRjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:39:40 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:54505 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhDNRje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:39:34 -0400
Date:   Wed, 14 Apr 2021 17:39:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1618421951;
        bh=BTrwt4Py8YXtFw2ZFlV3iiTbqXa6G4CKZAeFPHvZZms=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=MnAv+BJ95v0qai0I4TSjKX4Em1PZBnT4XCUxPvUatFON7udnunMQ1adb0qhIqFI1B
         +iDVp9xXwuREAA8vKepwHLxD0udDVXlGhAcrkqqFLLJmYPpC0veaI1ykKK1osM1kna
         Bk4Vr78U9Qjs0MRbTEW7stIaxnqx+6Fxgtd68yYdSHDt4EzWqo8aivnofXexlt91Va
         jukfGfWRUJpZhXnri+QMzKrlfI2Pk8jEKUksDHcFGC4byD6Cis41U7Hluam2xRviZA
         JmmdZmp+tXiq8CfP0TvarjQ8rx9AgdhTui/INcSEHI8tQUzYMBCvgzzATxxPGUbN4w
         OenRlz1oO3TDQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Bryan Brattlof <hello@bryanbrattlof.com>
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH v2] staging: rtl8723bs: remove sdio_drv_priv structure
Message-ID: <20210414173751.317762-1-hello@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sdio_drv_priv structure is a small wrapper around sdio_driver in
linux/mmc/sdio_func.h with an added drv_registered integer.

drv_registered is never used anywhere in the driver and only assigned to
during the sdio registering and unregistering process. We can safely
remove sdio_drv_priv and use the sdio_driver structure directly.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
Changes from:
 v1 -> v2: rebased to current staging-next

 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 28 +++++++-------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging=
/rtl8723bs/os_dep/sdio_intf.c
index a9a9631dd23c..c235c47e735a 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -36,17 +36,12 @@ static const struct dev_pm_ops rtw_sdio_pm_ops =3D {
 =09.resume=09=3D rtw_sdio_resume,
 };
=20
-struct sdio_drv_priv {
-=09struct sdio_driver r871xs_drv;
-=09int drv_registered;
-};
-
-static struct sdio_drv_priv sdio_drvpriv =3D {
-=09.r871xs_drv.probe =3D rtw_drv_init,
-=09.r871xs_drv.remove =3D rtw_dev_remove,
-=09.r871xs_drv.name =3D "rtl8723bs",
-=09.r871xs_drv.id_table =3D sdio_ids,
-=09.r871xs_drv.drv =3D {
+static struct sdio_driver rtl8723bs_sdio_driver =3D {
+=09.probe =3D rtw_drv_init,
+=09.remove =3D rtw_dev_remove,
+=09.name =3D "rtl8723bs",
+=09.id_table =3D sdio_ids,
+=09.drv =3D {
 =09=09.pm =3D &rtw_sdio_pm_ops,
 =09}
 };
@@ -496,13 +491,10 @@ static int __init rtw_drv_entry(void)
 =09DBG_871X_LEVEL(_drv_always_, "rtl8723bs BT-Coex version =3D %s\n", BTCO=
EXVERSION);
 #endif /*  BTCOEXVERSION */
=20
-=09sdio_drvpriv.drv_registered =3D true;
=20
-=09ret =3D sdio_register_driver(&sdio_drvpriv.r871xs_drv);
-=09if (ret !=3D 0) {
-=09=09sdio_drvpriv.drv_registered =3D false;
+=09ret =3D sdio_register_driver(&rtl8723bs_sdio_driver);
+=09if (ret !=3D 0)
 =09=09rtw_ndev_notifier_unregister();
-=09}
=20
 =09DBG_871X_LEVEL(_drv_always_, "module init ret =3D%d\n", ret);
 =09return ret;
@@ -512,9 +504,7 @@ static void __exit rtw_drv_halt(void)
 {
 =09DBG_871X_LEVEL(_drv_always_, "module exit start\n");
=20
-=09sdio_drvpriv.drv_registered =3D false;
-
-=09sdio_unregister_driver(&sdio_drvpriv.r871xs_drv);
+=09sdio_unregister_driver(&rtl8723bs_sdio_driver);
=20
 =09rtw_ndev_notifier_unregister();
=20
--=20
2.27.0


