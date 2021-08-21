Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC693F3CC9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 01:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhHUX4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 19:56:45 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:36464 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHUX4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 19:56:44 -0400
Date:   Sat, 21 Aug 2021 23:55:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1629590163;
        bh=wdAPJNqRs4L8i+w4JFiTHyTQcUOb9MfykknwRLa1lNU=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=Xc7xoQZD1wqgiJzRzFaCzU0yBlNYCVXFXwnR0ko+Kf/avpgcOtMly1/uGlRQN1jc/
         tvXER4FNaA5lZtTINDCi25AnToRyFnbuLOatsi3/Hm4cZvZHp4d+tMc6O3PuFfUyto
         huYPuTyz5mNwO6FSL1BehaFzns8nTOLZjXYuveT4uhLQuIm1/Q+qDHCv2nepDCjCaW
         E3ekV4+QpTmX2cwHsuUljazmURN4LU28VI04Z+GLUVXGGnAOONx60B/jt+3znHfKsI
         pkPeuIHPWWoyorKnx4AwdLic46/FYOSRvCVyhOEftb21f5mAhbZ00kKkgmeh5Ly+WV
         Vqc50tKsHEKkQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH 4/6] staging: rtl8723bs: remove sdio_readN()
Message-ID: <20210821235456.2502681-4-hello@bryanbrattlof.com>
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

The sdio_readN() function is unused. We can remove it.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 45 ------------------------
 1 file changed, 45 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl=
8723bs/hal/sdio_ops.c
index 019ace4b8564..928fa109565e 100644
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
--
2.30.2


