Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A504387F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351585AbhERSbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:31:15 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:33901 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344600AbhERSbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:31:14 -0400
Date:   Tue, 18 May 2021 18:29:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1621362594;
        bh=pWuux+OkJDeCk2/BsI4pvJhTzJJk4qa6rHE3mQqUKUo=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=kDaNI1Ixi6kEfy+m/9ttJGRICE9+jKVcZH2R0teSVxY4LSNjiEuFQ77n6o+BR5224
         lwD/cLUG6QVlN6Y6SMZdIXNsfxnP4NXFRhh1Jw3AokMPFKz8gJ1wAxAFmaXM5gD9d4
         yPHNqj1/ep8mEKrst3Fio09KmM45fMfqzAUUAQrNHUoLMutlVI07dMnm7gdKazz9w0
         miKWx0j7xcCTnBZjAIEfQ51vKwyuLOCEmTBcUIsdxtgvIiECaVya/tRPksTlL9Ru3j
         PLD7CXG/u7TGItG9JyTbCFXzckUBHEmka/7Y/x4kBLPIpKzv3XOYzGvqsOyP1vbHtU
         sjpkZUUL4WKdw==
To:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH 7/8] staging: rtl8723bs: remove duplicate name for _rtw_write_port()
Message-ID: <5b8543127a774ca65595588711c05cce28b17bf6.1621361919.git-series.hello@bryanbrattlof.com>
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

_rtw_write_port() is being redefined as rtw_write_port(). Because
rtw_write_port() is the only name used in the driver, remove the
duplicate definition and rename the function from _rtw_write_port()
to rtw_write_port()

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/core/rtw_io.c    | 2 +-
 drivers/staging/rtl8723bs/include/rtw_io.h | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8=
723bs/core/rtw_io.c
index 4f66b961ef61..6de549e90999 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -135,7 +135,7 @@ u8 _rtw_sd_f0_read8(struct adapter *adapter, u32 addr)
 =09return r_val;
 }

-u32 _rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
+u32 rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
 {
 =09u32 (*_write_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pm=
em);
 =09struct io_priv *pio_priv =3D &adapter->iopriv;
diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/r=
tl8723bs/include/rtw_io.h
index 3ba413ed3098..48e1352ac48a 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -180,9 +180,7 @@ extern int rtw_write32(struct adapter *adapter, u32 add=
r, u32 val);

 extern u8 _rtw_sd_f0_read8(struct adapter *adapter, u32 addr);

-extern u32 _rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 =
*pmem);
-
-#define rtw_write_port(adapter, addr, cnt, mem) _rtw_write_port((adapter),=
 (addr), (cnt), (mem))
+extern u32 rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *=
pmem);

 #define rtw_sd_f0_read8(adapter, addr) _rtw_sd_f0_read8((adapter), (addr))

--
git-series 0.9.1

