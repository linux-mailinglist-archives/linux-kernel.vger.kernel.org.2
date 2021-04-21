Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481E4366BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241195AbhDUNHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:07:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240721AbhDUNFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:05:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2634C61464;
        Wed, 21 Apr 2021 13:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010310;
        bh=fnUVQIx3gsSMmwjFUdEROC1SSDNtTcZJgiwWSP0Ahyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2wdPWxBQrnECB3izvINH/oGSSV77y78/+ot+1sW2mconBPHhVDigO5p/rbvSccLyv
         8WWBSZfl3vF6bfCqvhRnGXfaT0zfjplKVGPie8ou142ZSDv5sy0oOvUxrzZIWS1VA5
         sEkhOpbHjGbu6inPA/BqxceZpy+Fm+pljOTOyBlo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 089/190] Revert "PCI: endpoint: Fix a potential NULL pointer dereference"
Date:   Wed, 21 Apr 2021 14:59:24 +0200
Message-Id: <20210421130105.1226686-90-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 507b820009a457afa78202da337bcb56791fbb12.

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
Cc: commit log and code update]
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index c0ac4e9cbe72..39dd394284a5 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -915,11 +915,6 @@ static int __init pci_epf_test_init(void)
 
 	kpcitest_workqueue = alloc_workqueue("kpcitest",
 					     WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
-	if (!kpcitest_workqueue) {
-		pr_err("Failed to allocate the kpcitest work queue\n");
-		return -ENOMEM;
-	}
-
 	ret = pci_epf_register_driver(&test_driver);
 	if (ret) {
 		pr_err("Failed to register pci epf test driver --> %d\n", ret);
-- 
2.31.1

