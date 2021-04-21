Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8EC366BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241282AbhDUNH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240488AbhDUNFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:05:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AD776143B;
        Wed, 21 Apr 2021 13:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010318;
        bh=ojQvf/A1spJ4WB9WSdcGXFWVoC+D29fj+3vCBlmlzQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v0rYMu+iagqI4BlEp9p+2Jy//nFBx+xFHJg6TZRjksgR/9WtfSChjMJTMGyHuJObH
         /dG1FsCfWaIKK1PSyfkBQi+mlYpZOFbKtoqduKjgt0MjtVmRrM0F6gIb/4BfwmMKCf
         9xjITKYFfSERiyAkAT5eS/Td617ehqLNy0wJIE4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 092/190] Revert "power: charger-manager: fix a potential NULL pointer dereference"
Date:   Wed, 21 Apr 2021 14:59:27 +0200
Message-Id: <20210421130105.1226686-93-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 75cf4f5aa903604e1bd7bec2c0988d643c6fb946.

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

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/charger-manager.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 4dea8ecd70bc..f34c07ffcfe6 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1749,9 +1749,6 @@ static struct platform_driver charger_manager_driver = {
 static int __init charger_manager_init(void)
 {
 	cm_wq = create_freezable_workqueue("charger_manager");
-	if (unlikely(!cm_wq))
-		return -ENOMEM;
-
 	INIT_DELAYED_WORK(&cm_monitor_work, cm_monitor_poller);
 
 	return platform_driver_register(&charger_manager_driver);
-- 
2.31.1

