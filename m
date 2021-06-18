Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F573AC3C7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhFRGXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:23:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:5108 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233578AbhFRGWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:22:37 -0400
IronPort-SDR: QK+8ZVDxWRDrxDKbEvgnMssRJ72puombrWGFeXt40SIqTu63zlOORHqJ6mL0eGHyt7LC7x86AV
 hDB9iFKdieIA==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193815282"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="193815282"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 23:16:36 -0700
IronPort-SDR: eNX/Lk6huXiQb7hk/oFYMKGx4B1R4t4cHMt8AvL/Ch+OvNAEZ9wHYNXCRMas5Jk6kMYx6XS38a
 +FIbLgAZVzAw==
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="485573737"
Received: from mzhou6-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.212.155])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 23:16:33 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        osalvador <osalvador@suse.de>
Subject: [PATCH -V8 10/10] mm/migrate: add sysfs interface to enable reclaim migration
Date:   Fri, 18 Jun 2021 14:15:37 +0800
Message-Id: <20210618061537.434999-11-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618061537.434999-1-ying.huang@intel.com>
References: <20210618061537.434999-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some method is obviously needed to enable reclaim-based migration.

Just like traditional autonuma, there will be some workloads that
will benefit like workloads with more "static" configurations where
hot pages stay hot and cold pages stay cold.  If pages come and go
from the hot and cold sets, the benefits of this approach will be
more limited.

The benefits are truly workload-based and *not* hardware-based.
We do not believe that there is a viable threshold where certain
hardware configurations should have this mechanism enabled while
others do not.

To be conservative, earlier work defaulted to disable reclaim-
based migration and did not include a mechanism to enable it.
This proposes add a new sysfs file

  /sys/kernel/mm/numa/demotion_enabled

as a method to enable it.

We are open to any alternative that allows end users to enable
this mechanism or disable it if workload harm is detected (just
like traditional autonuma).

Once this is enabled page demotion may move data to a NUMA node
that does not fall into the cpuset of the allocating process.
This could be construed to violate the guarantees of cpusets.
However, since this is an opt-in mechanism, the assumption is
that anyone enabling it is content to relax the guarantees.

Originally-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Huang Ying <ying.huang@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>

Changes since 20200122:
 * Changelog material about relaxing cpuset constraints

Changes since 20210304:
 * Add Documentation/ material about relaxing cpuset constraints

Changes since 20210331:
 * Use sysfs interface separated from the zone_reclaim sysctl.
---
 .../ABI/testing/sysfs-kernel-mm-numa          | 24 ++++++++
 include/linux/mempolicy.h                     |  4 ++
 mm/mempolicy.c                                | 61 +++++++++++++++++++
 mm/vmscan.c                                   |  6 +-
 4 files changed, 93 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-numa

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-numa b/Documentation/ABI/testing/sysfs-kernel-mm-numa
new file mode 100644
index 000000000000..77e559d4ed80
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-numa
@@ -0,0 +1,24 @@
+What:		/sys/kernel/mm/numa/
+Date:		June 2021
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Interface for NUMA
+
+What:		/sys/kernel/mm/numa/demotion_enabled
+Date:		June 2021
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Enable/disable demoting pages during reclaim
+
+		Page migration during reclaim is intended for systems
+		with tiered memory configurations.  These systems have
+		multiple types of memory with varied performance
+		characteristics instead of plain NUMA systems where
+		the same kind of memory is found at varied distances.
+		Allowing page migration during reclaim enables these
+		systems to migrate pages from fast tiers to slow tiers
+		when the fast tier is under pressure.  This migration
+		is performed before swap.  It may move data to a NUMA
+		node that does not fall into the cpuset of the
+		allocating process which might be construed to violate
+		the guarantees of cpusets.  This should not be enabled
+		on systems which need strict cpuset location
+		guarantees.
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 5f1c74df264d..78a736e76d5c 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -187,6 +187,8 @@ extern bool vma_migratable(struct vm_area_struct *vma);
 extern int mpol_misplaced(struct page *, struct vm_area_struct *, unsigned long);
 extern void mpol_put_task_policy(struct task_struct *);
 
+extern bool numa_demotion_enabled;
+
 #else
 
 struct mempolicy {};
@@ -295,5 +297,7 @@ static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
 {
 	return NULL;
 }
+
+#define numa_demotion_enabled	false
 #endif /* CONFIG_NUMA */
 #endif
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 25dceedbb884..f19d91368931 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3060,3 +3060,64 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 		p += scnprintf(p, buffer + maxlen - p, ":%*pbl",
 			       nodemask_pr_args(&nodes));
 }
+
+bool numa_demotion_enabled = false;
+
+#ifdef CONFIG_SYSFS
+static ssize_t numa_demotion_enabled_show(struct kobject *kobj,
+					  struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+			  numa_demotion_enabled? "true" : "false");
+}
+
+static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	if (!strncmp(buf, "true", 4) || !strncmp(buf, "1", 1))
+		numa_demotion_enabled= true;
+	else if (!strncmp(buf, "false", 5) || !strncmp(buf, "0", 1))
+		numa_demotion_enabled = false;
+	else
+		return -EINVAL;
+
+	return count;
+}
+
+static struct kobj_attribute numa_demotion_enabled_attr =
+	__ATTR(demotion_enabled, 0644, numa_demotion_enabled_show,
+	       numa_demotion_enabled_store);
+
+static struct attribute *numa_attrs[] = {
+	&numa_demotion_enabled_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group numa_attr_group = {
+	.attrs = numa_attrs,
+};
+
+static int __init numa_init_sysfs(void)
+{
+	int err;
+	struct kobject *numa_kobj;
+
+	numa_kobj = kobject_create_and_add("numa", mm_kobj);
+	if (!numa_kobj) {
+		pr_err("failed to create numa kobject\n");
+		return -ENOMEM;
+	}
+	err = sysfs_create_group(numa_kobj, &numa_attr_group);
+	if (err) {
+		pr_err("failed to register numa group\n");
+		goto delete_obj;
+	}
+	return 0;
+
+delete_obj:
+	kobject_put(numa_kobj);
+	return err;
+}
+subsys_initcall(numa_init_sysfs);
+#endif
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 13a60426c12f..3560a9ea7565 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1270,6 +1270,9 @@ static bool migrate_demote_page_ok(struct page *page,
 	VM_BUG_ON_PAGE(PageHuge(page), page);
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
+	if (!numa_demotion_enabled)
+		return false;
+
 	/* It is pointless to do demotion in memcg reclaim */
 	if (cgroup_reclaim(sc))
 		return false;
@@ -1279,8 +1282,7 @@ static bool migrate_demote_page_ok(struct page *page,
 	if (PageTransHuge(page) && !thp_migration_supported())
 		return false;
 
-	// FIXME: actually enable this later in the series
-	return false;
+	return true;
 }
 
 /* Check if a page is dirty or under writeback */
-- 
2.30.2

