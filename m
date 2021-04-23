Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEBC369172
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 13:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbhDWLqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 07:46:11 -0400
Received: from smtp2.axis.com ([195.60.68.18]:65106 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhDWLqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 07:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1619178334;
  x=1650714334;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=heYjIjXEvv/x4jJo+D/vVJax31Yp5ggT+FOLqp/zAD8=;
  b=Lg9Yhw0oVoRHryNUzqe0FbXcYA039THx9uOyr91u7k69mOW15ZV0W6ZU
   HkOULQweDOIcIEme/4fqu6VTqtflsMs7TM6X4RKwKxsAoOdjauXVOUX5L
   PdiDoRkssog8q1biWeUbKnK8MgbHKVXTvdQy19DmuHIIUtvATYuUGcHyb
   c/9i5Oq1QQtsnxq/MMvnJkf4jBDMOweynCfUTw84A3iaQmcPPr9weSo6G
   xE3LU6Wps9Vzaz4dhhX5SZNBrZPot2HPZpjvpwtVfv0I+6ljxdk/oQrOa
   E8G6FHcK32dB70mZOOZJtMhn5RKxc/idQ15odyTDn3i281TdQG+HeMO2q
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <kernel@axis.com>, <guodong.xu@linaro.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] regulator: core: Fix off_on_delay handling
Date:   Fri, 23 Apr 2021 13:45:24 +0200
Message-ID: <20210423114524.26414-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jiffies-based off_on_delay implementation has a couple of problems
that cause it to sometimes not actually delay for the required time:

 (1) If, for example, the off_on_delay time is equivalent to one jiffy,
     and the ->last_off_jiffy is set just before a new jiffy starts,
     then _regulator_do_enable() does not wait at all since it checks
     using time_before().

 (2) When jiffies overflows, the value of "remaining" becomes higher
     than "max_delay" and the code simply proceeds without waiting.

Fix these problems by changing it to use ktime_t instead.

[Note that since jiffies doesn't start at zero but at INITIAL_JIFFIES
 ("-5 minutes"), (2) above also led to the code not delaying if
 the first regulator_enable() is called when the ->last_off_jiffy is not
 initialised, such as for regulators with ->constraints->boot_on set.
 It's not clear to me if this was intended or not, but I've preserved
 this behaviour explicitly with the check for a non-zero ->last_off.]

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/regulator/core.c         | 33 ++++++++------------------------
 include/linux/regulator/driver.h |  2 +-
 2 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d6219cb8bd29..6844cf54e997 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1440,7 +1440,7 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 		if (rdev->constraints->always_on)
 			rdev->use_count++;
 	} else if (rdev->desc->off_on_delay) {
-		rdev->last_off_jiffy = jiffies;
+		rdev->last_off = ktime_get();
 	}
 
 	print_constraints(rdev);
@@ -2485,29 +2485,15 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 
 	trace_regulator_enable(rdev_get_name(rdev));
 
-	if (rdev->desc->off_on_delay) {
+	if (rdev->desc->off_on_delay && rdev->last_off) {
 		/* if needed, keep a distance of off_on_delay from last time
 		 * this regulator was disabled.
 		 */
-		unsigned long start_jiffy = jiffies;
-		unsigned long intended, max_delay, remaining;
-
-		max_delay = usecs_to_jiffies(rdev->desc->off_on_delay);
-		intended = rdev->last_off_jiffy + max_delay;
-
-		if (time_before(start_jiffy, intended)) {
-			/* calc remaining jiffies to deal with one-time
-			 * timer wrapping.
-			 * in case of multiple timer wrapping, either it can be
-			 * detected by out-of-range remaining, or it cannot be
-			 * detected and we get a penalty of
-			 * _regulator_enable_delay().
-			 */
-			remaining = intended - start_jiffy;
-			if (remaining <= max_delay)
-				_regulator_enable_delay(
-						jiffies_to_usecs(remaining));
-		}
+		ktime_t end = ktime_add_us(rdev->last_off, rdev->desc->off_on_delay);
+		s64 remaining = ktime_us_delta(end, ktime_get());
+
+		if (remaining > 0)
+			_regulator_enable_delay(remaining);
 	}
 
 	if (rdev->ena_pin) {
@@ -2733,11 +2719,8 @@ static int _regulator_do_disable(struct regulator_dev *rdev)
 			return ret;
 	}
 
-	/* cares about last_off_jiffy only if off_on_delay is required by
-	 * device.
-	 */
 	if (rdev->desc->off_on_delay)
-		rdev->last_off_jiffy = jiffies;
+		rdev->last_off = ktime_get();
 
 	trace_regulator_disable_complete(rdev_get_name(rdev));
 
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index d7c77ee370f3..a0710fb3224e 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -472,7 +472,7 @@ struct regulator_dev {
 	unsigned int is_switch:1;
 
 	/* time when this regulator was disabled last time */
-	unsigned long last_off_jiffy;
+	ktime_t last_off;
 };
 
 struct regulator_dev *
-- 
2.28.0

