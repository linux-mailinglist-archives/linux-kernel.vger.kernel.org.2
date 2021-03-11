Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0817F337E94
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 20:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCKT66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 14:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhCKT6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:58:47 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10F4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 11:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bSmMOLSw9WLeo/tVcZK30vJrJFW9pjrEeZMnRgnpywo=; b=hD1Ln59GFU5MLqVfASxzUO4J6l
        0DCZZmCsGdWpad98F74Ffpl6LFTUDJuyz55ir1MZhJGMURCWPe1A1RTCNjl/AnhxafVfPH14oWCJU
        4mEU8oav5sCK0mH+ZISrfuAmwMTjUD2/Cw4SdyMQ03bw+Q/8yvbCQWJo7iQvRD0Qsq2WuF+CI+/86
        rwbknffAI1niyJ/Kbzc5CIdhhbovla5aIO7f9bx4nqgBskAmnO2xb0j7XF8DbaU9mv+2jXeUg36CJ
        ff8a5HARoQogdonouQIMhGS8n4j3on8kwG1aPGmRBzX1qoptsXh1S/mJX1vNiRNWQL3wraMzvzqPA
        iRSE8vqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKRS5-00A2Aw-Ua; Thu, 11 Mar 2021 19:58:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89AB99864D0; Thu, 11 Mar 2021 20:58:32 +0100 (CET)
Date:   Thu, 11 Mar 2021 20:58:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Mark Rutland <mark.rutland@arm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH V2 20/25] perf/x86/intel: Add Alder Lake Hybrid support
Message-ID: <20210311195832.GK4746@worktop.programming.kicks-ass.net>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-21-git-send-email-kan.liang@linux.intel.com>
 <YEpAtTttSxMVDWYp@hirez.programming.kicks-ass.net>
 <01176076-049b-0129-4865-8c49cd002060@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01176076-049b-0129-4865-8c49cd002060@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 11:53:35AM -0500, Liang, Kan wrote:

> > > The "cpu_core" PMU is similar to the Sapphire Rapids PMU, but without
> > > PMEM.
> > > The "cpu_atom" PMU is similar to Tremont, but with different
> > > event_constraints, extra_regs and number of counters.

> > So do these things use the same event lists as SPR and TNT?
> 
> No, there will be two new event lists on ADL. One is for Atom core, and the
> other is for big core. They are different to SPR and TNT.

*sigh* how different?

> > Is there any
> > way to discover that, because AFAICT /proc/cpuinfo will say every CPU
> > is 'Alderlake', and the above also doesn't give any clue.
> > 
> 
> Ricardo once submitted a patch to expose the CPU type under
> /sys/devices/system/cpu, but I don't know the latest status.
> https://lore.kernel.org/lkml/20201003011745.7768-5-ricardo.neri-calderon@linux.intel.com/

Yeah, but that was useless, it doesn't list the Cores as
FAM6_SAPPHIRERAPIDS nor the Atom as FAM6_ATOM_TREMONT.

> > My desktop has: cpu/caps/pmu_name and that gives "skylake", do we want
> > the above to have cpu_core/caps/pmu_name give "sapphire_rapids" etc.. ?
> > 
> 
> I think current implementation should be good enough.
> 
> $ cat /sys/devices/cpu_atom/caps/pmu_name
> alderlake_hybrid
> 
> "alderlake_hybrid" tells the perf tool that it's Alder Lake Hybrid system.
> "cpu_atom" tells the perf tool that it's for Atom core.

Yeah, but then I have to ask Google wth those atoms and cores actually
are. Why not tell me upfront?

Since we're now working on it, we all know, but in 6 months time nobody
will remember and then we'll constantly have to look it up and curse
ourselves for not doing better.
