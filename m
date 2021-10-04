Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B1A42145C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 18:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbhJDQtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 12:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbhJDQtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:49:15 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A29C061746
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 09:47:24 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id m5so2286389pfk.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 09:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=slTlsBUy0mVBR913Mb1fnT3NHvCMACe76jloyGr+bDY=;
        b=UJGQovBfYopBHS+99kE9Xi/b28+8BNjGdZjXHnM7WmyhccSXsRZwz7yJipZH1aovZE
         FYB48O9m2C3cz1mWvubgLUD4T1IsCBpm3l04hViYzt2VtsQOB0uz9Uqy6B3VDdQ3Tabz
         qlWOadeZnofPFtK12ynpOATfXgnQbrnPiKXFos0Tsqd7nSoGh+i4ZIi+1VVmmENJ1X5h
         rUor86lM3PuvEV0lxZ7jd31dQBeGFgVLqO0+kly7cI24LrnRU6/4EOt/m5q03zd34ViD
         Bf/r6VVTsSj/L5BA0GeXMlfRUAqOiaUWD2tQHjGGxgePIUP68uAT2py+nRnOCEFFNyAJ
         f24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=slTlsBUy0mVBR913Mb1fnT3NHvCMACe76jloyGr+bDY=;
        b=fz4v/TW6y6HQG9VUkiiMKhnLO0bk3/CkIfkTMhgKP93O5Vg/FNhvAua08IBVFckplh
         DfxwRzGPsdMjw8puynGVKLiQCHiP61xT0GdqUc9aLx6QvUbXj4OCsyMPF9/WohxgaEd1
         owAtXOliNZ9pN6ya35AVkBl9ZOANIBQyqDZidP14rwqmH7NSe/NNnoQmXPDlc/dZf2RR
         2S0cQNMem9AjlI/ZCwm37yHgfMfieXYFDVY7VbqcseBBgKabffse8qKGTQVVQqWM/Zfy
         C77i0etUvTmaZLOLQ6BiASPXIdLW3ly5AYUY9hA3REseJ4a9VXpUcp75CuwtuOWC4lEP
         5R+g==
X-Gm-Message-State: AOAM532qKSo5PQvFVV5+dnLUdjVlykhP5JBvOHIOTib3GzwIPPtsbDs0
        a7dR5WfC4VeZxx5q17cUqLnWZg==
X-Google-Smtp-Source: ABdhPJzrOGjWLwk0uBwi0itShioeViqo7z9Z1okWJzCu45+EFK7jpx6U2hDg7jZRGTEYfLc/uoh0Mg==
X-Received: by 2002:aa7:9542:0:b0:44c:6db9:f596 with SMTP id w2-20020aa79542000000b0044c6db9f596mr3021699pfq.21.1633366043634;
        Mon, 04 Oct 2021 09:47:23 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p48sm14865428pfw.160.2021.10.04.09.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:47:22 -0700 (PDT)
Date:   Mon, 4 Oct 2021 10:47:19 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        james.morse@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
Subject: Re: [PATCH v2 09/17] coresight: trbe: Workaround TRBE errata
 overwrite in FILL mode
Message-ID: <20211004164719.GA3263478@p14s>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-10-suzuki.poulose@arm.com>
 <20211001171522.GB3148492@p14s>
 <085e398c-767c-1b9b-0780-bed830d936fb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <085e398c-767c-1b9b-0780-bed830d936fb@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

