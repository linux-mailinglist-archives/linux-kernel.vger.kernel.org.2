Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0232D366B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbhDUNCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:02:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240114AbhDUNCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:02:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 233C96144C;
        Wed, 21 Apr 2021 13:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010106;
        bh=Dcfl1rvwlFyHX4bolSx9gaN7dGnKAHnieK8lqjRh/Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t5tj3zSI25cPf4oOSe4U6MVizDzoUaCGMH70ahjs1yw6JyjOHECTg98F1YMkCWz3m
         MSsQRiI931AWDjjMvoCRj6SJMy4tdvqhpJ7odcu42ScJP634DGBUefsJpOKA0zLsPb
         QxTgyT+chtwhVVmYkgfGOh7nqwwKZuaehwGxpFRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH 015/190] Revert "firmware: Fix a reference count leak."
Date:   Wed, 21 Apr 2021 14:58:10 +0200
Message-Id: <20210421130105.1226686-16-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit fe3c60684377d5ad9b0569b87ed3e26e12c8173b.

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
Cc: https
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/qemu_fw_cfg.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 0078260fbabe..8fa660dde0f6 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -608,10 +608,8 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
 	/* register entry under "/sys/firmware/qemu_fw_cfg/by_key/" */
 	err = kobject_init_and_add(&entry->kobj, &fw_cfg_sysfs_entry_ktype,
 				   fw_cfg_sel_ko, "%d", entry->select);
-	if (err) {
-		kobject_put(&entry->kobj);
-		return err;
-	}
+	if (err)
+		goto err_register;
 
 	/* add raw binary content access */
 	err = sysfs_create_bin_file(&entry->kobj, &fw_cfg_sysfs_attr_raw);
@@ -627,6 +625,7 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
 
 err_add_raw:
 	kobject_del(&entry->kobj);
+err_register:
 	kfree(entry);
 	return err;
 }
-- 
2.31.1

