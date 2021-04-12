Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5463335CED2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 18:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343623AbhDLQt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 12:49:58 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:46671 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343845AbhDLQoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 12:44:22 -0400
Date:   Mon, 12 Apr 2021 16:43:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1618245841;
        bh=ulTTUCXOpo0fssqFzQfBnBrBbtR/MokXSuII90+RuVc=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=ol6tJ8AmtDDvJIkrKbmLFFWLZbjb5TMqNfc90hk+lUJ9nN48tmBVtYne0kFf5ihna
         fMaEPL38jbKqzQD3uzLu6oL5hem3Nsh9+7SWMXgPcDHCVIYhtqrv2iq0hI10mCvQqX
         UbJ5fW/zR8Zfe5a4LZigQTDJTVHgOcfDIhVRAlje1TKCKLBSQZLU9k+G8B47Q8er4x
         JOMPdwJHhQVxppX+Qku6jEVamFZecDbyrn/7SA+V3ZQngibcvwxxfZtgKo/geB5KqB
         WHdxk87Mn8ky47UFKwPZVNF8vj1lEPZM9UcN1zfx810Ij9MAAn6saosHKSAxHqMum3
         1RB6GqWvVnYmA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Bryan Brattlof <hello@bryanbrattlof.com>
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH v2] staging: rtl8723bs: remove unnecessary adapter
Message-ID: <20210412163650.42467-1-hello@bryanbrattlof.com>
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

The if2 adapter is defined in rtw_dvr_init() and in the dvobj_priv
structure but never used anywhere in the driver. This will remove all
definitions of if2

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h |  1 -
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  | 10 ++++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/stagin=
g/rtl8723bs/include/drv_types.h
index 19da27fb5ddf..bf3de9a78f16 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -268,7 +268,6 @@ struct cam_entry_cache {
 struct dvobj_priv {
 =09/*-------- below is common data --------*/
 =09struct adapter *if1; /* PRIMARY_ADAPTER */
-=09struct adapter *if2; /* SECONDARY_ADAPTER */
=20
 =09s32=09processing_dev_remove;
=20
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging=
/rtl8723bs/os_dep/sdio_intf.c
index 7090c1b3cc2f..a9a9631dd23c 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -369,7 +369,7 @@ static int rtw_drv_init(
 =09const struct sdio_device_id *id)
 {
 =09int status =3D _FAIL;
-=09struct adapter *if1 =3D NULL, *if2 =3D NULL;
+=09struct adapter *if1 =3D NULL;
 =09struct dvobj_priv *dvobj;
=20
 =09dvobj =3D sdio_dvobj_init(func);
@@ -383,17 +383,15 @@ static int rtw_drv_init(
 =09/* dev_alloc_name && register_netdev */
 =09status =3D rtw_drv_register_netdev(if1);
 =09if (status !=3D _SUCCESS)
-=09=09goto free_if2;
+=09=09goto free_if1;
=20
 =09if (sdio_alloc_irq(dvobj) !=3D _SUCCESS)
-=09=09goto free_if2;
+=09=09goto free_if1;
=20
 =09rtw_ndev_notifier_register();
 =09status =3D _SUCCESS;
=20
-free_if2:
-=09if (status !=3D _SUCCESS && if2) {
-=09}
+free_if1:
 =09if (status !=3D _SUCCESS && if1)
 =09=09rtw_sdio_if1_deinit(if1);
=20
--=20
2.27.0