On Mon, Oct 04, 2021 at 09:46:07AM +0100, Suzuki K Poulose wrote:
> Hi Mathieu
> 
> On 01/10/2021 18:15, Mathieu Poirier wrote:
> > On Tue, Sep 21, 2021 at 02:41:13PM +0100, Suzuki K Poulose wrote:
> > > ARM Neoverse-N2 (#2139208) and Cortex-A710(##2119858) suffers from
> > > an erratum, which when triggered, might cause the TRBE to overwrite
> > > the trace data already collected in FILL mode, in the event of a WRAP.
> > > i.e, the TRBE doesn't stop writing the data, instead wraps to the base
> > > and could write upto 3 cache line size worth trace. Thus, this could
> > > corrupt the trace at the "BASE" pointer.
> > > 
> > > The workaround is to program the write pointer 256bytes from the
> > > base, such that if the erratum is triggered, it doesn't overwrite
> > > the trace data that was captured. This skipped region could be
> > > padded with ignore packets at the end of the session, so that
> > > the decoder sees a continuous buffer with some padding at the
> > > beginning. The trace data written at the base is considered
> > > lost as the limit could have been in the middle of the perf
> > > ring buffer, and jumping to the "base" is not acceptable.
> > > We set the flags already to indicate that some amount of trace
> > > was lost during the FILL event IRQ. So this is fine.
> > > 
> > > One important change with the work around is, we program the
> > > TRBBASER_EL1 to current page where we are allowed to write.
> > > Otherwise, it could overwrite a region that may be consumed
> > > by the perf. Towards this, we always make sure that the
> > > "handle->head" and thus the trbe_write is PAGE_SIZE aligned,
> > > so that we can set the BASE to the PAGE base and move the
> > > TRBPTR to the 256bytes offset.
> > > 
> > > Cc: Mike Leach <mike.leach@linaro.org>
> > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > > Cc: Leo Yan <leo.yan@linaro.org>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > > Change since v1:
> > >   - Updated comment with ASCII art
> > >   - Add _BYTES suffix for the space to skip for the work around.
> > > ---
> > >   drivers/hwtracing/coresight/coresight-trbe.c | 144 +++++++++++++++++--
> > >   1 file changed, 132 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> > > index f569010c672b..983dd5039e52 100644
> > > --- a/drivers/hwtracing/coresight/coresight-trbe.c
> > > +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> > > @@ -16,6 +16,7 @@
> > >   #define pr_fmt(fmt) DRVNAME ": " fmt
> > >   #include <asm/barrier.h>
> > > +#include <asm/cpufeature.h>
> > >   #include <asm/cputype.h>
> > >   #include "coresight-self-hosted-trace.h"
> > > @@ -84,9 +85,17 @@ struct trbe_buf {
> > >    * per TRBE instance, we keep track of the list of errata that
> > >    * affects the given instance of the TRBE.
> > >    */
> > > -#define TRBE_ERRATA_MAX			0
> > > +#define TRBE_WORKAROUND_OVERWRITE_FILL_MODE	0
> > > +#define TRBE_ERRATA_MAX				1
> > > +
> > > +/*
> > > + * Safe limit for the number of bytes that may be overwritten
> > > + * when the erratum is triggered.
> > > + */
> > > +#define TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP_BYTES	256
> > >   static unsigned long trbe_errata_cpucaps[TRBE_ERRATA_MAX] = {
> > > +	[TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
> > >   };
> > >   /*
> > > @@ -519,10 +528,13 @@ static void trbe_enable_hw(struct trbe_buf *buf)
> > >   	set_trbe_limit_pointer_enabled(buf->trbe_limit);
> > >   }
> > > -static enum trbe_fault_action trbe_get_fault_act(u64 trbsr)
> > > +static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *handle,
> > > +						 u64 trbsr)
> > >   {
> > >   	int ec = get_trbe_ec(trbsr);
> > >   	int bsc = get_trbe_bsc(trbsr);
> > > +	struct trbe_buf *buf = etm_perf_sink_config(handle);
> > > +	struct trbe_cpudata *cpudata = buf->cpudata;
> > >   	WARN_ON(is_trbe_running(trbsr));
> > >   	if (is_trbe_trg(trbsr) || is_trbe_abort(trbsr))
> > > @@ -531,10 +543,16 @@ static enum trbe_fault_action trbe_get_fault_act(u64 trbsr)
> > >   	if ((ec == TRBE_EC_STAGE1_ABORT) || (ec == TRBE_EC_STAGE2_ABORT))
> > >   		return TRBE_FAULT_ACT_FATAL;
> > > -	if (is_trbe_wrap(trbsr) && (ec == TRBE_EC_OTHERS) && (bsc == TRBE_BSC_FILLED)) {
> > > -		if (get_trbe_write_pointer() == get_trbe_base_pointer())
> > > -			return TRBE_FAULT_ACT_WRAP;
> > > -	}
> > > +	/*
> > > +	 * If the trbe is affected by TRBE_WORKAROUND_OVERWRITE_FILL_MODE,
> > > +	 * it might write data after a WRAP event in the fill mode.
> > > +	 * Thus the check TRBPTR == TRBBASER will not be honored.
> > > +	 */
> > > +	if ((is_trbe_wrap(trbsr) && (ec == TRBE_EC_OTHERS) && (bsc == TRBE_BSC_FILLED)) &&
> > > +	    (trbe_has_erratum(cpudata, TRBE_WORKAROUND_OVERWRITE_FILL_MODE) ||
> > > +	     get_trbe_write_pointer() == get_trbe_base_pointer()))
> > > +		return TRBE_FAULT_ACT_WRAP;
> > > +
> > 
> > I'm very perplexed by the trbe_has_erratum() infrastructure... Since this is a
> > TRBE the code will always run on the CPU it is associated with, and if
> > I'm correct here we could call this_cpu_has_cap() directly with the same
> > outcome.  I doubt that all divers using the cpucaps subsystem carry a shadow
> > structure to keep the same information.
> 
> Very valid question. Of course, we can use the this_cpu_has_cap()
> helper. Unlike the cpus_have_*_cap() - which gives you the system
> wide status of the erratum - the cpucap doesn't keep a cache of which
> CPUs are affected by a given erratum. Thus this_cpu_has_cap() would
> involve running the detection on the current CPU everytime we call it.
> i.e, scanning the MIDR of the CPU through the list of affected MIDRs
> for the given erratum. This is a bit of overhead.

I've looked around in the kernel for other places where this_cpu_has_cap() is
used.  In most instance it is part of some initialisation code where actions are
taken based on the turn value of the function.  In our case we need to call this
regularly so yes, I agree with your design.

> 
> Given that we already have CPU specific information in trbe_cpudata, I
> chose to cache the affected errata locally. This gives us quick access
> to the erratum for individual TRBE instances. Of course this list is
> initialised at TRBE probe and thus avoids us having to do the costly
> check, each time we need it. I could make this clear in the patch
> which introduces the framework.

Yes please.

Thanks,
Mathieu

> 
> 
> Thanks for the review
> 
> Suzuki
> 
> > Thanks,
> > Mathieu
