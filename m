Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED46366C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbhDUNKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240641AbhDUNH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:07:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5F4B6147D;
        Wed, 21 Apr 2021 13:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010435;
        bh=1l2bP0Z2HISASysOrGqw2ofYibH9fEIoDmGSaGpiC4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w+oOCBYgYdjD83PF7KGt9aVP8Q1fGvnQBkYnQLjpTmCveIXWRYT+vMxgzcvmVAjv5
         Jg7Hou0XlWON0rxrHVzOxaJBOAm9UJB5naAvG5Hijcjahh9htdpxeC2FJ0xZPvsvlL
         GCrFSQT2tm/lStIWe0h6x4Eiew9vG3ofaaO0U7k4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH 108/190] Revert "usb: u132-hcd: fix potential NULL pointer dereference"
Date:   Wed, 21 Apr 2021 14:59:43 +0200
Message-Id: <20210421130105.1226686-109-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3de3dbe7c13210171ba8411e36b409a2c29c7415.

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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/u132-hcd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index eb96e1e15b71..2b7bcbe2df4b 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -3195,8 +3195,6 @@ static int __init u132_hcd_init(void)
 		return -ENODEV;
 	printk(KERN_INFO "driver %s\n", hcd_name);
 	workqueue = create_singlethread_workqueue("u132");
-	if (!workqueue)
-		return -ENOMEM;
 	retval = platform_driver_register(&u132_platform_driver);
 	if (retval)
 		destroy_workqueue(workqueue);
-- 
2.31.1

