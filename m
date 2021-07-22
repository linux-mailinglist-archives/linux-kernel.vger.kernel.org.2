Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42E43D1E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhGVFrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:47:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:46906 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230331AbhGVFrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:47:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="233387054"
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; 
   d="scan'208";a="233387054"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 23:27:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; 
   d="scan'208";a="512385844"
Received: from louislifei-optiplex-7050.sh.intel.com ([10.239.154.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jul 2021 23:27:48 -0700
From:   Fei Li <fei1.li@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Shuo Liu <shuo.a.liu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, Fei Li <fei1.li@intel.com>,
        yu1.wang@intel.com
Subject: [PATCH] virt: acrn: Do hcall_destroy_vm() before resource release
Date:   Thu, 22 Jul 2021 14:27:36 +0800
Message-Id: <20210722062736.15050-1-fei1.li@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

The ACRN hypervisor has scenarios which could run a real-time guest VM.
The real-time guest VM occupies dedicated CPU cores, be assigned with
dedicated PCI devices. It can run without the Service VM after boot up.
hcall_destroy_vm() returns failure when a real-time guest VM refuses.
The clearing of flag ACRN_VM_FLAG_DESTROYED causes some kernel resource
double-freed in a later acrn_vm_destroy().

Do hcall_destroy_vm() before resource release to drop this chance to
destroy the VM if hypercall fails.

Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Signed-off-by: Fei Li <fei1.li@intel.com>
---
 drivers/virt/acrn/vm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/virt/acrn/vm.c b/drivers/virt/acrn/vm.c
index 0d002a355a93..fbc9f1042000 100644
--- a/drivers/virt/acrn/vm.c
+++ b/drivers/virt/acrn/vm.c
@@ -64,6 +64,14 @@ int acrn_vm_destroy(struct acrn_vm *vm)
 	    test_and_set_bit(ACRN_VM_FLAG_DESTROYED, &vm->flags))
 		return 0;
 
+	ret = hcall_destroy_vm(vm->vmid);
+	if (ret < 0) {
+		dev_err(acrn_dev.this_device,
+			"Failed to destroy VM %u\n", vm->vmid);
+		clear_bit(ACRN_VM_FLAG_DESTROYED, &vm->flags);
+		return ret;
+	}
+
 	/* Remove from global VM list */
 	write_lock_bh(&acrn_vm_list_lock);
 	list_del_init(&vm->list);
@@ -78,14 +86,6 @@ int acrn_vm_destroy(struct acrn_vm *vm)
 		vm->monitor_page = NULL;
 	}
 
-	ret = hcall_destroy_vm(vm->vmid);
-	if (ret < 0) {
-		dev_err(acrn_dev.this_device,
-			"Failed to destroy VM %u\n", vm->vmid);
-		clear_bit(ACRN_VM_FLAG_DESTROYED, &vm->flags);
-		return ret;
-	}
-
 	acrn_vm_all_ram_unmap(vm);
 
 	dev_dbg(acrn_dev.this_device, "VM %u destroyed.\n", vm->vmid);

base-commit: c453db6cd96418c79702eaf38259002755ab23ff
-- 
2.17.1

