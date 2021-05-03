Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1823714E5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhECMCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233964AbhECMB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:01:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F0AF61283;
        Mon,  3 May 2021 12:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043234;
        bh=3CVqKQuwB3TLp+cRmpho+k0T4BTsX+6CiLoJ88kybco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tqL8l1+82KebtPbL33FHmh3tCBLnJ33zIX+lJ3GmcnHdxM0Ps6K2OuRQeDu3K9ag9
         hn8aCCU8L4TLSTaIv7JFyNTCmkVg/hdpM9Y61XHng+joErHC9YBUzpOGPgp7j9lARy
         mqm2qCFbAHoZGnICMBEUxt/2HRF2jUtfZGrp8sxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>, Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 52/69] Revert "libertas: add checks for the return value of sysfs_create_group"
Date:   Mon,  3 May 2021 13:57:19 +0200
Message-Id: <20210503115736.2104747-53-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 434256833d8eb988cb7f3b8a41699e2fe48d9332.

Because of recent interactions with developers from @umn.edu, all
commits from them have been recently re-reviewed to ensure if they were
correct or not.

Upon review, this commit was found to be incorrect for the reasons
below, so it must be reverted.  It will be fixed up "correctly" in a
later kernel change.

The original commit was incorrect, the error needs to be propagated back
to the caller AND if the second group call fails, the first needs to be
removed.  There are much better ways to solve this, the driver should
NOT be calling sysfs_create_group() on its own as it is racing userspace
and loosing.

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/marvell/libertas/mesh.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/mesh.c b/drivers/net/wireless/marvell/libertas/mesh.c
index f5b78257d551..c611e6668b21 100644
--- a/drivers/net/wireless/marvell/libertas/mesh.c
+++ b/drivers/net/wireless/marvell/libertas/mesh.c
@@ -805,12 +805,7 @@ static void lbs_persist_config_init(struct net_device *dev)
 {
 	int ret;
 	ret = sysfs_create_group(&(dev->dev.kobj), &boot_opts_group);
-	if (ret)
-		pr_err("failed to create boot_opts_group.\n");
-
 	ret = sysfs_create_group(&(dev->dev.kobj), &mesh_ie_group);
-	if (ret)
-		pr_err("failed to create mesh_ie_group.\n");
 }
 
 static void lbs_persist_config_remove(struct net_device *dev)
-- 
2.31.1

