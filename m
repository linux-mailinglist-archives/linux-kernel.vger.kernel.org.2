Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C3C423C09
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbhJFLLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:11:11 -0400
Received: from mx.socionext.com ([202.248.49.38]:1102 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237952AbhJFLLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:11:09 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 06 Oct 2021 20:09:16 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 290422059034;
        Wed,  6 Oct 2021 20:09:16 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 6 Oct 2021 20:09:16 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id D3704AB192;
        Wed,  6 Oct 2021 20:09:15 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 1/5] clk: uniphier: Add audio system and video input clock control for PXs3
Date:   Wed,  6 Oct 2021 20:09:11 +0900
Message-Id: <1633518555-8195-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633518555-8195-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1633518555-8195-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clocks for audio subsystem (AIO) and video input subsystem (EXIV) on
UniPhier PXs3 SoC.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/clk/uniphier/clk-uniphier-sys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index 32b301724183..0ec28ebc39c2 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -288,6 +288,8 @@ const struct uniphier_clk_data uniphier_pxs3_sys_clk_data[] = {
 	UNIPHIER_CLK_GATE("sata0", 28, NULL, 0x210c, 7),
 	UNIPHIER_CLK_GATE("sata1", 29, NULL, 0x210c, 8),
 	UNIPHIER_CLK_GATE("sata-phy", 30, NULL, 0x210c, 21),
+	UNIPHIER_LD11_SYS_CLK_AIO(40),
+	UNIPHIER_LD11_SYS_CLK_EXIV(42),
 	/* CPU gears */
 	UNIPHIER_CLK_DIV4("cpll", 2, 3, 4, 8),
 	UNIPHIER_CLK_DIV4("spll", 2, 3, 4, 8),
-- 
2.7.4

