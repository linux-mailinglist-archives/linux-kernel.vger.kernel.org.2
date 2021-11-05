Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBBC446B0C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 23:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhKEW7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 18:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhKEW67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 18:58:59 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2496C061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 15:56:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id iq11so3992870pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 15:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E4B0gbAEB1NsoKSujN542JEGpuAn65I7hg0Tihu1gQc=;
        b=d4GGxj3FKkDMlu9LyHC4z/CSxbPEgR09ibv7MVVHjfY/CWGTuNdGFGtxLUI7VznhR/
         oEY6ac2Q8KTc82tegeFqMzd4i+aU0in1TBVzeor8v6YTgNQbYjAF+soZqt7Rd5kCxBbY
         DTUV0mA8Z5tnPojATAvjaJ6yciDcwBx7c89+fVLI4oqJx+fqXhqn7JXatIsUwfuhkXk5
         YE3hGgTpIn+ncWz1BsueN0Wayst0RJApmqzLOCAtpUWkmp8usM7UTmzujsVjt5B6wnGD
         EJwXlSBvnI13DI2ZCrZuP1lzhhwSxzr72stEHCTyddqICtEZd0gOy4GOlALAJ2/7sSS8
         SZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=E4B0gbAEB1NsoKSujN542JEGpuAn65I7hg0Tihu1gQc=;
        b=ftl58UC2iPDOOkPtcR9YO05xf7FrDJBERvjQmfbHrfurtDaeO6HgZMs3UGMoGqmZwS
         IVkzc0qM7VO/nGtFtcPcpA0HOcfhdmlNQrrb1d1dULf2eICRTXVeycFiwSkrlpZASGQD
         A1517+BC2E/WHroDAq+5/6AmKyXubq8AZybLmWjiCXRVLKcAKXQfgpfFn/4Ly8BY2TmZ
         jFq5tQCRBHju8+VRz4msxwGPMxONhiQ25Y3vBazFztiswSr1a9XHbeKZ7lu5rKgDKn3B
         JxUL9lxewW+R6krOC7oGftXJd/NHnml/tzj/iBxUT6xh1HYXeu+96zM8sQhmjp+fT80G
         SI6Q==
X-Gm-Message-State: AOAM53133y9vwo/DqxlLS0k9rg0Mv0mbvd3uwsTsbB57AXbga/tt6iT9
        GQYu3ceXpGaadGkdaZFkq5g=
X-Google-Smtp-Source: ABdhPJwnrJtqYqwAh0ZLlOO22inpSNLHxcuYhOgfMcJ9xRCKEPNUUBTmEJU9T2JNm/O7yn22Y8HdvA==
X-Received: by 2002:a17:90b:4a8e:: with SMTP id lp14mr12237268pjb.224.1636152979137;
        Fri, 05 Nov 2021 15:56:19 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:b275:19b3:fe7e:8efa])
        by smtp.gmail.com with ESMTPSA id d20sm8404546pfu.189.2021.11.05.15.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 15:56:18 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [RFC 1/3] perf tools: Fix weight sort key behavior
Date:   Fri,  5 Nov 2021 15:56:15 -0700
Message-Id: <20211105225617.151364-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the weight field in the perf sample has latency information
for some instructions like in memory access.  And perf tool has weight
and local_weight sort keys to display the info.

But it's somewhat confusing what it shows exactly.  In my understanding,
the local_weight shows a weight in a single sample, and (global) weight
shows a sum of the weights in the hist_entry.

For example,

  $ perf mem record -t load dd if=/dev/zero of=/dev/null bs=4k count=1M

  $ perf report --stdio -n -s +local_weight
  ...
  #
  # Overhead       Samples  Command  Shared Object     Symbol                               Local Weight
  # ........  ............  .......  ................  ...................................  ............
  #
      21.23%           313  dd       [kernel.vmlinux]  [k] lockref_get_not_zero             32
      12.43%           183  dd       [kernel.vmlinux]  [k] lockref_get_not_zero             35
      11.97%           159  dd       [kernel.vmlinux]  [k] lockref_get_not_zero             36
      10.40%           141  dd       [kernel.vmlinux]  [k] lockref_put_return               32
       7.63%           113  dd       [kernel.vmlinux]  [k] lockref_get_not_zero             33
       6.37%            92  dd       [kernel.vmlinux]  [k] lockref_get_not_zero             34
       6.15%            90  dd       [kernel.vmlinux]  [k] lockref_put_return               33
  ...

