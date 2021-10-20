Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C19435378
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhJTTMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 15:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhJTTMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:12:10 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7323C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:09:55 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id y41-20020a056a00182900b0044d43d31f20so2400237pfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc
         :content-transfer-encoding;
        bh=359/BoTwYXMfn/EFGB2TISehbC5XXMB3pXS6xxZQlxM=;
        b=cW7taxepkXfxzQtgHsfdY1U55sCuhmziqhGNRE1xVb82LjiF1IgK6es+MsfetBf9io
         wLMyvixDKUA3ihyu+GdNlGkZzietdD9bk9eNfp3WT+wf5TkfdiiuUZyzQAoO8fRiVrmh
         +QdSuQtvW0adXFG/+YF1GvPkCo7pGV7rftsKy/zGcqnnvEr8Dp+gZjXK6dNHwIH8feaw
         W4qXvfeE8B9z/sj5uo8K+LepCLdJxk3s9fsP4AkPOeBwT3jAKTp5TJCULhPyp37gz0nU
         z0rGk8YK3tvDScbAdxU2dQObP9xMLJFmjOFCu3H/6JFm7Vc6Dub+9FLVBy/JVhJb3THd
         gtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc
         :content-transfer-encoding;
        bh=359/BoTwYXMfn/EFGB2TISehbC5XXMB3pXS6xxZQlxM=;
        b=dSVJFmt+N+fveLwxZYqZu9vWZHeoDW9h+rdOv9tg5G5aQNbqX2y5nAfLNKY4GWvQQZ
         1zT/FOvm+4iqvthhQNkgPcnAcrlicP96vTKPbsLY6eiUhUf7e4YsGOzOTjcFOVxDI0sk
         4KJln4rfi5K+WSARRA+0NF9zVDl0drdgbtEAm4SbQ+6QMK/fcWEXx8KuhTKfLBRWYwlB
         OxjLwZwrfHBn3MmM5DbMCm04witASPK2qrR7+Gmr5xTtHZFugnqjnR6TO4LqyzQ/g2p0
         YoPcozOffenqE8Rz04cgMpZAjFiWzxQKUnhCFhgeoBU4XXOONlSXtLzQe2IwIDwDurt5
         9C8w==
X-Gm-Message-State: AOAM530NqQIe8Z5yxNV7lt6iq17z8G3+eqjriK6FD8N35VW2Kkr590OJ
        r6qHJNovOEXmWGXJyuwatq0vMPElpQoSq+VZLg==
X-Google-Smtp-Source: ABdhPJwkkpHWIYi1Yk5XobMtECstDCNTjXitxbscTc31Y4Xtp0ZVFHUIVIhJEPrrebawNjVOo/kzvh1AdyQB6OCMQg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:4751:e137:5384:fe9f])
 (user=almasrymina job=sendgmr) by 2002:aa7:8198:0:b0:44b:e191:7058 with SMTP
 id g24-20020aa78198000000b0044be1917058mr605212pfi.39.1634756995030; Wed, 20
 Oct 2021 12:09:55 -0700 (PDT)
Date:   Wed, 20 Oct 2021 12:09:52 -0700
Message-Id: <20211020190952.2658759-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2] hugetlb: Add hugetlb.*.numa_stat file
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Jue Wang <juew@google.com>, Yang Yao <ygyao@google.com>,
        Joanna Li <joannali@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For hugetlb backed jobs/VMs it's critical to understand the numa
information for the memory backing these jobs to deliver optimal
performance.

Currently this techinically can be queried from /proc/self/numa_maps, but
there are significant issues with that. Namely:
1. Memory can be mapped on unmapped.
2. numa_maps are per process and need to be aggregaged across all
   proceses in the cgroup. For shared memory this is more involved as
   the userspace needs to make sure it doesn't double count shared
   mappings.
3. I believe querying numa_maps needs to hold the mmap_lock which adds
   to the contention on this lock.

For these reasons I propose simply adding hugetlb.*.numa_stat file,
which shows the numa information of the cgroup similarly to
memory.numa_stat.

On cgroup-v2:
   cat /dev/cgroup/memory/test/hugetlb.2MB.numa_stat
   total=3D2097152 N0=3D2097152 N1=3D0

On cgroup-v1:
   cat /dev/cgroup/memory/test/hugetlb.2MB.numa_stat
   total=3D2097152 N0=3D2097152 N1=3D0
   hierarichal_total=3D2097152 N0=3D2097152 N1=3D0

