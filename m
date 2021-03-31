Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984B434F6A8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 04:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhCaCbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 22:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233083AbhCaCbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 22:31:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3166619B9;
        Wed, 31 Mar 2021 02:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617157879;
        bh=fr13jTOQEWe1BB0JMB/cNEz9x5WZAAbZqCR5j2GX1m0=;
        h=From:To:Cc:Subject:Date:From;
        b=R/pCgZ8WPOlxQWTvidf1zPG2w7Xo1+qbDub7Uettbm5NxSS0LHlM7txki7YvU/ZCB
         g2q+ACbnpKPe6SjVOcbqVvUxwgzTZJVwZpqNQAKk5FdZunHg4nqqeYOH8j1uAvJ/rK
         AOzmw+jzO+/EYSih5ihwMM8XyEbrpwCuB72Asdeq0T4z0k+phxiSDJM3ZDBDhWWTGz
         XxSwtJ47iPsG1yJ80ivWRcYJb0cMMPq5mjlPIipzafNg6Gg/s+mD65Yer/42HCnaGt
         yiqdh1prJ5mGsVaPBSXs/QMTPNDKdN4HwDRDb/vfuPkfRxnwdE7UNtI4KFs7y8K1p0
         7l/3eT8YS4GYw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH] clk: socfpga: Fix code formatting
Date:   Tue, 30 Mar 2021 19:31:19 -0700
Message-Id: <20210331023119.3294893-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function's parameters are oddly formatted. Looks like a newline was
missed or something. Fix it.

Cc: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/socfpga/clk-agilex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
index 319c69112bcf..92a6d740a799 100644
--- a/drivers/clk/socfpga/clk-agilex.c
+++ b/drivers/clk/socfpga/clk-agilex.c
@@ -358,7 +358,8 @@ static int agilex_clk_register_cnt_perip(const struct stratix10_perip_cnt_clock
 	return 0;
 }
 
-static int agilex_clk_register_gate(const struct stratix10_gate_clock *clks,					    int nums, struct stratix10_clock_data *data)
+static int agilex_clk_register_gate(const struct stratix10_gate_clock *clks,
+				    int nums, struct stratix10_clock_data *data)
 {
 	struct clk_hw *hw_clk;
 	void __iomem *base = data->base;

base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
prerequisite-patch-id: fce221f21ba697e24c6f788aab40747cf585e1c5
prerequisite-patch-id: 6cd0378ea67b2c20eb96aed596d1de6badeae3a1
prerequisite-patch-id: 81e6e7354fd55f958a781498448d0556ad5037ef
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

