Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933BC387F97
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351558AbhERS3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:29:30 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:53879 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351562AbhERS32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:29:28 -0400
Date:   Tue, 18 May 2021 18:28:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1621362488;
        bh=OSRAYOYo/vD5tJpr8Sovj6nPxunoGd65OxAGX7K3qTA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=GctmmkQcIm9O0NngLDiXVskyPoyyfxQCZNd0IqFdAhCoq/RZD9gNNrY3WA/1ScvqY
         CUpFKX4TQMw553elZHPGmlw8t9bjbxWsa/NKsN5pE3W183WbC6dAPFZZlQwZiQMQdK
         abaE3KXcxOtxV768tPp3DHa1x48rnlCE3WBZwsVnFg/RQAdRuE6PSw4C2IhhxToYi3
         c7LR51Tma5j02kqy42GLKFwth5cSl6lkLPlwseXBHtXuTGht/iUjg8L3AWaNoVfWZK
         nurcDqFQWFMmlARwdaaBFrU0yDNwSUlE+85mBA2NLgrq+bTG7HhiQ3QB/MfDdpi1bS
         E3T4hCSBOu/Mg==
To:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH 3/8] staging: rtl8723bs: remove duplicate names for _rtw_read32()
Message-ID: <15956707341f76de683245c392063b8121a805ea.1621361919.git-series.hello@bryanbrattlof.com>
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

_rtw_read32() is redefined as rtw_read32() and PlatformEFIORead4Byte().
Because rtw_read32() is the only name used in the driver, remove the
duplicate definitions and rename the function from _rtw_read32() to
rtw_read32()

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/core/rtw_io.c    | 2 +-
 drivers/staging/rtl8723bs/include/rtw_io.h | 7 +------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8=
723bs/core/rtw_io.c
index e06901cd8ce6..9428860162c3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -59,7 +59,7 @@ u16 rtw_read16(struct adapter *adapter, u32 addr)
 =09return rtw_le16_to_cpu(r_val);
 }

-u32 _rtw_read32(struct adapter *adapter, u32 addr)
+u32 rtw_read32(struct adapter *adapter, u32 addr)
 {
 =09u32 r_val;
 =09/* struct=09io_queue=09*pio_queue =3D (struct io_queue *)adapter->pio_q=
ueue; */
diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/r=
tl8723bs/include/rtw_io.h
index e89b677c5e13..fa0eed017e96 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -172,7 +172,7 @@ extern void _rtw_attrib_write(struct adapter *adapter, =
u32 addr, u32 cnt, u8 *pm

 extern u8 rtw_read8(struct adapter *adapter, u32 addr);
 extern u16 rtw_read16(struct adapter *adapter, u32 addr);
-extern u32 _rtw_read32(struct adapter *adapter, u32 addr);
+extern u32 rtw_read32(struct adapter *adapter, u32 addr);

 extern int _rtw_write8(struct adapter *adapter, u32 addr, u8 val);
 extern int _rtw_write16(struct adapter *adapter, u32 addr, u16 val);
@@ -182,8 +182,6 @@ extern u8 _rtw_sd_f0_read8(struct adapter *adapter, u32=
 addr);

 extern u32 _rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 =
*pmem);

-#define rtw_read32(adapter, addr) _rtw_read32((adapter), (addr))
-
 #define  rtw_write8(adapter, addr, val) _rtw_write8((adapter), (addr), (va=
l))
 #define  rtw_write16(adapter, addr, val) _rtw_write16((adapter), (addr), (=
val))
 #define  rtw_write32(adapter, addr, val) _rtw_write32((adapter), (addr), (=
val))
@@ -241,7 +239,4 @@ extern void dev_power_down(struct adapter *Adapter, u8 =
bpwrup);
 #define PlatformEFIOWrite4Byte(_a, _b, _c)=09=09\
 =09rtw_write32(_a, _b, _c)

-#define PlatformEFIORead4Byte(_a, _b)=09=09\
-=09=09rtw_read32(_a, _b)
-
 #endif=09/* _RTL8711_IO_H_ */
--
git-series 0.9.1

