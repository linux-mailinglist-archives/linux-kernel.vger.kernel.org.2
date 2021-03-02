Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8879832A3C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379105AbhCBJjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1837945AbhCBJPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:15:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3C6C061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 01:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=49Y/bM7V5+vZPPMYr7x9jzIuao/NFEnVpdlRIeBL2L4=; b=XeQa13IOQD7m0Ih07YnKbtDqAo
        EFqoQLpXXG/A3cRi0y8aLzQy1D4MKpNb03qSq9k5Bk/y6X3DGiT5U7U+OSbg3Gqe889xAN0Oj4i5R
        qj/T/9uysS2AScSf1mcnwPPD5xeo4orVuNPToxaZ+QnXYMNoP1ikqs0czb1tRRyi2ibLH/d6xfebs
        ZnIv/VHsc7in6kPF9CYx3kf14AqEZlZeSGJTTp4iSKhVHowDtXlBdBUtCMTheKg4UqyQAXmRYNBq3
        B38yeuHWXbJzuTe8/077LnW1YvMz0cR08TaOlVQZaFO76stUZ5YUn1RHKFLFPF/ltWySZgdmbEOUo
        SkaPSYsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lH16R-00GrhU-0l; Tue, 02 Mar 2021 09:14:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 291A030018A;
        Tue,  2 Mar 2021 10:14:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12034234E17C3; Tue,  2 Mar 2021 10:14:02 +0100 (CET)
Date:   Tue, 2 Mar 2021 10:14:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        dave.hansen@intel.com, andi.kleen@intel.com, len.brown@intel.com
Subject: Re: [PATCH] x86/tsc: mark tsc reliable for qualified platforms
Message-ID: <YD4B2TG7JPqFChhR@hirez.programming.kicks-ass.net>
References: <1614653572-19941-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614653572-19941-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 10:52:52AM +0800, Feng Tang wrote:
> @@ -1193,6 +1193,17 @@ static void __init check_system_tsc_reliable(void)
>  #endif
>  	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE))
>  		tsc_clocksource_reliable = 1;
> +
> +	/*
> +	 * Ideally the socket number should be checked, but this is called
> +	 * by tsc_init() which is in early boot phase and the socket numbers
> +	 * may not be available. Use 'nr_online_nodes' as a fallback solution
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC)
> +		&& boot_cpu_has(X86_FEATURE_NONSTOP_TSC)
> +		&& boot_cpu_has(X86_FEATURE_TSC_ADJUST)
> +		&& nr_online_nodes <= 2)
> +		tsc_clocksource_reliable = 1;

Logical operators go at the end of a line and alignment is with the (,
not the code block after it.
