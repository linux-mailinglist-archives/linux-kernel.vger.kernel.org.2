Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1093387F98
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351574AbhERS3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:29:47 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:28781 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351561AbhERS3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:29:42 -0400
Date:   Tue, 18 May 2021 18:28:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1621362502;
        bh=rM7iDneV9GHyzCZubFDOJRQRY6DPLoivpY3j9pEDDKM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=TcfD15P67eplFTJo4GrOlRxHTIfXLvtfy05xX31o+ohcxv/QE/eacPLKiLHf1lK/q
         FoSdSy+FgXOXJZ8qOSlyKXFe0wng4b+vLe1OjoWSJb3Mv2mVYY0mnhrAcJJN5dwh1P
         AKx12LXFw5TCJ11lcsrnXtf3lm2eMWrdcDBROg//gNYuKiyTCG0su9lmGKG2ky0TsV
         6BNOjU35fjIOaQTEHZQoxrlcilAUoraAx5pw84bGxQyBwk0VWQUHkWfdy3yjSE0dsq
         dRTPLflYjjqW92bDkRj60qeCUassW02oB55BbdVsl4xHOafBa6G3ii7pr5d9/QZxL5
         Fpu2EBQ9wAPLQ==
To:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH 5/8] staging: rtl8723bs: remove duplicate names for _rtw_write16()
Message-ID: <7d53fb295f67f01c72640045afb88150391bce35.1621361919.git-series.hello@bryanbrattlof.com>
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

_rtw_write16() is redefined as rtw_write16() and
PlatformEFIOWrite2Byte(). Because rtw_write16() is the only name used in
the driver, remove the duplicate definitions and rename the function
from _rtw_write16() to rtw_write16()

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/core/rtw_io.c    | 2 +-
 drivers/staging/rtl8723bs/include/rtw_io.h | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8=
723bs/core/rtw_io.c
index 6fafb84934e5..cdd42e992d6e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -88,7 +88,7 @@ int rtw_write8(struct adapter *adapter, u32 addr, u8 val)

 =09return RTW_STATUS_CODE(ret);
 }
-int _rtw_write16(struct adapter *adapter, u32 addr, u16 val)
+int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 {
 =09/* struct=09io_queue=09*pio_queue =3D (struct io_queue *)adapter->pio_q=
ueue; */
 =09struct io_priv *pio_priv =3D &adapter->iopriv;
diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/r=
tl8723bs/include/rtw_io.h
index dbcf227dbcba..88518293839e 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -175,14 +175,13 @@ extern u16 rtw_read16(struct adapter *adapter, u32 ad=
dr);
 extern u32 rtw_read32(struct adapter *adapter, u32 addr);

 extern int rtw_write8(struct adapter *adapter, u32 addr, u8 val);
-extern int _rtw_write16(struct adapter *adapter, u32 addr, u16 val);
+extern int rtw_write16(struct adapter *adapter, u32 addr, u16 val);
 extern int _rtw_write32(struct adapter *adapter, u32 addr, u32 val);

 extern u8 _rtw_sd_f0_read8(struct adapter *adapter, u32 addr);

 extern u32 _rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 =
*pmem);

-#define  rtw_write16(adapter, addr, val) _rtw_write16((adapter), (addr), (=
val))
 #define  rtw_write32(adapter, addr, val) _rtw_write32((adapter), (addr), (=
val))

 #define rtw_write_port(adapter, addr, cnt, mem) _rtw_write_port((adapter),=
 (addr), (cnt), (mem))
@@ -231,8 +230,6 @@ extern void bus_sync_io(struct io_queue *pio_q);
 extern u32 _ioreq2rwmem(struct io_queue *pio_q);
 extern void dev_power_down(struct adapter *Adapter, u8 bpwrup);

-#define PlatformEFIOWrite2Byte(_a, _b, _c)=09=09\
-=09rtw_write16(_a, _b, _c)
 #define PlatformEFIOWrite4Byte(_a, _b, _c)=09=09\
 =09rtw_write32(_a, _b, _c)

--
git-series 0.9.1

