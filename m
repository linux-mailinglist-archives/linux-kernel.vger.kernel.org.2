Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079A6366BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbhDUNF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240490AbhDUNEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:04:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A994C61458;
        Wed, 21 Apr 2021 13:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010259;
        bh=n/TSyYZd5zRsBCBBoZcaHAJTM1h/KbUqFgFErzwD0XA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zg0kQFqzsnfHPY0THjrdl0nmGyCNx4pUjsjgEDLgQGtdGEDCuw4S/3e7VFOw5tqfD
         3i2Ny7USA9qWWkiY9pN9BdxSsnOshk+ELXg7npQN1DVjniUwhdcZKcJaYN8D3aa6+r
         tZ77i1oeQUmRCBmAVgXMYadlKyLhQj+/oEitvfsA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Duncan <lduncan@suse.com>, Qiushi Wu <wu000273@umn.edu>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 035/190] Revert "scsi: iscsi: Fix reference count leak in iscsi_boot_create_kobj"
Date:   Wed, 21 Apr 2021 14:58:30 +0200
Message-Id: <20210421130105.1226686-36-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0267ffce562c8bbf9b57ebe0e38445ad04972890.

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

Cc: https
Cc: Lee Duncan <lduncan@suse.com>
Cc: Qiushi Wu <wu000273@umn.edu>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/iscsi_boot_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/iscsi_boot_sysfs.c b/drivers/scsi/iscsi_boot_sysfs.c
index a64abe38db2d..e4857b728033 100644
--- a/drivers/scsi/iscsi_boot_sysfs.c
+++ b/drivers/scsi/iscsi_boot_sysfs.c
@@ -352,7 +352,7 @@ iscsi_boot_create_kobj(struct iscsi_boot_kset *boot_kset,
 	boot_kobj->kobj.kset = boot_kset->kset;
 	if (kobject_init_and_add(&boot_kobj->kobj, &iscsi_boot_ktype,
 				 NULL, name, index)) {
-		kobject_put(&boot_kobj->kobj);
+		kfree(boot_kobj);
 		return NULL;
 	}
 	boot_kobj->data = data;
-- 
2.31.1

