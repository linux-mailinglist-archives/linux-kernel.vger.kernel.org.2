Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFAA366BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbhDUNEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240602AbhDUNEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:04:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95AB061457;
        Wed, 21 Apr 2021 13:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010208;
        bh=YBE/vMX5lB1YetSQlbQxSdFshyJMtgbig4qxvkfZ9CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vM7c5GT1sMV0bfdifREEtPdGNPtaxaUkovIpRmlXTdssDrN/Lantdefbd0NrRaEdJ
         4GrQkwssIJRWQgiIYFwEK4WDGiMAnc2lPkQBOGiiSKsQ/CSlxhHwwxuV0MjQq/E/io
         90i5uDnnkDXpJeog3JHW/yfWmQ5VxtL3nXKhyqNU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@kernel.org,
        Qiushi Wu <wu000273@umn.edu>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 051/190] Revert "power: supply: core: fix memory leak in HWMON error path"
Date:   Wed, 21 Apr 2021 14:58:46 +0200
Message-Id: <20210421130105.1226686-52-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1d7a7128a2e9e1f137c99b0a44e94d70a77343e3.

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

Cc: stable@kernel.org
Cc: Qiushi Wu <wu000273@umn.edu>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/power_supply_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index bffe6d84c429..62ca29e0d47a 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -356,7 +356,7 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 		goto error;
 	}
 
-	ret = devm_add_action_or_reset(dev, power_supply_hwmon_bitmap_free,
+	ret = devm_add_action(dev, power_supply_hwmon_bitmap_free,
 			      psyhw->props);
 	if (ret)
 		goto error;
-- 
2.31.1

