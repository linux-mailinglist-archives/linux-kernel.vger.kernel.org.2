Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFA9366BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbhDUNGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:06:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240776AbhDUNFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:05:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89F3B6143C;
        Wed, 21 Apr 2021 13:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010270;
        bh=dJhtTlGjgVhYBBb75ZTez9qEgnAZsAL6t71HFuNL1+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i7TJIJiGSE+++ulUbAK5MS/vOPCP5qz0iE4REUVEuHuuP7Ic41dicdaeLl4AEmp/4
         I2gqGwK33Mk85vL8gh2JlEaHKiJ+GYB1PejG/X0X4JH5M15LNlt2C8gZzJnTGlIu1L
         nPPir3uxs75ndrO82L6mpG+RXjxG7/NqXibsM1bc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>, Borislav Petkov <bp@suse.de>
Subject: [PATCH 029/190] Revert "EDAC: Fix reference count leaks"
Date:   Wed, 21 Apr 2021 14:58:24 +0200
Message-Id: <20210421130105.1226686-30-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 17ed808ad243192fb923e4e653c1338d3ba06207.

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

Cc: Qiushi Wu <wu000273@umn.edu>
Cc: Borislav Petkov <bp@suse.de>
Cc: https
Cc: https
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/edac_device_sysfs.c | 1 -
 drivers/edac/edac_pci_sysfs.c    | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 5e7593753799..0e7ea3591b78 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -275,7 +275,6 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
 
 	/* Error exit stack */
 err_kobj_reg:
-	kobject_put(&edac_dev->kobj);
 	module_put(edac_dev->owner);
 
 err_out:
diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
index 53042af7262e..72c9eb9fdffb 100644
--- a/drivers/edac/edac_pci_sysfs.c
+++ b/drivers/edac/edac_pci_sysfs.c
@@ -386,7 +386,7 @@ static int edac_pci_main_kobj_setup(void)
 
 	/* Error unwind statck */
 kobject_init_and_add_fail:
-	kobject_put(edac_pci_top_main_kobj);
+	kfree(edac_pci_top_main_kobj);
 
 kzalloc_fail:
 	module_put(THIS_MODULE);
-- 
2.31.1

