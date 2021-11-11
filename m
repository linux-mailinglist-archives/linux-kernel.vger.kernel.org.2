Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270FB44D36F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhKKIye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbhKKIyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:54:17 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA55C06120B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:28 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r18-20020a25ac52000000b005c9047c420bso3994919ybd.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7RR941hV0drKoNdaD1XlS+5rN/kVw9fh5DF0ZyY01rI=;
        b=VZeSfVEJXXvMubv6aEN3rbgUl08xPDUIpnPMP2e4wHTxUghrhpSNTHgXvHeaNHJyoU
         3xR9vJkW53drPJjo3pJSvmVORo+APpqhg1FvOkLQaQbG38XvQMf9Vvu9CC40IBCtfjH8
         0QoEzeR8R4tRJqQliFQnqdf2l09EKzEuchSdzTN8l/P//Qgoc54oNAmrZZAVbVkAGiKJ
         ed2sj55i3mV3IPjYSIrVRpad2S+KkdIR6LG7WymM7JaWlXHFytPOYP4zCUZ6QFoxaoRa
         pL84iTG7Udlnb1EPuojTDIfx7aFajfp5vUd7jm2pH6XpmELcqTtUoJhnYvEviqINbwCn
         6OaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7RR941hV0drKoNdaD1XlS+5rN/kVw9fh5DF0ZyY01rI=;
        b=1BDyFtYb83PxxgN9nHeMQocOEAbVtrdXRP4C6wVbfuaOEtV5v6OF96KrSkkEbtRu3/
         YJz22mWQtNCEIvykts8sx2iERtvGjB5d+NskT2CG/GF35lRRWJT2b6AezE1Blqxk6L1f
         pAAgCjvUKzbAZUfq4/Pz61v+QuyILztV4z80d30eTvxpdk1/O7FPXQNz+chOUPtHp7oM
         nR/8OhOp0deblNZ7vZgYrJuFW40zw3zhNVqkz000dAo1/gi2+1SzO7JhfFTt5rT8v9Kj
         n+9lgUEF+vp7JFvoR4UoAdEUEQ2WFreQLW0uv3WnUpCTSsAwXteNl0zrq8wdYvyN/lyM
         OE6g==
X-Gm-Message-State: AOAM533nr5MkdH1TonGs9vbf6oRxnslhJJcxhPkiJ7DV/LWjXamrkOee
        N/uAE+w/Eln1FSdGvldEV9fcsvJKPAMhOYWOB48sBD0umgpZc6NhLkYFMHfoRqp5HSn2K6EOJXU
        Rsj6zBk+Jd/Fn9OLGhsW8pSbfM8vEBd4KB5ofidoLR9TJXGWvjQ4o/koZCqjWKp6raHd802ok
X-Google-Smtp-Source: ABdhPJw/Du+5xDsMvmIgbNt11XR57gOC3lqqgpRiIdwDqW9uo5N2HZzcrvdfe36S9NsRrMz1N/gbudqIZ30N
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:cdfe:134b:9d27:6cbf])
 (user=eranian job=sendgmr) by 2002:a25:c091:: with SMTP id
 c139mr6494748ybf.275.1636620687782; Thu, 11 Nov 2021 00:51:27 -0800 (PST)
Date:   Thu, 11 Nov 2021 00:44:08 -0800
In-Reply-To: <20211111084415.663951-1-eranian@google.com>
Message-Id: <20211111084415.663951-7-eranian@google.com>
Mime-Version: 1.0
References: <20211111084415.663951-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 06/13] perf/x86/amd: add AMD branch sampling period adjustment
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supplemental patch adds the code to adjust the sampling event period
when used with the Branch Sampling feature (BRS). Given the depth of the BRS
(16), the period is reduced by that depth such that in the best case
scenario, BRS saturates at the desired sampling period.  In practice, though,
the processor may execute more branches. Given a desired period P and a depth
D, the kernel programs the actual period at P - D. After P occurrences of the
sampling event, the counter overflows. It then may take X branches (skid)
before the NMI is caught and held by the hardware and BRS activates. Then,
after D branches, BRS saturates and the NMI is delivered.  With no skid, the
effective period would be (P - D) + D = P. In practice, however, it will
likely be (P - D) + X + D. There is no way to eliminate X or predict X.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/core.c       |  7 +++++++
 arch/x86/events/perf_event.h | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 28559557f966..996212a02bfa 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1379,6 +1379,13 @@ int x86_perf_event_set_period(struct perf_event *event)
 	    x86_pmu.set_topdown_event_period)
 		return x86_pmu.set_topdown_event_period(event);
 
+	/*
+	 * decrease period by the depth of the BRS feature to get
+	 * the last N taken branches and approximate the desired period
+	 */
+	if (has_branch_stack(event))
+		period = amd_brs_adjust_period(period);
+
 	/*
 	 * If we are way outside a reasonable range then just skip forward:
 	 */
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index c8aa9bb1e61b..f0026266a9d7 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1256,6 +1256,14 @@ static inline bool amd_brs_active(void)
 	return cpuc->brs_active;
 }
 
+static inline s64 amd_brs_adjust_period(s64 period)
+{
+	if (period > x86_pmu.lbr_nr)
+		return period - x86_pmu.lbr_nr;
+
+	return period;
+}
+
 #else /* CONFIG_CPU_SUP_AMD */
 
 static inline int amd_pmu_init(void)
@@ -1273,6 +1281,10 @@ static inline void amd_brs_drain(void)
 	return 0;
 }
 
+static inline s64 amd_brs_adjust_period(s64 period)
+{
+	return period;
+}
 #endif /* CONFIG_CPU_SUP_AMD */
 
 static inline int is_pebs_pt(struct perf_event *event)
-- 
2.34.0.rc0.344.g81b53c2807-goog

