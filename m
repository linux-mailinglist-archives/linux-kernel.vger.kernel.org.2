Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C87387F95
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351549AbhERS3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:29:13 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:17349 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351557AbhERS3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:29:11 -0400
Date:   Tue, 18 May 2021 18:27:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1621362471;
        bh=V8gaLuSAeiV/7eUL9ZsICsxJj3Bdk6zVDgaoO1irXRM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=UP2G8tF6rEw/NGw/FZqnleteCvVDWFSajjUHVu+57rjgXFtkE4g8dvXqYb5Q/rY/y
         gcj4MMeX0V+N5/v3WbpwJsBoFvAQYpLM630o+/4XixPrDAR6MEBLp5urL5jhUaEI5i
         SIFlo/tHHgHr5K9Uh+ktwtNrV4IRt3+0u2Om0fFNPvY0BOrjESkABrytAsbBLieqAL
         uOssXoEoyUjdnzVV5f7WNeGLzR21P/w4kAkWjvPq8B668ag9R+RmWQLnufGKsgpwQv
         C0g3nTg0169csk4fn51MtMKoweIcuOEZS0Zew/VIi5GcAQiQbSFAJkkVnPY0SQmBQ3
         Bi+ZYuzsDqupw==
To:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH 1/8] staging: rtl8723bs: remove duplicate names for _rtw_read8()
Message-ID: <9880c86c2aad7d95a714d8b03b28b83634f98c1e.1621361919.git-series.hello@bryanbrattlof.com>
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

_rtw_read8() is redefined as rtw_read8() and PlatformEFIORead1Byte().
Because rtw_read8() is the only name used in the driver, remove the
duplicate definitions and rename the function from _rtw_read8() to
rtw_read8()

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/core/rtw_io.c    | 2 +-
 drivers/staging/rtl8723bs/include/rtw_io.h | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8=
723bs/core/rtw_io.c
index ecbb679fbc16..99bb53aee59c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -33,7 +33,7 @@ jackson@realtek.com.tw
 #define rtw_cpu_to_le16(val)=09=09val
 #define rtw_cpu_to_le32(val)=09=09val

-u8 _rtw_read8(struct adapter *adapter, u32 addr)
+u8 rtw_read8(struct adapter *adapter, u32 addr)
 {
 =09/* struct=09io_queue=09*pio_queue =3D (struct io_queue *)adapter->pio_q=
ueue; */
 =09struct io_priv *pio_priv =3D &adapter->iopriv;
diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/r=
tl8723bs/include/rtw_io.h
index fbb73e698e09..f7b441e1eae1 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -170,7 +170,7 @@ extern void unregister_intf_hdl(struct intf_hdl *pintfh=
dl);
 extern void _rtw_attrib_read(struct adapter *adapter, u32 addr, u32 cnt, u=
8 *pmem);
 extern void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, =
u8 *pmem);

-extern u8 _rtw_read8(struct adapter *adapter, u32 addr);
+extern u8 rtw_read8(struct adapter *adapter, u32 addr);
 extern u16 _rtw_read16(struct adapter *adapter, u32 addr);
 extern u32 _rtw_read32(struct adapter *adapter, u32 addr);

@@ -182,7 +182,6 @@ extern u8 _rtw_sd_f0_read8(struct adapter *adapter, u32=
 addr);

 extern u32 _rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 =
*pmem);

-#define rtw_read8(adapter, addr) _rtw_read8((adapter), (addr))
 #define rtw_read16(adapter, addr) _rtw_read16((adapter), (addr))
 #define rtw_read32(adapter, addr) _rtw_read32((adapter), (addr))

@@ -243,8 +242,6 @@ extern void dev_power_down(struct adapter *Adapter, u8 =
bpwrup);
 #define PlatformEFIOWrite4Byte(_a, _b, _c)=09=09\
 =09rtw_write32(_a, _b, _c)

-#define PlatformEFIORead1Byte(_a, _b)=09=09\
-=09=09rtw_read8(_a, _b)
 #define PlatformEFIORead2Byte(_a, _b)=09=09\
 =09=09rtw_read16(_a, _b)
 #define PlatformEFIORead4Byte(_a, _b)=09=09\
--
git-series 0.9.1

