Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B6B446B0D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 23:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhKEW7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 18:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbhKEW7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 18:59:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA48C061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 15:56:21 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v23so2048099pjr.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 15:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2TJFGmeqpenMJkOQkEI6Yh3lm+99ThgtsUEGqj7JF54=;
        b=n2P2bQeCssOFtqacptv8AdDswHeS8LvbFACGM1ssGp9nVimS0SzRhtoRo7rLjRCePK
         vI3mqIlsGxTiQ++sa5sOfZbB7XUKlgMGF/9m+09678S1HQ++IBfekqp1/Wx81vUwtdAL
         mrspFWq09H118aisBW5EdMdqOKlh2QY81Nr4Kh7uFKv3hQjELlgTfLI17uYH9Z3U4wuh
         RZKhJbpKkU7gZzHlMByZRf4TcY9lUVknclv26u1I9UP7t8Ln9+EfQogjY8TRV36s2A/S
         2EFfdvY5zCfP/xh9qOKB+6THIPoNrscCtdnE+OIjm7ba4jETAM53R7Pucl2ToUj2KOVK
         fNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2TJFGmeqpenMJkOQkEI6Yh3lm+99ThgtsUEGqj7JF54=;
        b=eFErlxWg4jSiTS4AongqFcSv5++0oZU0k/fKJs2Tffq3IzFfvM78V5nIHLqCsMfCbc
         eU8sQIRdSU4+eZ4YYsrNcEN8yXq7zxn2u474hXXZRWs+SyI9IwUGXzoPM/jSNh+M9aIS
         qXwCeIjBmi/hCYvFzhpiQGsJY/h2m8n+nfsQn07N1KZmLEj5+ckh+w9cjEezTDXI9UPS
         gpiA+fDAmbC7RqjgVCfFYO9bc9bQmq8Brp+1Gt4eJeqpMzzbOQ0fEMZjMsJ6NtOocOs9
         7LMyn4RPXN/cr+7IRV0t+dznNAjZidbz5hGTNPeTj9hnYsh2xrSV5KpfPG1ttPl7QIue
         nf/g==
X-Gm-Message-State: AOAM531+NhYpsNBlHRLKYJp0wmOM9qZ9LsJ8+jMFJXrtUE1AodzrzKo0
        nIzCtCAuzR2Rh416UU/JPUg=
X-Google-Smtp-Source: ABdhPJyUL8cNa36nnyMhss5ZcbwUm+X9Jgf1mtwXDey6h1SL05HzFj79hqVEB4NQxkpV4sWd7oxj0g==
X-Received: by 2002:a17:90a:bb14:: with SMTP id u20mr25084635pjr.139.1636152980684;
        Fri, 05 Nov 2021 15:56:20 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:b275:19b3:fe7e:8efa])
        by smtp.gmail.com with ESMTPSA id d20sm8404546pfu.189.2021.11.05.15.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 15:56:20 -0700 (PDT)
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
Subject: [RFC 2/3] perf tools: Fix ins_lat sort key behavior
Date:   Fri,  5 Nov 2021 15:56:16 -0700
Message-Id: <20211105225617.151364-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
In-Reply-To: <20211105225617.151364-1-namhyung@kernel.org>
References: <20211105225617.151364-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like weight and local_weight, the ins_lat (for instruction latency)
and local_ins_lat should be handled the same way.

But I couldn't test it actually, so only build tested.

Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/hist.c | 11 ++++-------
 tools/perf/util/sort.c | 24 +++++++-----------------
 tools/perf/util/sort.h |  2 +-
 3 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 4e9bd7b589b1..54fe97dd191c 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -290,11 +290,10 @@ static long hist_time(unsigned long htime)
 }
 
 static void he_stat__add_period(struct he_stat *he_stat, u64 period,
-				u64 ins_lat, u64 p_stage_cyc)
+				u64 p_stage_cyc)
 {
 	he_stat->period		+= period;
 	he_stat->nr_events	+= 1;
-	he_stat->ins_lat	+= ins_lat;
 	he_stat->p_stage_cyc	+= p_stage_cyc;
 }
 
@@ -306,7 +305,6 @@ static void he_stat__add_stat(struct he_stat *dest, struct he_stat *src)
 	dest->period_guest_sys	+= src->period_guest_sys;
 	dest->period_guest_us	+= src->period_guest_us;
 	dest->nr_events		+= src->nr_events;
-	dest->ins_lat		+= src->ins_lat;
 	dest->p_stage_cyc	+= src->p_stage_cyc;
 }
 