This patch was tested manually by allocating hugetlb memory and querying
the hugetlb.*.numa_stat file of the cgroup and its parents.
=EF=BF=BC
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Jue Wang <juew@google.com>
Cc: Yang Yao <ygyao@google.com>
Cc: Joanna Li <joannali@google.com>
Cc: Cannon Matthews <cannonmatthews@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

Changes in v2:
- Fix warning Reported-by: kernel test robot <lkp@intel.com>
---
 .../admin-guide/cgroup-v1/hugetlb.rst         |  4 +
 Documentation/admin-guide/cgroup-v2.rst       |  7 ++
 include/linux/hugetlb.h                       |  4 +-
 include/linux/hugetlb_cgroup.h                |  7 ++
 mm/hugetlb_cgroup.c                           | 93 +++++++++++++++++--
 .../testing/selftests/vm/write_to_hugetlbfs.c |  9 +-
 6 files changed, 113 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/hugetlb.rst b/Documentatio=
n/admin-guide/cgroup-v1/hugetlb.rst
index 338f2c7d7a1c..0fa724d82abb 100644
--- a/Documentation/admin-guide/cgroup-v1/hugetlb.rst
+++ b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
@@ -29,12 +29,14 @@ Brief summary of control files::
  hugetlb.<hugepagesize>.max_usage_in_bytes             # show max "hugepag=
esize" hugetlb  usage recorded
  hugetlb.<hugepagesize>.usage_in_bytes                 # show current usag=
e for "hugepagesize" hugetlb
  hugetlb.<hugepagesize>.failcnt                        # show the number o=
f allocation failure due to HugeTLB usage limit
+ hugetlb.<hugepagesize>.numa_stat                      # show the numa inf=
ormation of the hugetlb memory charged to this cgroup

 For a system supporting three hugepage sizes (64k, 32M and 1G), the contro=
l
 files include::

   hugetlb.1GB.limit_in_bytes
   hugetlb.1GB.max_usage_in_bytes
+  hugetlb.1GB.numa_stat
   hugetlb.1GB.usage_in_bytes
   hugetlb.1GB.failcnt
   hugetlb.1GB.rsvd.limit_in_bytes
@@ -43,6 +45,7 @@ files include::
   hugetlb.1GB.rsvd.failcnt
   hugetlb.64KB.limit_in_bytes
   hugetlb.64KB.max_usage_in_bytes
+  hugetlb.64KB.numa_stat
   hugetlb.64KB.usage_in_bytes
   hugetlb.64KB.failcnt
   hugetlb.64KB.rsvd.limit_in_bytes
@@ -51,6 +54,7 @@ files include::
   hugetlb.64KB.rsvd.failcnt
   hugetlb.32MB.limit_in_bytes
   hugetlb.32MB.max_usage_in_bytes
+  hugetlb.32MB.numa_stat
   hugetlb.32MB.usage_in_bytes
   hugetlb.32MB.failcnt
   hugetlb.32MB.rsvd.limit_in_bytes
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 4d8c27eca96b..8ba0d6aadd2c 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2252,6 +2252,13 @@ HugeTLB Interface Files
 	are local to the cgroup i.e. not hierarchical. The file modified event
 	generated on this file reflects only the local events.

+  hugetlb.<hugepagesize>.numa_stat
+	Similar to memory.numa_stat, it shows the numa information of the
+	memory in this cgroup:
+
+	/dev/cgroup/memory/test # cat hugetlb.2MB.numa_stat
+	total=3D0 N0=3D0 N1=3D0
+
 Misc
 ----

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1faebe1cd0ed..0445faaa636e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -613,8 +613,8 @@ struct hstate {
 #endif
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
-	struct cftype cgroup_files_dfl[7];
-	struct cftype cgroup_files_legacy[9];
+	struct cftype cgroup_files_dfl[8];
+	struct cftype cgroup_files_legacy[10];
 #endif
 	char name[HSTATE_NAME_LEN];
 };
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.=
h
index c137396129db..54ff6ec68ed3 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -36,6 +36,11 @@ enum hugetlb_memory_event {
 	HUGETLB_NR_MEMORY_EVENTS,
 };

