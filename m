Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F45F3F418D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 22:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhHVUoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 16:44:14 -0400
Received: from mail-4317.protonmail.ch ([185.70.43.17]:55412 "EHLO
        mail-4317.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhHVUoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 16:44:13 -0400
X-Greylist: delayed 74869 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Aug 2021 16:44:13 EDT
Date:   Sun, 22 Aug 2021 20:43:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1629665010;
        bh=SUiCKsss0Pm46QMs/QwJ5GIDOv4aQQwQjeJWav2xWiM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=sl9Zp12+J7UZbPPB7EBDOOMMzuNJ+yD/aTs2URLXFKmu1uKfalHTNB2HbNGRWC7R7
         5X4YfGyf2qQGwgLMIfI7GuFXVNgkFe+ZoGUZUxniHixV0X6unDgiRficuMD3VPxtGe
         vIhBr7kYGkvJwqn/TUWEndhGFvZWA6ziL4rLlY3R8ga/iaMJASLNX61PG0Uzqwd+/f
         BmVNMgyxw4Dc+6X2A21759huR8E/M/KCn41E23ypLQy2qaPHZHaFs2emq3UivVJpF7
         2l2c6uZsZ6x4rkDb5VGSNY5OpR+TkTlTawSHCvbZQC0hRgPBA7RlG1k+Osib3OGWFF
         hICxK7SrWGQ4Q==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bryan Brattlof <hello@bryanbrattlof.com>
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH v2 2/5] staging: rtl8723bs: remove sdio_writeN()
Message-ID: <20210822204212.2832397-3-hello@bryanbrattlof.com>
In-Reply-To: <20210822204212.2832397-1-hello@bryanbrattlof.com>
References: <20210822204212.2832397-1-hello@bryanbrattlof.com>
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

The sdio_writeN() function is unused. We can remove it.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c   | 48 ----------------------
 drivers/staging/rtl8723bs/include/rtw_io.h |  1 -
 2 files changed, 49 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl=
8723bs/hal/sdio_ops.c
index b784a390c8e1..6bd662928ab6 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -299,53 +299,6 @@ static s32 sdio_write32(struct intf_hdl *intfhdl, u32 =
addr, u32 val)
 =09return err;
 }

-static s32 sdio_writeN(struct intf_hdl *intfhdl, u32 addr, u32 cnt, u8 *bu=
f)
-{
-=09struct adapter *adapter;
-=09u8 mac_pwr_ctrl_on;
-=09u8 device_id;
-=09u16 offset;
-=09u32 ftaddr;
-=09u8 shift;
-=09s32 err;
-
-=09adapter =3D intfhdl->padapter;
-=09err =3D 0;
-
-=09ftaddr =3D _cvrt2ftaddr(addr, &device_id, &offset);
-
-=09rtw_hal_get_hwreg(adapter, HW_VAR_APFM_ON_MAC, &mac_pwr_ctrl_on);
-=09if (
-=09=09((device_id =3D=3D WLAN_IOREG_DEVICE_ID) && (offset < 0x100)) ||
-=09=09(!mac_pwr_ctrl_on) ||
-=09=09(adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
-=09)
-=09=09return sd_cmd52_write(intfhdl, ftaddr, cnt, buf);
-
-=09shift =3D ftaddr & 0x3;
-=09if (shift =3D=3D 0) {
-=09=09err =3D sd_write(intfhdl, ftaddr, cnt, buf);
-=09} else {
-=09=09u8 *tmpbuf;
-=09=09u32 n;
-
-=09=09ftaddr &=3D ~(u16)0x3;
-=09=09n =3D cnt + shift;
-=09=09tmpbuf =3D rtw_malloc(n);
-=09=09if (!tmpbuf)
-=09=09=09return -1;
-=09=09err =3D sd_read(intfhdl, ftaddr, 4, tmpbuf);
-=09=09if (err) {
-=09=09=09kfree(tmpbuf);
-=09=09=09return err;
-=09=09}
-=09=09memcpy(tmpbuf + shift, buf, cnt);
-=09=09err =3D sd_write(intfhdl, ftaddr, n, tmpbuf);
-=09=09kfree(tmpbuf);
-=09}
-=09return err;
-}
-
 static void sdio_read_mem(
 =09struct intf_hdl *intfhdl,
 =09u32 addr,
@@ -463,7 +416,6 @@ void sdio_set_intf_ops(struct adapter *adapter, struct =
_io_ops *ops)
 =09ops->_write8 =3D &sdio_write8;
 =09ops->_write16 =3D &sdio_write16;
 =09ops->_write32 =3D &sdio_write32;
-=09ops->_writeN =3D &sdio_writeN;
 =09ops->_write_port =3D &sdio_write_port;
 }

diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/r=
tl8723bs/include/rtw_io.h
index 87f36b7e880f..0753e20cfaa2 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -84,7 +84,6 @@ struct _io_ops {
 =09=09int (*_write8)(struct intf_hdl *pintfhdl, u32 addr, u8 val);
 =09=09int (*_write16)(struct intf_hdl *pintfhdl, u32 addr, u16 val);
 =09=09int (*_write32)(struct intf_hdl *pintfhdl, u32 addr, u32 val);
-=09=09int (*_writeN)(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *=
pdata);

 =09=09int (*_write8_async)(struct intf_hdl *pintfhdl, u32 addr, u8 val);
 =09=09int (*_write16_async)(struct intf_hdl *pintfhdl, u32 addr, u16 val);
--
2.30.2