@@ -595,7 +593,6 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 	struct hist_entry *he;
 	int64_t cmp;
 	u64 period = entry->stat.period;
-	u64 ins_lat = entry->stat.ins_lat;
 	u64 p_stage_cyc = entry->stat.p_stage_cyc;
 	bool leftmost = true;
 
@@ -615,11 +612,11 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 
 		if (!cmp) {
 			if (sample_self) {
-				he_stat__add_period(&he->stat, period, ins_lat, p_stage_cyc);
+				he_stat__add_period(&he->stat, period, p_stage_cyc);
 				hist_entry__add_callchain_period(he, period);
 			}
 			if (symbol_conf.cumulate_callchain)
-				he_stat__add_period(he->stat_acc, period, ins_lat, p_stage_cyc);
+				he_stat__add_period(he->stat_acc, period, p_stage_cyc);
 
 			/*
 			 * This mem info was allocated from sample__resolve_mem
@@ -729,7 +726,6 @@ __hists__add_entry(struct hists *hists,
 		.stat = {
 			.nr_events = 1,
 			.period	= sample->period,
-			.ins_lat = sample->ins_lat,
 			.p_stage_cyc = sample->p_stage_cyc,
 		},
 		.parent = sym_parent,
@@ -744,6 +740,7 @@ __hists__add_entry(struct hists *hists,
 		.ops = ops,
 		.time = hist_time(sample->time),
 		.weight = sample->weight,
+		.ins_lat = sample->ins_lat,
 	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
 
 	if (!hists->has_callchains && he && he->callchain_size != 0)
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 903f34fff27e..adc0584695d6 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1358,45 +1358,35 @@ struct sort_entry sort_global_weight = {
 	.se_width_idx	= HISTC_GLOBAL_WEIGHT,
 };
 
-static u64 he_ins_lat(struct hist_entry *he)
-{
-		return he->stat.nr_events ? he->stat.ins_lat / he->stat.nr_events : 0;
-}
-
 static int64_t
-sort__local_ins_lat_cmp(struct hist_entry *left, struct hist_entry *right)
+sort__ins_lat_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-		return he_ins_lat(left) - he_ins_lat(right);
+	return left->ins_lat - right->ins_lat;
 }
 
 static int hist_entry__local_ins_lat_snprintf(struct hist_entry *he, char *bf,
 					      size_t size, unsigned int width)
 {
-		return repsep_snprintf(bf, size, "%-*u", width, he_ins_lat(he));
+	return repsep_snprintf(bf, size, "%-*u", width, he->ins_lat);
 }
 
 struct sort_entry sort_local_ins_lat = {
 	.se_header	= "Local INSTR Latency",
-	.se_cmp		= sort__local_ins_lat_cmp,
+	.se_cmp		= sort__ins_lat_cmp,
 	.se_snprintf	= hist_entry__local_ins_lat_snprintf,
 	.se_width_idx	= HISTC_LOCAL_INS_LAT,
 };
 
-static int64_t
-sort__global_ins_lat_cmp(struct hist_entry *left, struct hist_entry *right)
-{
-		return left->stat.ins_lat - right->stat.ins_lat;
-}
-
 static int hist_entry__global_ins_lat_snprintf(struct hist_entry *he, char *bf,
 					       size_t size, unsigned int width)
 {
-		return repsep_snprintf(bf, size, "%-*u", width, he->stat.ins_lat);
+	return repsep_snprintf(bf, size, "%-*u", width,
+			       he->ins_lat * he->stat.nr_events);
 }
 
 struct sort_entry sort_global_ins_lat = {
 	.se_header	= "INSTR Latency",
-	.se_cmp		= sort__global_ins_lat_cmp,
+	.se_cmp		= sort__ins_lat_cmp,
 	.se_snprintf	= hist_entry__global_ins_lat_snprintf,
 	.se_width_idx	= HISTC_GLOBAL_INS_LAT,
 };
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index e18b79916f63..22ae7c6ae398 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -49,7 +49,6 @@ struct he_stat {
 	u64			period_us;
 	u64			period_guest_sys;
 	u64			period_guest_us;
-	u64			ins_lat;
 	u64			p_stage_cyc;
 	u32			nr_events;
 };
@@ -109,6 +108,7 @@ struct hist_entry {
 	s32			cpu;
 	u64			code_page_size;
 	u64			weight;
+	u64			ins_lat;
 	u8			cpumode;
 	u8			depth;
 
-- 
2.34.0.rc0.344.g81b53c2807-goog

