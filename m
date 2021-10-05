Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95B3421F33
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhJEHCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:02:18 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:53540 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231816AbhJEHCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:02:14 -0400
X-UUID: be0b5d5e78f24b48875d241a10957d00-20211005
X-UUID: be0b5d5e78f24b48875d241a10957d00-20211005
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 4802693; Tue, 05 Oct 2021 15:00:20 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 5 Oct 2021 15:00:19 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 5 Oct
 2021 15:00:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Oct 2021 15:00:18 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <mark-pk.tsai@mediatek.com>, <yj.chiang@mediatek.com>,
        <matthias.bgg@gmail.com>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] clk: make clk_core_lookup faster by using clk name hash
Date:   Tue, 5 Oct 2021 14:59:49 +0800
Message-ID: <20211005065948.10092-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compare hash value before strcmp the full name to make
clk_core_lookup faster.

It make clk driver probe 30 percent faster on the platform
have 1483 registered clks and average clock name length 20.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 drivers/clk/clk.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 65508eb89ec9..d5f65fda3db8 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -89,6 +89,7 @@ struct clk_core {
 	struct hlist_node	debug_node;
 #endif
 	struct kref		ref;
+	unsigned int		hash;
 };
 
 #define CREATE_TRACE_POINTS
@@ -292,16 +293,17 @@ struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw)
 EXPORT_SYMBOL_GPL(clk_hw_get_parent);
 
 static struct clk_core *__clk_lookup_subtree(const char *name,
+					     unsigned int hash,
 					     struct clk_core *core)
 {
 	struct clk_core *child;
 	struct clk_core *ret;
 
-	if (!strcmp(core->name, name))
+	if (hash == core->hash && !strcmp(core->name, name))
 		return core;
 
 	hlist_for_each_entry(child, &core->children, child_node) {
-		ret = __clk_lookup_subtree(name, child);
+		ret = __clk_lookup_subtree(name, hash, child);
 		if (ret)
 			return ret;
 	}
@@ -313,20 +315,22 @@ static struct clk_core *clk_core_lookup(const char *name)
 {
 	struct clk_core *root_clk;
 	struct clk_core *ret;
+	unsigned int hash;
 
 	if (!name)
 		return NULL;
 
+	hash = full_name_hash(NULL, name, strlen(name));
 	/* search the 'proper' clk tree first */
 	hlist_for_each_entry(root_clk, &clk_root_list, child_node) {
-		ret = __clk_lookup_subtree(name, root_clk);
+		ret = __clk_lookup_subtree(name, hash, root_clk);
 		if (ret)
 			return ret;
 	}
 
 	/* if not found, then search the orphan tree */
 	hlist_for_each_entry(root_clk, &clk_orphan_list, child_node) {
-		ret = __clk_lookup_subtree(name, root_clk);
+		ret = __clk_lookup_subtree(name, hash, root_clk);
 		if (ret)
 			return ret;
 	}
@@ -3827,6 +3831,7 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 		goto fail_name;
 	}
 
+	core->hash = full_name_hash(NULL, core->name, strlen(core->name));
 	if (WARN_ON(!init->ops)) {
 		ret = -EINVAL;
 		goto fail_ops;
-- 
2.18.0

