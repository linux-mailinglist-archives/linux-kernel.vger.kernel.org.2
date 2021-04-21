Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4752C366BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbhDUNHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240826AbhDUNFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:05:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A545161494;
        Wed, 21 Apr 2021 13:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010313;
        bh=gQQLJDAzzJBQbG/E7ybbAyUR3aHwH5+xI5XATwqOUmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c1oME+lggFrS5ahiQ4Bnb+V6JDRqlevT5CMrK5E3kblHVWbyhQ5IkfNjo76ke6aVL
         sYrnCPChNUgu5mYGubAQPCCJ/+G7mYhyXGheWZ060JD1lWqQm75Gi8WgL0iI3QMADD
         Za6KaZsI8o4tE09vxtKsnRT1YpWpUoI6x9s6eXl4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>, Ursula Braun <ubraun@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 090/190] Revert "net/smc: fix a NULL pointer dereference"
Date:   Wed, 21 Apr 2021 14:59:25 +0200
Message-Id: <20210421130105.1226686-91-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e183d4e414b64711baf7a04e214b61969ca08dfa.

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

