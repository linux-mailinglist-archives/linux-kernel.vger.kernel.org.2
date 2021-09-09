Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C614046A4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhIIIAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhIIIAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:00:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5800C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 00:58:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w8-20020a259188000000b0059bf0bed21fso1360319ybl.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 00:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ulRSsJddDAx6pkvDZyUTxZSrZIHs26PyDscpG8w2zoM=;
        b=RpuKasrUfVdCsIbbWVOQ4CCZp36LJEYP5tg7Mc8rueQAwYjHOPHKvJVCTKvNNglcXu
         AsuZhrz5Yxb3BlTDGtqRe0YB09xBSJRKYEy6V3d79AqqWcVxMCVZzi+wYi6b37lHqbVu
         5oqH6JtTH1V8t0qPKdvGulBSfY6/daRpW9WD2TjrPTOmNiGEvMzWS5j5sWjwu/T/kFEc
         XsyAu+Y+8m4WKlc3uxjUKUZrbH6++uoEe4gPd0vGRMH8lrTHbuftBATi5QS/fwNimJ+B
         UwEeZs5W1FoJ+eAGYEKt84ArTlSSrzJ4XLNzzhK6pvie6F78iavxAty7N8v655FN3AsZ
         fQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ulRSsJddDAx6pkvDZyUTxZSrZIHs26PyDscpG8w2zoM=;
        b=HWIGuKE4bDA5QLaNWPtgRR2srum1+J1tO77tPbvovMLpuct/gMf0UKpAGvGHF58Zwm
         535nF16MClOKBNwlN+6CkZaJfYVZ6DyJezGl2yNWVIG8J8pNnKQAjlVWtKacfirfhfjo
         RPAs0p5h3757gcym+N4KDF0Uevj9BsKU1G++opztXTB6qeNi9M4HoMnqTCiFpzx22dOY
         bQrR9bG23I1bBeehsgmfNbCaYdi1ehXmVRlvq2wGDzLVYzYrio1yisHDkALXDy2mvVLX
         FnH33XBMjkiLNFNUZPq2dakhOa+d1Ly8VDGZPQs4IdzmWIzYIlOvi4vskfLRrEX+iH1/
         F4IA==
X-Gm-Message-State: AOAM531uaxnRjVQDb3bdUN/dfc1HVxWZJRKkHEz8hOiwaAeqVXQzk9wq
        R5QH0ts5wxtyo58Dun/6OMaEZLg5JkbLGLeTjH7tE/PG5LftEg1C+oeuLV5ev3dmEjSAd5ys9B5
        trUqw5PtfdPRP1TrWxFH3FUzOCLOPCSw1A6s+wmFS70gNABfLedZ1FfPE4oJ41dTndR4R7rMR
X-Google-Smtp-Source: ABdhPJypq0b17DSSvCajuVr4WyZESmd7UwW4nvMiJMi6GnM32gOtCXOUJGgzAxFAjQXVjCrgpGP2WJ/QcCeH
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:f950:61f2:f1ec:ae8b])
 (user=eranian job=sendgmr) by 2002:a25:25cf:: with SMTP id
 l198mr2172925ybl.41.1631174332886; Thu, 09 Sep 2021 00:58:52 -0700 (PDT)
Date:   Thu,  9 Sep 2021 00:56:53 -0700
In-Reply-To: <20210909075700.4025355-1-eranian@google.com>
Message-Id: <20210909075700.4025355-7-eranian@google.com>
Mime-Version: 1.0
References: <20210909075700.4025355-1-eranian@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v1 06/13] perf/x86/amd: add AMD branch sampling period adjustment
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supplemental patch adds the code to adjust the sampling event period
when used with the Branch Sampling feature (BRS). Given the depth of the
BRS (16 on Fam19h Zen3), the period is reduced by that depth such that in
the best case scenario, BRS saturates at the desired sampling period.
In practice, though, the processor may execute more branches. Given a desired
period P and a depth D, the kernel programs the actual period at P - D. After
P occurrences of the sampling event, the counter overflows. It then may take
X branches (skid) before the NMI is caught and held by the hardware and BRS activates. Then,
after D branches, BRS saturates and the NMI is delivered.  With no skid, the
effective period would be (P - D) + D = P. In practice, however, it will likely
be (P - D) + X + D. There is no way to eliminate X or predict X.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/core.c       |  7 +++++++
 arch/x86/events/perf_event.h | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 66a073f21bb7..e1fb0e5ceaa3 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1375,6 +1375,13 @@ int x86_perf_event_set_period(struct perf_event *event)
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
index 12fb1e68f188..a275553e78b9 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1254,6 +1254,14 @@ static inline bool amd_brs_active(void)
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
@@ -1271,6 +1279,10 @@ static inline void amd_brs_drain(void)
 	return 0;
 }
 
+static inline s64 amd_brs_adjust_period(s64 period)
+{
+	return period;
+}
 #endif /* CONFIG_CPU_SUP_AMD */
 
 static inline int is_pebs_pt(struct perf_event *event)
-- 
2.33.0.153.gba50c8fa24-goog

