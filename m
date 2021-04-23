Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF47368D25
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbhDWG0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:26:03 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:28514 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240645AbhDWGZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:25:49 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d49 with ME
        id w6RC2400421Fzsu036RCl9; Fri, 23 Apr 2021 08:25:12 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Apr 2021 08:25:12 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        gregory.clement@bootlin.com, thomas.petazzoni@free-electrons.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/4] clk: mvebu: Fix a another memory leak in an error handling path
Date:   Fri, 23 Apr 2021 08:25:10 +0200
Message-Id: <5f1ba3fb1950a2743ec8c4baa4b4925f134c0f28.1619157996.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1619157996.git.christophe.jaillet@wanadoo.fr>
References: <cover.1619157996.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we exit the for_each_of_cpu_node loop early, the reference on the
current node must be decremented, otherwise there is a leak.

Fixes: ab8ba01b3fe5 ("clk: mvebu: add armada-370-xp CPU specific clocks")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clk/mvebu/clk-cpu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index a11d7273fcc7..9a5c2aec6ec2 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -199,11 +199,14 @@ static void __init of_cpu_clk_setup(struct device_node *node)
 		int cpu, err;
 
 		err = of_property_read_u32(dn, "reg", &cpu);
-		if (WARN_ON(err))
+		if (WARN_ON(err)) {
+			of_node_put(dn);
 			goto bail_out;
+		}
 
 		clk_name = kasprintf(GFP_KERNEL, "cpu%d", cpu);
 		if (WARN_ON(!clk_name)) {
+			of_node_put(dn);
 			goto bail_out;
 		}
 
@@ -222,8 +225,10 @@ static void __init of_cpu_clk_setup(struct device_node *node)
 		init.num_parents = 1;
 
 		clk = clk_register(NULL, &cpuclk[cpu].hw);
-		if (WARN_ON(IS_ERR(clk)))
+		if (WARN_ON(IS_ERR(clk))) {
+			of_node_put(dn);
 			goto bail_out;
+		}
 		clks[cpu] = clk;
 	}
 	clk_data.clk_num = MAX_CPU;
-- 
2.27.0

