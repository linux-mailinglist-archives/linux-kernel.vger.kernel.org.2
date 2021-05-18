Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C233387F96
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351560AbhERS3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:29:24 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:30229 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351547AbhERS3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:29:23 -0400
Date:   Tue, 18 May 2021 18:27:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1621362483;
        bh=1cbLO6Za89h7ZQgNGjgXoJ0coKMW+RnX2fLI4KmMQEE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=eIgo5nz/qODQPrF/uRmtIVMa+hojwlqJzoBZye6GzDYUJkoh2jmzwQeheqqHiVbWX
         n2V7N/CEAW40pW8y6U/at4qNuyeFVPHxixwdmM1QMkTMZB2TMUesNCC1msSyUDFIK7
         Y38UTq7U5VskvSlNcOo7EnH623FknQQaYmS7RIvB7iD0nmQD+RNKtEuOSTZlZKmWNA
         2xpZGsFSasN4EC8bZA0LNCTETzmT0EUriBOdX5ktoVPq7uiQAVQUCYF5hWZ9ijHvRO
         0S+bcbc9nkpHzdAiMZVgqUs+D7S3USepq5Wvdbnhbkqcd3dtqRaN0OlFiNzvGYJpel
         uUNvGw9rNszxw==
To:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH 4/8] staging: rtl8723bs: remove duplicate names for _rtw_write8()
Message-ID: <35ffc9cd5af7009b317361033a6ca5263307d61a.1621361919.git-series.hello@bryanbrattlof.com>
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

_rtw_write8() is redefined as rtw_write8() and PlatformEFIOWrite1Byte().
Because rtw_write8() is the only name used in the driver, remove the
duplicate definitions and rename the function from _rtw_write8() to
rtw_write8()

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/core/rtw_io.c    | 2 +-
 drivers/staging/rtl8723bs/include/rtw_io.h | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8=
723bs/core/rtw_io.c
index 9428860162c3..6fafb84934e5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -74,7 +74,7 @@ u32 rtw_read32(struct adapter *adapter, u32 addr)

 }

-int _rtw_write8(struct adapter *adapter, u32 addr, u8 val)
+int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 {
 =09/* struct=09io_queue=09*pio_queue =3D (struct io_queue *)adapter->pio_q=
ueue; */
 =09struct io_priv *pio_priv =3D &adapter->iopriv;
diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/r=
tl8723bs/include/rtw_io.h
index fa0eed017e96..dbcf227dbcba 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -174,7 +174,7 @@ extern u8 rtw_read8(struct adapter *adapter, u32 addr);
 extern u16 rtw_read16(struct adapter *adapter, u32 addr);
 extern u32 rtw_read32(struct adapter *adapter, u32 addr);

-extern int _rtw_write8(struct adapter *adapter, u32 addr, u8 val);
+extern int rtw_write8(struct adapter *adapter, u32 addr, u8 val);
 extern int _rtw_write16(struct adapter *adapter, u32 addr, u16 val);
 extern int _rtw_write32(struct adapter *adapter, u32 addr, u32 val);

@@ -182,7 +182,6 @@ extern u8 _rtw_sd_f0_read8(struct adapter *adapter, u32=
 addr);

 extern u32 _rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 =
*pmem);

-#define  rtw_write8(adapter, addr, val) _rtw_write8((adapter), (addr), (va=
l))
 #define  rtw_write16(adapter, addr, val) _rtw_write16((adapter), (addr), (=
val))
 #define  rtw_write32(adapter, addr, val) _rtw_write32((adapter), (addr), (=
val))

@@ -232,8 +231,6 @@ extern void bus_sync_io(struct io_queue *pio_q);
 extern u32 _ioreq2rwmem(struct io_queue *pio_q);
 extern void dev_power_down(struct adapter *Adapter, u8 bpwrup);

-#define PlatformEFIOWrite1Byte(_a, _b, _c)=09=09\
-=09rtw_write8(_a, _b, _c)
 #define PlatformEFIOWrite2Byte(_a, _b, _c)=09=09\
 =09rtw_write16(_a, _b, _c)
 #define PlatformEFIOWrite4Byte(_a, _b, _c)=09=09\
--
git-series 0.9.1

