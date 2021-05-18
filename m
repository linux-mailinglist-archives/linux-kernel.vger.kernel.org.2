Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64341387528
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347922AbhERJcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239643AbhERJcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:32:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ABCC061756
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/vSU8RTGnwlIQLK2t7JJuA7v3cI83CZKt9aMUNg5/2Y=; b=A3fJEG2VLSLHZIKtQkqAWgSG1E
        BFnYhY24E2VBhleNRECWSlUvq14ki5jho67YmEz9YQBV1wPEEhoamkmaD9jHIuXF5bxx50N8HbFdX
        +aIvW6PTV+/Xer7c/949sfR+cMywplVyl1TCDKca/bd8C9NiEKAf2QT6OcxI6FYv8mdGXhbpo7sXl
        skr9HKSSv9LRT+3Luph9OwfzPjVoKtnecygpmH+0I8OiE1XpTjQtc282vRMSjlW7yoYuchgEeDQ27
        h5QzutTMDz3+1G8H5brrzRe1zNkcuKB3DNYL0oZKxI7d8tTsuF+T7JR2FvfqEV9BN4bvbbkGGCNku
        VZWAkuCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1liw41-0008jT-2u; Tue, 18 May 2021 09:30:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67BF430021B;
        Tue, 18 May 2021 11:30:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 536BD2D3D3E90; Tue, 18 May 2021 11:30:54 +0200 (CEST)
Date:   Tue, 18 May 2021 11:30:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, seanjc@google.com,
        x86@kernel.org
Subject: Re: [PATCH v2 1/2] perf/x86: Skip checking if 0x0 MSR exists for
 guest Arch LBR
Message-ID: <YKOJTtmjvxbBJOcS@hirez.programming.kicks-ass.net>
References: <20210430052247.3079672-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430052247.3079672-1-like.xu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 01:22:46PM +0800, Like Xu wrote:

> - Avoid checking unrelated Architecture MSR 0x0 in a simple way

I'm thinking the below is simpler still, no?

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 5272f349dca2..456aa6ffd9a1 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -6250,7 +6250,8 @@ __init int intel_pmu_init(void)
>  	 * Check all LBT MSR here.
>  	 * Disable LBR access if any LBR MSRs can not be accessed.
>  	 */
> -	if (x86_pmu.lbr_nr && !check_msr(x86_pmu.lbr_tos, 0x3UL))
> +	if (x86_pmu.lbr_nr && !static_cpu_has(X86_FEATURE_ARCH_LBR) &&
> +	    !check_msr(x86_pmu.lbr_tos, 0x3UL))
>  		x86_pmu.lbr_nr = 0;
>  	for (i = 0; i < x86_pmu.lbr_nr; i++) {
>  		if (!(check_msr(x86_pmu.lbr_from + i, 0xffffUL) &&

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2521d03de5e0..e28892270c58 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6253,7 +6253,7 @@ __init int intel_pmu_init(void)
 	 * Check all LBT MSR here.
 	 * Disable LBR access if any LBR MSRs can not be accessed.
 	 */
-	if (x86_pmu.lbr_nr && !check_msr(x86_pmu.lbr_tos, 0x3UL))
+	if (x86_pmu.lbr_tos && !check_msr(x86_pmu.lbr_tos, 0x3UL))
 		x86_pmu.lbr_nr = 0;
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		if (!(check_msr(x86_pmu.lbr_from + i, 0xffffUL) &&
