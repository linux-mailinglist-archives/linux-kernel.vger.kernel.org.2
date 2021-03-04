Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5E932D74A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhCDQDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbhCDQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:03:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ACFC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 08:02:23 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lHqQg-000604-Be; Thu, 04 Mar 2021 17:02:22 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] reset: sti/syscfg: replace comma with semicolon
Date:   Thu,  4 Mar 2021 17:02:20 +0100
Message-Id: <20210304160220.24179-1-p.zabel@pengutronix.de>
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

Fixes a checkpatch warning:

  WARNING: Possible comma where semicolon could be used
  #156: FILE: drivers/reset/sti/reset-syscfg.c:156:
  +	rc->rst.ops = &syscfg_reset_ops,
  +	rc->rst.of_node = dev->of_node;

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/sti/reset-syscfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/sti/reset-syscfg.c b/drivers/reset/sti/reset-syscfg.c
index 99b63035fe72..b4b46e0f207e 100644
--- a/drivers/reset/sti/reset-syscfg.c
+++ b/drivers/reset/sti/reset-syscfg.c
@@ -153,7 +153,7 @@ static int syscfg_reset_controller_register(struct device *dev,
 	if (!rc->channels)
 		return -ENOMEM;
 
-	rc->rst.ops = &syscfg_reset_ops,
+	rc->rst.ops = &syscfg_reset_ops;
 	rc->rst.of_node = dev->of_node;
 	rc->rst.nr_resets = data->nr_channels;
 	rc->active_low = data->active_low;
-- 
2.29.2

