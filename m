Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8ED36EB0A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbhD2NAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:00:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:50863 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238706AbhD2NAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:00:08 -0400
IronPort-SDR: o9RhwTP88/CdnZYf75YrXGmOME+r9Nli2b8VikpNz+p8TsTlezmSZCMkOQai+Ss0X6ffpBDUf3
 ljwnUt+czj6A==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="177107498"
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="177107498"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 05:58:48 -0700
IronPort-SDR: 6eDkx5631BTWV7QIncHoj20RB+I/VivNy//f4Nw6xrfMr7jsDV7IhnAz73OZ5KOJEzRN2aU4Gv
 DVmxSTqndpVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="537361655"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2021 05:58:45 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] perf intel-pt: Add a tree for VMCS information
Date:   Thu, 29 Apr 2021 15:58:50 +0300
Message-Id: <20210429125854.13905-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429125854.13905-1-adrian.hunter@intel.com>
References: <20210429125854.13905-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even when VMX TSC Offset is not changing (during perf record), different
virtual machines can have different TSC Offsets. There is a Virtual Machine
Control Structure (VMCS) for each virtual CPU, the address of which is
reported to Intel PT in the VMCS packet. We do not know which VMCS belongs
to which virtual machine, so use a tree to keep track of VMCS information.
Then the decoder will be able to use the current VMCS value to look up the
current TSC Offset.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  |  2 +
 .../util/intel-pt-decoder/intel-pt-decoder.h  | 11 ++++
 tools/perf/util/intel-pt.c                    | 66 +++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 8f916f90205e..8cbcb419c0d1 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -107,6 +107,7 @@ struct intel_pt_decoder {
 			 uint64_t max_insn_cnt, void *data);
 	bool (*pgd_ip)(uint64_t ip, void *data);
 	int (*lookahead)(void *data, intel_pt_lookahead_cb_t cb, void *cb_data);
+	struct intel_pt_vmcs_info *(*lookup_vmcs_info)(void *data, uint64_t vmcs);
 	void *data;
 	struct intel_pt_state state;
 	const unsigned char *buf;
@@ -258,6 +259,7 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
 	decoder->walk_insn          = params->walk_insn;
 	decoder->pgd_ip             = params->pgd_ip;
 	decoder->lookahead          = params->lookahead;
+	decoder->lookup_vmcs_info   = params->lookup_vmcs_info;
 	decoder->data               = params->data;
 	decoder->return_compression = params->return_compression;
 	decoder->branch_enable      = params->branch_enable;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index bebdb7d37b39..634dd4ac174a 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -11,6 +11,8 @@
 #include <stddef.h>
 #include <stdbool.h>
 
+#include <linux/rbtree.h>
+
 #include "intel-pt-insn-decoder.h"
 
 #define INTEL_PT_IN_TX		(1 << 0)
@@ -199,6 +201,14 @@ struct intel_pt_blk_items {
 	bool is_32_bit;
 };
 
+struct intel_pt_vmcs_info {
+	struct rb_node rb_node;
+	uint64_t vmcs;
+	uint64_t tsc_offset;
+	bool reliable;
+	bool error_printed;
+};
+
 struct intel_pt_state {
 	enum intel_pt_sample_type type;
 	bool from_nr;
@@ -244,6 +254,7 @@ struct intel_pt_params {
 			 uint64_t max_insn_cnt, void *data);
 	bool (*pgd_ip)(uint64_t ip, void *data);
 	int (*lookahead)(void *data, intel_pt_lookahead_cb_t cb, void *cb_data);
+	struct intel_pt_vmcs_info *(*lookup_vmcs_info)(void *data, uint64_t vmcs);
 	void *data;
 	bool return_compression;
 	bool branch_enable;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index a494d47aa1ad..71e29a82a7cf 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -133,6 +133,9 @@ struct intel_pt {
 
 	struct ip_callchain *chain;
 	struct branch_stack *br_stack;
+
+	u64 dflt_tsc_offset;
+	struct rb_root vmcs_info;
 };
 
 enum switch_state {
@@ -271,6 +274,65 @@ static bool intel_pt_log_events(struct intel_pt *pt, u64 tm)
 	return !n || !perf_time__ranges_skip_sample(range, n, tm);
 }
 
+static struct intel_pt_vmcs_info *intel_pt_lookup_vmcs(struct rb_root *rb_root,
+						       u64 vmcs,
+						       u64 dflt_tsc_offset)
+{
+	struct rb_node **p = &rb_root->rb_node;
+	struct rb_node *parent = NULL;
+	struct intel_pt_vmcs_info *v;
+
+	while (*p) {
+		parent = *p;
+		v = rb_entry(parent, struct intel_pt_vmcs_info, rb_node);
+
+		if (v->vmcs == vmcs)
+			return v;
+
+		if (vmcs < v->vmcs)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+
+	v = zalloc(sizeof(*v));
+	if (v) {
+		v->vmcs = vmcs;
+		v->tsc_offset = dflt_tsc_offset;
+		v->reliable = dflt_tsc_offset;
+
+		rb_link_node(&v->rb_node, parent, p);
+		rb_insert_color(&v->rb_node, rb_root);
+	}
+
+	return v;
+}
+
+static struct intel_pt_vmcs_info *intel_pt_lookup_vmcs_info(void *data, uint64_t vmcs)
+{
+	struct intel_pt_queue *ptq = data;
+	struct intel_pt *pt = ptq->pt;
+
+	if (!vmcs && !pt->dflt_tsc_offset)
+		return NULL;
+
+	return intel_pt_lookup_vmcs(&pt->vmcs_info, vmcs, pt->dflt_tsc_offset);
+}
+
+static void intel_pt_free_vmcs_info(struct intel_pt *pt)
+{
+	struct intel_pt_vmcs_info *v;
+	struct rb_node *n;
+
+	n = rb_first(&pt->vmcs_info);
+	while (n) {
+		v = rb_entry(n, struct intel_pt_vmcs_info, rb_node);
+		n = rb_next(n);
+		rb_erase(&v->rb_node, &pt->vmcs_info);
+		free(v);
+	}
+}
+
 static int intel_pt_do_fix_overlap(struct intel_pt *pt, struct auxtrace_buffer *a,
 				   struct auxtrace_buffer *b)
 {
@@ -1109,6 +1171,7 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 	params.get_trace = intel_pt_get_trace;
 	params.walk_insn = intel_pt_walk_next_insn;
 	params.lookahead = intel_pt_lookahead;
+	params.lookup_vmcs_info = intel_pt_lookup_vmcs_info;
 	params.data = ptq;
 	params.return_compression = intel_pt_return_compression(pt);
 	params.branch_enable = intel_pt_branch_enable(pt);
@@ -2970,6 +3033,7 @@ static void intel_pt_free(struct perf_session *session)
 	auxtrace_heap__free(&pt->heap);
 	intel_pt_free_events(session);
 	session->auxtrace = NULL;
+	intel_pt_free_vmcs_info(pt);
 	thread__put(pt->unknown_thread);
 	addr_filters__exit(&pt->filts);
 	zfree(&pt->chain);
@@ -3475,6 +3539,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	if (!pt)
 		return -ENOMEM;
 
+	pt->vmcs_info = RB_ROOT;
+
 	addr_filters__init(&pt->filts);
 
 	err = perf_config(intel_pt_perf_config, pt);
-- 
2.17.1

