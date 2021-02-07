Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5B7312119
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 04:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhBGDP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 22:15:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:17671 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229846AbhBGDMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 22:12:52 -0500
IronPort-SDR: CryZuM8zTWLE2H8NVk/m6wf4zO0bhS6paYI82Nai/9BzXmnxkJteLxVlaJ8XFj05ubaB/qXKDO
 uNR+WZ8vGf8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9887"; a="169254719"
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="169254719"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 19:12:12 -0800
IronPort-SDR: FxVpGc7LoWsW4V/WfI6oR1/DSdyQZUHc8VqniFlWu4m2dcCP/He+pm0E/J6HYYEw/X24UHmOA8
 zCahyp2IfDOA==
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="584618214"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 19:12:09 -0800
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH v9 14/18] virt: acrn: Introduce I/O ranges operation interfaces
Date:   Sun,  7 Feb 2021 11:10:36 +0800
Message-Id: <20210207031040.49576-15-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210207031040.49576-1-shuo.a.liu@intel.com>
References: <20210207031040.49576-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

An I/O request of a User VM, which is constructed by hypervisor, is
distributed by the ACRN Hypervisor Service Module to an I/O client
corresponding to the address range of the I/O request.

I/O client maintains a list of address ranges. Introduce
acrn_ioreq_range_{add,del}() to manage these address ranges.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/acrn/acrn_drv.h |  4 +++
 drivers/virt/acrn/ioreq.c    | 60 ++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index 068f0be769f6..8a7d7721f505 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -197,6 +197,10 @@ struct acrn_ioreq_client *acrn_ioreq_client_create(struct acrn_vm *vm,
 						   void *data, bool is_default,
 						   const char *name);
 void acrn_ioreq_client_destroy(struct acrn_ioreq_client *client);
+int acrn_ioreq_range_add(struct acrn_ioreq_client *client,
+			 u32 type, u64 start, u64 end);
+void acrn_ioreq_range_del(struct acrn_ioreq_client *client,
+			  u32 type, u64 start, u64 end);
 
 int acrn_msi_inject(struct acrn_vm *vm, u64 msi_addr, u64 msi_data);
 
diff --git a/drivers/virt/acrn/ioreq.c b/drivers/virt/acrn/ioreq.c
index d19c05582d38..80b2e3f0e276 100644
--- a/drivers/virt/acrn/ioreq.c
+++ b/drivers/virt/acrn/ioreq.c
@@ -103,6 +103,66 @@ int acrn_ioreq_request_default_complete(struct acrn_vm *vm, u16 vcpu)
 	return ret;
 }
 
+/**
+ * acrn_ioreq_range_add() - Add an iorange monitored by an ioreq client
+ * @client:	The ioreq client
+ * @type:	Type (ACRN_IOREQ_TYPE_MMIO or ACRN_IOREQ_TYPE_PORTIO)
+ * @start:	Start address of iorange
+ * @end:	End address of iorange
+ *
+ * Return: 0 on success, <0 on error
+ */
+int acrn_ioreq_range_add(struct acrn_ioreq_client *client,
+			 u32 type, u64 start, u64 end)
+{
+	struct acrn_ioreq_range *range;
+
+	if (end < start) {
+		dev_err(acrn_dev.this_device,
+			"Invalid IO range [0x%llx,0x%llx]\n", start, end);
+		return -EINVAL;
+	}
+
+	range = kzalloc(sizeof(*range), GFP_KERNEL);
+	if (!range)
+		return -ENOMEM;
+
+	range->type = type;
+	range->start = start;
+	range->end = end;
+
+	write_lock_bh(&client->range_lock);
+	list_add(&range->list, &client->range_list);
+	write_unlock_bh(&client->range_lock);
+
+	return 0;
+}
+
+/**
+ * acrn_ioreq_range_del() - Del an iorange monitored by an ioreq client
+ * @client:	The ioreq client
+ * @type:	Type (ACRN_IOREQ_TYPE_MMIO or ACRN_IOREQ_TYPE_PORTIO)
+ * @start:	Start address of iorange
+ * @end:	End address of iorange
+ */
+void acrn_ioreq_range_del(struct acrn_ioreq_client *client,
+			  u32 type, u64 start, u64 end)
+{
+	struct acrn_ioreq_range *range;
+
+	write_lock_bh(&client->range_lock);
+	list_for_each_entry(range, &client->range_list, list) {
+		if (type == range->type &&
+		    start == range->start &&
+		    end == range->end) {
+			list_del(&range->list);
+			kfree(range);
+			break;
+		}
+	}
+	write_unlock_bh(&client->range_lock);
+}
+
 /*
  * ioreq_task() is the execution entity of handler thread of an I/O client.
  * The handler callback of the I/O client is called within the handler thread.
-- 
2.28.0

