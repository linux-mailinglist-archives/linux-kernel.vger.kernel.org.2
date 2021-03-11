Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E613378F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhCKQOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhCKQOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:14:06 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1280AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=whWBvoNb3Pce92YggrosMeszjH470wWd9Ek1CsO5FDg=; b=eK9pitziHMJtSJXvhapq7T/fc7
        DRm1pbST/KHjdVdaERzlBisGGXFfu735qkDSTCcpKRUHwBsxma/gLd5wKSL66Nikhx9f/neCWsaI6
        TzDCZQfTevWM15i0ZJwgTcWdBARWZUohpx+b3MvhyKWOyfWdtwN6K/fBvTldNyyuw2VaSJR4puV1d
        //W554lyfo5xVx/nZVGSUTN4k1PYlBa05I8saB0K48rRUS3rDUd/jQ5KpU6jmkikrmk4ndyOMjC84
        gh5d89mDPyKBonbKV/NT0fnft2v4AAYYX8C75SRiQ/P4qcYtzZe17874ncFyxkjAKUC38KZg8fQ0g
        wc/PH/KQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKNwh-009XjQ-St; Thu, 11 Mar 2021 16:13:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 645203013E5;
        Thu, 11 Mar 2021 17:13:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4FD8C29E3D9F5; Thu, 11 Mar 2021 17:13:55 +0100 (CET)
Date:   Thu, 11 Mar 2021 17:13:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: Re: [PATCH V2 16/25] perf/x86: Register hybrid PMUs
Message-ID: <YEpBw0jRH+ariY70@hirez.programming.kicks-ass.net>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-17-git-send-email-kan.liang@linux.intel.com>
 <YEoOVTVhN3DpQXl2@hirez.programming.kicks-ass.net>
 <24dbe717-ffb8-204b-bac2-59941c2314f7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24dbe717-ffb8-204b-bac2-59941c2314f7@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:41:00AM -0500, Liang, Kan wrote:
> 
> 
> On 3/11/2021 7:34 AM, Peter Zijlstra wrote:
> > On Wed, Mar 10, 2021 at 08:37:52AM -0800, kan.liang@linux.intel.com wrote:
> > > @@ -2092,9 +2105,37 @@ static int __init init_hw_perf_events(void)
> > >   	if (err)
> > >   		goto out1;
> > > -	err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
> > > -	if (err)
> > > -		goto out2;
> > > +	if (!is_hybrid()) {
> > > +		err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
> > > +		if (err)
> > > +			goto out2;
> > > +	} else {
> > > +		u8 cpu_type = get_hybrid_cpu_type(smp_processor_id());
> > > +		struct x86_hybrid_pmu *hybrid_pmu;
> > > +		int i;
> > > +
> > > +		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
> > > +			hybrid_pmu = &x86_pmu.hybrid_pmu[i];
> > > +
> > > +			hybrid_pmu->pmu = pmu;
> > > +			hybrid_pmu->pmu.type = -1;
> > > +			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
> > > +			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_HETEROGENEOUS_CPUS;
> > > +
> > > +			/* Only register the PMU for the boot CPU */
> > 
> > Why ?!
> > > AFAICT we could register them all here. That instantly fixes that
> > CPU_STARTING / CPU_DEAD fail elsewhere in this patch.
> 
> It's possible that all CPUs of a certain type all offline, but I cannot know
> the information here, because the boot CPU is the only online CPU. I don't
> know the status of the other CPUs.
> 
> If we unconditionally register all PMUs, users may see a PMU in
> /sys/devices, but they cannot use it, because there is no available CPU.
> Is it acceptable that registering an empty PMU?

Sure. That's what it has a cpumask for after all.

ISTR that being the case with some dodgy RAPL thing on SPR as well.
