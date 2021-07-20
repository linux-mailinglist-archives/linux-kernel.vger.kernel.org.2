Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAB43CF282
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 05:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346566AbhGTCpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 22:45:23 -0400
Received: from out2.migadu.com ([188.165.223.204]:62265 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236420AbhGTCln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 22:41:43 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1626751335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ymvuQOiwKUSpANGmy6VygBcyGlRswj0psccsffBvtok=;
        b=o3OIYjC1X/lsNU8INdO6c0welkJ6wQHvZ7wvmvEA21ALB63D20hPelkRtY98uB31BsFsRl
        yjFgCgM+DR3UcHGhAVxRL54WMX7yd/8+WGy2D+wUAM5oSXwkct04yKb3RvKytiDrX3r+7g
        ES+hE6zqChub6KZFJzUM7tDUJiUxLeM=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     courmisch@gmail.com, remi@remlab.net
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH 1/4] rtnetlink: remove rtnetlink_send() in rtnetlink
Date:   Tue, 20 Jul 2021 11:22:02 +0800
Message-Id: <20210720032202.2348-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtnetlink_send() is similar to rtnl_notify(), so remove rtnetlink_send().
Modify the fifth parameter from 'struct nlmsghdr *nlh' to 'int report'
in rtnl_notify(). This will do well for the caller havn't nlh variable.
And modify the return value to integer, Some caller may be need the
return value.

Rename pid to portid to avoid confusion in rtnl_{unicast, notify}.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/rtnetlink.h |  7 +++----
 net/core/rtnetlink.c      | 21 +++++----------------
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index bb9cb84114c1..409c334746a6 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -9,10 +9,9 @@
 #include <linux/refcount.h>
 #include <uapi/linux/rtnetlink.h>
 
-extern int rtnetlink_send(struct sk_buff *skb, struct net *net, u32 pid, u32 group, int echo);
-extern int rtnl_unicast(struct sk_buff *skb, struct net *net, u32 pid);
-extern void rtnl_notify(struct sk_buff *skb, struct net *net, u32 pid,
-			u32 group, struct nlmsghdr *nlh, gfp_t flags);
+extern int rtnl_unicast(struct sk_buff *skb, struct net *net, u32 portid);
+extern int rtnl_notify(struct sk_buff *skb, struct net *net, u32 portid,
+		       u32 group, int report, gfp_t flags);
 extern void rtnl_set_sk_err(struct net *net, u32 group, int error);
 extern int rtnetlink_put_metrics(struct sk_buff *skb, u32 *metrics);
 extern int rtnl_put_cacheinfo(struct sk_buff *skb, struct dst_entry *dst,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 670d74ab91ae..48bb9dc6f06f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -707,31 +707,20 @@ static int rtnl_link_fill(struct sk_buff *skb, const struct net_device *dev)
 	return err;
 }
 
-int rtnetlink_send(struct sk_buff *skb, struct net *net, u32 pid, unsigned int group, int echo)
+int rtnl_unicast(struct sk_buff *skb, struct net *net, u32 portid)
 {
 	struct sock *rtnl = net->rtnl;
 
-	return nlmsg_notify(rtnl, skb, pid, group, echo, GFP_KERNEL);
-}
-
-int rtnl_unicast(struct sk_buff *skb, struct net *net, u32 pid)
-{
-	struct sock *rtnl = net->rtnl;
-
-	return nlmsg_unicast(rtnl, skb, pid);
+	return nlmsg_unicast(rtnl, skb, portid);
 }
 EXPORT_SYMBOL(rtnl_unicast);
 
-void rtnl_notify(struct sk_buff *skb, struct net *net, u32 pid, u32 group,
-		 struct nlmsghdr *nlh, gfp_t flags)
+int rtnl_notify(struct sk_buff *skb, struct net *net, u32 portid,
+		u32 group, int report, gfp_t flags)
 {
 	struct sock *rtnl = net->rtnl;
-	int report = 0;
-
-	if (nlh)
-		report = nlmsg_report(nlh);
 
-	nlmsg_notify(rtnl, skb, pid, group, report, flags);
+	return nlmsg_notify(rtnl, skb, portid, group, report, flags);
 }
 EXPORT_SYMBOL(rtnl_notify);
 
-- 
2.32.0

