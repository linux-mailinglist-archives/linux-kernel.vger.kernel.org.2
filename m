Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A143DA021
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbhG2JPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbhG2JPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:15:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A26EC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v/T8ooxFYhLgRNwewbXjp26oDIJbuCkkQtmo2vPCN00=; b=SCNCvNzri9Zv2RYJ82lvuk79r+
        Omk76KmDu2TQua67ZXWltLjfD2Ayvfc4Acbut73iEMCgZ+n/2d2X6plIjOnlfsKzWfzi2Wf97W8ll
        sCnT6rAV8EZiL+44rRioUw7tDknmmh/E+CVMSYPq60pPG7ixDEy93EuyDk2W2sUvxIFRUkhM4UmWa
        BDfISS6ikbVBOp+wQ0feEw/wpF+r9jK5Nk1TrlEm5HVsUAO4UNltnXNU9UaagE9mBpv/y2cqy6oBl
        zM22ayu64jbW0mPrOlXrjS61pvyWe1vsaGtuKRXZxAraIiFhgHyPo5Nay1HreG9lgRn9buHLUkmH7
        8qdib4Iw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9283-003veS-Ic; Thu, 29 Jul 2021 09:14:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 63CC330005A;
        Thu, 29 Jul 2021 11:14:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DE1D2C8A331C; Thu, 29 Jul 2021 11:14:57 +0200 (CEST)
Date:   Thu, 29 Jul 2021 11:14:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Liang, Kan" <kan.liang@intel.com>
Subject: Re: [perf] fuzzer triggers unchecked MSR access error: WRMSR to 0x318
Message-ID: <YQJxka3dxgdIdebG@hirez.programming.kicks-ass.net>
References: <37881148-a43e-5fd4-817c-a875adc7a15f@maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37881148-a43e-5fd4-817c-a875adc7a15f@maine.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 12:49:43PM -0400, Vince Weaver wrote:
> [32694.087403] unchecked MSR access error: WRMSR to 0x318 (tried to write 0x0000000000000000) at rIP: 0xffffffff8106f854 (native_write_msr+0x4/0x20)
> [32694.101374] Call Trace:
> [32694.103974]  perf_clear_dirty_counters+0x86/0x100

Hmm.. if I read this right that's MSR_ARCH_PERFMON_FIXED_CTR0 + i, given
that FIXED_CTR0 is 0x309 that gives i == 15, which is FIXED_BTS.

I'm thinking something like this ought to cure things.

---
 arch/x86/events/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1eb45139fcc6..04edf8017961 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2489,13 +2489,15 @@ void perf_clear_dirty_counters(void)
 		return;
 
 	for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
-		/* Metrics and fake events don't have corresponding HW counters. */
-		if (is_metric_idx(i) || (i == INTEL_PMC_IDX_FIXED_VLBR))
-			continue;
-		else if (i >= INTEL_PMC_IDX_FIXED)
+		if (i >= INTEL_PMC_IDX_FIXED) {
+			/* Metrics and fake events don't have corresponding HW counters. */
+			if ((i - INTEL_PMC_IDX_FIXED) >= x86_pmu.num_counters_fixed)
+				continue;
+
 			wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
-		else
+		} else {
 			wrmsrl(x86_pmu_event_addr(i), 0);
+		}
 	}
 
 	bitmap_zero(cpuc->dirty, X86_PMC_IDX_MAX);
