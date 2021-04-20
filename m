Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A9A365C44
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhDTPeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhDTPeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:34:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C51C06174A;
        Tue, 20 Apr 2021 08:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4lb1LnTLGkIdXTQo5Xqxyu0JUq7Aqt0OGUHw1Lai628=; b=uyb9m4kZgsrKZ3liNSNlGSNPHt
        bUEFd2WLB/CK4MqJswE2vjF6OMMWJnOh3r3mJdz9fu4XftjeMGiQhi6i1oKv11V+bMk0VTm8wGgT6
        geZ4wZ7/OKgVXsjsBxlwnBqneBBk/ROY3yJJu+2YHOn+dMkVcLRyYd42rtoRlR7yrUAbHDSZJ6DMC
        cq2IdfOd0RRys8LLdqEUcRamizX6vRf0jsD5KN2ewldzEBupIEc4mWQR2YoNBR7VUDS2ESceOGxvb
        AbPmHS8WzlLN93tuqITYlmgf5w/7/qh3S6Vu/lQqG5xqPuFE0h2NpKpSsMo5ykBOG6D7lP3ZpSBHQ
        hlIOngww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYsLw-00FKMC-D9; Tue, 20 Apr 2021 15:32:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD0AB30020C;
        Tue, 20 Apr 2021 17:31:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 962AB2BCB3F63; Tue, 20 Apr 2021 17:31:50 +0200 (CEST)
Date:   Tue, 20 Apr 2021 17:31:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        George Dunlap <george.dunlap@eu.citrix.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86: Fix integer overflow when left shifting an
 integer more than 32 bits
Message-ID: <YH7z5lv9CVQuiI7V@hirez.programming.kicks-ass.net>
References: <20210420142907.382417-1-colin.king@canonical.com>
 <YH7tJz6WnPH7s8yO@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH7tJz6WnPH7s8yO@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 05:03:03PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 20, 2021 at 03:29:07PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The 64 bit value read from MSR_ARCH_PERFMON_FIXED_CTR_CTRL is being
> > bit-wise masked with the value (0x03 << i*4). However, the shifted value
> > is evaluated using 32 bit arithmetic, so will overflow when i > 8.
> > Fix this by making 0x03 a ULL so that the shift is performed using
> > 64 bit arithmetic.
> > 
> > Addresses-Coverity: ("Unintentional integer overflow")
> 
> Strange tag that, also inaccurate, wide shifts are UB and don't behave
> consistently.
> 
> As is, we've not had hardware with that many fixed counters, but yes,
> worth fixing I suppose.

Patch now reads:

---
Subject: perf/x86: Allow for 8<num_fixed_counters<16
From: Colin Ian King <colin.king@canonical.com>
Date: Tue, 20 Apr 2021 15:29:07 +0100

From: Colin Ian King <colin.king@canonical.com>

The 64 bit value read from MSR_ARCH_PERFMON_FIXED_CTR_CTRL is being
bit-wise masked with the value (0x03 << i*4). However, the shifted value
is evaluated using 32 bit arithmetic, so will UB when i > 8. Fix this
by making 0x03 a ULL so that the shift is performed using 64 bit
arithmetic.

This makes the arithmetic internally consistent and preparers for the
day when hardware provides 8<num_fixed_counters<16.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210420142907.382417-1-colin.king@canonical.com
---
 arch/x86/events/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -261,7 +261,7 @@ static bool check_hw_exists(void)
 		for (i = 0; i < x86_pmu.num_counters_fixed; i++) {
 			if (fixed_counter_disabled(i))
 				continue;
-			if (val & (0x03 << i*4)) {
+			if (val & (0x03ULL << i*4)) {
 				bios_fail = 1;
 				val_fail = val;
 				reg_fail = reg;
