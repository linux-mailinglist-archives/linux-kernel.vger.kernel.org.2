Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797EC366BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241115AbhDUNIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:08:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240756AbhDUNGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:06:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 975FE6145E;
        Wed, 21 Apr 2021 13:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010332;
        bh=sCLqANXAX786STyiAW2V24LoRfYtqIrgiYZo6bt7cVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zoLH5QFs0X5Z1tUg3KAfuD8E7yeGLe3t8si2n9c3Mshgy7HrfevMcIdyTac8JOho1
         vxgIJA3QdrZ7qMcM72Z5SD2PzUhE2za/0c0wrVwrm8G3FXEp8aKqqY5eJ7d8+5VcK6
         qeR+6I01kJeWaQ9hKLbI6b+Qa0uvtErRwv55tA+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 070/190] Revert "rfkill: Fix incorrect check to avoid NULL pointer dereference"
Date:   Wed, 21 Apr 2021 14:59:05 +0200
Message-Id: <20210421130105.1226686-71-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6fc232db9e8cd50b9b83534de9cd91ace711b2d7.

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

Cc: Aditya Pakki <pakki001@umn.edu>
Cc: https
Cc: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rfkill/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index ac15a944573f..8a27164d7f5f 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -1033,13 +1033,10 @@ static void rfkill_sync_work(struct work_struct *work)
 int __must_check rfkill_register(struct rfkill *rfkill)
 {
 	static unsigned long rfkill_no;
-	struct device *dev;
+	struct device *dev = &rfkill->dev;
 	int error;
 
-	if (!rfkill)
-		return -EINVAL;
-
-	dev = &rfkill->dev;
+	BUG_ON(!rfkill);
 
 	mutex_lock(&rfkill_global_mutex);
 
-- 
2.31.1

