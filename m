Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA05240469E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhIIH7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 03:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhIIH7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:59:50 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A90C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 00:58:41 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id r18-20020a056214069200b0037a291a6081so4502572qvz.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 00:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rOMzaylhOjZPs4TPjzHhpfnCvQe9JwRgeH4yWWcvJZw=;
        b=n0bWAuwScIFabiuD3QdztE96zt3y5wPiG8i+KrQISZ0VQblhmSVwx+AtWv9z2pm5uy
         WzZtohORFxNJxeZad3GEfz+VKFVQKcs3f2pJBOv90hp5fjEWgMFRtKFPGK0ZOlg1BmyV
         z0pJWpFMr8Ql7YxeNImqQYiFkOu5PTRg9/3Nt9bQcO1COrFYX/fQKwKfk2QNy4f6xT9z
         8ZSXtz9mXA3Iwv/zrYWq/9o09gQgCxM/KqN7twJSPMYpAI1pnEO2ao0jGUWjACkUdLNd
         ytpj8ODvWXQN8n8cNG1Sc8HkPClB/NGHAHbV1J5VDbdiu3q2qr11WxTlTYc4yxN3YP5h
         +NLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rOMzaylhOjZPs4TPjzHhpfnCvQe9JwRgeH4yWWcvJZw=;
        b=FxTneuGIhW5VYqiLU11onUGA8siEExP/QVzs1ypM74u+GnbmCqilFvd1qdYZPFV4FF
         roTUszD5cpgVCMzvSBfyJcJkMkhM0RHETk9h4jIIz+uXHb3YmrzFk0wZKbYf/2WqTq1J
         B0CqB3V1uejAu/J9ZHpACvyw+pkcqpvJ9O1RtWuW57yxg+zQICvgX+aE1nX1ovRlXWeC
         iZXBa05BuH4y6tDNP1w62Jh+B68X4rpDXyM1mIQD2AtEacRCMoNKOfD1H8BddtAIPYhx
         OwNnWTmOgweTBNiO3zsU8TpM7mEUBk8Jt3jS/7jx3XqSEIpGPfwnzsUzybhsPrXU10dW
         g/Tg==
X-Gm-Message-State: AOAM533fNHohEy1jUTmNsaQgsPGx3A4urVQinzS3vWvjYPWpBoWyM/SZ
        aTMWEAmURUeuRgPlDWASV6ugGKypBuZg3yGXrBp7Bc9CPG9mgOkwygj6lkQ+R7RRskrCuZ7UQ4e
        jUOfMJPYTnSGzG/Unidb0eRHpWIZXntKqfLZfepA0XladoNCuHqTNjRK89uo0ex3+Tg0ZOKb9
X-Google-Smtp-Source: ABdhPJw8zJki2ocaLrWDHpSyRA0j7AeDHlHQ8oUgUXmDeOSq0kA2eHu2Q9vURMcQoC2InXEhnriY4BOa4A7e
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:f950:61f2:f1ec:ae8b])
 (user=eranian job=sendgmr) by 2002:ad4:46f0:: with SMTP id
 h16mr1703292qvw.0.1631174320320; Thu, 09 Sep 2021 00:58:40 -0700 (PDT)
Date:   Thu,  9 Sep 2021 00:56:48 -0700
In-Reply-To: <20210909075700.4025355-1-eranian@google.com>
Message-Id: <20210909075700.4025355-2-eranian@google.com>
Mime-Version: 1.0
References: <20210909075700.4025355-1-eranian@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v1 01/13] perf/core: add union to struct perf_branch_entry
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make it simpler to reset all the info fields on the perf_branch_entry in
a single store, we use a union. This avoids missing some of the bitfields and
improves generated code by minimizing the number of stores.

Using an anonymous struct around the bitfields to guarantee field ordering.

A single perf_branch_entry.val = 0 guarantees all fields are all zeroes on any arch.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/intel/lbr.c     | 13 +++----------
 include/uapi/linux/perf_event.h | 19 ++++++++++++-------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 9e6d6eaeb4cb..27aa48cce3c6 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -801,15 +801,9 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 
 		rdmsrl(x86_pmu.lbr_from + lbr_idx, msr_lastbranch.lbr);
 
+		cpuc->lbr_entries[i].val	= 0;
 		cpuc->lbr_entries[i].from	= msr_lastbranch.from;
 		cpuc->lbr_entries[i].to		= msr_lastbranch.to;
-		cpuc->lbr_entries[i].mispred	= 0;
-		cpuc->lbr_entries[i].predicted	= 0;
-		cpuc->lbr_entries[i].in_tx	= 0;
-		cpuc->lbr_entries[i].abort	= 0;
-		cpuc->lbr_entries[i].cycles	= 0;
-		cpuc->lbr_entries[i].type	= 0;
-		cpuc->lbr_entries[i].reserved	= 0;
 	}
 	cpuc->lbr_stack.nr = i;
 	cpuc->lbr_stack.hw_idx = tos;
@@ -896,6 +890,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		if (abort && x86_pmu.lbr_double_abort && out > 0)
 			out--;
 
+		cpuc->lbr_entries[out].val	 = 0;
 		cpuc->lbr_entries[out].from	 = from;
 		cpuc->lbr_entries[out].to	 = to;
 		cpuc->lbr_entries[out].mispred	 = mis;
@@ -903,8 +898,6 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		cpuc->lbr_entries[out].in_tx	 = in_tx;
 		cpuc->lbr_entries[out].abort	 = abort;
 		cpuc->lbr_entries[out].cycles	 = cycles;
-		cpuc->lbr_entries[out].type	 = 0;
-		cpuc->lbr_entries[out].reserved	 = 0;
 		out++;
 	}
 	cpuc->lbr_stack.nr = out;
@@ -966,6 +959,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		to = rdlbr_to(i, lbr);
 		info = rdlbr_info(i, lbr);
 
+		e->val		= 0;
 		e->from		= from;
 		e->to		= to;
 		e->mispred	= get_lbr_mispred(info);
@@ -974,7 +968,6 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		e->abort	= !!(info & LBR_INFO_ABORT);
 		e->cycles	= get_lbr_cycles(info);
 		e->type		= get_lbr_br_type(info);
-		e->reserved	= 0;
 	}
 
 	cpuc->lbr_stack.nr = i;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index f92880a15645..eb11f383f4be 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1329,13 +1329,18 @@ union perf_mem_data_src {
 struct perf_branch_entry {
 	__u64	from;
 	__u64	to;
-	__u64	mispred:1,  /* target mispredicted */
-		predicted:1,/* target predicted */
-		in_tx:1,    /* in transaction */
-		abort:1,    /* transaction abort */
-		cycles:16,  /* cycle count to last branch */
-		type:4,     /* branch type */
-		reserved:40;
+	union {
+		__u64	val;	    /* to make it easier to clear all fields */
+		struct {
+			__u64	mispred:1,  /* target mispredicted */
+				predicted:1,/* target predicted */
+				in_tx:1,    /* in transaction */
+				abort:1,    /* transaction abort */
+				cycles:16,  /* cycle count to last branch */
+				type:4,     /* branch type */
+				reserved:40;
+		};
+	};
 };
 
 union perf_sample_weight {
-- 
2.33.0.153.gba50c8fa24-goog

