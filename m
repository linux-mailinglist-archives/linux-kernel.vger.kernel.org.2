Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784C33B6480
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhF1PJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:09:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236406AbhF1OsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 10:48:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25B9E61CB3;
        Mon, 28 Jun 2021 14:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624891002;
        bh=YPfVsIP4uCZ7IM44bwqCjKcDi1lb2f8isXM2kOjgkkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HPYPP8boh9KFI4weIqGj1dZX15twVtWgFdZ2qzz99xRt1B5JDw7K+hIDrDH9WGcYy
         u12jd7g1Tdl6WWKBsJY+e/Dq8xhVEJN5PoPcXio3MEd9oSOtEiEweWvUfo4u7K1Ogc
         xn78vI4/c9yYPgxVPyatxX0L+NEQWccsturGwJ0rlEhMcs0q4ibRemQ0YXJq8sFFQU
         swSLYKtLSziQeMQIto0AQ4F1wa7rSunk+6JixarCeplYWiSl8gittz6D5Ojgx2379L
         Mehsd6KFm2C6nvnz5t3iRnOb9FpYfQzxEBO2+30E3s8wPO3fdpm9/5EdUA/sJZPfsk
         fb8ghjOhKUmYg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 14/88] rtnetlink: Fix missing error code in rtnl_bridge_notify()
Date:   Mon, 28 Jun 2021 10:35:14 -0400
Message-Id: <20210628143628.33342-15-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210628143628.33342-1-sashal@kernel.org>
References: <20210628143628.33342-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.238-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.238-rc1
X-KernelTest-Deadline: 2021-06-30T14:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

[ Upstream commit a8db57c1d285c758adc7fb43d6e2bad2554106e1 ]

The error code is missing in this code scenario, add the error code
'-EINVAL' to the return value 'err'.

Eliminate the follow smatch warning:

net/core/rtnetlink.c:4834 rtnl_bridge_notify() warn: missing error code
'err'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/rtnetlink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 0168c700a201..fa3ed51f846b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3648,8 +3648,10 @@ static int rtnl_bridge_notify(struct net_device *dev)
 	if (err < 0)
 		goto errout;
 
-	if (!skb->len)
+	if (!skb->len) {
+		err = -EINVAL;
 		goto errout;
+	}
 
 	rtnl_notify(skb, net, 0, RTNLGRP_LINK, NULL, GFP_ATOMIC);
 	return 0;
-- 
2.30.2

