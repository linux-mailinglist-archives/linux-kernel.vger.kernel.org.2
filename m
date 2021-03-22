Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D21C343E11
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhCVKfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhCVKft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:35:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC0176196F;
        Mon, 22 Mar 2021 10:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616409348;
        bh=9rqVGkwYGZJxK/AGPwtJFqRPeHaoL8wIILYKBok34r4=;
        h=From:To:Cc:Subject:Date:From;
        b=HQKezWEm8wNqf1V7MQfWl7VHYkmqAw6oVJPEezvuKMjP1HFR2JrgoFHXj+S8T48Yy
         GeEaimTC8DIDH7Dc/2pfA3+q6sp3UYFb35qwVUFnI17aDZlcxi9QKiukhMuM6uceoh
         U0pjgZmzFjbJVZY3NmAsJKEo7+2G/9Bvi1JBAvxzLPOUIHCx5fkuZ3xn031n0nC2z7
         z+BGrneGPteuAXx0EaxbhD9vyPZKu5eHVAerUJz6+7d/LXAyy4ofyOUt2Bc4pHnRxp
         2KyGEdQTO2JyvSWaQILBVzffHUvkCzqvT4a4pPIMzJzMKL3BzTan6hkNZ73WKr8H2b
         4H8czhxrIbDxg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging/rtl8192u: avoid Wempty-body warning
Date:   Mon, 22 Mar 2021 11:35:39 +0100
Message-Id: <20210322103545.704121-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This driver has a few disabled diagnostics, which can probably
just get removed, or might still be helpful:

drivers/staging/rtl8192u/r8192U_core.c: In function 'rtl8192_set_rxconf':
drivers/staging/rtl8192u/r8192U_core.c:767:45: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  767 |                 DMESG("NIC in promisc mode");
      |                                             ^
drivers/staging/rtl8192u/r8192U_core.c: In function 'rtl819xusb_rx_command_packet':
drivers/staging/rtl8192u/r8192U_core.c:883:80: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  883 |                 DMESG("rxcommandpackethandle819xusb: It is a command packet\n");
      |                                                                                ^

Changing the empty macro to no_printk() to shut up the compiler warnings
and add format string checking.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/rtl8192u/r8192U.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index ec33fb9122e9..4013107cd93a 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -46,9 +46,9 @@
 #define KEY_BUF_SIZE    5
 
 #define	RX_SMOOTH_FACTOR		20
-#define DMESG(x, a...)
-#define DMESGW(x, a...)
-#define DMESGE(x, a...)
+#define DMESG(x, a...)  no_printk(x, ##a)
+#define DMESGW(x, a...) no_printk(x, ##a)
+#define DMESGE(x, a...) no_printk(x, ##a)
 extern u32 rt_global_debug_component;
 #define RT_TRACE(component, x, args...) \
 	do {							\
-- 
2.29.2

