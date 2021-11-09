Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC36C44A5D1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 05:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242598AbhKIEht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 23:37:49 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:36616 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240672AbhKIEhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 23:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636432502; x=1667968502;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=poM1gZKQfjN+HtFXLe21lk9FzBES5xXKmX+iYnChdps=;
  b=bNdG9ALbQ54eAQUzxHKFq5uF0neO6+lW1V5IU0DC1U+OQYlb7olbMqPp
   K5XLVmSLOWKJaQBRoUan4AjwN1uTmhFKFiMjmoPwW8SiaolZWRN5dBoZy
   QIMv0uUrEbNCIW1s+nzUWBQHy4ivIoXV3GXNa/o7jiBlQuugs0Yf822wx
   Q=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Nov 2021 20:35:02 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 20:35:02 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 8 Nov 2021 20:35:01 -0800
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 8 Nov 2021 20:35:01 -0800
From:   Mike Tipton <quic_mdtipton@quicinc.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: [PATCH] clk: Fix children not voting entire parent chain during init
Date:   Mon, 8 Nov 2021 20:34:38 -0800
Message-ID: <20211109043438.4639-1-quic_mdtipton@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a child's parent is set by calling __clk_init_parent() while the
parent is still being registered in __clk_register(), then it can result
in the child voting its direct parent without those votes propagating up
the entire parent chain.

__clk_register() sets hw->core before grabbing the prepare_lock and
before initializing hw->core->parent. Since hw->core is used indirectly
by __clk_init_parent(), then children can find their parents before
they're fully initialized. If children vote for their parents during
this window, then those votes won't propagate past the direct parent.

This can happen when:
    1. CRITICAL clocks are enabled in __clk_core_init().
    2. Reparenting enabled orphans in clk_core_reparent_orphans_nolock().

Fix this by not setting hw->core until we've already grabbed the
prepare_lock in __clk_core_init(). This prevents orphaned children from
finding and voting their parents before the parents are fully
initialized.

Fixes: fc0c209c147f ("clk: Allow parents to be specified without string names")
Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
---

This is very difficult to reproduce. We can't reproduce it at all
internally, in fact. But some customers are able to reproduce it fairly
easily and this patch fixes it for them.

 drivers/clk/clk.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f467d63bbf1e..af562af9d54d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3418,6 +3418,13 @@ static int __clk_core_init(struct clk_core *core)
 
 	clk_prepare_lock();
 
+	/*
+	 * Set hw->core after grabbing the prepare_lock to prevent race
+	 * conditions with orphans finding and voting their parents before the
+	 * parents are fully initialized.
+	 */
+	core->hw->core = core;
+
 	ret = clk_pm_runtime_get(core);
 	if (ret)
 		goto unlock;
@@ -3582,8 +3589,10 @@ static int __clk_core_init(struct clk_core *core)
 out:
 	clk_pm_runtime_put(core);
 unlock:
-	if (ret)
+	if (ret) {
 		hlist_del_init(&core->child_node);
+		core->hw->core = NULL;
+	}
 
 	clk_prepare_unlock();
 
@@ -3847,7 +3856,6 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 	core->num_parents = init->num_parents;
 	core->min_rate = 0;
 	core->max_rate = ULONG_MAX;
-	hw->core = core;
 
 	ret = clk_core_populate_parent_map(core, init);
 	if (ret)
@@ -3865,7 +3873,7 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 		goto fail_create_clk;
 	}
 
-	clk_core_link_consumer(hw->core, hw->clk);
+	clk_core_link_consumer(core, hw->clk);
 
 	ret = __clk_core_init(core);
 	if (!ret)
-- 
2.31.1

