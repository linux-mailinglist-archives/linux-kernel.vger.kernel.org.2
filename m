Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0544366719
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbhDUIkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbhDUIkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:40:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B815CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 01:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WX/ulq1oGNVEHNSHwMYQBTN+yMAByfD4DdWq5Ogc4BE=; b=IHOjLVkFNthLw0m0jh91D4QMrK
        dLgad/fvbQKBTEe6c45p2Ewv0J8Jnx6I/b7rO0fgKcbcE61S39UPINs5iXMtI3rcLmjelM2FDSa4R
        /agPjGmL9w56IytbRQqd5rq5pe1A7i0bIQn3pNlpFbWn7ObVBpjEajxNp32nUjpQKLrLr6mXp1Ej/
        6EWVaD3SLjCZKFhbUBTUF8HWicN2NlwVi8rVD4+FaLri/AtlNua0eqmS4zqIbRIsUJqLfzwlYnIVp
        XERvuJZsBj4YvppFMbdPOG+KyhXgVNvILLeVDhgyF5v3OLQYx9XUC58WaXQZtUES81oYk6kY9LUVD
        sfxZ1xiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZ8NY-00GHDi-R4; Wed, 21 Apr 2021 08:38:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87A993001E2;
        Wed, 21 Apr 2021 10:38:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E2C52C6D8C9C; Wed, 21 Apr 2021 10:38:34 +0200 (CEST)
Date:   Wed, 21 Apr 2021 10:38:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] perf/x86/lbr: Move cpuc->lbr_xsave allocation
 out of sleeping region
Message-ID: <YH/kikWFlfD260qy@hirez.programming.kicks-ass.net>
References: <20210421021825.37872-1-like.xu@linux.intel.com>
 <20210421021825.37872-2-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421021825.37872-2-like.xu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 10:18:25AM +0800, Like Xu wrote:
> -int x86_reserve_hardware(void)
> +int x86_reserve_hardware(struct perf_event *event)
>  {
>  	int err = 0;
>  
> @@ -398,8 +398,10 @@ int x86_reserve_hardware(void)
>  		if (atomic_read(&pmc_refcount) == 0) {
>  			if (!reserve_pmc_hardware())
>  				err = -EBUSY;
> -			else
> +			else {
>  				reserve_ds_buffers();
> +				reserve_lbr_buffers(event);
> +			}
>  		}
>  		if (!err)
>  			atomic_inc(&pmc_refcount);
> @@ -650,7 +652,7 @@ static int __x86_pmu_event_init(struct perf_event *event)
>  	if (!x86_pmu_initialized())
>  		return -ENODEV;
>  
> -	err = x86_reserve_hardware();
> +	err = x86_reserve_hardware(event);
>  	if (err)
>  		return err;
>  

This is still complete garbage..
