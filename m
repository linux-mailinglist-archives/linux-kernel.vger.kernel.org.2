Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392D737A2FE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhEKJJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:09:18 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:35330 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhEKJJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:09:16 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id E8864D1BD5;
        Tue, 11 May 2021 17:08:04 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P2750T140649399834368S1620724083479486_;
        Tue, 11 May 2021 17:08:04 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <5e7375e9cb175c45ce8adb932f730bbf>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: mturquette@baylibre.com
X-RCPT-COUNT: 12
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Elaine@vger.kernel.org, Zhang@vger.kernel.org
To:     mturquette@baylibre.com, sboyd@kernel.org, heiko@sntech.de
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        huangtao@rock-chips.com, kever.yang@rock-chips.com,
        tony.xie@rock-chips.com, finley.xiao@rock-chips.com,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v1] clk: rockchip: Optimize PLL table memory usage
Date:   Tue, 11 May 2021 17:07:26 +0800
Message-Id: <20210511090726.15146-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

Before the change: The sizeof rk3568_pll_rates = 2544
Use union: The sizeof rk3568_pll_rates = 1696

In future Soc, more PLL types will be added, and the
rockchip_pll_rate_table will add more members,
and the space savings will be even more pronounced
by using union.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk.h | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 571cee7bbfdc..7aa45cc70287 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -271,17 +271,24 @@ struct rockchip_clk_provider {
 
 struct rockchip_pll_rate_table {
 	unsigned long rate;
-	unsigned int nr;
-	unsigned int nf;
-	unsigned int no;
-	unsigned int nb;
-	/* for RK3036/RK3399 */
-	unsigned int fbdiv;
-	unsigned int postdiv1;
-	unsigned int refdiv;
-	unsigned int postdiv2;
-	unsigned int dsmpd;
-	unsigned int frac;
+	union {
+		struct {
+			/* for RK3066 */
+			unsigned int nr;
+			unsigned int nf;
+			unsigned int no;
+			unsigned int nb;
+		};
+		struct {
+			/* for RK3036/RK3399 */
+			unsigned int fbdiv;
+			unsigned int postdiv1;
+			unsigned int refdiv;
+			unsigned int postdiv2;
+			unsigned int dsmpd;
+			unsigned int frac;
+		};
+	};
 };
 
 /**
-- 
2.17.1



