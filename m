Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53559366C00
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242395AbhDUNKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240762AbhDUNHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:07:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DADE61454;
        Wed, 21 Apr 2021 13:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010415;
        bh=kTTIUOI1lvgEO744bfl/sbBEmDo4AC4onNLNFUDA7HU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J5jZO/pWwB+r0jtBd9ENzzexsqs+1+tYoXFHD4D/DvM5dqtiljmwX3rTemZzjqlzG
         n3DJMFealHL1yATV4tigilO7251gkJp00FnooB6ERAa7eFHZgyLZbm2drDvM3aOuBJ
         QkyuEzltxID6p6dmRySNpKr4g8r+Y9kSLRFMZkug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 128/190] Revert "net: strparser: fix a missing check for create_singlethread_workqueue"
Date:   Wed, 21 Apr 2021 15:00:03 +0200
Message-Id: <20210421130105.1226686-129-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 228cd2dba27cee9956c1af97e6445be056881e41.

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
 net/strparser/strparser.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index b3815c1e8f2e..efce4ddaa320 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -542,8 +542,6 @@ EXPORT_SYMBOL_GPL(strp_check_rcv);
 static int __init strp_dev_init(void)
 {
 	strp_wq = create_singlethread_workqueue("kstrp");
-	if (unlikely(!strp_wq))
-		return -ENOMEM;
 
 	return 0;
 }
-- 
2.31.1

