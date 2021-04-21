Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBF83666C8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhDUILv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhDUILt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:11:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF72CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 01:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RF1KBkYzPgdbo2HHSPnyOjODyBl1vp50ND2wwWY3PoE=; b=NJnylM5CtFZCN+bRHfJvlNMLZ2
        G4tf5ePYTtfVC0XzEob+Ebm+JI//qKKYLkUqiyoYLFmPTOoZ0HBzXVrOjCPECebGwPz+IuuXNUlYf
        uJnck5E7TH0dVNbyqERwxF9fPZ+NpYb7Dapa8ofsPbQO95WF+uq/tCh9OLsRdwQ2/BtGGkpWx+0Ka
        PgdYfV9Ri7U3bXN53aRp5441ZAaszZ1MWsxpSgk+7MMGM9yPvXZMYK8hRCW3pWd7klvjj8JyOpVtB
        eqQXKuWelgbmAU62mACcvm+/EpE9RkkbX6VkiNCa0As9hPgN8K6SFfmeUVrOrgDRki8m9+KRQO3KD
        SmUcU5tQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZ7wv-00Dx8o-54; Wed, 21 Apr 2021 08:11:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 027D53001E2;
        Wed, 21 Apr 2021 10:11:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DED6B2C37BCF8; Wed, 21 Apr 2021 10:11:03 +0200 (CEST)
Date:   Wed, 21 Apr 2021 10:11:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com, luto@amacapital.net,
        eranian@google.com, namhyung@kernel.org
Subject: Re: [PATCH V5] perf/x86: Reset the dirty counter to prevent the leak
 for an RDPMC task
Message-ID: <YH/eF4YWg73Lkcrr@hirez.programming.kicks-ass.net>
References: <1618957842-103858-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618957842-103858-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 03:30:42PM -0700, kan.liang@linux.intel.com wrote:
>  static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
>  {
> +	unsigned long flags;
> +
>  	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
>  		return;
>  
>  	/*
> +	 * Enable sched_task() for the RDPMC task,
> +	 * and clear the existing dirty counters.
> +	 */
> +	if (x86_pmu.sched_task && event->hw.target) {
> +		local_irq_save(flags);
> +		perf_sched_cb_inc(event->ctx->pmu);
> +		x86_pmu_clear_dirty_counters();
> +		local_irq_restore(flags);
> +	}
> +
> +	/*
>  	 * This function relies on not being called concurrently in two
>  	 * tasks in the same mm.  Otherwise one task could observe
>  	 * perf_rdpmc_allowed > 1 and return all the way back to
> @@ -2327,10 +2367,17 @@ static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
>  
>  static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
>  {
> +	unsigned long flags;
>  
>  	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
>  		return;
>  
> +	if (x86_pmu.sched_task && event->hw.target) {
> +		local_irq_save(flags);
> +		perf_sched_cb_dec(event->ctx->pmu);
> +		local_irq_restore(flags);
> +	}
> +
>  	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
>  		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
>  }

I don't understand how this can possibly be correct. Both
perf_sched_cb_{inc,dec} modify strict per-cpu state, but the mapped
functions happen on whatever random CPU of the moment whenever the task
memory map changes.

Suppose we mmap() on CPU0 and then exit on CPU1. Suppose the task does
mmap() on CPU0 but then creates threads and runs on CPU1-4 concurrently
before existing on CPU5.

Could be I'm not seeing it due to having a snot-brain, please explain.
