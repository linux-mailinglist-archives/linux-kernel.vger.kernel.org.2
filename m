Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1247366BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbhDUNEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240646AbhDUNEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:04:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB4276144C;
        Wed, 21 Apr 2021 13:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010216;
        bh=safbXJMe4uxXLpovjnkp5EwbdjRLORiNMeJaarTVHhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slRVLgsyp9m+UH450CIMxI/XwcDvodsbGexm8DQCXNJcIiXZaB5xYvYD8aspWM4cR
         4bL4MiBp0P+iRklkdYDomh9E4fLmucc4BzSOU2uJUAjRAY/hLsl/Pffmy8m2W3n5AR
         9C4ujDcCpUq/ynkPGL+sPxGYe+NFSzMmSVTLv2ok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 054/190] Revert "clk: samsung: Remove redundant check in samsung_cmu_register_one"
Date:   Wed, 21 Apr 2021 14:58:49 +0200
Message-Id: <20210421130105.1226686-55-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 8d7a577d04e8ce24b1b81ee44ec8cd1dda2a9cd9.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Aditya Pakki <pakki001@umn.edu>
Cc: https
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/samsung/clk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 1949ae7851b2..dad31308c071 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -356,6 +356,10 @@ struct samsung_clk_provider * __init samsung_cmu_register_one(
 	}
 
 	ctx = samsung_clk_init(np, reg_base, cmu->nr_clk_ids);
+	if (!ctx) {
+		panic("%s: unable to allocate ctx\n", __func__);
+		return ctx;
+	}
 
 	if (cmu->pll_clks)
 		samsung_clk_register_pll(ctx, cmu->pll_clks, cmu->nr_pll_clks,
-- 
2.31.1

