Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E273F533A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhHWWNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:13:16 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:59727 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhHWWNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:13:15 -0400
Date:   Mon, 23 Aug 2021 22:12:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1629756750;
        bh=50FeX9ibMRexduiJPC7ZruLY3uInaCBLMCqmvNkS5U0=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=n87t4/uzOd24l/bpzoR+J5L318JBRkh11+3dYkaJUAjslnpOk0+WAZ0x/fyuDql8Y
         pxuJ4lu4uRfM/wJT2Xsb5EZsHGtjNuF4ZiOsHoMz94HGU8THrddZaLNtTCR2RsD8xw
         5oOee2H2JDOxYHdshb0G5z9EfGwUhZRxs9IJtpOxj+wt8QrZ0/tFSrEzc/pI/aN9ip
         OklGQuwZFnCb41mxkhlCOCUBRBW2OfuxiMzPCm9ntiHb9PCP1C4WGu/gZ6xS30aK0p
         QRR4k73im/ndLpvCCmj1JkxXz6MyJsOyJPblcymJDHR2vayID1IwMMsYtFlIzZgRmB
         z5gnWCBxU834g==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Bryan Brattlof <hello@bryanbrattlof.com>
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH] staging: rtl8723bs: remove sdio_osintf.h
Message-ID: <20210823221156.3353972-1-hello@bryanbrattlof.com>
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

All definitions inside sdio_osintf.h are unused. Remove it.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h   |  1 -
 drivers/staging/rtl8723bs/include/sdio_osintf.h | 16 ----------------
 2 files changed, 17 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/include/sdio_osintf.h

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/stagin=
g/rtl8723bs/include/drv_types.h
index 580028d28c42..0e6741db95bf 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -489,7 +489,6 @@ static inline u8 *myid(struct eeprom_priv *peepriv)
 }

 /*  HCI Related header file */
-#include <sdio_osintf.h>
 #include <sdio_ops.h>
 #include <sdio_hal.h>

diff --git a/drivers/staging/rtl8723bs/include/sdio_osintf.h b/drivers/stag=
ing/rtl8723bs/include/sdio_osintf.h
deleted file mode 100644
index 146b44f95e29..000000000000
--- a/drivers/staging/rtl8723bs/include/sdio_osintf.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*************************************************************************=
*****
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- *************************************************************************=
*****/
-#ifndef __SDIO_OSINTF_H__
-#define __SDIO_OSINTF_H__
-
-
-
-u8 sd_hal_bus_init(struct adapter *padapter);
-u8 sd_hal_bus_deinit(struct adapter *padapter);
-void sd_c2h_hdl(struct adapter *padapter);
-
-#endif
--
2.30.2


