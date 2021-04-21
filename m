Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F786366D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239109AbhDUNxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233038AbhDUNxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:53:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15A5A60720;
        Wed, 21 Apr 2021 13:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619013179;
        bh=zm33FFo0oaYHNMKYEHBLMyzmz7eFwL2hEZFcgUnD+dM=;
        h=From:To:Cc:Subject:Date:From;
        b=BofO5KVgzmshHM2H9cRjLeD6M2f3MdJCnCWrrVELml3/ppv3PUh9V+D0ceL8a6Rsi
         1qvy1qI9+VJ7GLEOlB83ltJg/lX22mjmcknfvDk7Fya02cLxgi1hZogrdGXhMWRqmf
         Bs2QlUMOmUEXYc6gzhyz8vX6g/aHr4tGAgADfbdORMmQIsAxEZrhELOnHMMIsu48jW
         O87MDMZgoXFU8YRSHCPsHwpJLEW8sVRnpvEVp6+QvCl9kMUbdRNBr8Hzu0jqcWO5UG
         Vrsic7Rh4hODA+sBdwKEFlEQGdj4o8Y4ifnSDZLAbO6PD1TlOp+nwJ24LRrU09VVsB
         hWZ9QvxJ262lQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Oded Gabbay <ogabbay@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ofir Bitton <obitton@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Ohad Sharabi <osharabi@habana.ai>,
        Alon Mizrahi <amizrahi@habana.ai>, linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: fix enum type mismatch
Date:   Wed, 21 Apr 2021 15:52:35 +0200
Message-Id: <20210421135253.3435360-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The definition of these two arrays does not match the type of the
enums in them:

drivers/misc/habanalabs/goya/goya.c:136:21: error: implicit conversion from 'enum goya_pll_index' to 'enum pll_index' [-Werror=enum-conversion]
  136 |         [CPU_PLL] = GOYA_CPU_PLL,
drivers/misc/habanalabs/gaudi/gaudi.c:126:21: error: implicit conversion from 'enum gaudi_pll_index' to 'enum pll_index' [-Werror=enum-conversion]
  126 |         [CPU_PLL] = GAUDI_CPU_PLL,

Remove the enum and just use literal numbers, which avoids the
warning and is more concise without really losing any information.

Fixes: e8f9392a5c7f ("habanalabs: support legacy and new pll indexes")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 38 ++++++++-------------------
 drivers/misc/habanalabs/goya/goya.c   | 29 ++++++--------------
 2 files changed, 19 insertions(+), 48 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index b751652f80a8..69bd7ff694f8 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -105,34 +105,18 @@
 
 #define GAUDI_PLL_MAX 10
 
-/*
- * this enum kept here for compatibility with old FW (in which each asic has
- * unique PLL numbering
- */
-enum gaudi_pll_index {
-	GAUDI_CPU_PLL = 0,
-	GAUDI_PCI_PLL,
-	GAUDI_SRAM_PLL,
-	GAUDI_HBM_PLL,
-	GAUDI_NIC_PLL,
-	GAUDI_DMA_PLL,
-	GAUDI_MESH_PLL,
-	GAUDI_MME_PLL,
-	GAUDI_TPC_PLL,
-	GAUDI_IF_PLL,
-};
-
+/* compatibility with old FW (in which each asic has unique PLL numbering */
 static enum pll_index gaudi_pll_map[PLL_MAX] = {
-	[CPU_PLL] = GAUDI_CPU_PLL,
-	[PCI_PLL] = GAUDI_PCI_PLL,
-	[SRAM_PLL] = GAUDI_SRAM_PLL,
-	[HBM_PLL] = GAUDI_HBM_PLL,
-	[NIC_PLL] = GAUDI_NIC_PLL,
-	[DMA_PLL] = GAUDI_DMA_PLL,
-	[MESH_PLL] = GAUDI_MESH_PLL,
-	[MME_PLL] = GAUDI_MME_PLL,
-	[TPC_PLL] = GAUDI_TPC_PLL,
-	[IF_PLL] = GAUDI_IF_PLL,
+	[CPU_PLL] = 0,
+	[PCI_PLL] = 1,
+	[SRAM_PLL] = 2,
+	[HBM_PLL] = 3,
+	[NIC_PLL] = 4,
+	[DMA_PLL] = 5,
+	[MESH_PLL] = 6,
+	[MME_PLL] = 7,
+	[TPC_PLL] = 8,
+	[IF_PLL] = 9,
 };
 
 static const char gaudi_irq_name[GAUDI_MSI_ENTRIES][GAUDI_MAX_STRING_LEN] = {
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index e27338f4aad2..0a8cf00b5f45 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -118,28 +118,15 @@
 #define IS_MME_IDLE(mme_arch_sts) \
 	(((mme_arch_sts) & MME_ARCH_IDLE_MASK) == MME_ARCH_IDLE_MASK)
 
-/*
- * this enum kept here for compatibility with old FW (in which each asic has
- * unique PLL numbering
- */
-enum goya_pll_index {
-	GOYA_CPU_PLL = 0,
-	GOYA_IC_PLL,
-	GOYA_MC_PLL,
-	GOYA_MME_PLL,
-	GOYA_PCI_PLL,
-	GOYA_EMMC_PLL,
-	GOYA_TPC_PLL,
-};
-
+/* compatibility with old FW (in which each asic has unique PLL numbering */
 static enum pll_index goya_pll_map[PLL_MAX] = {
-	[CPU_PLL] = GOYA_CPU_PLL,
-	[IC_PLL] = GOYA_IC_PLL,
-	[MC_PLL] = GOYA_MC_PLL,
-	[MME_PLL] = GOYA_MME_PLL,
-	[PCI_PLL] = GOYA_PCI_PLL,
-	[EMMC_PLL] = GOYA_EMMC_PLL,
-	[TPC_PLL] = GOYA_TPC_PLL,
+	[CPU_PLL] = 0,
+	[IC_PLL] = 1,
+	[MC_PLL] = 2,
+	[MME_PLL] = 3,
+	[PCI_PLL] = 4,
+	[EMMC_PLL] = 5,
+	[TPC_PLL] = 6,
 };
 
 static const char goya_irq_name[GOYA_MSIX_ENTRIES][GOYA_MAX_STRING_LEN] = {
-- 
2.29.2

