Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71EF32D755
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbhCDQEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbhCDQDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:03:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2ADC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 08:03:11 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lHqRS-00069V-2S; Thu, 04 Mar 2021 17:03:10 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org
Subject: [PATCH] reset: uniphier: enclose UNIPHIER_RESET_ID_END value in parentheses
Date:   Thu,  4 Mar 2021 17:03:09 +0100
Message-Id: <20210304160309.12230-1-p.zabel@pengutronix.de>
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

Fixes a checkpatch error:

  ERROR: Macros with complex values should be enclosed in parentheses
  #23: FILE: drivers/reset/reset-uniphier.c:23:
  +#define UNIPHIER_RESET_ID_END		(unsigned int)(-1)

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/reset-uniphier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index 279e535bf5d8..5f75783f9397 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -20,7 +20,7 @@ struct uniphier_reset_data {
 #define UNIPHIER_RESET_ACTIVE_LOW		BIT(0)
 };
 
-#define UNIPHIER_RESET_ID_END		(unsigned int)(-1)
+#define UNIPHIER_RESET_ID_END		((unsigned int)(-1))
 
 #define UNIPHIER_RESET_END				\
 	{ .id = UNIPHIER_RESET_ID_END }
-- 
2.29.2

