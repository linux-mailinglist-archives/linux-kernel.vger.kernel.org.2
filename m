Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC99366BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242314AbhDUNKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239079AbhDUNHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:07:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C339361461;
        Wed, 21 Apr 2021 13:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010407;
        bh=t8pHsFSAc99qRtX8oVjYQOac1gO0SohEy/Z13Ui0or8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gd2KGO0F6w7qUIZu3fm+En2pkLo8TtdHiNxFB8oktclOULeqaDWuO5AGYkA6nSh2w
         dSR+JQn0IvEmxMQAPi8n8+9Jf9vDDVV6XhmOqSm9a+ea/GOIWlNp2rfognnADLInHu
         yS2gEa+TRL0s1HXEMtTQAjUis2BaAzSVjGjj2zNw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 125/190] Revert "net: tipc: fix a missing check of nla_nest_start"
Date:   Wed, 21 Apr 2021 15:00:00 +0200
Message-Id: <20210421130105.1226686-126-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 4589e28db46ee4961edfd794c5bb43887d38c8e5.

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
 net/tipc/group.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/tipc/group.c b/net/tipc/group.c
index 3e137d8c9d2f..d18d497af4de 100644
--- a/net/tipc/group.c
+++ b/net/tipc/group.c
@@ -927,9 +927,6 @@ int tipc_group_fill_sock_diag(struct tipc_group *grp, struct sk_buff *skb)
 {
 	struct nlattr *group = nla_nest_start_noflag(skb, TIPC_NLA_SOCK_GROUP);
 
-	if (!group)
-		return -EMSGSIZE;
-
 	if (nla_put_u32(skb, TIPC_NLA_SOCK_GROUP_ID,
 			grp->type) ||
 	    nla_put_u32(skb, TIPC_NLA_SOCK_GROUP_INSTANCE,
-- 
2.31.1

