Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91FC35D823
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 08:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244753AbhDMGhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:37:17 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:53886 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230350AbhDMGhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:37:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UVQQ.CO_1618295806;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVQQ.CO_1618295806)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 13 Apr 2021 14:36:54 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.shishkin@linux.intel.com
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] stm class: remove useless function
Date:   Tue, 13 Apr 2021 14:36:43 +0800
Message-Id: <1618295803-19756-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following clang warning:

drivers/hwtracing/stm/policy.c:60:21: warning: unused function
'stp_policy_node_name' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/hwtracing/stm/policy.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hwtracing/stm/policy.c b/drivers/hwtracing/stm/policy.c
index 603b4a99..42103c3 100644
--- a/drivers/hwtracing/stm/policy.c
+++ b/drivers/hwtracing/stm/policy.c
@@ -57,11 +57,6 @@ void stp_policy_node_get_ranges(struct stp_policy_node *policy_node,
 	*cend	= policy_node->last_channel;
 }
 
-static inline char *stp_policy_node_name(struct stp_policy_node *policy_node)
-{
-	return policy_node->group.cg_item.ci_name ? : "<none>";
-}
-
 static inline struct stp_policy *to_stp_policy(struct config_item *item)
 {
 	return item ?
-- 
1.8.3.1

