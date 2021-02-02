Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3595330CCED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhBBUTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:19:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:59909 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232277AbhBBURo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:17:44 -0500
IronPort-SDR: 9rSpNq1LxMTzcN0MmpgTkYvqn98s+ICGMKp1F7m0+FVqIAeZY4SvTkml54QxT3ybALq+6nYmAs
 QQrj6Y+9xMrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="180148788"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="180148788"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 12:14:10 -0800
IronPort-SDR: Ota90BHoUU+YVCoQsCJ1hRfDn6R2x6Hf+5oF9gF1dKOuImw0Se8siJU9g0OeDtmvJqV0Zd8gEe
 HuOluNnjefYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="356442505"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 02 Feb 2021 12:14:09 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, eranian@google.com, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        maddy@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/9] perf tools: Support data block and addr block
Date:   Tue,  2 Feb 2021 12:09:07 -0800
Message-Id: <1612296553-21962-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Two new data source fields, to indicate the block reasons of a load
instruction, are introduced on the Intel Sapphire Rapids server. The
fields can be used by the memory profiling.

Add a new sort function, SORT_MEM_BLOCKED, for the two fields.

For the previous platforms or the block reason is unknown, print "N/A"
for the block reason.

Add blocked as a default mem sort key for perf report and
perf mem report.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-report.txt |  5 +++--
 tools/perf/builtin-mem.c                 |  2 +-
 tools/perf/util/hist.c                   |  1 +
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/mem-events.c             | 25 +++++++++++++++++++++
 tools/perf/util/mem-events.h             |  1 +
 tools/perf/util/sort.c                   | 38 +++++++++++++++++++++++++++++++-
 tools/perf/util/sort.h                   |  1 +
 8 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 8f7f4e9..826b5a9 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -139,7 +139,7 @@ OPTIONS
 
 	If the --mem-mode option is used, the following sort keys are also available
 	(incompatible with --branch-stack):
-	symbol_daddr, dso_daddr, locked, tlb, mem, snoop, dcacheline.
+	symbol_daddr, dso_daddr, locked, tlb, mem, snoop, dcacheline, blocked.
 
 	- symbol_daddr: name of data symbol being executed on at the time of sample
 	- dso_daddr: name of library or module containing the data being executed
@@ -151,9 +151,10 @@ OPTIONS
 	- dcacheline: the cacheline the data address is on at the time of the sample
 	- phys_daddr: physical address of data being executed on at the time of sample
 	- data_page_size: the data page size of data being executed on at the time of sample
+	- blocked: reason of blocked load access for the data at the time of the sample
 
 	And the default sort keys are changed to local_weight, mem, sym, dso,
-	symbol_daddr, dso_daddr, snoop, tlb, locked, see '--mem-mode'.
+	symbol_daddr, dso_daddr, snoop, tlb, locked, blocked, see '--mem-mode'.
 
 	If the data file has tracepoint event(s), following (dynamic) sort keys
 	are also available:
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 8237420..e5778aa 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -312,7 +312,7 @@ static char *get_sort_order(struct perf_mem *mem)
 			     "dso_daddr,tlb,locked");
 	} else if (has_extra_options) {
 		strcpy(sort, "--sort=local_weight,mem,sym,dso,symbol_daddr,"
-			     "dso_daddr,snoop,tlb,locked");
+			     "dso_daddr,snoop,tlb,locked,blocked");
 	} else
 		return NULL;
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index a08fb9e..6866ab0 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -208,6 +208,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	hists__new_col_len(hists, HISTC_MEM_LVL, 21 + 3);
 	hists__new_col_len(hists, HISTC_LOCAL_WEIGHT, 12);
 	hists__new_col_len(hists, HISTC_GLOBAL_WEIGHT, 12);
+	hists__new_col_len(hists, HISTC_MEM_BLOCKED, 10);
 	if (symbol_conf.nanosecs)
 		hists__new_col_len(hists, HISTC_TIME, 16);
 	else
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 14f6633..522486b 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -71,6 +71,7 @@ enum hist_column {
 	HISTC_SYM_SIZE,
 	HISTC_DSO_SIZE,
 	HISTC_SYMBOL_IPC,
+	HISTC_MEM_BLOCKED,
 	HISTC_NR_COLS, /* Last entry */
 };
 
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 3edfb88..890f638 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -337,6 +337,29 @@ int perf_mem__lck_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 	return l;
 }
 
