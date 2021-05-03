Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5EE3714AF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhECMAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233516AbhECMAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:00:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C76F61185;
        Mon,  3 May 2021 11:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043147;
        bh=HTH8Loe9bGNFvHLAWRqr4mqbB+7rSi+n4KOQ3IvjTkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1kEgk2sp1LeFLC2EANg7njqObCC223Z0CfyzI+N7Wl8uxaUwLVA45chhDLNQeY3th
         1uonBOC7piDNArM9HZu5npGrQscD/+hhT5pdYYZkYZ9AMz9UxDvTtm0xvPBKr0iwQq
         jtPHwdcNlPCMM92TpS9Ir7omeBN/h2xjo6HdpYbE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>, Ursula Braun <ubraun@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 16/69] Revert "net/smc: fix a NULL pointer dereference"
Date:   Mon,  3 May 2021 13:56:43 +0200
Message-Id: <20210503115736.2104747-17-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e183d4e414b64711baf7a04e214b61969ca08dfa.

Because of recent interactions with developers from @umn.edu, all
commits from them have been recently re-reviewed to ensure if they were
correct or not.

Upon review, this commit was found to be incorrect for the reasons
below, so it must be reverted.  It will be fixed up "correctly" in a
later kernel change.

The original commit causes a memory leak and does not properly fix the
issue it claims to fix.  I will send a follow-on patch to resolve this
properly.

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Ursula Braun <ubraun@linux.ibm.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/smc_ism.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 9c6e95882553..6558cf7643a7 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -417,11 +417,6 @@ struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
 	init_waitqueue_head(&smcd->lgrs_deleted);
 	smcd->event_wq = alloc_ordered_workqueue("ism_evt_wq-%s)",
 						 WQ_MEM_RECLAIM, name);
-	if (!smcd->event_wq) {
-		kfree(smcd->conn);
-		kfree(smcd);
-		return NULL;
-	}
 	return smcd;
 }
 EXPORT_SYMBOL_GPL(smcd_alloc_dev);
-- 
2.31.1