So let's look at the lockref_get_not_zero symbols.  The top entry shows
that 313 samples were captured with local_weight 32, so the total weight
should be 313 x 32 = 10016.  But it's not the case like below:

  $ perf report --stdio -n -s +local_weight,weight -S lockref_get_not_zero
  ...
  #
  # Overhead       Samples  Command  Shared Object     Local Weight  Weight
  # ........  ............  .......  ................  ............  ............
  #
       1.36%             4  dd       [kernel.vmlinux]  36            144
       0.47%             4  dd       [kernel.vmlinux]  37            148
       0.42%             4  dd       [kernel.vmlinux]  32            128
       0.40%             4  dd       [kernel.vmlinux]  34            136
       0.35%             4  dd       [kernel.vmlinux]  36            144
       0.34%             4  dd       [kernel.vmlinux]  35            140
       0.30%             4  dd       [kernel.vmlinux]  36            144
       0.30%             4  dd       [kernel.vmlinux]  34            136
       0.30%             4  dd       [kernel.vmlinux]  32            128
       0.30%             4  dd       [kernel.vmlinux]  32            128
  ...

With 'weight' sort key, it's divided to 4 samples even with same info
(comm,dso,sym and local_weight).  I don't think this is what we want.

I found this is because of the way it aggregate the weight value.
Since it's not a period, we should not add them in the he->stat.
Otherwise, two 32 weight entries will create a 64 weight entry.

After that, new 32 weight samples don't have a matching entry so it'd
create a new entry and make it a 64 weight entry again and again.
Later, they will be merged into 128 weight entries during the
hists__collapse_resort() with 4 samples, multiple times like above.

Let's keep the weight and display differently.  For local_weight, it
can show the weight as is, and for (global) weight it can display the
number multiplied by the number of samples.

With this change, I can see the expected numbers.

  $ perf report --stdio -n -s +local_weight,weight -S lockref_get_not_zero
  ...
  #
  # Overhead       Samples  Command  Shared Object     Local Weight  Weight
  # ........  ............  .......  ................  ............  ............
  #
      21.23%           313  dd       [kernel.vmlinux]  32            10016
      12.43%           183  dd       [kernel.vmlinux]  35            6405
      11.97%           159  dd       [kernel.vmlinux]  36            5724
       7.63%           113  dd       [kernel.vmlinux]  33            3729
       6.37%            92  dd       [kernel.vmlinux]  34            3128
       4.17%            59  dd       [kernel.vmlinux]  37            2183
       0.08%             1  dd       [kernel.vmlinux]  269           269
       0.08%             1  dd       [kernel.vmlinux]  38            38

Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/hist.c | 14 +++++---------
 tools/perf/util/sort.c | 24 +++++++-----------------
 tools/perf/util/sort.h |  2 +-
 3 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 65fe65ba03c2..4e9bd7b589b1 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -290,11 +290,9 @@ static long hist_time(unsigned long htime)
 }
 
 static void he_stat__add_period(struct he_stat *he_stat, u64 period,
-				u64 weight, u64 ins_lat, u64 p_stage_cyc)
+				u64 ins_lat, u64 p_stage_cyc)
 {
-
 	he_stat->period		+= period;
-	he_stat->weight		+= weight;
 	he_stat->nr_events	+= 1;
 	he_stat->ins_lat	+= ins_lat;
 	he_stat->p_stage_cyc	+= p_stage_cyc;
@@ -308,9 +306,8 @@ static void he_stat__add_stat(struct he_stat *dest, struct he_stat *src)
 	dest->period_guest_sys	+= src->period_guest_sys;
 	dest->period_guest_us	+= src->period_guest_us;
 	dest->nr_events		+= src->nr_events;
-	dest->weight		+= src->weight;
 	dest->ins_lat		+= src->ins_lat;
-	dest->p_stage_cyc		+= src->p_stage_cyc;
+	dest->p_stage_cyc	+= src->p_stage_cyc;
 }
 
 static void he_stat__decay(struct he_stat *he_stat)
@@ -598,7 +595,6 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 	struct hist_entry *he;
 	int64_t cmp;
 	u64 period = entry->stat.period;
