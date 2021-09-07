Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A39402D03
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344636AbhIGQmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:42:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:27264 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231347AbhIGQma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:42:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="283959474"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="283959474"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 09:38:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="430979265"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2021 09:38:39 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/3] perf/x86: Add new event for AUX output counter index
Date:   Tue,  7 Sep 2021 19:39:01 +0300
Message-Id: <20210907163903.11820-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210907163903.11820-1-adrian.hunter@intel.com>
References: <20210907163903.11820-1-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PEBS-via-PT records contain a mask of applicable counters. To identify
which event belongs to which counter, a side-band event is needed. Until
now, there has been no side-band event, and consequently users were limited
to using a single event.

Add such a side-band event. Note the event is optimised to output only
when the counter index changes for an event. That works only so long as
all PEBS-via-PT events are scheduled together, which they are for a
recording session because they are in a single group.

Also no attribute bit is used to select the new event, so a new
kernel is not compatible with older perf tools.  The assumption
being that PEBS-via-PT is sufficiently esoteric that users will not
be troubled by this.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---

Changes in V3:
	Do not set assign callback unless x86_pmu.intel_cap.pebs_output_pt_available

Changes in V2:
	Use callback from x86_assign_hw_event


 arch/x86/events/core.c          |  6 ++++++
 arch/x86/events/intel/core.c    | 16 ++++++++++++++++
 arch/x86/events/perf_event.h    |  1 +
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h | 15 +++++++++++++++
 kernel/events/core.c            | 30 ++++++++++++++++++++++++++++++
 6 files changed, 69 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 2a57dbed4894..be33423e9762 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -66,6 +66,8 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_enable_all,  *x86_pmu.enable_all);
 DEFINE_STATIC_CALL_NULL(x86_pmu_enable,	     *x86_pmu.enable);
 DEFINE_STATIC_CALL_NULL(x86_pmu_disable,     *x86_pmu.disable);
 
+DEFINE_STATIC_CALL_NULL(x86_pmu_assign, *x86_pmu.assign);
+
 DEFINE_STATIC_CALL_NULL(x86_pmu_add,  *x86_pmu.add);
 DEFINE_STATIC_CALL_NULL(x86_pmu_del,  *x86_pmu.del);
 DEFINE_STATIC_CALL_NULL(x86_pmu_read, *x86_pmu.read);
@@ -1215,6 +1217,8 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 	hwc->last_cpu = smp_processor_id();
 	hwc->last_tag = ++cpuc->tags[i];
 
+	static_call_cond(x86_pmu_assign)(event, idx);
+
 	switch (hwc->idx) {
 	case INTEL_PMC_IDX_FIXED_BTS:
 	case INTEL_PMC_IDX_FIXED_VLBR:
@@ -2005,6 +2009,8 @@ static void x86_pmu_static_call_update(void)
 	static_call_update(x86_pmu_enable, x86_pmu.enable);
 	static_call_update(x86_pmu_disable, x86_pmu.disable);
 
+	static_call_update(x86_pmu_assign, x86_pmu.assign);
+
 	static_call_update(x86_pmu_add, x86_pmu.add);
 	static_call_update(x86_pmu_del, x86_pmu.del);
 	static_call_update(x86_pmu_read, x86_pmu.read);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7011e87be6d0..a555e7c2dce9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2402,6 +2402,12 @@ static void intel_pmu_disable_event(struct perf_event *event)
 		intel_pmu_pebs_disable(event);
 }
 
+static void intel_pmu_assign_event(struct perf_event *event, int idx)
+{
+	if (is_pebs_pt(event))
+		perf_report_aux_output_id(event, idx);
+}
+
 static void intel_pmu_del_event(struct perf_event *event)
 {
 	if (needs_branch_stack(event))
@@ -4494,8 +4500,16 @@ static int intel_pmu_check_period(struct perf_event *event, u64 value)
 	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
 }
 
+static void intel_aux_output_init(void)
+{
+	/* Refer also intel_pmu_aux_output_match() */
+	if (x86_pmu.intel_cap.pebs_output_pt_available)
+		x86_pmu.assign = intel_pmu_assign_event;
+}
+
 static int intel_pmu_aux_output_match(struct perf_event *event)
 {
+	/* intel_pmu_assign_event() is needed, refer intel_aux_output_init() */
 	if (!x86_pmu.intel_cap.pebs_output_pt_available)
 		return 0;
 
@@ -6301,6 +6315,8 @@ __init int intel_pmu_init(void)
 	if (is_hybrid())
 		intel_pmu_check_hybrid_pmus((u64)fixed_mask);
 
+	intel_aux_output_init();
+
 	return 0;
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e3ac05c97b5e..76436a55d9ba 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -726,6 +726,7 @@ struct x86_pmu {
 	void		(*enable_all)(int added);
 	void		(*enable)(struct perf_event *);
 	void		(*disable)(struct perf_event *);
+	void		(*assign)(struct perf_event *event, int idx);
 	void		(*add)(struct perf_event *);
 	void		(*del)(struct perf_event *);
 	void		(*read)(struct perf_event *event);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fe156a8170aa..6f4a15660651 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1398,6 +1398,7 @@ perf_event_addr_filters(struct perf_event *event)
 }
 
 extern void perf_event_addr_filters_sync(struct perf_event *event);
+extern void perf_report_aux_output_id(struct perf_event *event, u64 hw_id);
 
 extern int perf_output_begin(struct perf_output_handle *handle,
 			     struct perf_sample_data *data,
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index f92880a15645..c89535de1ec8 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1141,6 +1141,21 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_TEXT_POKE			= 20,
 
+	/*
+	 * Data written to the AUX area by hardware due to aux_output, may need
+	 * to be matched to the event by an architecture-specific hardware ID.
+	 * This records the hardware ID, but requires sample_id to provide the
+	 * event ID. e.g. Intel PT uses this record to disambiguate PEBS-via-PT
+	 * records from multiple events.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				hw_id;
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 744e8726c5b2..79241b6e57c7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9073,6 +9073,36 @@ static void perf_log_itrace_start(struct perf_event *event)
 	perf_output_end(&handle);
 }
 
+void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
+{
+	struct perf_output_handle handle;
+	struct perf_sample_data sample;
+	struct perf_aux_event {
+		struct perf_event_header        header;
+		u64				hw_id;
+	} rec;
+	int ret;
+
+	if (event->parent)
+		event = event->parent;
+
+	rec.header.type	= PERF_RECORD_AUX_OUTPUT_HW_ID;
+	rec.header.misc	= 0;
+	rec.header.size	= sizeof(rec);
+	rec.hw_id	= hw_id;
+
+	perf_event_header__init_id(&rec.header, &sample, event);
+	ret = perf_output_begin(&handle, &sample, event, rec.header.size);
+
+	if (ret)
+		return;
+
+	perf_output_put(&handle, rec);
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+}
+
 static int
 __perf_event_account_interrupt(struct perf_event *event, int throttle)
 {
-- 
2.17.1

