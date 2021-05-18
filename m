Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5429387FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351590AbhERSdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:33:06 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:13930 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351586AbhERSdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:33:05 -0400
Date:   Tue, 18 May 2021 18:31:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1621362705;
        bh=tJtrdutIXVTolG178z7GLoOZStEY+n4l5NmOe6sRTQU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=UlFuSpdxrkXBed7B0mnqxEyrLaVa0nXpqf/KaBCXldqfCH4r2CDrvPyfh0S6+Ibik
         Xlbqs7VipEiHC9C3a3Gb465DXHjeiso7jL7whaLgkmyv9QyTjSfHm119p6ktiYquir
         cUnDoA0W6mgw4tpJLZUXXUU+9aCbY3bEGHrVsx9lvSahfU+hj1OLF4qMPLpgPYsNJJ
         a0+wXwZ5fgKQPFkjytL86CMrC7mzqeANp0/zLCQyA4GmAfnIR1uj6qm6kLziYNVVBl
         9oBg5NDqFqNiFplalwBZ7933E6jfJuVJEk/mHaQeudXtvkip024UAwRAh8J8UyO7dB
         tNclUl2p+kIOQ==
To:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH 6/8] staging: rtl8723bs: remove duplicate names for _rtw_write32()
Message-ID: <43917aee34e85139e613578cf6f14938211c8835.1621361919.git-series.hello@bryanbrattlof.com>
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

_rtw_write32() is redefined as rtw_write32() and
PlatformEFIOWrite4Byte(). Because rtw_write32() is the only name used in
the driver, remove the duplicate definitions and rename the function
from _rtw_write32() to rtw_write32()

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/core/rtw_io.c    | 2 +-
 drivers/staging/rtl8723bs/include/rtw_io.h | 7 +------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8=
723bs/core/rtw_io.c
index cdd42e992d6e..4f66b961ef61 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -101,7 +101,7 @@ int rtw_write16(struct adapter *adapter, u32 addr, u16 =
val)
 =09ret =3D _write16(pintfhdl, addr, val);
 =09return RTW_STATUS_CODE(ret);
 }
-int _rtw_write32(struct adapter *adapter, u32 addr, u32 val)
+int rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 {
 =09/* struct=09io_queue=09*pio_queue =3D (struct io_queue *)adapter->pio_q=
ueue; */
 =09struct io_priv *pio_priv =3D &adapter->iopriv;
diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/r=
tl8723bs/include/rtw_io.h
index 88518293839e..3ba413ed3098 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -176,14 +176,12 @@ extern u32 rtw_read32(struct adapter *adapter, u32 ad=
dr);

 extern int rtw_write8(struct adapter *adapter, u32 addr, u8 val);
 extern int rtw_write16(struct adapter *adapter, u32 addr, u16 val);
-extern int _rtw_write32(struct adapter *adapter, u32 addr, u32 val);
+extern int rtw_write32(struct adapter *adapter, u32 addr, u32 val);

 extern u8 _rtw_sd_f0_read8(struct adapter *adapter, u32 addr);

 extern u32 _rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 =
*pmem);

-#define  rtw_write32(adapter, addr, val) _rtw_write32((adapter), (addr), (=
val))
-
 #define rtw_write_port(adapter, addr, cnt, mem) _rtw_write_port((adapter),=
 (addr), (cnt), (mem))

 #define rtw_sd_f0_read8(adapter, addr) _rtw_sd_f0_read8((adapter), (addr))
@@ -230,7 +228,4 @@ extern void bus_sync_io(struct io_queue *pio_q);
 extern u32 _ioreq2rwmem(struct io_queue *pio_q);
 extern void dev_power_down(struct adapter *Adapter, u8 bpwrup);

-#define PlatformEFIOWrite4Byte(_a, _b, _c)=09=09\
-=09rtw_write32(_a, _b, _c)
-
 #endif=09/* _RTL8711_IO_H_ */
--
git-series 0.9.1

