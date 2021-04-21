Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35F1366C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242632AbhDUNPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242049AbhDUNJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6FF36143B;
        Wed, 21 Apr 2021 13:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010552;
        bh=n8p7gmoBMGxYaYDIWV+TarqBdxopoMWdbljAJqiCndA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=by83PEflAD5OKbW5Z+zeJ5SGcVa+COi+kHkNRNgtss8PJvbOrpHHILXe2Ue6uTPGZ
         rZLY9B3+x87domz6AL39mi32pkLVY9tyhChMbJpzL5/fZY4gbkzsAYuqVDzUXfeSAi
         JxT8k83ycNA4kCCVZjhaVZXSpSPnub4NfdwGTWzc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 176/190] Revert "net/net_namespace: Check the return value of register_pernet_subsys()"
Date:   Wed, 21 Apr 2021 15:00:51 +0200
Message-Id: <20210421130105.1226686-177-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0eb987c874dc93f9c9d85a6465dbde20fdd3884c.

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
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/net_namespace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 43b6ac4c4439..9ae0b275238e 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -1101,8 +1101,7 @@ static int __init net_ns_init(void)
 	init_net_initialized = true;
 	up_write(&pernet_ops_rwsem);
 
-	if (register_pernet_subsys(&net_ns_ops))
-		panic("Could not register network namespace subsystems");
+	register_pernet_subsys(&net_ns_ops);
 
 	rtnl_register(PF_UNSPEC, RTM_NEWNSID, rtnl_net_newid, NULL,
 		      RTNL_FLAG_DOIT_UNLOCKED);
-- 
2.31.1

