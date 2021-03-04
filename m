Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA1332D75E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbhCDQFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbhCDQEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:04:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB87C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 08:04:01 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lHqSG-0006UW-Ao; Thu, 04 Mar 2021 17:04:00 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, linux-oxnas@groups.io
Subject: [PATCH] reset: oxnas: replace file name with short description
Date:   Thu,  4 Mar 2021 17:03:58 +0100
Message-Id: <20210304160358.21030-1-p.zabel@pengutronix.de>
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

  WARNING: It's generally not useful to have the filename in the file
  #3: FILE: drivers/reset/reset-oxnas.c:3:
  + * drivers/reset/reset-oxnas.c

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/reset-oxnas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-oxnas.c b/drivers/reset/reset-oxnas.c
index c4013165bdda..8209f922dc16 100644
--- a/drivers/reset/reset-oxnas.c
+++ b/drivers/reset/reset-oxnas.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * drivers/reset/reset-oxnas.c
+ * Oxford Semiconductor Reset Controller driver
  *
  * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
  * Copyright (C) 2014 Ma Haijun <mahaijuns@gmail.com>
-- 
2.29.2

