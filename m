Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CA332D73E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbhCDP6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbhCDP5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:57:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C443CC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 07:57:09 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lHqLc-0005XI-EI; Thu, 04 Mar 2021 16:57:08 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] reset: whitespace fixes
Date:   Thu,  4 Mar 2021 16:56:56 +0100
Message-Id: <20210304155656.13955-1-p.zabel@pengutronix.de>
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

  CHECK: Alignment should match open parenthesis
  #87: FILE: drivers/reset/core.c:87:
  +static int of_reset_simple_xlate(struct reset_controller_dev *rcdev,
  +			  const struct of_phandle_args *reset_spec)

  CHECK: Lines should not end with a '('
  #540: FILE: drivers/reset/core.c:540:
  +static struct reset_control *__reset_control_get_internal(

  CHECK: Alignment should match open parenthesis
  #603: FILE: drivers/reset/core.c:603:
  +struct reset_control *__of_reset_control_get(struct device_node *node,
  +				     const char *id, int index, bool shared,

  CHECK: Alignment should match open parenthesis
  #781: FILE: drivers/reset/core.c:781:
  +struct reset_control *__devm_reset_control_get(struct device *dev,
  +				     const char *id, int index, bool shared,

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index dbf881b586d9..123b0c53a857 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -84,7 +84,7 @@ static const char *rcdev_name(struct reset_controller_dev *rcdev)
  * without gaps.
  */
 static int of_reset_simple_xlate(struct reset_controller_dev *rcdev,
-			  const struct of_phandle_args *reset_spec)
+				 const struct of_phandle_args *reset_spec)
 {
 	if (reset_spec->args[0] >= rcdev->nr_resets)
 		return -EINVAL;
@@ -610,9 +610,9 @@ void reset_control_release(struct reset_control *rstc)
 }
 EXPORT_SYMBOL_GPL(reset_control_release);
 
-static struct reset_control *__reset_control_get_internal(
-				struct reset_controller_dev *rcdev,
-				unsigned int index, bool shared, bool acquired)
+static struct reset_control *
+__reset_control_get_internal(struct reset_controller_dev *rcdev,
+			     unsigned int index, bool shared, bool acquired)
 {
 	struct reset_control *rstc;
 
@@ -672,9 +672,9 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
-struct reset_control *__of_reset_control_get(struct device_node *node,
-				     const char *id, int index, bool shared,
-				     bool optional, bool acquired)
+struct reset_control *
+__of_reset_control_get(struct device_node *node, const char *id, int index,
+		       bool shared, bool optional, bool acquired)
 {
 	struct reset_control *rstc;
 	struct reset_controller_dev *r, *rcdev;
@@ -850,9 +850,9 @@ static void devm_reset_control_release(struct device *dev, void *res)
 	reset_control_put(*(struct reset_control **)res);
 }
 
-struct reset_control *__devm_reset_control_get(struct device *dev,
-				     const char *id, int index, bool shared,
-				     bool optional, bool acquired)
+struct reset_control *
+__devm_reset_control_get(struct device *dev, const char *id, int index,
+			 bool shared, bool optional, bool acquired)
 {
 	struct reset_control **ptr, *rstc;
 
-- 
2.29.2

