Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD0238F3DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 21:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhEXTyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 15:54:54 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:58625 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhEXTyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 15:54:53 -0400
Date:   Mon, 24 May 2021 19:53:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1621886002;
        bh=bXCt2Xvwh8yJ0dYvpXrjt8eMZ6cWK43qw/iY/SShco0=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=IHthz3IGDdIUnfD/BZARtKNxuirFU1sAN7gqt5+vOznPWOxY49HXj7AkDpWF7/x5c
         rYW6Aiv9diKoTUnB41z2ODHDDrRvu7MFvWL91DJYEJ/iQnbztINmnAAkSy/PH+gkXY
         FgGNrLOgLWjM73pdRvbUXPMOn1Q21KKTFV8WidOFTP1Mb2TYcdVtP89UeXCq1D6FRw
         Otr35NKue+RZ0PTdDGiE8hMIPlGQXgF2O0fpVchdxFyiKotumus+LN3CSKmDCeR1kC
         fcSSUp1Xlyxlrx9MNHSQmrKFJCoTFoXmIWl9voZP8djTbqn/pdvOaJBKOgKye7uH1h
         wMh5WQTtu6zZA==
To:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH] staging: rtl8723bs: remove sd_f0_read8()
Message-ID: <20210524195144.1943280-1-hello@bryanbrattlof.com>
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

The sd_f0_read8() function, which is used by the sdio_f0_read8()
function, are not used anywhere in the driver and both can be
safely removed.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c      |  7 -----
 drivers/staging/rtl8723bs/include/rtw_io.h    |  2 --
 .../rtl8723bs/include/sdio_ops_linux.h        |  2 --
 .../staging/rtl8723bs/os_dep/sdio_ops_linux.c | 28 -------------------
 4 files changed, 39 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl=
8723bs/hal/sdio_ops.c
index 196b2232c17d..2dd251ce177e 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -346,11 +346,6 @@ static s32 sdio_writeN(struct intf_hdl *intfhdl, u32 a=
ddr, u32 cnt, u8 *buf)
 =09return err;
 }

-static u8 sdio_f0_read8(struct intf_hdl *intfhdl, u32 addr)
-{
-=09return sd_f0_read8(intfhdl, addr, NULL);
-}
-
 static void sdio_read_mem(
 =09struct intf_hdl *intfhdl,
 =09u32 addr,
@@ -481,8 +476,6 @@ void sdio_set_intf_ops(struct adapter *adapter, struct =
_io_ops *ops)
 =09ops->_writeN =3D &sdio_writeN;
 =09ops->_write_mem =3D &sdio_write_mem;
 =09ops->_write_port =3D &sdio_write_port;
-
-=09ops->_sd_f0_read8 =3D sdio_f0_read8;
 }

 /*
diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/r=
tl8723bs/include/rtw_io.h
index ab3c5ffe011b..e98083a07a66 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -104,8 +104,6 @@ struct _io_ops {

 =09=09void (*_read_port_cancel)(struct intf_hdl *pintfhdl);
 =09=09void (*_write_port_cancel)(struct intf_hdl *pintfhdl);
-
-=09=09u8 (*_sd_f0_read8)(struct intf_hdl *pintfhdl, u32 addr);
 };

 struct io_req {
diff --git a/drivers/staging/rtl8723bs/include/sdio_ops_linux.h b/drivers/s=
taging/rtl8723bs/include/sdio_ops_linux.h
index 16a03adbc2cf..18830dd18372 100644
--- a/drivers/staging/rtl8723bs/include/sdio_ops_linux.h
+++ b/drivers/staging/rtl8723bs/include/sdio_ops_linux.h
@@ -11,8 +11,6 @@
 #define SDIO_ERR_VAL16=090xEAEA
 #define SDIO_ERR_VAL32=090xEAEAEAEA

-u8 sd_f0_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err);
-
 s32 _sd_cmd52_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata=
);
 s32 _sd_cmd52_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdat=
a);
 s32 sd_cmd52_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)=
;
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c b/drivers/st=
aging/rtl8723bs/os_dep/sdio_ops_linux.c
index 5cedf775b6ef..bed930760656 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
@@ -26,34 +26,6 @@ inline void rtw_sdio_set_irq_thd(struct dvobj_priv *dvob=
j, void *thd_hdl)
 =09sdio_data->sys_sdio_irq_thd =3D thd_hdl;
 }

-u8 sd_f0_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
-{
-=09struct adapter *padapter;
-=09struct dvobj_priv *psdiodev;
-=09struct sdio_data *psdio;
-
-=09u8 v =3D 0;
-=09struct sdio_func *func;
-=09bool claim_needed;
-
-=09padapter =3D pintfhdl->padapter;
-=09psdiodev =3D pintfhdl->pintf_dev;
-=09psdio =3D &psdiodev->intf_data;
-
-=09if (padapter->bSurpriseRemoved)
-=09=09return v;
-
-=09func =3D psdio->func;
-=09claim_needed =3D rtw_sdio_claim_host_needed(func);
-
-=09if (claim_needed)
-=09=09sdio_claim_host(func);
-=09v =3D sdio_f0_readb(func, addr, err);
-=09if (claim_needed)
-=09=09sdio_release_host(func);
-=09return v;
-}
-
 /*
  * Return:
  *0=09=09Success
--
2.27.0


