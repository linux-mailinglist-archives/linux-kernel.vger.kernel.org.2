Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB0A366BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240808AbhDUNGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:06:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240664AbhDUNE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:04:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA3FB6145F;
        Wed, 21 Apr 2021 13:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010264;
        bh=2J71QIBPU4Q4kIcaPN0yMUi+xHpFanATChbdZbNZqhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mwf2LMEIC6CAv1ESwUsUyt69ETs3/8FO2SDf7732bX+mJeXjH2ZI+4oGWGpP/TQC+
         EXjqMcDqJO0MNZoh6sySe+RSjg4+W5KQGb2qQmxr4Jtu/2pgVPQAEHjdEtTT7Hv2oD
         FK1QIzjRqjZPD3eRbhuMYpgdEdaOE6aSBjy1n0C8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 037/190] Revert "RDMA/core: Fix several reference count leaks."
Date:   Wed, 21 Apr 2021 14:58:32 +0200
Message-Id: <20210421130105.1226686-38-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0b8e125e213204508e1b3c4bdfe69713280b7abd.

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
Cc: Qiushi Wu <wu000273@umn.edu>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index b8abb30f80df..1ff580362a7c 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1076,7 +1076,8 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 				   coredev->ports_kobj,
 				   "%d", port_num);
 	if (ret) {
-		goto err_put;
+		kfree(p);
+		return ret;
 	}
 
 	p->gid_attr_group = kzalloc(sizeof(*p->gid_attr_group), GFP_KERNEL);
@@ -1089,7 +1090,8 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	ret = kobject_init_and_add(&p->gid_attr_group->kobj, &gid_attr_type,
 				   &p->kobj, "gid_attrs");
 	if (ret) {
-		goto err_put_gid_attrs;
+		kfree(p->gid_attr_group);
+		goto err_put;
 	}
 
 	if (device->ops.process_mad && is_full_dev) {
@@ -1452,10 +1454,8 @@ int ib_port_register_module_stat(struct ib_device *device, u8 port_num,
 
 		ret = kobject_init_and_add(kobj, ktype, &port->kobj, "%s",
 					   name);
-		if (ret) {
-			kobject_put(kobj);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
-- 
2.31.1

