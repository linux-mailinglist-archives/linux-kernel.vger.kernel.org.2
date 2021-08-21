Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A413F3CCB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 01:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhHUX5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 19:57:06 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:40205 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHUX5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 19:57:04 -0400
Date:   Sat, 21 Aug 2021 23:55:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1629590151;
        bh=SUiCKsss0Pm46QMs/QwJ5GIDOv4aQQwQjeJWav2xWiM=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=kdaTdGPxrWAM46/nGIFqp7rhsl2B2U9UUZ/2dA0xVJyns8jICoB3Yo1HWC8BhKlbB
         cY6r9NEiVvnzNE4tmgB2CfDhMF8DIcKt+TdZLCpnMOXNI5ahJbaEkp7o8gltx9j6Vh
         9ejqY34ETxumN7X+RNUz6OGcStxxWEYnOm+h4eOoM4gnpbY09KCuf2KcpNYk/oMF4y
         L2BKmIrnODHJUxsqLE0SpA2wb9ywikKLAyirwnNMNJlUMuz4rSqGv8Tt1gdY6XNK/3
         NSCrklk55kHaSj3zC8C2HbvNU55Uig0zd55EMINAsb5M/L5/HNBuxG5u3JJ/UMycTO
         FVpD4NV13AM9g==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH 2/6] staging: rtl8723bs: remove sdio_writeN()
Message-ID: <20210821235456.2502681-2-hello@bryanbrattlof.com>
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


