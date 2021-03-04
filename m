Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6B832D743
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhCDQB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbhCDQBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:01:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E4FC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 08:00:44 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lHqP4-0005mj-TD; Thu, 04 Mar 2021 17:00:42 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] reset: zynqmp: replace spaces with tabs
Date:   Thu,  4 Mar 2021 17:00:42 +0100
Message-Id: <20210304160042.15316-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch issues:

  ERROR: code indent should use tabs where possible
  #86: FILE: drivers/reset/reset-zynqmp.c:86:
  +        .reset_id = 0,$

  WARNING: please, no spaces at the start of a line
  #86: FILE: drivers/reset/reset-zynqmp.c:86:
  +        .reset_id = 0,$

  ERROR: code indent should use tabs where possible
  #87: FILE: drivers/reset/reset-zynqmp.c:87:
  +        .num_resets = VERSAL_NR_RESETS,$

  WARNING: please, no spaces at the start of a line
  #87: FILE: drivers/reset/reset-zynqmp.c:87:
  +        .num_resets = VERSAL_NR_RESETS,$

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/reset-zynqmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
index ebd433fa09dd..daa425e74c96 100644
--- a/drivers/reset/reset-zynqmp.c
+++ b/drivers/reset/reset-zynqmp.c
@@ -83,8 +83,8 @@ static const struct zynqmp_reset_soc_data zynqmp_reset_data = {
 };
 
 static const struct zynqmp_reset_soc_data versal_reset_data = {
-        .reset_id = 0,
-        .num_resets = VERSAL_NR_RESETS,
+	.reset_id = 0,
+	.num_resets = VERSAL_NR_RESETS,
 };
 
 static const struct reset_control_ops zynqmp_reset_ops = {
-- 
2.29.2

