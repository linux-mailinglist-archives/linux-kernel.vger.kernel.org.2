Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E21E36EB26
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbhD2NJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238815AbhD2NJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:09:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED4B961057;
        Thu, 29 Apr 2021 13:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619701708;
        bh=+TElKSOoYADfybP5EYFHwW3GqSEegDoUj/EoYNFv5sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e1kQyQ08SWcKN9h2k8tTBjyBmUrvoxuUPpjEImnh8NBrZcmehByKBSdtb8OwXtykR
         icm0QPFmDc6H4tLz14sNSWz0DkG1ovB9tz6hV2Vjb4XblW5sA9ZiQm9sWn+28a5F10
         46pYk+MEF+5z5Y9X+JJxC/3twUO9sCRmSag227g4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wenwen Wang <wang6495@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 4/7] Revert "ethtool: fix a potential missing-check bug"
Date:   Thu, 29 Apr 2021 15:08:08 +0200
Message-Id: <20210429130811.3353369-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210429130811.3353369-1-gregkh@linuxfoundation.org>
References: <20210429130811.3353369-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d656fe49e33df48ee6bc19e871f5862f49895c9e.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper submitted to the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota) but later
withdrawn.

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Wenwen Wang <wang6495@umn.edu>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ethtool/ioctl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 771688e1b0da..34688ebfd74e 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -869,11 +869,6 @@ static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 		info_size = sizeof(info);
 		if (copy_from_user(&info, useraddr, info_size))
 			return -EFAULT;
-		/* Since malicious users may modify the original data,
-		 * we need to check whether FLOW_RSS is still requested.
-		 */
-		if (!(info.flow_type & FLOW_RSS))
-			return -EINVAL;
 	}
 
 	if (info.cmd != cmd)
-- 
2.31.1

