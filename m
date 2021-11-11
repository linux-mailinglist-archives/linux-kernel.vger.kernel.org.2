Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1585544D36A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhKKIyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbhKKIyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:54:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B222C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so8336812yba.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k3rJKkLyUnVNonhcQ+k727cMEGVWFyCoG4NpA5a5IQ4=;
        b=mekbeUn7teAc1at4q0VILkOkiERtdOo2ic9zWKgUUQrYl5SV2JkwMPTXYt36JmKQ1I
         m6CDVEjO3nyR5oK/7lkGnNT9ncy6tsyuW67pHT7GDWY0ZnIGtsVXnC8GkBwDmMt3+MZN
         DIwT0+T0BkKZ0rPP6nHJPeMvj6A4b8rGQ+VDXlSh700YsKQawYoIS5R7dih0/qFn04Zx
         Uhp7zR3hXa4L5H4nvUgTQNG30IBrSgmw4l8kMfQIf5a2dT5imncB3qorXV2CjabTjn7Y
         9ZpHCM2XcqTxjmAOj+Q7su0KRD8U33Nqrm5KHsb0w9OxctaT5qUPx5x4NryKK3bsdxgo
         S7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k3rJKkLyUnVNonhcQ+k727cMEGVWFyCoG4NpA5a5IQ4=;
        b=kY7FHkht6XDh4cTOTMAnCfs5ijX8gBLoXsS964vXsO0xUT4JjqWOssa9U98Caa3KZ4
         MPHRGFTgCFbvYs/sMRXb79WcHwwRuv0mdiO1NG51TaVjyplWsJGvunsAgAEpRH3FPuMj
         G0wdoaBrz1TRBrFaN5xu2xerWVWST2rDWiIHsrnOgNy8a5IQEMrussNGniZIFLDkuGkx
         SvBQ6FmJE878ZsKeC2bkf8TttrfZgNeEDplCcvKY5iAnfAIneA+ymcM9J2RGm9iqEvT6
         o4pJIJF5RdfRHX1irjdpYSD2YDeXwZ2nfn0VYViDGhCugQXjL3xjUVEz0IOLj/pB2KWT
         tXew==
X-Gm-Message-State: AOAM531RfaqEWxGY0IxKpJ8UmwRh+peXuj7YGTvJrB6lrG5N20O+0I73
        VxhIJRgWX45x77OCAb/DIxH7poexrqLLzX+ULQrAX9Ip5M3asjCPZFtBDcF8IuVdpu3LWE0k7MF
        esoWVGiNflLzohntFPsFmsDuec3D+DLkUbDwGnmAcG0D92MPJY3kYJCEjjr/dfFFMupZemDGY
X-Google-Smtp-Source: ABdhPJzmEQPo0MJDiROY97rYTo1vmNBL8IPeUR6D+j8NpCP2Bw0P3NN4K6n48LVgs9PFOlg17AGeUQXNehZN
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:cdfe:134b:9d27:6cbf])
 (user=eranian job=sendgmr) by 2002:a25:4150:: with SMTP id
 o77mr6681173yba.304.1636620675458; Thu, 11 Nov 2021 00:51:15 -0800 (PST)
