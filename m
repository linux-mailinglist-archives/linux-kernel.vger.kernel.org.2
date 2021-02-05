Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B91C3104B2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 06:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhBEFnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 00:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhBEFnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 00:43:05 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6538C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 21:42:24 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id lw17so6150556pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 21:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FvgdxNInb0oVeGhL4PW/aE3z9p2JTGo1itzqu/MywdU=;
        b=IVavZq/Gz1USEIInGrPz5TOyKYbE7Ob0IDyu79VNFqRAXQ22ugPOPN46o+Ih/VEElJ
         CNgSWlsrmttQ/emnDT7r3DbntylSHCDXTOoEs6NgtTLCONEi1eY0ARVAQzM4x4cvJv8i
         SLDcqIEmh/U3NlxLI11F+4wTjU84tHh40hAC0xZYFxeBaDAmRGnYXy3fFFMHk9Ki34vm
         I5FyNT0gVVW6oDa0sDbqGY3rLV+EpnVQdSPlQffa5RQI/8yLJzc8e1tRKN/j2t2zL9Vv
         Zv/qy++/SMo7tLo8elxjwL3yYgSY/hOjtqJArootYSi4DIGA/IKPTZrk0RyFwAqzH4cJ
         +whQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FvgdxNInb0oVeGhL4PW/aE3z9p2JTGo1itzqu/MywdU=;
        b=HHv1CUfxJici68MYOY2Xhyhy1Wif5BEURz8C81XcyENhnqD5h9uFTAn/SLbw0v8mNP
         xtx6o2YnsbnTHz8iwYThBpYk8Ib3VYa7vImf3DA/LPAOXIeJLjqG0O4D4QfmVpEfK0LR
         AxonfkoKm6qO7bhrva66eTL0TX1zT+mizK02OIw8Ht72qhqF7aH9GAHEZLpOJJp9vgn3
         QGoy9wbtjJwReRWec/3eCXG6XTGGOYDVrrEPUo9hTP2CYC5bumLMYPL2G4y9xS6pl171
         4samfjWWvbq9GOWyNZFWU7bREtWnCY3MeNU5i0epPi2QQStb1Hj0rx6T7JM19nrTkgv+
         l1Gw==
X-Gm-Message-State: AOAM532tyreqgoV1vC4GCdwCL9hmj16Pu4DIqh1n5TRDvMBxsWu64L7R
        nRDFKvtaKxYhvtmX35gnE9j1Ew==
X-Google-Smtp-Source: ABdhPJxme1S5+Tw77DQWAZHvdF86EsOcfYUldc3Zua8T3zS6vzsVRpOxUUme8ALWJLXRulAc6k6fCw==
X-Received: by 2002:a17:902:a614:b029:e1:5b43:956a with SMTP id u20-20020a170902a614b02900e15b43956amr2909593plq.38.1612503744336;
        Thu, 04 Feb 2021 21:42:24 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([202.131.71.236])
        by smtp.gmail.com with ESMTPSA id j9sm8572756pgb.47.2021.02.04.21.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 21:42:23 -0800 (PST)
Date:   Fri, 5 Feb 2021 13:42:16 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
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
        Denis Nikitin <denik@chromium.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] Documentation: coresight: Add PID tracing
 description
Message-ID: <20210205054216.GB5797@leoy-ThinkPad-X240s>
References: <20210202163842.134734-1-leo.yan@linaro.org>
 <20210202163842.134734-8-leo.yan@linaro.org>
 <CAJ9a7VgzNphx=OkxjrxHJsuFAYEbOgHuAm9ysdwHq20=GhbgTg@mail.gmail.com>
 <20210204040909.GH11059@leoy-ThinkPad-X240s>
 <a6ee6d9e-a17f-0861-60b5-585abe99ce92@arm.com>
 <CAJ9a7VgQUAsD46DQARXm1qwiNgd4KU+yymezSEqmoX_7Umvt_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VgQUAsD46DQARXm1qwiNgd4KU+yymezSEqmoX_7Umvt_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 12:14:12PM +0000, Mike Leach wrote:

[...]

> > >>> +To support tracing PID for the kernel runs at different exception levels,
> > >>> +the PMU formats are defined as follow:
> > >>> +
> > >>> +  "contextid1": Available on both EL1 kernel and EL2 kernel.  When the
> > >>> +                kernel is running at EL1, "contextid1" enables the PID
> > >>> +                tracing; when the kernel is running at EL2, this enables
> > >>> +                tracing the PID of guest applications.
> > >>> +
> > >>> +  "contextid2": Only usable when the kernel is running at EL2.  When
> > >>> +                selected, enables PID tracing on EL2 kernel.
> > >>> +
> > >>> +  "contextid":  Will be an alias for the option that enables PID
> > >>> +                tracing.  I.e,
> > >>> +                contextid == contextid1, on EL1 kernel.
> > >>> +                contextid == contextid2, on EL2 kernel.
> > >>> +
> > >>> +The perf tool automatically sets corresponding bit for the "contextid" config,
> > >>> +therefore, the user doesn't have to bother which EL the kernel is running.
> > >>> +
> > >>> +  i.e, perf record -e cs_etm/contextid/u -- uname
> > >>> +    or perf record -e cs_etm//u -- uname
> > >>> +
> > >>> +will always do the "PID" tracing, independent of the kernel EL.
> > >>> +
> > >>
> > >> This is telling me that both cs_etm// and cs_etm/contextid/ have the
> > >> same effect - trace PID. Is this correct?
> > >
> >
> > Just to make this clear, this is not a side effect of the patch.
> 
> Which is fine - but the documentation should accurately reflect what
> is happening on the system.
> This is a new paragraph about the PID tracing or otherwise, Even if
> some of the effects pre-date this patch, they have to be accurately
> communicated.
> I am also reading the new paragraph in the context of the rest of the
> coresight.rst document - which is a user level document explaining the
> basic operation of the coresight system and tools.
> This document mentions no other perf command line parameters relevant
> to coresight other than the @sink option.It actually calls out to the
> OpenCSD docs to provide further information.
> 
> > The perf
> > tool driver automatically adds the "contextid" tracing and timestamp for
> > "system wide" and process bound events, as they traces get mixed into
> > the single sink. So these options are added implicitly by the perf tool
> > to make the decoding easier.
> >
> 
> That's fine - I have no problem with contextID trace enabled by
> default. Context ID is relatively low overhead - and only emitted at
> start of trace  / context changes.
> But the explanation of the parameters currently reads as though they
> always have an effect - and not putting them in there will omit the
> effect - unless you spot the very subtle line at the end.
> 
> The user does not need to know about parameters that have no effect!

Thanks for the suggestion, Mike.

> Perhaps a better approach would be to explain the above - an explicit
> statement that "perf will always enable PID/ contextID tracing at the
> relevant EL - but for EL2 it is possible to make specific adjustments
> using parameters......."

Usually users assume the PMU format has no effect if without set it; but
this is not the case for the config "contextid", this config has been
automatically enabled by perf tool.

Based on your suggesiton, will refine the descrption for two things:
clarify what's the common usage for EL1/EL2, and what's specific for
EL2.

Thanks,
Leo
