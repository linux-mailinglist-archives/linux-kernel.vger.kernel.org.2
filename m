Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0C140BD73
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbhIOB5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:57:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233232AbhIOB47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:56:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7748E61214;
        Wed, 15 Sep 2021 01:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631670941;
        bh=U0FpOLu57zGumfxCfqMsFNk0eDDobWRALMMSgQeZdDY=;
        h=From:To:Cc:Subject:Date:From;
        b=nklhtqNKA4HLPMOXg7Uq2UdUAVLWBK4tY5yhXPCKm8kDX1fqOOOCyrLN1ZVI1N/sV
         yLTOnBV3L+uoRl6A8yX7/8j3tKGoOGObyuqcimNEEwj8LzVYx58yCdwoEg7y3q3kzt
         EtvktubffzITOUXmHsBI7ysGHkgt4kMj61x82n4p9Rbqm3caGsKRzq5LhxVa5nnZts
         +/EmwymC9C3TRr/zrBqRJjUKyPUu5FzEGAZZ0i5boayWDtH8au/h7vcAx2/CUnvC5s
         V1FymYk/Oz8MaZgqIsQSlIYp7V7ZS63A2qYOwAv4ZUBCUO//2HXaPCd4T8Q9oFXpdm
         75ywt44JBFNFQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Hanks Chen <hanks.chen@mediatek.com>,
        Wendell Lin <wendell.lin@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] clk: mediatek: Export clk_ops structures to modules
Date:   Tue, 14 Sep 2021 18:55:40 -0700
Message-Id: <20210915015540.1732014-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

modpost complains once these drivers become modules.

 ERROR: modpost: "mtk_mux_gate_clr_set_upd_ops" [drivers/clk/mediatek/clk-mt6779.ko] undefined!

Let's just export them.

Cc: Hanks Chen <hanks.chen@mediatek.com>
Cc: Wendell Lin <wendell.lin@mediatek.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Miles Chen <miles.chen@mediatek.com>
Fixes: 32b028fb1d09 ("clk: mediatek: support COMMON_CLK_MEDIATEK module build")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/mediatek/clk-mux.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 6b8a274e2c01..6d3a50eb7d6f 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -121,6 +121,7 @@ const struct clk_ops mtk_mux_clr_set_upd_ops = {
 	.get_parent = mtk_clk_mux_get_parent,
 	.set_parent = mtk_clk_mux_set_parent_setclr_lock,
 };
+EXPORT_SYMBOL_GPL(mtk_mux_clr_set_upd_ops);
 
 const struct clk_ops mtk_mux_gate_clr_set_upd_ops  = {
 	.enable = mtk_clk_mux_enable_setclr,
@@ -129,6 +130,7 @@ const struct clk_ops mtk_mux_gate_clr_set_upd_ops  = {
 	.get_parent = mtk_clk_mux_get_parent,
 	.set_parent = mtk_clk_mux_set_parent_setclr_lock,
 };
+EXPORT_SYMBOL_GPL(mtk_mux_gate_clr_set_upd_ops);
 
 static struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
 				 struct regmap *regmap,

base-commit: f09b9460a5e448dac8fb4f645828c0668144f9e6
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

