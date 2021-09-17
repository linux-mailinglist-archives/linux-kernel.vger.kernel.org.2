Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F5540FC20
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbhIQPXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:23:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:52202 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231712AbhIQPWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:22:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10110"; a="308361924"
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="308361924"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 08:18:48 -0700
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="509948718"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.102.23])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 08:18:47 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     song@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] raid5: introduce MD_BROKEN
Date:   Fri, 17 Sep 2021 17:18:31 +0200
Message-Id: <20210917151831.3000-3-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210917151831.3000-1-mariusz.tkaczyk@linux.intel.com>
References: <20210917151831.3000-1-mariusz.tkaczyk@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raid456 module had allowed to achieve failed state, distinct from other
redundant levels. It was fixed by fb73b357fb9 ("raid5: block failing
device if raid will be failed").
This fix introduces a bug, now if raid5 fails during IO, it may result
with a hung task without completion. Faulty flag on the device is
necessary to process all requests and is checked many times, mainly in
anaylze_stripe().
Allow to set faulty flag on drive again and set MD_BROKEN if raid is
failed.

Fixes: fb73b357fb9 ("raid5: block failing device if raid will be failed")
Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
---
 drivers/md/raid5.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 02ed53b20654..43e1ff43a222 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -690,6 +690,9 @@ static int has_failed(struct r5conf *conf)
 {
 	int degraded;
 
+	if (test_bit(MD_BROKEN, &conf->mddev->flags))
+		return 1;
+
 	if (conf->mddev->reshape_position == MaxSector)
 		return conf->mddev->degraded > conf->max_degraded;
 
@@ -2877,34 +2880,29 @@ static void raid5_error(struct mddev *mddev, struct md_rdev *rdev)
 	unsigned long flags;
 	pr_debug("raid456: error called\n");
 
-	spin_lock_irqsave(&conf->device_lock, flags);
-
-	if (test_bit(In_sync, &rdev->flags) &&
-	    mddev->degraded == conf->max_degraded) {
-		/*
-		 * Don't allow to achieve failed state
-		 * Don't try to recover this device
-		 */
-		conf->recovery_disabled = mddev->recovery_disabled;
-		spin_unlock_irqrestore(&conf->device_lock, flags);
-		return;
-	}
+	pr_crit("md/raid:%s: Disk failure on %s, disabling device.\n",
+		mdname(mddev), bdevname(rdev->bdev, b));
 
+	spin_lock_irqsave(&conf->device_lock, flags);
 	set_bit(Faulty, &rdev->flags);
 	clear_bit(In_sync, &rdev->flags);
 	mddev->degraded = raid5_calc_degraded(conf);
+
+	if (has_failed(conf)) {
+		set_bit(MD_BROKEN, &mddev->flags);
+		conf->recovery_disabled = mddev->recovery_disabled;
+		pr_crit("md/raid:%s: Cannot continue on %d devices.\n",
+			mdname(mddev), conf->raid_disks - mddev->degraded);
+	} else
+		pr_crit("md/raid:%s: Operation continuing on %d devices.\n",
+			mdname(mddev), conf->raid_disks - mddev->degraded);
+
 	spin_unlock_irqrestore(&conf->device_lock, flags);
 	set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 
 	set_bit(Blocked, &rdev->flags);
 	set_mask_bits(&mddev->sb_flags, 0,
 		      BIT(MD_SB_CHANGE_DEVS) | BIT(MD_SB_CHANGE_PENDING));
-	pr_crit("md/raid:%s: Disk failure on %s, disabling device.\n"
-		"md/raid:%s: Operation continuing on %d devices.\n",
-		mdname(mddev),
-		bdevname(rdev->bdev, b),
-		mdname(mddev),
-		conf->raid_disks - mddev->degraded);
 	r5c_update_on_rdev_error(mddev, rdev);
 }
 
-- 
2.26.2

