Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DCA3B73C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhF2OHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:07:47 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:48972 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhF2OHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:07:44 -0400
Date:   Tue, 29 Jun 2021 14:04:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1624975484;
        bh=dhxJvVB5vGNzlqPV/Vc3Rg4M/zVZQZH9g1DDMaRrUrA=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=XlecZXxI6Xfp+NGBpyfOcyE8lxYK3caHy5ZTXxrL0ZhsnJpmBb4JGOmP/laKSzayw
         1yZ2+W1n6SA5scwQPvUzMI1e5m/mShEOUCH18JUYaHh7FUmOMrYnQsjc3HugiJohUS
         a8u7tFPZDRCzbXf5OldIMaGdSWcFF0D+CgeF4awELG0C8KWj3A8p5f/qCfIxWFQ3TA
         xzCrRIIa0iPx0ldIFrghx64F8MscvcSAhh3Of+5U0JcQj6QOckQ7ubi/gPBfRh6gxs
         8B9IurABu/mQ9oUcyugWJlASsoELeDM8CjcW4gF0Fpq7YBr4Z3cE4C+D/AJcdVX8jt
         OId6IAe+6YRJw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bryan Brattlof <hello@bryanbrattlof.com>
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH] staging: rtl8723bs: remove custom endian conversion macros
Message-ID: <20210629135824.47749-1-hello@bryanbrattlof.com>
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

The rtw_cpu_to_leXX() and rtw_leXX_to_cpu() family of macros are
unnecessary and should be removed.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/core/rtw_io.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8=
723bs/core/rtw_io.c
index 856e23398c03..4d3c30ec93b5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -28,11 +28,6 @@ jackson@realtek.com.tw
 #include <drv_types.h>
 #include <rtw_debug.h>

-#define rtw_le16_to_cpu(val)=09=09val
-#define rtw_le32_to_cpu(val)=09=09val
-#define rtw_cpu_to_le16(val)=09=09val
-#define rtw_cpu_to_le32(val)=09=09val
-
 u8 rtw_read8(struct adapter *adapter, u32 addr)
 {
 =09/* struct=09io_queue=09*pio_queue =3D (struct io_queue *)adapter->pio_q=
ueue; */
@@ -47,7 +42,6 @@ u8 rtw_read8(struct adapter *adapter, u32 addr)

 u16 rtw_read16(struct adapter *adapter, u32 addr)
 {
-=09u16 r_val;
 =09/* struct=09io_queue=09*pio_queue =3D (struct io_queue *)adapter->pio_q=
ueue; */
 =09struct io_priv *pio_priv =3D &adapter->iopriv;
 =09struct=09intf_hdl=09=09*pintfhdl =3D &(pio_priv->intf);
@@ -55,13 +49,11 @@ u16 rtw_read16(struct adapter *adapter, u32 addr)

 =09_read16 =3D pintfhdl->io_ops._read16;

-=09r_val =3D _read16(pintfhdl, addr);
-=09return rtw_le16_to_cpu(r_val);
+=09return _read16(pintfhdl, addr);
 }

 u32 rtw_read32(struct adapter *adapter, u32 addr)
 {
-=09u32 r_val;
 =09/* struct=09io_queue=09*pio_queue =3D (struct io_queue *)adapter->pio_q=
ueue; */
 =09struct io_priv *pio_priv =3D &adapter->iopriv;
 =09struct=09intf_hdl=09=09*pintfhdl =3D &(pio_priv->intf);
@@ -69,8 +61,7 @@ u32 rtw_read32(struct adapter *adapter, u32 addr)

 =09_read32 =3D pintfhdl->io_ops._read32;

-=09r_val =3D _read32(pintfhdl, addr);
-=09return rtw_le32_to_cpu(r_val);
+=09return _read32(pintfhdl, addr);

 }

--
2.27.0


