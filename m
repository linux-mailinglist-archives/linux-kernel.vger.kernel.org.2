Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEC9372D94
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 18:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhEDQIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 12:08:50 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:47771 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhEDQIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 12:08:50 -0400
Date:   Tue, 04 May 2021 16:07:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1620144473;
        bh=izMrQ29i9o8lR9msxy7VHUJ0aaa/lS+KxRCqJNJ4ZUE=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=gwexdwPe7LPbdOmPuDeoG6NiUzMDP2OJpjhIhq6Yf89xir95BgSQiYcQcEhfpZ67j
         bJdlpSHgL20cfyaqARoCum8VgdWG5fzXLh2yeVRsJ3cN6uGYbpF3+YEHNRUzbhpS9s
         YDJc9kv/kU2SXK6XGUkaQR3Vr0zgjOxAsYQTbohH0Ut+yXaBcZQ6tknfUCL0A1Xncd
         ec1ivs540D+nNk72VOBSp0wM6ZdyBd9Cyxh60cDtk/+A6SR19aa1vTMz8gaSEQdKzJ
         VX2phk8qNhhn1Digu5dZ4TeVmY3qAJPehmafJTAMskV54LSWfeObtvH1+s3kXvwyaP
         G5h5mMuGctLKQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH] staging: rtl8723bs: use generic kernel error codes
Message-ID: <c94e5865e59d35fe0e39d5cd46d71ad4a752ddd4.1620144194.git-series.hello@bryanbrattlof.com>
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

The current _FAIL and _SUCCESS error codes are defined as:

        #define _FAIL    0
=09#define _SUCCESS 1

which adds complexity (and confusion) when interacting with other
submodules in the kernel. These definitions can be removed and replaced
with the kernel's generic error codes.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h |  2 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/stagin=
g/rtl8723bs/include/drv_types.h
index 83d43e5726dd..5b702ff432ae 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -385,7 +385,7 @@ struct adapter {
 =09void *xmitThread;
 =09void *recvThread;

-=09u32 (*intf_init)(struct dvobj_priv *dvobj);
+=09int (*intf_init)(struct dvobj_priv *dvobj);
 =09void (*intf_deinit)(struct dvobj_priv *dvobj);
 =09int (*intf_alloc_irq)(struct dvobj_priv *dvobj);
 =09void (*intf_free_irq)(struct dvobj_priv *dvobj);
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging=
/rtl8723bs/os_dep/sdio_intf.c
index d2bf444117b8..e26c51d847b6 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -112,7 +112,7 @@ static void sdio_free_irq(struct dvobj_priv *dvobj)
 =09}
 }

-static u32 sdio_init(struct dvobj_priv *dvobj)
+static int sdio_init(struct dvobj_priv *dvobj)
 {
 =09struct sdio_data *psdio_data;
 =09struct sdio_func *func;
@@ -139,12 +139,11 @@ static u32 sdio_init(struct dvobj_priv *dvobj)
 =09psdio_data->tx_block_mode =3D 1;
 =09psdio_data->rx_block_mode =3D 1;

+=09return err;
+
 release:
 =09sdio_release_host(func);
-
-=09if (err)
-=09=09return _FAIL;
-=09return _SUCCESS;
+=09return err;
 }

 static void sdio_deinit(struct dvobj_priv *dvobj)
@@ -186,7 +185,7 @@ static struct dvobj_priv *sdio_dvobj_init(struct sdio_f=
unc *func)
 =09psdio =3D &dvobj->intf_data;
 =09psdio->func =3D func;

-=09if (sdio_init(dvobj) !=3D _SUCCESS)
+=09if (sdio_init(dvobj) < 0)
 =09=09goto free_dvobj;

 =09rtw_reset_continual_io_error(dvobj);

base-commit: 9ccce092fc64d19504fa54de4fd659e279cc92e7
--
git-series 0.9.1

