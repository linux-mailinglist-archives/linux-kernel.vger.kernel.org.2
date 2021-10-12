Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9A5429A94
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 02:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhJLAz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 20:55:58 -0400
Received: from mx.socionext.com ([202.248.49.38]:59612 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230003AbhJLAz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 20:55:57 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 12 Oct 2021 09:53:55 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id CF8942058B40;
        Tue, 12 Oct 2021 09:53:55 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 12 Oct 2021 09:53:55 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 93E1CAB192;
        Tue, 12 Oct 2021 09:53:55 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 1/5] clk: uniphier: Add audio system and video input clock control for PXs3
Date:   Tue, 12 Oct 2021 09:53:51 +0900
Message-Id: <1634000035-3114-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634000035-3114-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1634000035-3114-1-git-send-email-hayashi.kunihiko@socionext.com>
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

