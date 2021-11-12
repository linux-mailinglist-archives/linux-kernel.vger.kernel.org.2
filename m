Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6089844EB4E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhKLQ2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbhKLQ2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:28:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6707AC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/ROg51YQcAWoGgiADnmDIeE1UY58eMWg/67dPU094hk=; b=dvq/2osQeQjlwxspDfDMtrKbKf
        6S99nI9Cs0YeTUlTTraGFn/ganoB0K8wEACHUHTW7TPednllqEdm15yUrWxk1Pvv/9Iqy8sZXJcIp
        WQbpqjnVxR+hL0zfkKjXTiEpEhj5bvXplyJDTp9tCPIwM1WWO2rC2QumazqwKpe1jMxNGWBSpjx7R
        JCFct7VFFwH+juP95NoCOh5CFvSWG7Px4ek7baK6Odk1eSpybQ84Rh6kzuACMagzwNmAh+drsx9yO
        /YN8BwSZZKTIXsN1yroBvQcm1fpRITNvVeF3HmpC+eCZxJXuA7rWabkPLIOPPyc4sCJHnFr+UQmgR
        j5quQ3xw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlZML-003fLh-KI; Fri, 12 Nov 2021 16:25:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E73153000DD;
        Fri, 12 Nov 2021 17:25:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF7A62CEFE198; Fri, 12 Nov 2021 17:25:01 +0100 (CET)
Date:   Fri, 12 Nov 2021 17:25:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        mpe@ellerman.id.au, maddy@linux.ibm.com
Subject: Re: [PATCH v2 03/13] perf/x86/amd: add AMD Fam19h Branch Sampling
 support
Message-ID: <YY6VXdEl2xbwitjk@hirez.programming.kicks-ass.net>
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
> @@ -989,6 +1165,23 @@ static int __init amd_core_pmu_init(void)
>  		x86_pmu.flags |= PMU_FL_PAIR;
>  	}
>  
> +	if (boot_cpu_data.x86 >= 0x19) {
> +		/*
> +		 * On AMD, invoking pmu_disable_all() is very expensive and the function is
> +		 * invoked on context-switch in via sched_task_in(), so enable only when necessary
> +		 */

Well, it only gets called when brs is in use, so afaict the above
comment is a bit misleading. Still no point in installing that function
when there it no point for it.

> +		if (!amd_brs_init()) {
> +			x86_pmu.get_event_constraints = amd_get_event_constraints_f19h;
> +			x86_pmu.sched_task = amd_pmu_sched_task;
> +			/*
> +			 * The put_event_constraints callback is shared with
> +			 * Fam17h, set above
> +			 */
> +		}
> +	}
> +
> +	x86_pmu.attr_update = amd_attr_update;
> +
>  	pr_cont("core perfctr, ");
>  	return 0;
>  }
