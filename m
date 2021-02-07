Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855FA312260
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 09:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBGIDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 03:03:55 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:50175 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhBGIDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 03:03:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UO3XEeI_1612684972;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UO3XEeI_1612684972)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 07 Feb 2021 16:02:56 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     krzk@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH v2] memory: tegra186-emc: Replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
Date:   Sun,  7 Feb 2021 16:02:50 +0800
Message-Id: <1612684970-125948-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/memory/tegra/tegra186-emc.c:158:0-23: WARNING:
tegra186_emc_debug_max_rate_fops should be defined with
DEFINE_DEBUGFS_ATTRIBUTE.

drivers/memory/tegra/tegra186-emc.c:128:0-23: WARNING:
tegra186_emc_debug_min_rate_fops should be defined with
DEFINE_DEBUGFS_ATTRIBUTE.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  - Stripped unrelated parts of the paths (./). 

 drivers/memory/tegra/tegra186-emc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index fa8af17..d65e7c2 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -125,9 +125,9 @@ static int tegra186_emc_debug_min_rate_set(void *data, u64 rate)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(tegra186_emc_debug_min_rate_fops,
-			tegra186_emc_debug_min_rate_get,
-			tegra186_emc_debug_min_rate_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(tegra186_emc_debug_min_rate_fops,
+			  tegra186_emc_debug_min_rate_get,
+			  tegra186_emc_debug_min_rate_set, "%llu\n");
 
 static int tegra186_emc_debug_max_rate_get(void *data, u64 *rate)
 {
@@ -155,9 +155,9 @@ static int tegra186_emc_debug_max_rate_set(void *data, u64 rate)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(tegra186_emc_debug_max_rate_fops,
-			tegra186_emc_debug_max_rate_get,
-			tegra186_emc_debug_max_rate_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(tegra186_emc_debug_max_rate_fops,
+			  tegra186_emc_debug_max_rate_get,
+			  tegra186_emc_debug_max_rate_set, "%llu\n");
 
 static int tegra186_emc_probe(struct platform_device *pdev)
 {
-- 
1.8.3.1

