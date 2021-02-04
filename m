Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90ED030EB5F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 05:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhBDEC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 23:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbhBDEBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 23:01:20 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B453C061786
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 20:00:39 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id n10so1197707pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 20:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ekev10vmev54YC6YS3oAAP96uS/rpxiv7X/ntZD7Dbw=;
        b=mGAZTDHihq/drbQSw1FvQ3M47w93qk6ssTjsPvKjn/8OypobWipJHgGbENvZxoXk7E
         VoQ9Yxi8h8KPwXTc0xJO5qlhUe07suXBeeqja5pC/p+M1YxItxxTkNnkt+Gev9wz5mz7
         yfA3MX3TZPg5cUv7fZxHMcl58+oPZjWdWka9tZohkswIxTaVTPGZtEZrRQS8pxL9mume
         tHt2PcrEt1MjpOMWttkQ2aYUjEFv9muE/mO5fWssXE4E36FYO5SDRIoMENzBVL6Hx0f5
         b6c2N8allH6eGElknLNli2mJlB2KE7CTL4QS7rotnjB3MkBNWHjpOgsuj/zQmPn81iUf
         +Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ekev10vmev54YC6YS3oAAP96uS/rpxiv7X/ntZD7Dbw=;
        b=UkD5Ohfb83h+/c55Hwor1TSAMtRnUxPD5R3d5Ya7c3VcRy4S23UiLCm8eSIvr1fHWE
         8z7Pgr+ti+khl+LQVqFnEJOY89djbK4E4EUNHJEF262yhi/IYsG7T/E/wmpQbfFaGurF
         WXk0arLjvBTh/8pXk5NBjBLpCNa3XN61RWmuToAj1F3tZk/J+YV03YUr4FEXnpHj1iQK
         s9P6BoaDbk1dqbhGrxUgEEH6weULqnfFg3mVeGyr/xA8QgZgbl9vuoW9QjMPNa0oCFu8
         eu2RskrTLxNXrS8LSZxsOgCPuCZRluaw66zfgyE9X/eFR1w0mca9HsEBrQo3Zc9Rbjk6
         bN2Q==
X-Gm-Message-State: AOAM533oEIKoO1wunZQdOqeiX2t+z6LAs7Jd93VF8hVW61mzIyYjm0Z3
        0EKPUFUVZ+Tg8Q6dqq9orSMaTw==
X-Google-Smtp-Source: ABdhPJxm7gZSrWcznAoy/XnaxZqv9Jlv4v0jt9MlTHa9aQZbfi7VCAe+wh3ZDfVyF6iZDhLn0MQIYQ==
X-Received: by 2002:a63:f703:: with SMTP id x3mr6871446pgh.66.1612411238656;
        Wed, 03 Feb 2021 20:00:38 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id 124sm3769128pfd.59.2021.02.03.20.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 20:00:38 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:00:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Grant <al.grant@arm.com>
Subject: Re: [PATCH v2 6/7] perf cs-etm: Detect pid in VMID for kernel
 running at EL2
Message-ID: <20210204040021.GF11059@leoy-ThinkPad-X240s>
References: <20210202163842.134734-1-leo.yan@linaro.org>
 <20210202163842.134734-7-leo.yan@linaro.org>
 <f5158216-c3d1-10bb-02eb-00ff9a78f617@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5158216-c3d1-10bb-02eb-00ff9a78f617@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 11:29:47PM +0000, Suzuki Kuruppassery Poulose wrote:
> On 2/2/21 4:38 PM, Leo Yan wrote:
> > From: Suzuki K Poulose <suzuki.poulose@arm.com>
> > 
> > The PID of the task could be traced as VMID when the kernel is running
> > at EL2.  Teach the decoder to look for VMID when the CONTEXTIDR (Arm32)
> > or CONTEXTIDR_EL1 (Arm64) is invalid but we have a valid VMID.
> > 
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Al Grant <al.grant@arm.com>
> > Co-developed-by: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >   .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 32 ++++++++++++++++---
> >   1 file changed, 28 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > index 3f4bc4050477..fb2a163ff74e 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -6,6 +6,7 @@
> >    * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
> >    */
> > +#include <linux/coresight-pmu.h>
> >   #include <linux/err.h>
> >   #include <linux/list.h>
> >   #include <linux/zalloc.h>
> > @@ -491,13 +492,36 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
> >   			const ocsd_generic_trace_elem *elem,
> >   			const uint8_t trace_chan_id)
> >   {
> > -	pid_t tid;
> > +	pid_t tid = -1;
> > +	u64 pid_fmt;
> > +	int ret;
> > -	/* Ignore PE_CONTEXT packets that don't have a valid contextID */
> > -	if (!elem->context.ctxt_id_valid)
> > +	ret = cs_etm__get_pid_fmt(trace_chan_id, &pid_fmt);
> > +	if (ret)
> 
> Is this something we can cache in this function ? e.g,
> 	static u64 pid_fmt;
> 
> 	if (!pid_pfmt)
> 		ret = cs_etm__get_pid_fmt(trace_chan_id, &pid_fmt);
> 
> As all the ETMs will be running at the same exception level.

Sorry that I let you repeated your comments again.

To be honest, I considered this after read your comment in the previous
series, but I thought it's possible that multiple CPUs have different
PID format, especially for big.LITTLE arch.  After read your suggestion
again, I think my concern is not valid, even for big.LITTLE, all CPUs
should run on the same kernel exception level.

So will follow up your suggestion to cache "pid_fmt".

> 
> > +		return OCSD_RESP_FATAL_SYS_ERR;
> > +
> > +	/*
> > +	 * Process the PE_CONTEXT packets if we have a valid contextID or VMID.
> > +	 * If the kernel is running at EL2, the PID is traced in CONTEXTIDR_EL2
> > +	 * as VMID, Bit ETM_OPT_CTXTID2 is set in this case.
> > +	 */
> > +	switch (pid_fmt) {
> > +	case BIT(ETM_OPT_CTXTID):
> > +		if (elem->context.ctxt_id_valid)
> > +			tid = elem->context.context_id;
> > +		break;
> > +	case BIT(ETM_OPT_CTXTID2) | BIT(ETM_OPT_CTXTID):
> 
> I would rather fix the cs_etm__get_pid_fmt() to return either of these
> as commented. i.e, ETM_OPT_CTXTID or ETM_OPT_CTXTID2. Thus we don't
> need the this case.

I explained why I set both bits for ETM_OPT_CTXTID and ETM_OPT_CTXTID2
in the patch 05/07.  Could you take a look for it?

> With the above two addressed:
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks,
Leo
