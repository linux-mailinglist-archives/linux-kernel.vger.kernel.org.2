Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02D044D36E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhKKIyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbhKKIyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:54:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED54C06120A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so8337261yba.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WaZ2ildB4zl8h+e8WN1Tdv4rVeZtCq2gXs2nqEYHN6Y=;
        b=dYZxDxXlyOQUDIvq8ZPWAp0JGBSSujSkvnM8RMhttLgP4tNw3fNfNk3+xpTWyLwi1e
         G5VE3JM+IpxIkrgTalb/B3enNwTV/041rrjcIgP7yN0mrVWrgmnZp+2mozZNq887QWYm
         zeWCoCmf3Y44yhKot/EOIZZQARxfWre/6hFihIAJm8KVRY46vam//SGPfmYbdEhigR9G
         LU1K+fKs9ZILUu6N3yl4FAtBPBurN9sg7Gni3ori5v+/egBC6DVfiJNrjI+3QJTXv219
         LpqbJIBsq6PiReQg/apfMA06GL9A4TZAYR3+9SPfSZ/d2ljAH23gFuv5RU7e9x6Q2rx4
         bqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WaZ2ildB4zl8h+e8WN1Tdv4rVeZtCq2gXs2nqEYHN6Y=;
        b=qgHu11rKX9L5L66KSP55yOcydmEU958CzN3COA96NJvDptU3XCbmC8BiZ1zfiQwsrl
         ADityV34ecOM+u/XToBAYeoibN13km+dK4TX88h+PfV2ZIbT/qVbMjpPXG8J3GcNrHUF
         lnwRcFpvqEBpOpcF89Y2w//gj/v6hDssLjnYHHd7ww/EProEcfFgtR9vwhmP9O5+C3nZ
         vnF9dk3Sg6HKNf00kNOtgC95RKxRLl75f4u4mu9jpBuQYrA3B2o0PEVGBCoVcV7rdBvz
         9vkcF2Am8s4X3lKKfuSOqK1dRvFeUOXNUrjkxVOqCiGjD1E6GBWphVQ6dot5/NlPiqOK
         RuhA==
X-Gm-Message-State: AOAM530mGp1Fd8UskAAAL7SJCR+vG07Po/UNjCufrq3qPXKMT7v3JVR1
        fRY1vq+P5qQIzU5KDeGcEu9UtA5YxA8h9u5XE5WXAC1wUQxp3/n3ptT2ZgWbGbFss+yPPEvV2JT
        5DEQmwNeEEPU9eHd9BY36I9FMI7DH5AqvJbf6Hk0D23KCSnAYw4pcTEt6sLKrj/WBgl/Q7knu
X-Google-Smtp-Source: ABdhPJzoRvJzJNsAh2ZhHT7YAMiIdBSl1ur1SZh/9oG8KcU3j3NQNzt7whSrt6/P6UXJyHF/aSsMSnHdwDez
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:cdfe:134b:9d27:6cbf])
 (user=eranian job=sendgmr) by 2002:a25:d6d4:: with SMTP id
 n203mr6392036ybg.80.1636620685334; Thu, 11 Nov 2021 00:51:25 -0800 (PST)
Date:   Thu, 11 Nov 2021 00:44:07 -0800
In-Reply-To: <20211111084415.663951-1-eranian@google.com>
Message-Id: <20211111084415.663951-6-eranian@google.com>
Mime-Version: 1.0
References: <20211111084415.663951-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 05/13] perf/x86/amd: enable branch sampling priv level filtering
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD Branch Sampling features does not provide hardware filtering by
privilege level. The associated PMU counter does but not the branch sampling
by itself. Given how BRS operates there is a possibility that BRS captures
kernel level branches even though the event is programmed to count only at
the user level. This patch implements a workaround in software by removing
the branches which belong to the wrong privilege level. The privilege level
is evaluated on the target of the branch and not the source so as to be
compatible with other architectures. As a consequence of this patch, the
number of entries in the PERF_RECORD_BRANCH_STACK buffer may be less than
the maximum (16).  It could even be zero. Another consequence is that
consecutive entries in the branch stack may not reflect actual code path and
may have discontinuities, in case kernel branches were suppressed. But this
is no different than what happens on other architectures.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/amd/brs.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index f0d33511000d..771c4248979e 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -92,10 +92,6 @@ int amd_brs_setup_filter(struct perf_event *event)
 	if ((type & ~PERF_SAMPLE_BRANCH_PLM_ALL) != PERF_SAMPLE_BRANCH_ANY)
 		return -EINVAL;
 
-	/* can only capture at all priv levels due to the way BRS works */
-	if ((type & PERF_SAMPLE_BRANCH_PLM_ALL) != PERF_SAMPLE_BRANCH_PLM_ALL)
-		return -EINVAL;
-
 	return 0;
 }
 
@@ -181,6 +177,21 @@ void amd_brs_disable(void)
 	}
 }
 
+static bool amd_brs_match_plm(struct perf_event *event, u64 to)
+{
+	int type = event->attr.branch_sample_type;
+	int plm_k = PERF_SAMPLE_BRANCH_KERNEL | PERF_SAMPLE_BRANCH_HV;
+	int plm_u = PERF_SAMPLE_BRANCH_USER;
+
+	if (!(type & plm_k) && kernel_ip(to))
+		return 0;
+
+	if (!(type & plm_u) && !kernel_ip(to))
+		return 0;
+
+	return 1;
+}
+
 /*
  * Caller must ensure amd_brs_inuse() is true before calling
  * return:
@@ -238,8 +249,6 @@ void amd_brs_drain(void)
 		if (to == BRS_POISON)
 			break;
 
-		rdmsrl(brs_from(brs_idx), from);
-
 		/*
 		 * Sign-extend SAMP_BR_TO to 64 bits, bits 61-63 are reserved.
 		 * Necessary to generate proper virtual addresses suitable for
@@ -247,6 +256,11 @@ void amd_brs_drain(void)
 		 */
 		to = (u64)(((s64)to << shift) >> shift);
 
+		if (!amd_brs_match_plm(event, to))
+			continue;
+
+		rdmsrl(brs_from(brs_idx), from);
+
 		perf_clear_branch_entry_bitfields(br+nr);
 
 		br[nr].from = from;
-- 
2.34.0.rc0.344.g81b53c2807-goog

