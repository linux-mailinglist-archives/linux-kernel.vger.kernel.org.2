Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9805E366C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243011AbhDUNTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241212AbhDUNKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:10:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B086D61458;
        Wed, 21 Apr 2021 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010605;
        bh=aO3XaVz4NRMbQy2cpkc3LwKWJ3zyQhq8qYCW+0ke/VY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYye03X9dI/xyK31L6J4VwetErbEh5lE0VpC1jNxhZkDIuUhhU/hmMzi5KDjEyRbc
         MxdqPx2tPiLJf1Y/f9RTcBa5VosdHV9wz9ohedquIQ8R93CRX2xo5xE1qIBX4Oeb32
         yFaHqLxVMdAVro3nfP+o7nPZzdjdS0M/MXX23UCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wenwen Wang <wang6495@umn.edu>,
        Adam Radford <aradford@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 188/190] Revert "scsi: 3w-xxxx: fix a missing-check bug"
Date:   Wed, 21 Apr 2021 15:01:03 +0200
Message-Id: <20210421130105.1226686-189-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9899e4d3523faaef17c67141aa80ff2088f17871.

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

Cc: Wenwen Wang <wang6495@umn.edu>
Cc: Adam Radford <aradford@gmail.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/3w-xxxx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index d90b9fca4aea..8f52f35e40f1 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -1035,9 +1035,6 @@ static int tw_chrdev_open(struct inode *inode, struct file *file)
 
 	dprintk(KERN_WARNING "3w-xxxx: tw_ioctl_open()\n");
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
 	minor_number = iminor(inode);
 	if (minor_number >= tw_device_extension_count)
 		return -ENODEV;
-- 
2.31.1

