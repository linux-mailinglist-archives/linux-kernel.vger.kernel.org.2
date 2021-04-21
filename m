Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A5C366BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241189AbhDUNIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240936AbhDUNGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:06:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CDB261461;
        Wed, 21 Apr 2021 13:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010340;
        bh=O7f6JAJl8JVpzDmD3dx7VnqUo1TvRInzlcNMF2uCz38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avgY3+7ZDCkmmR5tqwtkwK60oRShITf3LwnhrK9SYTTy+ZAAz+nhp4lp4X9UoAiat
         kyTlUD29rh+1Ih5EKV3oPmCes1JZQFQs9dQAhUZgkIF6s7350OZxKmqwBKhtTxtIdk
         LZWaJ+J5O6Sod92duW3l/I6qJC3ZDt8M5vhgNbko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 099/190] Revert "omapfb: Fix potential NULL pointer dereference in kmalloc"
Date:   Wed, 21 Apr 2021 14:59:34 +0200
Message-Id: <20210421130105.1226686-100-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 31fa6e2ae65feed0de10823c5d1eea21a93086c9.

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
Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c b/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
index 0ae0cab252d3..05d87dcbdd8b 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
@@ -100,8 +100,6 @@ static void __init omapdss_omapify_node(struct device_node *node)
 
 	new_len = prop->length + strlen(prefix) * num_strs;
 	new_compat = kmalloc(new_len, GFP_KERNEL);
-	if (!new_compat)
-		return;
 
 	omapdss_prefix_strcpy(new_compat, new_len, prop->value, prop->length);
 
-- 
2.31.1

