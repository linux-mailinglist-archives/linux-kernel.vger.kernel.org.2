Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA0A368D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbhDWG0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:26:08 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:48267 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbhDWGZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:25:57 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d49 with ME
        id w6RL2400421Fzsu036RLls; Fri, 23 Apr 2021 08:25:20 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Apr 2021 08:25:20 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        gregory.clement@bootlin.com, thomas.petazzoni@free-electrons.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/4] clk: mvebu: Add a missing space
Date:   Fri, 23 Apr 2021 08:25:18 +0200
Message-Id: <39826a4aaf2b1769d7ff95301a25eab4adc98535.1619157996.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1619157996.git.christophe.jaillet@wanadoo.fr>
References: <cover.1619157996.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a checkpatch warning.
Add a missing space.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clk/mvebu/clk-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index 9a5c2aec6ec2..55a8486f665f 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -238,7 +238,7 @@ static void __init of_cpu_clk_setup(struct device_node *node)
 	return;
 bail_out:
 	kfree(clks);
-	while(ncpus--)
+	while (ncpus--)
 		kfree(cpuclk[ncpus].clk_name);
 clks_out:
 	kfree(cpuclk);
-- 
2.27.0

