Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38017368D22
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbhDWGZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:25:42 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:50770 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240645AbhDWGZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:25:39 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d49 with ME
        id w6R22400i21Fzsu036R3ju; Fri, 23 Apr 2021 08:25:03 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Apr 2021 08:25:03 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        gregory.clement@bootlin.com, thomas.petazzoni@free-electrons.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/4] clk: mvebu: Fix a memory leak in an error handling path
Date:   Fri, 23 Apr 2021 08:25:01 +0200
Message-Id: <27db232fdd14e14d493f29a5404d9e643f09cc96.1619157996.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1619157996.git.christophe.jaillet@wanadoo.fr>
References: <cover.1619157996.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs in the for_each loop, clk_name must be freed.

In order to do so, sightly rearrange the code:
   - move the allocation to simplify error handling
   - use kasprintf instead of kzalloc/sprintf to simplify code and avoid a
     magic number

Fixes: ab8ba01b3fe5 ("clk: mvebu: add armada-370-xp CPU specific clocks")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The { } around the 1 line block after kasprintf is intentional and makes
sense with 2/2
---
 drivers/clk/mvebu/clk-cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index c2af3395cf13..a11d7273fcc7 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -195,17 +195,17 @@ static void __init of_cpu_clk_setup(struct device_node *node)
 	for_each_of_cpu_node(dn) {
 		struct clk_init_data init;
 		struct clk *clk;
-		char *clk_name = kzalloc(5, GFP_KERNEL);
+		char *clk_name;
 		int cpu, err;
 
-		if (WARN_ON(!clk_name))
-			goto bail_out;
-
 		err = of_property_read_u32(dn, "reg", &cpu);
 		if (WARN_ON(err))
 			goto bail_out;
 
-		sprintf(clk_name, "cpu%d", cpu);
+		clk_name = kasprintf(GFP_KERNEL, "cpu%d", cpu);
+		if (WARN_ON(!clk_name)) {
+			goto bail_out;
+		}
 
 		cpuclk[cpu].parent_name = of_clk_get_parent_name(node, 0);
 		cpuclk[cpu].clk_name = clk_name;
-- 
2.27.0

