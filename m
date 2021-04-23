Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC71368D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240803AbhDWHDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:03:08 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:18014 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbhDWHDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:03:06 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d49 with ME
        id w72U2400A21Fzsu0372UQK; Fri, 23 Apr 2021 09:02:29 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Apr 2021 09:02:29 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mturquette@baylibre.com, sboyd@kernel.org, lee.jones@linaro.org,
        Julia.Lawall@inria.fr, gregory.clement@bootlin.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] clk: mvebu: ap-cpu-clk: Fix a memory leak in error handling paths
Date:   Fri, 23 Apr 2021 09:02:26 +0200
Message-Id: <545df946044fc1fc05a4217cdf0054be7a79e49e.1619161112.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we exit the for_each_of_cpu_node loop early, the reference on the
current node must be decremented, otherwise there is a leak.

Fixes: f756e362d938 ("clk: mvebu: add CPU clock driver for Armada 7K/8K")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Also, I wonder if the drivers in drivers/clk/mvebu are used by anyone.
In order to compile-test the changes, I also had to change the 'bool' in Kconfig
by 'bool "blah"'. Without this change, it was not possible to set
CONFIG_ARMADA_AP_CPU_CLK required by Makefile.

I don't know if I did something wrong, if it is an issue only on my environment
or if something got broken at some time in the build chain but it looks
spurious.

If I'm right and that these drivers never compile and no-one noticed it,
maybe removing them is better than fixing some unlikely issues and style.
If these drivers should stay, Kconfig may need some love from someone.
---
 drivers/clk/mvebu/ap-cpu-clk.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mvebu/ap-cpu-clk.c b/drivers/clk/mvebu/ap-cpu-clk.c
index 08ba59ec3fb1..71bdd7c3ff03 100644
--- a/drivers/clk/mvebu/ap-cpu-clk.c
+++ b/drivers/clk/mvebu/ap-cpu-clk.c
@@ -256,12 +256,15 @@ static int ap_cpu_clock_probe(struct platform_device *pdev)
 		int cpu, err;
 
 		err = of_property_read_u32(dn, "reg", &cpu);
-		if (WARN_ON(err))
+		if (WARN_ON(err)) {
+			of_node_put(dn);
 			return err;
+		}
 
 		/* If cpu2 or cpu3 is enabled */
 		if (cpu & APN806_CLUSTER_NUM_MASK) {
 			nclusters = 2;
+			of_node_put(dn);
 			break;
 		}
 	}
@@ -288,8 +291,10 @@ static int ap_cpu_clock_probe(struct platform_device *pdev)
 		int cpu, err;
 
 		err = of_property_read_u32(dn, "reg", &cpu);
-		if (WARN_ON(err))
+		if (WARN_ON(err)) {
+			of_node_put(dn);
 			return err;
+		}
 
 		cluster_index = cpu & APN806_CLUSTER_NUM_MASK;
 		cluster_index >>= APN806_CLUSTER_NUM_OFFSET;
@@ -301,6 +306,7 @@ static int ap_cpu_clock_probe(struct platform_device *pdev)
 		parent = of_clk_get(np, cluster_index);
 		if (IS_ERR(parent)) {
 			dev_err(dev, "Could not get the clock parent\n");
+			of_node_put(dn);
 			return -EINVAL;
 		}
 		parent_name =  __clk_get_name(parent);
@@ -319,8 +325,10 @@ static int ap_cpu_clock_probe(struct platform_device *pdev)
 		init.parent_names = &parent_name;
 
 		ret = devm_clk_hw_register(dev, &ap_cpu_clk[cluster_index].hw);
-		if (ret)
+		if (ret) {
+			of_node_put(dn);
 			return ret;
+		}
 		ap_cpu_data->hws[cluster_index] = &ap_cpu_clk[cluster_index].hw;
 	}
 
-- 
2.27.0

