Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D5C355B52
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 20:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbhDFS15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 14:27:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43055 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbhDFS14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 14:27:56 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lTqQU-0006PL-Co; Tue, 06 Apr 2021 18:27:46 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] clk: socfpga: remove redundant initialization of variable div
Date:   Tue,  6 Apr 2021 19:27:46 +0100
Message-Id: <20210406182746.432861-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable div is being initialized with a value that is
never read and it is being updated later with a new value.  The
initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/clk/socfpga/clk-gate-s10.c | 2 +-
 drivers/clk/socfpga/clk-pll-s10.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/socfpga/clk-gate-s10.c b/drivers/clk/socfpga/clk-gate-s10.c
index f9f403d7bb58..b84f2627551e 100644
--- a/drivers/clk/socfpga/clk-gate-s10.c
+++ b/drivers/clk/socfpga/clk-gate-s10.c
@@ -31,7 +31,7 @@ static unsigned long socfpga_dbg_clk_recalc_rate(struct clk_hw *hwclk,
 						  unsigned long parent_rate)
 {
 	struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
-	u32 div = 1, val;
+	u32 div, val;
 
 	val = readl(socfpgaclk->div_reg) >> socfpgaclk->shift;
 	val &= GENMASK(socfpgaclk->width - 1, 0);
diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-pll-s10.c
index bc37461d43c0..70076a80149d 100644
--- a/drivers/clk/socfpga/clk-pll-s10.c
+++ b/drivers/clk/socfpga/clk-pll-s10.c
@@ -107,7 +107,7 @@ static unsigned long clk_boot_clk_recalc_rate(struct clk_hw *hwclk,
 					 unsigned long parent_rate)
 {
 	struct socfpga_pll *socfpgaclk = to_socfpga_clk(hwclk);
-	u32 div = 1;
+	u32 div;
 
 	div = ((readl(socfpgaclk->hw.reg) &
 		SWCTRLBTCLKSEL_MASK) >>
-- 
2.30.2