Date:   Thu, 11 Nov 2021 00:44:03 -0800
In-Reply-To: <20211111084415.663951-1-eranian@google.com>
Message-Id: <20211111084415.663951-2-eranian@google.com>
Mime-Version: 1.0
References: <20211111084415.663951-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 01/13] perf/core: add perf_clear_branch_entry_bitfields() helper
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make it simpler to reset all the info fields on the
perf_branch_entry, this patch adds a helper inline function.
The goal is to centralize the initialization to avoid missing
a field in case more are added.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/intel/lbr.c | 36 +++++++++++++++++-------------------
 include/linux/perf_event.h  | 16 ++++++++++++++++
 2 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 6b72e9b55c69..78bf4636831a 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -776,6 +776,7 @@ void intel_pmu_lbr_disable_all(void)
 void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 {
 	unsigned long mask = x86_pmu.lbr_nr - 1;
+	struct perf_branch_entry *br = cpuc->lbr_entries;
 	u64 tos = intel_pmu_lbr_tos();
 	int i;
 
@@ -791,15 +792,11 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 
 		rdmsrl(x86_pmu.lbr_from + lbr_idx, msr_lastbranch.lbr);
 
-		cpuc->lbr_entries[i].from	= msr_lastbranch.from;
-		cpuc->lbr_entries[i].to		= msr_lastbranch.to;
-		cpuc->lbr_entries[i].mispred	= 0;
-		cpuc->lbr_entries[i].predicted	= 0;
-		cpuc->lbr_entries[i].in_tx	= 0;
-		cpuc->lbr_entries[i].abort	= 0;
-		cpuc->lbr_entries[i].cycles	= 0;
-		cpuc->lbr_entries[i].type	= 0;
-		cpuc->lbr_entries[i].reserved	= 0;
+		perf_clear_branch_entry_bitfields(br);
+
+		br->from	= msr_lastbranch.from;
+		br->to		= msr_lastbranch.to;
+		br++;
 	}
 	cpuc->lbr_stack.nr = i;
 	cpuc->lbr_stack.hw_idx = tos;
@@ -814,6 +811,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 {
 	bool need_info = false, call_stack = false;
 	unsigned long mask = x86_pmu.lbr_nr - 1;
+	struct perf_branch_entry *br = cpuc->lbr_entries;
 	int lbr_format = x86_pmu.intel_cap.lbr_format;
 	u64 tos = intel_pmu_lbr_tos();
 	int i;
@@ -886,15 +884,14 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		if (abort && x86_pmu.lbr_double_abort && out > 0)
 			out--;
 
-		cpuc->lbr_entries[out].from	 = from;
-		cpuc->lbr_entries[out].to	 = to;
-		cpuc->lbr_entries[out].mispred	 = mis;
-		cpuc->lbr_entries[out].predicted = pred;
-		cpuc->lbr_entries[out].in_tx	 = in_tx;
-		cpuc->lbr_entries[out].abort	 = abort;
-		cpuc->lbr_entries[out].cycles	 = cycles;
-		cpuc->lbr_entries[out].type	 = 0;
-		cpuc->lbr_entries[out].reserved	 = 0;
+		perf_clear_branch_entry_bitfields(br+out);
+		br[out].from	 = from;
+		br[out].to	 = to;
+		br[out].mispred	 = mis;
+		br[out].predicted = pred;
+		br[out].in_tx	 = in_tx;
+		br[out].abort	 = abort;
+		br[out].cycles	 = cycles;
 		out++;
 	}
 	cpuc->lbr_stack.nr = out;
@@ -956,6 +953,8 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		to = rdlbr_to(i, lbr);
 		info = rdlbr_info(i, lbr);
 
+		perf_clear_branch_entry_bitfields(e);
+
 		e->from		= from;
 		e->to		= to;
 		e->mispred	= get_lbr_mispred(info);
@@ -964,7 +963,6 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		e->abort	= !!(info & LBR_INFO_ABORT);
 		e->cycles	= get_lbr_cycles(info);
 		e->type		= get_lbr_br_type(info);
-		e->reserved	= 0;
 	}
 
 	cpuc->lbr_stack.nr = i;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0dcfd265beed..0c96448059be 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1059,6 +1059,22 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	data->txn = 0;
 }
 
+/*
+ * Clear all bitfields in the perf_branch_entry.
+ * The to and from fields are not cleared because they are
+ * systematically modified by caller.
+ */
+static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *br)
+{
+	br->mispred = 0;
+	br->predicted = 0;
+	br->in_tx = 0;
+	br->abort = 0;
+	br->cycles = 0;
+	br->type = 0;
+	br->reserved = 0;
+}
+
 extern void perf_output_sample(struct perf_output_handle *handle,
 			       struct perf_event_header *header,
 			       struct perf_sample_data *data,
-- 
2.34.0.rc0.344.g81b53c2807-goog