-	u64 weight = entry->stat.weight;
 	u64 ins_lat = entry->stat.ins_lat;
 	u64 p_stage_cyc = entry->stat.p_stage_cyc;
 	bool leftmost = true;
@@ -619,11 +615,11 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 
 		if (!cmp) {
 			if (sample_self) {
-				he_stat__add_period(&he->stat, period, weight, ins_lat, p_stage_cyc);
+				he_stat__add_period(&he->stat, period, ins_lat, p_stage_cyc);
 				hist_entry__add_callchain_period(he, period);
 			}
 			if (symbol_conf.cumulate_callchain)
-				he_stat__add_period(he->stat_acc, period, weight, ins_lat, p_stage_cyc);
+				he_stat__add_period(he->stat_acc, period, ins_lat, p_stage_cyc);
 
 			/*
 			 * This mem info was allocated from sample__resolve_mem
@@ -733,7 +729,6 @@ __hists__add_entry(struct hists *hists,
 		.stat = {
 			.nr_events = 1,
 			.period	= sample->period,
-			.weight = sample->weight,
 			.ins_lat = sample->ins_lat,
 			.p_stage_cyc = sample->p_stage_cyc,
 		},
@@ -748,6 +743,7 @@ __hists__add_entry(struct hists *hists,
 		.raw_size = sample->raw_size,
 		.ops = ops,
 		.time = hist_time(sample->time),
+		.weight = sample->weight,
 	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
 
 	if (!hists->has_callchains && he && he->callchain_size != 0)
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 568a88c001c6..903f34fff27e 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1325,45 +1325,35 @@ struct sort_entry sort_mispredict = {
 	.se_width_idx	= HISTC_MISPREDICT,
 };
 
-static u64 he_weight(struct hist_entry *he)
-{
-	return he->stat.nr_events ? he->stat.weight / he->stat.nr_events : 0;
-}
-
 static int64_t
-sort__local_weight_cmp(struct hist_entry *left, struct hist_entry *right)
+sort__weight_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	return he_weight(left) - he_weight(right);
+	return left->weight - right->weight;
 }
 
 static int hist_entry__local_weight_snprintf(struct hist_entry *he, char *bf,
 				    size_t size, unsigned int width)
 {
-	return repsep_snprintf(bf, size, "%-*llu", width, he_weight(he));
+	return repsep_snprintf(bf, size, "%-*llu", width, he->weight);
 }
 
 struct sort_entry sort_local_weight = {
 	.se_header	= "Local Weight",
-	.se_cmp		= sort__local_weight_cmp,
+	.se_cmp		= sort__weight_cmp,
 	.se_snprintf	= hist_entry__local_weight_snprintf,
 	.se_width_idx	= HISTC_LOCAL_WEIGHT,
 };
 
-static int64_t
-sort__global_weight_cmp(struct hist_entry *left, struct hist_entry *right)
-{
-	return left->stat.weight - right->stat.weight;
-}
-
 static int hist_entry__global_weight_snprintf(struct hist_entry *he, char *bf,
 					      size_t size, unsigned int width)
 {
-	return repsep_snprintf(bf, size, "%-*llu", width, he->stat.weight);
+	return repsep_snprintf(bf, size, "%-*llu", width,
+			       he->weight * he->stat.nr_events);
 }
 
 struct sort_entry sort_global_weight = {
 	.se_header	= "Weight",
-	.se_cmp		= sort__global_weight_cmp,
+	.se_cmp		= sort__weight_cmp,
 	.se_snprintf	= hist_entry__global_weight_snprintf,
 	.se_width_idx	= HISTC_GLOBAL_WEIGHT,
 };
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index b67c469aba79..e18b79916f63 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -49,7 +49,6 @@ struct he_stat {
 	u64			period_us;
 	u64			period_guest_sys;
 	u64			period_guest_us;
-	u64			weight;
 	u64			ins_lat;
 	u64			p_stage_cyc;
 	u32			nr_events;
@@ -109,6 +108,7 @@ struct hist_entry {
 	s32			socket;
 	s32			cpu;
 	u64			code_page_size;
+	u64			weight;
 	u8			cpumode;
 	u8			depth;
 
-- 
2.34.0.rc0.344.g81b53c2807-goog

