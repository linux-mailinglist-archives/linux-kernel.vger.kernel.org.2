Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8BD366BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242287AbhDUNKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241145AbhDUNHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:07:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C8C761463;
        Wed, 21 Apr 2021 13:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010410;
        bh=HAm8BC6yz7cag+cWbb3+xf7Kxx4duj+BVVvUa8Ezd58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0LtWdots9aDirA2wYL2zIySVD8VQRMRPTxinNZN07yOi417zEAZVIJ5GfUDRavlRh
         7npb++jS6gYVucitQdITw22U8n8Xbs1Oj+Vdrlmu/SN6X77xFmiDjEbpKTY+QLK9WJ
         bYRiYNiWjJEfy3XNmo7lljSGyvIEy0JkeGEzAObo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 126/190] Revert "net: openvswitch: fix a NULL pointer dereference"
Date:   Wed, 21 Apr 2021 15:00:01 +0200
Message-Id: <20210421130105.1226686-127-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6f19893b644a9454d85e593b5e90914e7a72b7dd.

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
 net/openvswitch/datapath.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 9d6ef6cb9b26..99e63f4bbcaf 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -443,10 +443,6 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 
 	upcall = genlmsg_put(user_skb, 0, 0, &dp_packet_genl_family,
 			     0, upcall_info->cmd);
-	if (!upcall) {
-		err = -EINVAL;
-		goto out;
-	}
 	upcall->dp_ifindex = dp_ifindex;
 
 	err = ovs_nla_put_key(key, key, OVS_PACKET_ATTR_KEY, false, user_skb);
-- 
2.31.1

