Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596923F9C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245570AbhH0QPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:15:15 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:57407 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245421AbhH0QPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:15:12 -0400
Date:   Fri, 27 Aug 2021 16:13:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1630080831;
        bh=elvI4PYFjwoBQZkWf3kEVUPEO6m0nRDZ+h/+tU39oRY=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=grx6U82TKe73Zjt5cA+H1i+xYZ8x4DAhIKmwbmlQuXUAzynjKLIfja30J2+n6rArn
         yDLqtRC+pKSjtkTeRdzFAhVntl3TcTSy3PVx/LODX7cROMkLP2T6k74r3jj35vLpyq
         dCW9Tvtzq4Ck9L+R+D8hbR1OwkJj+ZQZJwTwb7jg+sSGtzJWE3WTLme991n4+Muitu
         kon8uu5xG9NW+DE9lx/UtXoG7nckVDyii2Sq43Dry/4MNrqiUWfDi/BHSMiYxtuQYh
         XMMfANKfMtRo1BFBv6pjGmSmGID2p4wpua7mWcgeJH4sACFsFlDTmfqLwkV15hB1nk
         u5z9ezvxRSinA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bryan Brattlof <hello@bryanbrattlof.com>
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH 3/5] staging: rtl8723bs: remove sdio_read_mem() and sdio_readN()
Message-ID: <d05f4a683554be40ddec3ca33047acd6e59ad950.1630080164.git.hello@bryanbrattlof.com>
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

The sdio_read_mem() function is unused. We can remove it along with the
sdio_readN() function that it uses.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c   | 56 ----------------------
 drivers/staging/rtl8723bs/include/rtw_io.h |  2 -
 2 files changed, 58 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl=
8723bs/hal/sdio_ops.c
index 6bd662928ab6..928fa109565e 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -195,51 +195,6 @@ static u32 sdio_read32(struct intf_hdl *intfhdl, u32 a=
ddr)
 =09return val;
 }

-static s32 sdio_readN(struct intf_hdl *intfhdl, u32 addr, u32 cnt, u8 *buf=
)
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
-=09=09return sd_cmd52_read(intfhdl, ftaddr, cnt, buf);
-
-=09/*  4 bytes alignment */
-=09shift =3D ftaddr & 0x3;
-=09if (shift =3D=3D 0) {
-=09=09err =3D sd_read(intfhdl, ftaddr, cnt, buf);
-=09} else {
-=09=09u8 *tmpbuf;
-=09=09u32 n;
-
-=09=09ftaddr &=3D ~(u16)0x3;
-=09=09n =3D cnt + shift;
-=09=09tmpbuf =3D rtw_malloc(n);
-=09=09if (!tmpbuf)
-=09=09=09return -1;
-
-=09=09err =3D sd_read(intfhdl, ftaddr, n, tmpbuf);
-=09=09if (!err)
-=09=09=09memcpy(buf, tmpbuf + shift, cnt);
-=09=09kfree(tmpbuf);
-=09}
-=09return err;
-}
-
 static s32 sdio_write8(struct intf_hdl *intfhdl, u32 addr, u8 val)
 {
 =09u32 ftaddr;
@@ -299,16 +254,6 @@ static s32 sdio_write32(struct intf_hdl *intfhdl, u32 =
addr, u32 val)
 =09return err;
 }

-static void sdio_read_mem(
-=09struct intf_hdl *intfhdl,
-=09u32 addr,
-=09u32 cnt,
-=09u8 *rmem
-)
-{
-=09sdio_readN(intfhdl, addr, cnt, rmem);
-}
-
 /*
  * Description:
  *Read from RX FIFO
@@ -410,7 +355,6 @@ void sdio_set_intf_ops(struct adapter *adapter, struct =
_io_ops *ops)
 =09ops->_read8 =3D &sdio_read8;
 =09ops->_read16 =3D &sdio_read16;
 =09ops->_read32 =3D &sdio_read32;
-=09ops->_read_mem =3D &sdio_read_mem;
 =09ops->_read_port =3D &sdio_read_port;

 =09ops->_write8 =3D &sdio_write8;
diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/r=
tl8723bs/include/rtw_io.h
index 0753e20cfaa2..43102f65bddd 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -89,8 +89,6 @@ struct _io_ops {
 =09=09int (*_write16_async)(struct intf_hdl *pintfhdl, u32 addr, u16 val);
 =09=09int (*_write32_async)(struct intf_hdl *pintfhdl, u32 addr, u32 val);

-=09=09void (*_read_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *=
pmem);
-
 =09=09void (*_sync_irp_protocol_rw)(struct io_queue *pio_q);

 =09=09u32 (*_read_interrupt)(struct intf_hdl *pintfhdl, u32 addr);
--
2.30.2


