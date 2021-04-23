Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955E3368D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240781AbhDWG0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:26:14 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:47927 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240699AbhDWG0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:26:05 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d49 with ME
        id w6RT2400Y21Fzsu036RUmj; Fri, 23 Apr 2021 08:25:28 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Apr 2021 08:25:28 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        gregory.clement@bootlin.com, thomas.petazzoni@free-electrons.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 4/4] clk: mvebu: Remove an unneeded include
Date:   Fri, 23 Apr 2021 08:25:26 +0200
Message-Id: <0dfcf67d0afe0cd58fd267ef0c4ec0d0414b6fe7.1619157996.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1619157996.git.christophe.jaillet@wanadoo.fr>
References: <cover.1619157996.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling without <asm/smp_plat.h> just works fine, so remove it

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Completely speculative, but compilation works for me without this include
---
 drivers/clk/mvebu/clk-cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index 55a8486f665f..4879458c768a 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -16,7 +16,6 @@
 #include <linux/of.h>
 #include <linux/delay.h>
 #include <linux/mvebu-pmsu.h>
-#include <asm/smp_plat.h>
 
 #define SYS_CTRL_CLK_DIVIDER_CTRL_OFFSET               0x0
 #define   SYS_CTRL_CLK_DIVIDER_CTRL_RESET_ALL          0xff
-- 
2.27.0

