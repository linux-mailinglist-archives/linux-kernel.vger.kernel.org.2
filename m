Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDFA44EAF8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhKLQFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbhKLQFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:05:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3454C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EIMDZB8v/QNJMWxEA/VFn/Tm47nWxYESvcNR8W/yUnw=; b=BAryPcgHMRZueNA27yenIqBFR8
        WG9jV7KoerYCgTPtFvt5mKnJoj8jWQurXL0IiJulsUVPhGWDwWTDhYbyuclncs2dBqtuKhcdKey3w
        26zqIkG+mTKRuPloNuJiFMBpUC5N2eF3CKwpCZQkNdFnQipVi8rh+SMKfjxZm0K87JcwUZR8xRv9X
        nJpoZkWfdOYMzbTmRU81rbQBCzGzeTG+V2m3uKM6rv+tyCnKPJX8I6dNl3CNNQrPDym/J3zGnnNC0
        YlzLsc1n1qOkjugdoJfxRiv9CifhtQMKz+/3p/ituulQW+JhZ/27582fdEURaOIbK/C/YIyZep2cS
        M+PIkhkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlZ0I-003eMF-Qr; Fri, 12 Nov 2021 16:02:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9423530001C;
        Fri, 12 Nov 2021 17:02:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7DAED2CD8E74F; Fri, 12 Nov 2021 17:02:13 +0100 (CET)
Date:   Fri, 12 Nov 2021 17:02:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        mpe@ellerman.id.au, maddy@linux.ibm.com
Subject: Re: [PATCH v2 03/13] perf/x86/amd: add AMD Fam19h Branch Sampling
 support
Message-ID: <YY6QBXs0sM16DdbV@hirez.programming.kicks-ass.net>
References: <20211111084415.663951-1-eranian@google.com>
 <20211111084415.663951-4-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111084415.663951-4-eranian@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 12:44:05AM -0800, Stephane Eranian wrote:
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 38b2c779146f..28559557f966 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -683,11 +683,16 @@ void x86_pmu_disable_all(void)
>  
>  		if (!test_bit(idx, cpuc->active_mask))
>  			continue;
> +
> +		if (is_amd_brs(hwc))
> +			amd_brs_disable();
> +
>  		rdmsrl(x86_pmu_config_addr(idx), val);
>  		if (!(val & ARCH_PERFMON_EVENTSEL_ENABLE))
>  			continue;
>  		val &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
>  		wrmsrl(x86_pmu_config_addr(idx), val);
> +
>  		if (is_counter_pair(hwc))
>  			wrmsrl(x86_pmu_config_addr(idx + 1), 0);
>  	}

Please, stick that in amd_pmu_disable_all().

