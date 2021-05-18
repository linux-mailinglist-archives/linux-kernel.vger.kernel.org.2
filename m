Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A033879F7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349608AbhERNao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349598AbhERNal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:30:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE137C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YPdGuTheVxR4ga139eQKM5TvxRmYiVXY5RnZ9U/3GXY=; b=D7FcY7n7zkSyHz9kp0WQgo8XFC
        CNBzQJKb0u89zPe/WtlV1iriV5HR/n2jmbobo3lvTfNYfzQzmHUZMXmobaZfTBQnEPb6lczq95Stc
        F9G7oNKpuC0MH46MCCMDwCxAHazTAXqyrlC/ES1O/vC6M9uoy/P2+ZgcNzVi4+5Yux6WHvGAAmGvX
        D5NfkqfvoigxOsINWvu2PvayLzcwQRdzilC1b8FgLrBnfvYsKcSipMGsnmVhSYyacfmpNin6iotAu
        Qtjn78t485FqtmqcO8vD7+/TJQasiNBEnuLTooHaSOGTCgaY4V9Y5eidHwRKoNGJzG5B5i+pK3+NN
        06UUoWNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lizmZ-000skL-HY; Tue, 18 May 2021 13:29:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 807D3300250;
        Tue, 18 May 2021 15:29:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 711923011B173; Tue, 18 May 2021 15:29:10 +0200 (CEST)
Date:   Tue, 18 May 2021 15:29:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        seanjc@google.com, x86@kernel.org
Subject: Re: [PATCH v2 2/2] perf/x86/lbr: Move cpuc->lbr_xsave allocation out
 of sleeping region
Message-ID: <YKPBJoK1b/2PIQfk@hirez.programming.kicks-ass.net>
References: <20210430052247.3079672-1-like.xu@linux.intel.com>
 <20210430052247.3079672-2-like.xu@linux.intel.com>
 <YKOQqT+Ktc4C2kQp@hirez.programming.kicks-ass.net>
 <a9032de6-e55d-bfff-e6b5-4c79dcab30f3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9032de6-e55d-bfff-e6b5-4c79dcab30f3@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 08:34:33PM +0800, Like Xu wrote:
> > > +	if (!static_cpu_has(X86_FEATURE_ARCH_LBR))
> > > +		return;
> > > +
> > > +	for_each_possible_cpu(cpu) {
> > > +		cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
> > > +		kmem_cache = x86_get_pmu(cpu)->task_ctx_cache;
> > > +		if (kmem_cache && !cpuc->lbr_xsave && !event->attr.precise_ip)
> > > +			cpuc->lbr_xsave =
> > > +				kmem_cache_alloc_node(kmem_cache, GFP_KERNEL,
> > > +						      cpu_to_node(cpu));
> > 
> > (coding style fail)
> > 
> > But then I looked at this function, and srlsy that !precise_ip is the
> > only thing you need @event for? Why do we care?
> 
> Kan once commented, we only need to alloc the buffer for the non-PEBS
> event. It seems the check "(cpuc->lbr_users != cpuc->lbr_pebs_users)"
> is implicitly removed.
> 
> I think we still need to check !precision_ip, right ?

It's just a memory allocation; who cares if we allocate but not use it
ever?
