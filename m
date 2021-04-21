Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F06366C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbhDUNT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:19:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241013AbhDUNKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:10:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D87261469;
        Wed, 21 Apr 2021 13:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010607;
        bh=XCGS38mhYxLD3/cRVW/efDV0uQs7n1/+j8g/mA/sRhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5n9tqUXXMpF/Lp//eeZx6QSrFAn8KpRDWKBP483ZG9isCymxM2NvOtsYZiCg5/kn
         i2gPQnRO8R5YZmnaInlfcAq8oYpS7gEU/OLytuyTF2HQXMoP6QYKLcNm8wSsUaa10w
         ys2UGfCtBDUQSFIxxPX4P8ffBbdZRXEmbB1zrFHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wenwen Wang <wang6495@umn.edu>,
        Adam Radford <aradford@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 189/190] Revert "scsi: 3w-9xxx: fix a missing-check bug"
Date:   Wed, 21 Apr 2021 15:01:04 +0200
Message-Id: <20210421130105.1226686-190-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c9318a3e0218bc9dacc25be46b9eec363259536f.

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
 drivers/scsi/3w-9xxx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index b96e82de4237..4c5d4ea8a592 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -886,11 +886,6 @@ static int twa_chrdev_open(struct inode *inode, struct file *file)
 	unsigned int minor_number;
 	int retval = TW_IOCTL_ERROR_OS_ENODEV;
 
-	if (!capable(CAP_SYS_ADMIN)) {
-		retval = -EACCES;
-		goto out;
-	}
-
 	minor_number = iminor(inode);
 	if (minor_number >= twa_device_extension_count)
 		goto out;
-- 
2.31.1

