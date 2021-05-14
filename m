Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66628380394
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 08:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhENGQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 02:16:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3681 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhENGQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 02:16:21 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FhJ8q71tbz16PpQ;
        Fri, 14 May 2021 14:12:27 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 14 May 2021
 14:15:01 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <dinguyen@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <s.trumtrar@pengutronix.de>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] clk: socfpga: remove set but not used variable 'rc'
Date:   Fri, 14 May 2021 14:22:34 +0800
Message-ID: <20210514062234.3534615-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/clk/socfpga/clk-pll.c:83:6: warning: variable ‘rc’ set but
not used [-Wunused-but-set-variable]

The returned value of of_clk_add_provider() is never used, and so
can be removed.

Fixes: 97259e99bdc9 ("clk: socfpga: split clk code")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/clk/socfpga/clk-pll.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
index dcb573d44034..127cc849c5ee 100644
--- a/drivers/clk/socfpga/clk-pll.c
+++ b/drivers/clk/socfpga/clk-pll.c
@@ -80,7 +80,6 @@ static __init struct clk_hw *__socfpga_pll_init(struct device_node *node,
 	const char *parent_name[SOCFPGA_MAX_PARENTS];
 	struct clk_init_data init;
 	struct device_node *clkmgr_np;
-	int rc;
 	int err;
 
 	of_property_read_u32(node, "reg", &reg);
@@ -114,7 +113,7 @@ static __init struct clk_hw *__socfpga_pll_init(struct device_node *node,
 		kfree(pll_clk);
 		return ERR_PTR(err);
 	}
-	rc = of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
+	of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
 	return hw_clk;
 }
 
-- 
2.25.4

