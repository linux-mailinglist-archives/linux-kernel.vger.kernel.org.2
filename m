Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C545330410
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 19:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhCGSwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 13:52:41 -0500
Received: from inva020.nxp.com ([92.121.34.13]:55638 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231612AbhCGSw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 13:52:29 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5C70C1A0848;
        Sun,  7 Mar 2021 19:52:28 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 506BE1A0833;
        Sun,  7 Mar 2021 19:52:28 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B9492030D;
        Sun,  7 Mar 2021 19:52:28 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] clk: Call clk_core_enable_lock variant when lock is needed
Date:   Sun,  7 Mar 2021 20:52:08 +0200
Message-Id: <1615143128-6141-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of locking explicitly every time, call the clk_core_enable_lock
variant.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/clk.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 5052541..fd37773 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2078,12 +2078,8 @@ static void clk_change_rate(struct clk_core *core)
 		return;
 
 	if (core->flags & CLK_SET_RATE_UNGATE) {
-		unsigned long flags;
-
 		clk_core_prepare(core);
-		flags = clk_enable_lock();
-		clk_core_enable(core);
-		clk_enable_unlock(flags);
+		clk_core_enable_lock(core);
 	}
 
 	if (core->new_parent && core->new_parent != core->parent) {
@@ -3564,8 +3560,6 @@ static int __clk_core_init(struct clk_core *core)
 	 * reparenting clocks
 	 */
 	if (core->flags & CLK_IS_CRITICAL) {
-		unsigned long flags;
-
 		ret = clk_core_prepare(core);
 		if (ret) {
 			pr_warn("%s: critical clk '%s' failed to prepare\n",
@@ -3573,9 +3567,7 @@ static int __clk_core_init(struct clk_core *core)
 			goto out;
 		}
 
-		flags = clk_enable_lock();
-		ret = clk_core_enable(core);
-		clk_enable_unlock(flags);
+		ret = clk_core_enable_lock(core);
 		if (ret) {
 			pr_warn("%s: critical clk '%s' failed to enable\n",
 			       __func__, core->name);
-- 
2.7.4

