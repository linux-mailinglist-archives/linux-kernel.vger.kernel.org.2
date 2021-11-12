Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B85644EB4B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbhKLQ0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbhKLQ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:26:22 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97314C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UZHjD9Bn4bep+f/7dZ4Q88x2GebGnlQ44xZXpuYXGKY=; b=kT5bdsLZQLoYrmU9r47NbSiOZW
        TAJH8kYE963P0xGd1MxNU+z4+2ZjWo4R/M3YouuQ6g3a8/Jj1LyABRrVMQSZz6s2m4rtFTwSq+l1w
        hUM2S3O8D/QME/snvdbfemAX6oNbvAyIY2AF9QUtCD7t7qIPY27W4FWrcJ3o1R+5xf4v0jMwMV328
        hd5FRAuE52LBbV6T60y7e0H3i1L7beDVUXvvje//Nh4HQ4WZ6IJUFG4pqOHZOm6Zj1P6uq4lsthUG
        cwiCb6vnR4FmnfIqGY64+aDPGDsC8PXnEr5ooOF33TgFJMrawajEWF3kvWKhSdSO4eZnraC/w/Gxi
        axMxsq3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlZKd-00FeUy-3N; Fri, 12 Nov 2021 16:23:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24EA13000DD;
        Fri, 12 Nov 2021 17:23:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E00D2CEFE19B; Fri, 12 Nov 2021 17:23:14 +0100 (CET)
Date:   Fri, 12 Nov 2021 17:23:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        mpe@ellerman.id.au, maddy@linux.ibm.com
Subject: Re: [PATCH v2 03/13] perf/x86/amd: add AMD Fam19h Branch Sampling
 support
Message-ID: <YY6U8UY3/9X2ZNYt@hirez.programming.kicks-ass.net>
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

> +static void amd_pmu_enable_event(struct perf_event *event)
> +{
> +	x86_pmu_enable_event(event);
> +
> +	if (__this_cpu_read(cpu_hw_events.enabled)) {
> +		if (is_amd_brs(&event->hw))
> +			amd_brs_enable();
> +	}

Does this path actually trigger? I thought we always use the enable_all
path these days. Could easily be I misremember though.

> +}
> +
> +static void amd_pmu_enable_all(int added)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	struct hw_perf_event *hwc;
> +	int idx;
> +
> +	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
> +		hwc = &cpuc->events[idx]->hw;
> +
> +		/* only activate events which are marked as active */
> +		if (!test_bit(idx, cpuc->active_mask))
> +			continue;
> +
> +		amd_pmu_enable_event(cpuc->events[idx]);
> +	}
> +}

The thing is, since te BRS is a 'global' state, it doesn't really make
sense to enable it per-event.

Anyway, I think the above actually works, just wondering if we can
perhaps simplify it.

