Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91206433119
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhJSId4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:33:56 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:37967 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234537AbhJSIdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:33:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UsuQa83_1634632296;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UsuQa83_1634632296)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Oct 2021 16:31:37 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     krzysztof.kozlowski@canonical.com
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] memory: tegra20-emc: replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
Date:   Tue, 19 Oct 2021 16:31:34 +0800
Message-Id: <1634632294-27413-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./drivers/memory/tegra/tegra20-emc.c:915:0-23: WARNING:
tegra_emc_debug_max_rate_fops should be defined with
DEFINE_DEBUGFS_ATTRIBUTE
./drivers/memory/tegra/tegra20-emc.c:885:0-23: WARNING:
tegra_emc_debug_min_rate_fops should be defined with
DEFINE_DEBUGFS_ATTRIBUTE

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/memory/tegra/tegra20-emc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 77c5cd5..f4d3470 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -882,7 +882,7 @@ static int tegra_emc_debug_min_rate_set(void *data, u64 rate)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(tegra_emc_debug_min_rate_fops,
+DEFINE_DEBUGFS_ATTRIBUTE(tegra_emc_debug_min_rate_fops,
 			tegra_emc_debug_min_rate_get,
 			tegra_emc_debug_min_rate_set, "%llu\n");
 
@@ -912,7 +912,7 @@ static int tegra_emc_debug_max_rate_set(void *data, u64 rate)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(tegra_emc_debug_max_rate_fops,
+DEFINE_DEBUGFS_ATTRIBUTE(tegra_emc_debug_max_rate_fops,
 			tegra_emc_debug_max_rate_get,
 			tegra_emc_debug_max_rate_set, "%llu\n");
 
-- 
1.8.3.1

