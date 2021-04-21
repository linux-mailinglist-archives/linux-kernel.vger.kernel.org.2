Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB25366C82
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242190AbhDUNTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242010AbhDUNJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03BB06144B;
        Wed, 21 Apr 2021 13:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010549;
        bh=zYsc1oYGTs1KFsQafOVNXB3YG2pMaYsWcKLFUMtmck8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YvGcVl8/yvV4dk3E89E3485cBhAmDzX995gsk2aEYLm6L1+jK/P1pLShznBE/7rd6
         W3+YMY1JFTVdOSNIzR6i96j2CLYhT35bmIwbDNv3huyhWnRIlJYz6hfytrgGuhKcI6
         WqJcztbUsJTY/uO37Whuh8rr21wXUYCWaM5vykWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 175/190] Revert "ipv6/route: Add a missing check on proc_dointvec"
Date:   Wed, 21 Apr 2021 15:00:50 +0200
Message-Id: <20210421130105.1226686-176-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit f0fb9b288d0a7e9cc324ae362e2dfd2cc2217ded.

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
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 373d48073106..0e85741423d7 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6169,16 +6169,12 @@ static int ipv6_sysctl_rtcache_flush(struct ctl_table *ctl, int write,
 {
 	struct net *net;
 	int delay;
-	int ret;
 	if (!write)
 		return -EINVAL;
 
 	net = (struct net *)ctl->extra1;
 	delay = net->ipv6.sysctl.flush_delay;
-	ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
-	if (ret)
-		return ret;
-
+	proc_dointvec(ctl, write, buffer, lenp, ppos);
 	fib6_run_gc(delay <= 0 ? 0 : (unsigned long)delay, net, delay > 0);
 	return 0;
 }
-- 
2.31.1