+struct hugetlb_cgroup_per_node {
+	/* hugetlb usage in bytes over all hstates. */
+	unsigned long usage[HUGE_MAX_HSTATE];
+};
+
 struct hugetlb_cgroup {
 	struct cgroup_subsys_state css;

@@ -57,6 +62,8 @@ struct hugetlb_cgroup {

 	/* Handle for "hugetlb.events.local" */
 	struct cgroup_file events_local_file[HUGE_MAX_HSTATE];
+
+	struct hugetlb_cgroup_per_node *nodeinfo[];
 };

 static inline struct hugetlb_cgroup *
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 5383023d0cca..4b807292f7e8 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -92,6 +92,7 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_=
cgroup,
 				struct hugetlb_cgroup *parent_h_cgroup)
 {
 	int idx;
+	int node;

 	for (idx =3D 0; idx < HUGE_MAX_HSTATE; idx++) {
 		struct page_counter *fault_parent =3D NULL;
@@ -124,6 +125,15 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup =
*h_cgroup,
 			limit);
 		VM_BUG_ON(ret);
 	}
+
+	for_each_node(node) {
+		/* Set node_to_alloc to -1 for offline nodes. */
+		int node_to_alloc =3D
+			node_state(node, N_NORMAL_MEMORY) ? node : -1;
+		h_cgroup->nodeinfo[node] =3D
+			kzalloc_node(sizeof(struct hugetlb_cgroup_per_node),
+				     GFP_KERNEL, node_to_alloc);
+	}
 }

 static struct cgroup_subsys_state *
@@ -132,7 +142,10 @@ hugetlb_cgroup_css_alloc(struct cgroup_subsys_state *p=
arent_css)
 	struct hugetlb_cgroup *parent_h_cgroup =3D hugetlb_cgroup_from_css(parent=
_css);
 	struct hugetlb_cgroup *h_cgroup;

-	h_cgroup =3D kzalloc(sizeof(*h_cgroup), GFP_KERNEL);
+	unsigned int size =3D
+		sizeof(*h_cgroup) +
+		MAX_NUMNODES * sizeof(struct hugetlb_cgroup_per_node *);
+	h_cgroup =3D kzalloc(size, GFP_KERNEL);
 	if (!h_cgroup)
 		return ERR_PTR(-ENOMEM);

@@ -292,7 +305,9 @@ static void __hugetlb_cgroup_commit_charge(int idx, uns=
igned long nr_pages,
 		return;

 	__set_hugetlb_cgroup(page, h_cg, rsvd);
-	return;
+	if (!rsvd && h_cg)
+		h_cg->nodeinfo[page_to_nid(page)]->usage[idx] +=3D nr_pages
+								 << PAGE_SHIFT;
 }

 void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
@@ -331,7 +346,9 @@ static void __hugetlb_cgroup_uncharge_page(int idx, uns=
igned long nr_pages,

 	if (rsvd)
 		css_put(&h_cg->css);
-
+	else
+		h_cg->nodeinfo[page_to_nid(page)]->usage[idx] -=3D nr_pages
+								 << PAGE_SHIFT;
 	return;
 }

@@ -421,6 +438,56 @@ enum {
 	RES_RSVD_FAILCNT,
 };

