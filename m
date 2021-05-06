Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E963752AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhEFK5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:57:52 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:49455 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234508AbhEFK5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:57:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UXyl1SF_1620298592;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UXyl1SF_1620298592)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 May 2021 18:56:50 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ASoC: amd: renoir: Remove redundant assignment to pdm_ctrl and pdm_enable and pdm_dma_enable
Date:   Thu,  6 May 2021 18:56:30 +0800
Message-Id: <1620298590-29749-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable pdm_ctrl and pdm_enable and pdm_dma_enable are set to '0x00',
but they are overwritten later on, so these are redundant assignments
that can be removed.

Clean up the following clang-analyzer warning:

sound/soc/amd/renoir/acp3x-pdm-dma.c:148:2: warning: Value stored to
'pdm_dma_enable' is never read [clang-analyzer-deadcode.DeadStores].

sound/soc/amd/renoir/acp3x-pdm-dma.c:147:2: warning: Value stored to
'pdm_enable' is never read [clang-analyzer-deadcode.DeadStores].

sound/soc/amd/renoir/acp3x-pdm-dma.c:80:2: warning: Value stored to
'pdm_ctrl' is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/amd/renoir/acp3x-pdm-dma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/amd/renoir/acp3x-pdm-dma.c b/sound/soc/amd/renoir/acp3x-pdm-dma.c
index 4c2810e..bd20622b 100644
--- a/sound/soc/amd/renoir/acp3x-pdm-dma.c
+++ b/sound/soc/amd/renoir/acp3x-pdm-dma.c
@@ -77,7 +77,6 @@ static void enable_pdm_clock(void __iomem *acp_base)
 	u32 pdm_clk_enable, pdm_ctrl;
 
 	pdm_clk_enable = ACP_PDM_CLK_FREQ_MASK;
-	pdm_ctrl = 0x00;
 
 	rn_writel(pdm_clk_enable, acp_base + ACP_WOV_CLK_CTRL);
 	pdm_ctrl = rn_readl(acp_base + ACP_WOV_MISC_CTRL);
@@ -144,9 +143,6 @@ static int stop_pdm_dma(void __iomem *acp_base)
 	u32 pdm_enable, pdm_dma_enable;
 	int timeout;
 
-	pdm_enable = 0x00;
-	pdm_dma_enable  = 0x00;
-
 	pdm_enable = rn_readl(acp_base + ACP_WOV_PDM_ENABLE);
 	pdm_dma_enable = rn_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
 	if (pdm_dma_enable & 0x01) {
-- 
1.8.3.1

