Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA923D0923
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 08:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhGUGEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 02:04:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:44379 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234290AbhGUF7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:59:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="272496411"
X-IronPort-AV: E=Sophos;i="5.84,257,1620716400"; 
   d="scan'208";a="272496411"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 23:40:05 -0700
X-IronPort-AV: E=Sophos;i="5.84,257,1620716400"; 
   d="scan'208";a="511390108"
Received: from yhuang6-desk2.sh.intel.com ([10.239.159.119])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 23:40:00 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Yang Shi <shy828301@gmail.com>
Subject: [PATCH -V11 9/9] mm/migrate: add sysfs interface to enable reclaim migration
Date:   Wed, 21 Jul 2021 14:39:26 +0800
Message-Id: <20210721063926.3024591-9-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721063926.3024591-1-ying.huang@intel.com>
References: <20210721063926.3024591-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some method is obviously needed to enable reclaim-based migration.

Just like traditional autonuma, there will be some workloads that will
benefit like workloads with more "static" configurations where hot pages
stay hot and cold pages stay cold.  If pages come and go from the hot and
cold sets, the benefits of this approach will be more limited.

The benefits are truly workload-based and *not* hardware-based.  We do not
believe that there is a viable threshold where certain hardware
configurations should have this mechanism enabled while others do not.

To be conservative, earlier work defaulted to disable reclaim- based
migration and did not include a mechanism to enable it.  This proposes add
a new sysfs file

  /sys/kernel/mm/numa/demotion_enabled

as a method to enable it.

We are open to any alternative that allows end users to enable this
mechanism or disable it if workload harm is detected (just like
traditional autonuma).

Once this is enabled page demotion may move data to a NUMA node that does
not fall into the cpuset of the allocating process.  This could be
construed to violate the guarantees of cpusets.  However, since this is an
opt-in mechanism, the assumption is that anyone enabling it is content to
relax the guarantees.

Originally-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20210715055145.195411-10-ying.huang@intel.com
Signed-off-by: Huang Ying <ying.huang@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Yang Shi <shy828301@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 .../ABI/testing/sysfs-kernel-mm-numa          | 24 ++++++++
 include/linux/mempolicy.h                     |  4 ++
 mm/mempolicy.c                                | 61 +++++++++++++++++++
 mm/vmscan.c                                   |  5 +-
 4 files changed, 92 insertions(+), 2 deletions(-)
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
index 0aaf91b496e2..4ca025e2a77e 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -184,6 +184,8 @@ extern bool vma_migratable(struct vm_area_struct *vma);
 extern int mpol_misplaced(struct page *, struct vm_area_struct *, unsigned long);
 extern void mpol_put_task_policy(struct task_struct *);
 
+extern bool numa_demotion_enabled;
+
 #else
 
 struct mempolicy {};
@@ -292,5 +294,7 @@ static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
 {
 	return NULL;
 }
+
+#define numa_demotion_enabled	false
 #endif /* CONFIG_NUMA */
 #endif
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f58c38ea1e83..a0535b73697f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3062,3 +3062,64 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
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
+		numa_demotion_enabled = true;
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
index 60179903ed9e..fa59b1344e36 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -521,6 +521,8 @@ static long add_nr_deferred(long nr, struct shrinker *shrinker,
 
 static bool can_demote(int nid, struct scan_control *sc)
 {
+	if (!numa_demotion_enabled)
+		return false;
 	if (sc) {
 		if (sc->no_demotion)
 			return false;
@@ -531,8 +533,7 @@ static bool can_demote(int nid, struct scan_control *sc)
 	if (next_demotion_node(nid) == NUMA_NO_NODE)
 		return false;
 
-	// FIXME: actually enable this later in the series
-	return false;
+	return true;
 }
 
 static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
-- 
2.30.2

