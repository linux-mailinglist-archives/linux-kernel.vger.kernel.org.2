Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F3742E1DD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 21:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhJNTPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 15:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232392AbhJNTPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:15:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26E1561108;
        Thu, 14 Oct 2021 19:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634238780;
        bh=5qD1P2LTtN0mwVjdHZNYQdfeTUsXyK//h1c7T1/LYX0=;
        h=From:To:Cc:Subject:Date:From;
        b=DoRYWtotHTCQKy2AqZgpcfZ3n2/c/YN9edIYGdaPhfWzd3QkLc2BbLPfmU3UtyltD
         Py+3O0Rk0JaL4bcwTIHPKZrnddQTA9JYHz0H6vcaRfBb45DvYMlPlyraXiBhaUROQr
         Rd1Kf0PtFowVR9j2ixkPm/RDU9bfrUR3XQGHWWu3FIokVgqjLrFd4SBHbQXQyK+4fR
         8243ZjRM4Sp3p29iLKImZSF2Vynhxekw5VoXOrjgsG1YJSXM8xEOLQsErJUsW5ZFsB
         jFSPlDmJlf3UBBmglECjHILt0kgLaLwskJr8TGtMkyZ9/x6IOFpd9ozdF3fcgG93tO
         phuHScJIGVzeg==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH] clk: qcom: gcc-sc7280: Drop unused array
Date:   Thu, 14 Oct 2021 12:12:59 -0700
Message-Id: <20211014191259.1689641-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 3165d1e3c737 ("clk: qcom: gcc: Remove CPUSS clocks control
for SC7280") this array is unused. Remove it.

Reported-by: kernel test robot <lkp@intel.com>
Cc: Taniya Das <tdas@codeaurora.org>
Fixes: 3165d1e3c737 ("clk: qcom: gcc: Remove CPUSS clocks control for SC7280")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/gcc-sc7280.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index 667f584bc2e1..8fb6bd69f240 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -197,12 +197,6 @@ static const struct clk_parent_data gcc_parent_data_0[] = {
 	{ .hw = &gcc_gpll0_out_even.clkr.hw },
 };
 
-static const struct clk_parent_data gcc_parent_data_0_ao[] = {
-	{ .fw_name = "bi_tcxo_ao" },
-	{ .hw = &gcc_gpll0.clkr.hw },
-	{ .hw = &gcc_gpll0_out_even.clkr.hw },
-};
-
 static const struct parent_map gcc_parent_map_1[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_GCC_GPLL0_OUT_MAIN, 1 },

base-commit: 1daec8cfebc28bbe596743c34bebd11b80fba990
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

