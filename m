Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D208366B84
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240273AbhDUNC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:02:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240200AbhDUNCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:02:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2270A61453;
        Wed, 21 Apr 2021 13:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010134;
        bh=ezuOcTByzCIrFyUFNPvg+Ngf/KtYgFuVQpxSaSVaa0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GFYLM+kUN+Ys+Yz+foCAejtqTUymtj92NBhOax3m0ABYoHHm7A1/huCoaqZe4Za2L
         RLLNJpIf4t7Q1eUeuzL/avx3N75pVJb0zzPpH0o58ahdxKTy/SMivUVIJ47fNvlqJi
         n8TzDPGDZTOLVlhJ99H+W6A0P+EttdR5af2q9qAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 024/190] Revert "drm/amdkfd: Fix reference count leaks."
Date:   Wed, 21 Apr 2021 14:58:19 +0200
Message-Id: <20210421130105.1226686-25-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 20eca0123a35305e38b344d571cf32768854168c.

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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 0be72789ccbc..d3c3fa25c2cc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -637,10 +637,8 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
 
 	ret = kobject_init_and_add(dev->kobj_node, &node_type,
 			sys_props.kobj_nodes, "%d", id);
-	if (ret < 0) {
-		kobject_put(dev->kobj_node);
+	if (ret < 0)
 		return ret;
-	}
 
 	dev->kobj_mem = kobject_create_and_add("mem_banks", dev->kobj_node);
 	if (!dev->kobj_mem)
@@ -687,10 +685,8 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
 			return -ENOMEM;
 		ret = kobject_init_and_add(mem->kobj, &mem_type,
 				dev->kobj_mem, "%d", i);
-		if (ret < 0) {
-			kobject_put(mem->kobj);
+		if (ret < 0)
 			return ret;
-		}
 
 		mem->attr.name = "properties";
 		mem->attr.mode = KFD_SYSFS_FILE_MODE;
@@ -708,10 +704,8 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
 			return -ENOMEM;
 		ret = kobject_init_and_add(cache->kobj, &cache_type,
 				dev->kobj_cache, "%d", i);
-		if (ret < 0) {
-			kobject_put(cache->kobj);
+		if (ret < 0)
 			return ret;
-		}
 
 		cache->attr.name = "properties";
 		cache->attr.mode = KFD_SYSFS_FILE_MODE;
@@ -729,10 +723,8 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
 			return -ENOMEM;
 		ret = kobject_init_and_add(iolink->kobj, &iolink_type,
 				dev->kobj_iolink, "%d", i);
-		if (ret < 0) {
-			kobject_put(iolink->kobj);
+		if (ret < 0)
 			return ret;
-		}
 
 		iolink->attr.name = "properties";
 		iolink->attr.mode = KFD_SYSFS_FILE_MODE;
@@ -811,10 +803,8 @@ static int kfd_topology_update_sysfs(void)
 		ret = kobject_init_and_add(sys_props.kobj_topology,
 				&sysprops_type,  &kfd_device->kobj,
 				"topology");
-		if (ret < 0) {
-			kobject_put(sys_props.kobj_topology);
+		if (ret < 0)
 			return ret;
-		}
 
 		sys_props.kobj_nodes = kobject_create_and_add("nodes",
 				sys_props.kobj_topology);
-- 
2.31.1

