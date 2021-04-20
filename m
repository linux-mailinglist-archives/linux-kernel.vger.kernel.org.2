Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD1C365BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhDTPDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhDTPDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:03:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07D5C06174A;
        Tue, 20 Apr 2021 08:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mb5AHdWBCTJM8bFehTa04Nsq1Os4J64P/LDxyzO0Yeg=; b=UI+BSFtg25/pMsqycT+l3czzlQ
        sg7/zIeDawUqPk57u9sobI1ZmEQXlEftNjJIRZdV6sHQBTDSEpQJQm+nru3Y2LmODxuTHehfQxQRo
        0IH2TPFYAzI0M7wloosTsHx2wJuX49GcOZ+PtCmK2GHzhm8mXE7WCaxKIWvHwstW9vrh63CB4xCoM
        GfPVLCU4UfDkAtPfHRxssXmibhDWdC7LA5SkFXzNakqsqAnAx60yb6FoK5Q5XklRsUWY3cWCMqEwI
        /Rv/rBSK/I5UoLCRBT9+62xU4Orz+g0dEm4JVQGCq1MBQPagPkPNpfdXVvlI64PqAPppnqbxyMz8l
        j1wQB4ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYru4-00CPhG-MK; Tue, 20 Apr 2021 15:03:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D20CA30018E;
        Tue, 20 Apr 2021 17:03:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7AE3F2BCEDE6D; Tue, 20 Apr 2021 17:03:03 +0200 (CEST)
Date:   Tue, 20 Apr 2021 17:03:03 +0200
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
Message-ID: <YH7tJz6WnPH7s8yO@hirez.programming.kicks-ass.net>
References: <20210420142907.382417-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420142907.382417-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 03:29:07PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The 64 bit value read from MSR_ARCH_PERFMON_FIXED_CTR_CTRL is being
> bit-wise masked with the value (0x03 << i*4). However, the shifted value
> is evaluated using 32 bit arithmetic, so will overflow when i > 8.
> Fix this by making 0x03 a ULL so that the shift is performed using
> 64 bit arithmetic.
> 
> Addresses-Coverity: ("Unintentional integer overflow")

Strange tag that, also inaccurate, wide shifts are UB and don't behave
consistently.

As is, we've not had hardware with that many fixed counters, but yes,
worth fixing I suppose.

> Fixes: a5ebe0ba3dff ("perf/x86: Check all MSRs before passing hw check")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  arch/x86/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index bafd93c54ffa..59c665c8c2e9 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -261,7 +261,7 @@ static bool check_hw_exists(void)
>  		for (i = 0; i < x86_pmu.num_counters_fixed; i++) {
>  			if (fixed_counter_disabled(i))
>  				continue;
> -			if (val & (0x03 << i*4)) {
> +			if (val & (0x03ULL << i*4)) {
>  				bios_fail = 1;
>  				val_fail = val;
>  				reg_fail = reg;
> -- 
> 2.30.2
> 
