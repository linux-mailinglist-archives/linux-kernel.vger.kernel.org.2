Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFE0387F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351580AbhERSa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:30:27 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:26411 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351561AbhERSaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:30:24 -0400
Date:   Tue, 18 May 2021 18:28:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1621362544;
        bh=HhWs/rAZ8OcQk25p44X81ywoFOp4ud08SPFEcjIUJWo=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=fa5iQeFOpop7xEnPqJoky4GnPcr+iZVmhjPYzS8IcBOaBOCd6AxzsWm0iusroJoen
         26U6otWolupx/Lk7lYilN1DLGlz7TLUcINEUzY+bem6GAT5YCR9AvGcgzQR5TO3PUG
         eK54uNEL6Ttg/txIZ7zT3+Ihzci5shBHi4KxhnxRxXLS2Wz85SUAe6GwFYXPxa4U0x
         WV4Ky2Xi8nYqA4Pu4e0MoUfbSTHW66XMx02MESbvRSSTJz3uU9xlaUsmQHsze6GGKG
         zb9ZCN8+w2ooyBZZsp2TCwBbXP6K5CAG548HCSrABU2pJmVPw9qyPBVtgyvRt5mbpx
         NYJdziieDr8CA==
To:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH 2/8] staging: rtl8723bs: remove duplicate names for _rtw_read16()
Message-ID: <11458342572f21d9df58b3969ad1f16fdff157f4.1621361919.git-series.hello@bryanbrattlof.com>
In-Reply-To: <cover.7975aa58aadc20eae4102c8c0fe0e0d0ecb0a9fa.1621361919.git-series.hello@bryanbrattlof.com>
References: <cover.7975aa58aadc20eae4102c8c0fe0e0d0ecb0a9fa.1621361919.git-series.hello@bryanbrattlof.com>
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

_rtw_read16() is redefined as rtw_read16() and PlatformEFIORead2Byte().
Because rtw_read16() is the only name used in the driver, remove the
duplicate definitions and rename the function from _rtw_read16() to
rtw_read16()

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/core/rtw_io.c    | 2 +-
 drivers/staging/rtl8723bs/include/rtw_io.h | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8=
723bs/core/rtw_io.c
index 99bb53aee59c..e06901cd8ce6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -45,7 +45,7 @@ u8 rtw_read8(struct adapter *adapter, u32 addr)
 =09return _read8(pintfhdl, addr);
 }

-u16 _rtw_read16(struct adapter *adapter, u32 addr)
+u16 rtw_read16(struct adapter *adapter, u32 addr)
 {
 =09u16 r_val;
 =09/* struct=09io_queue=09*pio_queue =3D (struct io_queue *)adapter->pio_q=
ueue; */
diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/r=
tl8723bs/include/rtw_io.h
index f7b441e1eae1..e89b677c5e13 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -171,7 +171,7 @@ extern void _rtw_attrib_read(struct adapter *adapter, u=
32 addr, u32 cnt, u8 *pme
 extern void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, =
u8 *pmem);

 extern u8 rtw_read8(struct adapter *adapter, u32 addr);
-extern u16 _rtw_read16(struct adapter *adapter, u32 addr);
+extern u16 rtw_read16(struct adapter *adapter, u32 addr);
 extern u32 _rtw_read32(struct adapter *adapter, u32 addr);

 extern int _rtw_write8(struct adapter *adapter, u32 addr, u8 val);
@@ -182,7 +182,6 @@ extern u8 _rtw_sd_f0_read8(struct adapter *adapter, u32=
 addr);

 extern u32 _rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 =
*pmem);

-#define rtw_read16(adapter, addr) _rtw_read16((adapter), (addr))
 #define rtw_read32(adapter, addr) _rtw_read32((adapter), (addr))

 #define  rtw_write8(adapter, addr, val) _rtw_write8((adapter), (addr), (va=
l))
@@ -242,8 +241,6 @@ extern void dev_power_down(struct adapter *Adapter, u8 =
bpwrup);
 #define PlatformEFIOWrite4Byte(_a, _b, _c)=09=09\
 =09rtw_write32(_a, _b, _c)

-#define PlatformEFIORead2Byte(_a, _b)=09=09\
-=09=09rtw_read16(_a, _b)
 #define PlatformEFIORead4Byte(_a, _b)=09=09\
 =09=09rtw_read32(_a, _b)

--
git-series 0.9.1

