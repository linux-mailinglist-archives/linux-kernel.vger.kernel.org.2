Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDDC366C87
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242587AbhDUNTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240024AbhDUNKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:10:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8A1A61460;
        Wed, 21 Apr 2021 13:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010588;
        bh=PC+AmimZ64LXINEFBEJcfX3oi27j5+mQsX9YRy/xi4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m6fF8zP2jzW0QOszZDIy0+lBp0Bi+HULSmffhhdOiUV4+I4bTlz/uneKEuM8dwi7S
         VDpnLi41+n3n6nLM785LnEqMpl4HwEheSbpLM605QcvR2MAqzupH/U54Kltsxk9If3
         UKFe6PErOM5pgCdTE+JT2QdHz8Ea6aJzAEEgPmjs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wenwen Wang <wang6495@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 182/190] Revert "ethtool: fix a missing-check bug"
Date:   Wed, 21 Apr 2021 15:00:57 +0200
Message-Id: <20210421130105.1226686-183-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2bb3207dbbd4d30e96dd0e1c8e013104193bd59c.

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

Cc: Wenwen Wang <wang6495@umn.edu>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ethtool/ioctl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 771688e1b0da..807bc9465add 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -876,9 +876,6 @@ static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 			return -EINVAL;
 	}
 
-	if (info.cmd != cmd)
-		return -EINVAL;
-
 	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
 		if (info.rule_cnt > 0) {
 			if (info.rule_cnt <= KMALLOC_MAX_SIZE / sizeof(u32))
-- 
2.31.1

