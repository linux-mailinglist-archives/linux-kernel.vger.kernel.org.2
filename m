Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAF0446B0E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 23:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhKEW7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 18:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbhKEW7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 18:59:02 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E808C061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 15:56:22 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso4378240pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 15:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YK9cI8uYHdUfGOfzB1B7au9uu14Q0Ut97UdjdXl64Pg=;
        b=If1/UdnZfdrXd+np6QBknGsrpEXO3n5S5WiRN6D3BvMhkRHzabtWr3d7f7gy4hC8cy
         fQRzMKsZNE4KX2Ji61WNfiqFZlLHWb5d+scZMOf4Ln3SXI+EhXoBXvxhZ+aohFzHoDB8
         aZx8cB3MCl6NJF2En3pYJUlFsQG9J6cqOhe8YQnLa71jdthOmMVE8pItYbKvU+pUQ6It
         9AUAI0Gn7QkItY/L5BZcHe0YXH1Cakvjpklg0yU2tcvnwYTmKcB8l3Er7qSJgLaoO/BA
         fHFIIbEEE+ydNaY36a32NjIVx9TmGBuax/0KX5Z+8lRuGbUhNIh2Rdl0nZ6vxtfhLCNc
         0gVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YK9cI8uYHdUfGOfzB1B7au9uu14Q0Ut97UdjdXl64Pg=;
        b=jNBOOe2coovs0Ham53jcoky8yFA4vgPzke2iF2IBwcnq4DVphadetONZwdB4IP3Drl
         QDQJGgduNYNFsBEg+o180Ky69dR8R1MBsjwZfiM+QYgTuGsK5dS2z/sNywW1eV+JUm3m
         gCT7q2QWt9pUXQCdJ+bcrUEIc22znbOaJwPZetNtmb9RxpUIGE5jhD+OlmKvR9kHam6D
         ifgj/h7IDI19ux1zvv3GxpiVKOLMTYbpU9or051VK5Jx1C8hByyhCnfqQiN0YGUFtkbT
         yBF3I14LiFQU0hOVx3HE79caYTcWl/GHptnPEmZQk0UwWLlRD74rcvK9Bd2MZ3VzwyQO
         rrlQ==
X-Gm-Message-State: AOAM531saM+D6MhOHeZQD3Y1Mqf5wa3ruiVVr2ex7wEMrUVjRUqK+7bz
        QYF9wzVqg61pT+rOIjcHhDs=
X-Google-Smtp-Source: ABdhPJwFL+dbbXrEw+nWD31rTjEk/LrvI6KruVqglEe2DXxirlA6f9L5HhCHMhLDWc0bpMS8uUdZiA==
X-Received: by 2002:a17:90b:2251:: with SMTP id hk17mr33385650pjb.31.1636152981891;
        Fri, 05 Nov 2021 15:56:21 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:b275:19b3:fe7e:8efa])
        by smtp.gmail.com with ESMTPSA id d20sm8404546pfu.189.2021.11.05.15.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 15:56:21 -0700 (PDT)
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
Subject: [RFC 3/3] perf tools: Fix p_stage_cyc sort key behavior
Date:   Fri,  5 Nov 2021 15:56:17 -0700
Message-Id: <20211105225617.151364-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
In-Reply-To: <20211105225617.151364-1-namhyung@kernel.org>
References: <20211105225617.151364-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like weight and local_weight, the p_stage_cyc (for pipeline stage
cycles) should be handled the same way.  Not sure it also needs
the local and global variants.

But I couldn't test it actually because I don't have the machine.

Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/hist.c | 12 ++++--------
 tools/perf/util/sort.c |  4 ++--
 tools/perf/util/sort.h |  2 +-
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 54fe97dd191c..b776465e04ef 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -289,12 +289,10 @@ static long hist_time(unsigned long htime)
 	return htime;
 }
 
-static void he_stat__add_period(struct he_stat *he_stat, u64 period,
-				u64 p_stage_cyc)
+static void he_stat__add_period(struct he_stat *he_stat, u64 period)
 {
 	he_stat->period		+= period;
 	he_stat->nr_events	+= 1;
-	he_stat->p_stage_cyc	+= p_stage_cyc;
 }
 
 static void he_stat__add_stat(struct he_stat *dest, struct he_stat *src)
@@ -305,7 +303,6 @@ static void he_stat__add_stat(struct he_stat *dest, struct he_stat *src)
 	dest->period_guest_sys	+= src->period_guest_sys;
 	dest->period_guest_us	+= src->period_guest_us;
 	dest->nr_events		+= src->nr_events;
-	dest->p_stage_cyc	+= src->p_stage_cyc;
 }
 
 static void he_stat__decay(struct he_stat *he_stat)
@@ -593,7 +590,6 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 	struct hist_entry *he;
 	int64_t cmp;
 	u64 period = entry->stat.period;
-	u64 p_stage_cyc = entry->stat.p_stage_cyc;
 	bool leftmost = true;
 
 	p = &hists->entries_in->rb_root.rb_node;
@@ -612,11 +608,11 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 
 		if (!cmp) {
 			if (sample_self) {
-				he_stat__add_period(&he->stat, period, p_stage_cyc);
+				he_stat__add_period(&he->stat, period);
 				hist_entry__add_callchain_period(he, period);
 			}
 			if (symbol_conf.cumulate_callchain)
-				he_stat__add_period(he->stat_acc, period, p_stage_cyc);
+				he_stat__add_period(he->stat_acc, period);
 
 			/*
 			 * This mem info was allocated from sample__resolve_mem
@@ -726,7 +722,6 @@ __hists__add_entry(struct hists *hists,
 		.stat = {
 			.nr_events = 1,
 			.period	= sample->period,
-			.p_stage_cyc = sample->p_stage_cyc,
 		},
 		.parent = sym_parent,
 		.filtered = symbol__parent_filter(sym_parent) | al->filtered,
@@ -741,6 +736,7 @@ __hists__add_entry(struct hists *hists,
 		.time = hist_time(sample->time),
 		.weight = sample->weight,
 		.ins_lat = sample->ins_lat,
+		.p_stage_cyc = sample->p_stage_cyc,
 	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
 
 	if (!hists->has_callchains && he && he->callchain_size != 0)
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index adc0584695d6..a111065b484e 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1394,13 +1394,13 @@ struct sort_entry sort_global_ins_lat = {
 static int64_t
 sort__global_p_stage_cyc_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	return left->stat.p_stage_cyc - right->stat.p_stage_cyc;
+	return left->p_stage_cyc - right->p_stage_cyc;
 }
 
 static int hist_entry__p_stage_cyc_snprintf(struct hist_entry *he, char *bf,
 					size_t size, unsigned int width)
 {
-	return repsep_snprintf(bf, size, "%-*u", width, he->stat.p_stage_cyc);
+	return repsep_snprintf(bf, size, "%-*u", width, he->p_stage_cyc);
 }
 
 struct sort_entry sort_p_stage_cyc = {
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 22ae7c6ae398..7b7145501933 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -49,7 +49,6 @@ struct he_stat {
 	u64			period_us;
 	u64			period_guest_sys;
 	u64			period_guest_us;
-	u64			p_stage_cyc;
 	u32			nr_events;
 };
 
@@ -109,6 +108,7 @@ struct hist_entry {
 	u64			code_page_size;
 	u64			weight;
 	u64			ins_lat;
+	u64			p_stage_cyc;
 	u8			cpumode;
 	u8			depth;
 
-- 
2.34.0.rc0.344.g81b53c2807-goog