+int perf_mem__blk_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
+{
+	size_t l = 0;
+	u64 mask = PERF_MEM_BLK_NA;
+
+	sz -= 1; /* -1 for null termination */
+	out[0] = '\0';
+
+	if (mem_info)
+		mask = mem_info->data_src.mem_blk;
+
+	if (!mask || (mask & PERF_MEM_BLK_NA)) {
+		l += scnprintf(out + l, sz - l, " N/A");
+		return l;
+	}
+	if (mask & PERF_MEM_BLK_DATA)
+		l += scnprintf(out + l, sz - l, " Data");
+	if (mask & PERF_MEM_BLK_ADDR)
+		l += scnprintf(out + l, sz - l, " Addr");
+
+	return l;
+}
+
 int perf_script__meminfo_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 {
 	int i = 0;
@@ -348,6 +371,8 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, struct mem_info *mem_in
 	i += perf_mem__tlb_scnprintf(out + i, sz - i, mem_info);
 	i += scnprintf(out + i, sz - i, "|LCK ");
 	i += perf_mem__lck_scnprintf(out + i, sz - i, mem_info);
+	i += scnprintf(out + i, sz - i, "|BLK ");
+	i += perf_mem__blk_scnprintf(out + i, sz - i, mem_info);
 
 	return i;
 }
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 045a507..5ddf447 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -49,6 +49,7 @@ int perf_mem__tlb_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
 int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
 int perf_mem__snp_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
 int perf_mem__lck_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
+int perf_mem__blk_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
 
 int perf_script__meminfo_scnprintf(char *bf, size_t size, struct mem_info *mem_info);
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 80907bc..249a03c 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -36,7 +36,7 @@ const char	default_parent_pattern[] = "^sys_|^do_page_fault";
 const char	*parent_pattern = default_parent_pattern;
 const char	*default_sort_order = "comm,dso,symbol";
 const char	default_branch_sort_order[] = "comm,dso_from,symbol_from,symbol_to,cycles";
-const char	default_mem_sort_order[] = "local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked";
+const char	default_mem_sort_order[] = "local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked";
 const char	default_top_sort_order[] = "dso,symbol";
 const char	default_diff_sort_order[] = "dso,symbol";
 const char	default_tracepoint_sort_order[] = "trace";
@@ -1422,6 +1422,41 @@ struct sort_entry sort_mem_dcacheline = {
 };
 
 static int64_t
+sort__blocked_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	union perf_mem_data_src data_src_l;
+	union perf_mem_data_src data_src_r;
+
+	if (left->mem_info)
+		data_src_l = left->mem_info->data_src;
+	else
+		data_src_l.mem_blk = PERF_MEM_BLK_NA;
+
+	if (right->mem_info)
+		data_src_r = right->mem_info->data_src;
+	else
+		data_src_r.mem_blk = PERF_MEM_BLK_NA;
+
+	return (int64_t)(data_src_r.mem_blk - data_src_l.mem_blk);
+}
+
+static int hist_entry__blocked_snprintf(struct hist_entry *he, char *bf,
+					size_t size, unsigned int width)
+{
+	char out[16];
+
+	perf_mem__blk_scnprintf(out, sizeof(out), he->mem_info);
+	return repsep_snprintf(bf, size, "%.*s", width, out);
+}
+
+struct sort_entry sort_mem_blocked = {
+	.se_header	= "Blocked",
+	.se_cmp		= sort__blocked_cmp,
+	.se_snprintf	= hist_entry__blocked_snprintf,
+	.se_width_idx	= HISTC_MEM_BLOCKED,
+};
+
+static int64_t
 sort__phys_daddr_cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	uint64_t l = 0, r = 0;
@@ -1770,6 +1805,7 @@ static struct sort_dimension memory_sort_dimensions[] = {
 	DIM(SORT_MEM_DCACHELINE, "dcacheline", sort_mem_dcacheline),
 	DIM(SORT_MEM_PHYS_DADDR, "phys_daddr", sort_mem_phys_daddr),
 	DIM(SORT_MEM_DATA_PAGE_SIZE, "data_page_size", sort_mem_data_page_size),
+	DIM(SORT_MEM_BLOCKED, "blocked", sort_mem_blocked),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index e50f2b6..2b2645b 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -256,6 +256,7 @@ enum sort_type {
 	SORT_MEM_IADDR_SYMBOL,
 	SORT_MEM_PHYS_DADDR,
 	SORT_MEM_DATA_PAGE_SIZE,
+	SORT_MEM_BLOCKED,
 };
 
 /*
-- 
2.7.4

