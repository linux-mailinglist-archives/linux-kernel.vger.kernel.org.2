Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5CE366C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241248AbhDUNKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241013AbhDUNIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:08:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 956E761477;
        Wed, 21 Apr 2021 13:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010438;
        bh=UkeJTbqvrsU2zlAAhvZFrfkVLmlAQG2vJTgjrVuGanM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0gWrn0dZNY1UTKY0mDBYH0SiFtLuW/yua+pGfSe40MAYn4Ej9uB/0RgZZqL1o4rAw
         nco2R7FTNohrU3vU9vY0TOoXw/RzVXoJ+xD6LWakekwzuEftfnLMV+R8kRnWnc09sM
         SlJIqQ6ylXPSY9rCTHwdh/8ga3i0k7YrPFZXEr4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 135/190] Revert "net: rocker: fix a potential NULL pointer dereference"
Date:   Wed, 21 Apr 2021 15:00:10 +0200
Message-Id: <20210421130105.1226686-136-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 5c149314d91876f743ee43efd75b6287ec55480e.

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
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/rocker/rocker_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 3473d296b2e2..a9c654b885de 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2791,11 +2791,6 @@ static int rocker_switchdev_event(struct notifier_block *unused,
 		memcpy(&switchdev_work->fdb_info, ptr,
 		       sizeof(switchdev_work->fdb_info));
 		switchdev_work->fdb_info.addr = kzalloc(ETH_ALEN, GFP_ATOMIC);
-		if (unlikely(!switchdev_work->fdb_info.addr)) {
-			kfree(switchdev_work);
-			return NOTIFY_BAD;
-		}
-
 		ether_addr_copy((u8 *)switchdev_work->fdb_info.addr,
 				fdb_info->addr);
 		/* Take a reference on the rocker device */
-- 
2.31.1

