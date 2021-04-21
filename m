Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D420366C84
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242398AbhDUNTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242253AbhDUNJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 858BA61440;
        Wed, 21 Apr 2021 13:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010564;
        bh=7JmVUAZ7giIE4HFNf49LkOz7t12ZepTbU4f9xj1i5CI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NyI4P1TEtpzUBQgRFTGdGHAFHd5M1XJxQyqo842zRUUwB4kEU47BtwdImiu5/ktjr
         TyAgEXE6R0vwA2GZvpKRcMpec1oRLE/NAygfXKecasWngBfyb9cWYP2d34dIuPMAKi
         iH8jCElNOYDuDUWXw3rY2FdYA35KWXAmflJ8UvZ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wenwen Wang <wang6495@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 180/190] Revert "net: socket: fix a missing-check bug"
Date:   Wed, 21 Apr 2021 15:00:55 +0200
Message-Id: <20210421130105.1226686-181-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b6168562c8ce2bd5a30e213021650422e08764dc.

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
 net/socket.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 84a8049c2b09..d4176362a27b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3182,14 +3182,9 @@ static int ethtool_ioctl(struct net *net, struct compat_ifreq __user *ifr32)
 		    copy_in_user(&rxnfc->fs.ring_cookie,
 				 &compat_rxnfc->fs.ring_cookie,
 				 (void __user *)(&rxnfc->fs.location + 1) -
-				 (void __user *)&rxnfc->fs.ring_cookie))
-			return -EFAULT;
-		if (ethcmd == ETHTOOL_GRXCLSRLALL) {
-			if (put_user(rule_cnt, &rxnfc->rule_cnt))
-				return -EFAULT;
-		} else if (copy_in_user(&rxnfc->rule_cnt,
-					&compat_rxnfc->rule_cnt,
-					sizeof(rxnfc->rule_cnt)))
+				 (void __user *)&rxnfc->fs.ring_cookie) ||
+		    copy_in_user(&rxnfc->rule_cnt, &compat_rxnfc->rule_cnt,
+				 sizeof(rxnfc->rule_cnt)))
 			return -EFAULT;
 	}
 
-- 
2.31.1