+static int hugetlb_cgroup_read_numa_stat(struct seq_file *seq, void *dummy=
)
+{
+	int nid;
+	struct cftype *cft =3D seq_cft(seq);
+	int idx =3D MEMFILE_IDX(cft->private);
+	bool legacy =3D MEMFILE_ATTR(cft->private);
+	struct hugetlb_cgroup *h_cg =3D hugetlb_cgroup_from_css(seq_css(seq));
+	struct cgroup_subsys_state *css;
+	unsigned long usage;
+
+	if (legacy) {
+		/* Add up usage across all nodes for the non-hierarchical total. */
+		usage =3D 0;
+		for_each_node_state(nid, N_MEMORY)
+			usage +=3D h_cg->nodeinfo[nid]->usage[idx];
+		seq_printf(seq, "total=3D%lu", usage);
+
+		/* Simply print the per-node usage for the non-hierarchical total. */
+		for_each_node_state(nid, N_MEMORY)
+			seq_printf(seq, " N%d=3D%lu", nid,
+				   h_cg->nodeinfo[nid]->usage[idx]);
+		seq_putc(seq, '\n');
+	}
+
+	/* The hierarchical total is pretty much the value recorded by the
+	 * counter, so use that.
+	 */
+	seq_printf(seq, "%stotal=3D%lu", legacy ? "hierarichal_" : "",
+		   page_counter_read(&h_cg->hugepage[idx]) * PAGE_SIZE);
+
+	/* For each node, transverse the css tree to obtain the hierarichal
+	 * node usage.
+	 */
+	for_each_node_state(nid, N_MEMORY) {
+		usage =3D 0;
+		rcu_read_lock();
+		css_for_each_descendant_pre(css, &h_cg->css) {
+			usage +=3D hugetlb_cgroup_from_css(css)
+					 ->nodeinfo[nid]
+					 ->usage[idx];
+		}
+		rcu_read_unlock();
+		seq_printf(seq, " N%d=3D%lu", nid, usage);
+	}
+
+	seq_putc(seq, '\n');
+
+	return 0;
+}
+
 static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
 				   struct cftype *cft)
 {
@@ -654,8 +721,14 @@ static void __init __hugetlb_cgroup_file_dfl_init(int =
idx)
 	cft->seq_show =3D hugetlb_cgroup_read_u64_max;
 	cft->flags =3D CFTYPE_NOT_ON_ROOT;

-	/* Add the events file */
+	/* Add the numa stat file */
 	cft =3D &h->cgroup_files_dfl[4];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
+	cft->seq_show =3D hugetlb_cgroup_read_numa_stat;
+	cft->flags =3D CFTYPE_NOT_ON_ROOT;
+
+	/* Add the events file */
+	cft =3D &h->cgroup_files_dfl[5];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events", buf);
 	cft->private =3D MEMFILE_PRIVATE(idx, 0);
 	cft->seq_show =3D hugetlb_events_show;
@@ -663,7 +736,7 @@ static void __init __hugetlb_cgroup_file_dfl_init(int i=
dx)
 	cft->flags =3D CFTYPE_NOT_ON_ROOT;

 	/* Add the events.local file */
-	cft =3D &h->cgroup_files_dfl[5];
+	cft =3D &h->cgroup_files_dfl[6];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events.local", buf);
 	cft->private =3D MEMFILE_PRIVATE(idx, 0);
 	cft->seq_show =3D hugetlb_events_local_show;
@@ -672,7 +745,7 @@ static void __init __hugetlb_cgroup_file_dfl_init(int i=
dx)
 	cft->flags =3D CFTYPE_NOT_ON_ROOT;

 	/* NULL terminate the last cft */
-	cft =3D &h->cgroup_files_dfl[6];
+	cft =3D &h->cgroup_files_dfl[7];
 	memset(cft, 0, sizeof(*cft));

 	WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
@@ -742,8 +815,14 @@ static void __init __hugetlb_cgroup_file_legacy_init(i=
nt idx)
 	cft->write =3D hugetlb_cgroup_reset;
 	cft->read_u64 =3D hugetlb_cgroup_read_u64;

+	/* Add the numa stat file */
+	cft =3D &h->cgroup_files_dfl[8];
+	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
+	cft->private =3D MEMFILE_PRIVATE(idx, 1);
+	cft->seq_show =3D hugetlb_cgroup_read_numa_stat;
+
 	/* NULL terminate the last cft */
-	cft =3D &h->cgroup_files_legacy[8];
+	cft =3D &h->cgroup_files_legacy[9];
 	memset(cft, 0, sizeof(*cft));

 	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
diff --git a/tools/testing/selftests/vm/write_to_hugetlbfs.c b/tools/testin=
g/selftests/vm/write_to_hugetlbfs.c
index 6a2caba19ee1..d2da6315a40c 100644
--- a/tools/testing/selftests/vm/write_to_hugetlbfs.c
+++ b/tools/testing/selftests/vm/write_to_hugetlbfs.c
@@ -37,8 +37,8 @@ static int shmid;
 static void exit_usage(void)
 {
 	printf("Usage: %s -p <path to hugetlbfs file> -s <size to map> "
-	       "[-m <0=3Dhugetlbfs | 1=3Dmmap(MAP_HUGETLB)>] [-l] [-r] "
-	       "[-o] [-w] [-n]\n",
+	       "[-m <0=3Dhugetlbfs | 1=3Dmmap(MAP_HUGETLB)>] [-l(sleep)] [-r(priv=
ate)] "
+	       "[-o(populate)] [-w(rite)] [-n(o-reserve)]\n",
 	       self);
 	exit(EXIT_FAILURE);
 }
@@ -161,6 +161,11 @@ int main(int argc, char **argv)
 	else
 		printf("RESERVE mapping.\n");

+	if (want_sleep)
+		printf("Sleeping\n");
+	else
+		printf("Not sleeping\n");
+
 	switch (method) {
 	case HUGETLBFS:
 		printf("Allocating using HUGETLBFS.\n");
--
2.33.0.1079.g6e70778dc9-goog
