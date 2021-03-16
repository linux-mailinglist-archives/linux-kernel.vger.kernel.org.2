Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB2133D4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbhCPNhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbhCPNhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:37:07 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3069CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 06:37:07 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:b1e0:9434:c5b6:aecd])
        by michel.telenet-ops.be with bizsmtp
        id h1d22400J0UTkXy061d2CT; Tue, 16 Mar 2021 14:37:04 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lM9sc-0088QO-B5; Tue, 16 Mar 2021 14:37:02 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lM9sb-009yI2-U4; Tue, 16 Mar 2021 14:37:01 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mfd: ABX500_CORE should depend on ARCH_U8500
Date:   Tue, 16 Mar 2021 14:37:00 +0100
Message-Id: <20210316133700.2376662-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ST-Ericsson ABX500 Mixed Signal IC family chips are only present on
ST-Ericsson U8500 Series platforms.  Hence add a dependency on
ARCH_U8500, to prevent asking the user about this driver when
configuring a kernel without U8500 support.

Also, merely enabling CONFIG_COMPILE_TEST should not enable additional
code, and thus should not enable this driver by default.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mfd/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 21a131d4e7bb9eca..d07e8cf9328612c5 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1235,7 +1235,8 @@ config MFD_SC27XX_PMIC
 
 config ABX500_CORE
 	bool "ST-Ericsson ABX500 Mixed Signal Circuit register functions"
-	default y if ARCH_U8500 || COMPILE_TEST
+	depends on ARCH_U8500 || COMPILE_TEST
+	default y if ARCH_U8500
 	help
 	  Say yes here if you have the ABX500 Mixed Signal IC family
 	  chips. This core driver expose register access functions.
-- 
2.25.1

