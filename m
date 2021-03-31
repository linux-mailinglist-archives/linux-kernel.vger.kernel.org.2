Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651F634FDAA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbhCaJ7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbhCaJ7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:59:40 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4A3C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:59:40 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:ada2:b4da:6568:5ad5])
        by xavier.telenet-ops.be with bizsmtp
        id mxzd2400A5W9KJv01xzdYQ; Wed, 31 Mar 2021 11:59:37 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lRXdQ-00BseR-Ok; Wed, 31 Mar 2021 11:59:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lRW0W-001XUV-DX; Wed, 31 Mar 2021 10:15:20 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] reset: RESET_INTEL_GW should depend on X86
Date:   Wed, 31 Mar 2021 10:15:19 +0200
Message-Id: <20210331081519.367024-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel Gateway reset controller is only present on Intel Gateway
platforms.  Hence add a dependency on X86, to prevent asking the user
about this driver when configuring a kernel without Intel Gateway
support.

Fixes: c9aef213e38cde27 ("reset: intel: Add system reset controller driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/reset/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 6dba675bcec47777..c5dc1503de7909fa 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -83,6 +83,7 @@ config RESET_IMX7
 
 config RESET_INTEL_GW
 	bool "Intel Reset Controller Driver"
+	depends on X86 || COMPILE_TEST
 	depends on OF && HAS_IOMEM
 	select REGMAP_MMIO
 	help
-- 
2.25.1

