Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE3630EB63
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 05:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBDEDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 23:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhBDEDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 23:03:36 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23503C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 20:02:56 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r38so1188583pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 20:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M85X1MjJYGgo1IfIZsmjwYJ9uoQMu5IYZdM5xfYzY4k=;
        b=kxr3c6PQOhqYiDgopnWiM8/AbTzQ+VW7UmO+dimUTFi1E0ZP1uc5gKO4QKAJATIX4e
         kzRN1s+HW1VPX4v3ZvNh+COBVrP/hj3+4mEBZ4ke1HasW6l95ZSjbLLUbuMjFa0GsTFh
         sCHZgaZrdRWiQw2GpZRTsXRQ7fpnD+Q7msLKMNtJ1AkCN5yB23Wkjq4BDB2tz2bH7v94
         gBPtyT+YSFwFLS22A0PxVTHM2yT7DtsIIj8JUK8SU+f54HdHrGbunMZuxyKery7VyY8S
         Rwk94H1KWqrs9qMyjidIVbc4rJJjmOrXY0OuYzWfv7wLvMoZ3eaW99UizJeytKrfot2x
         /5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M85X1MjJYGgo1IfIZsmjwYJ9uoQMu5IYZdM5xfYzY4k=;
        b=OtYZUzAHMel0dcy2XBluIbVx/qoIHD/20P9dSxtNJZfoYWtURa40T5BWI4dNxDgziK
         Ku3auuNRAI4LLuwQPJU+aT/4HXt+DhJtvsQ2aalfGtK5NkGqOtaArBv5z7Bqw5bz907g
         CblExfkD6OzHVz2zeQODlIR6M/1dWgI2PHnSDxzgSHsqNumThQEtMwpUuzuCxHl2Tlth
         CRH/xtJyhEcWy5IhRCiC87SnXUQUfR0lHmUJI3zXJLrDhQNRrBoBFgciGig/8qjWTxMP
         S6C3EgTOmodAU07NVWdXhke5yGzER5tJbr8W8vToDEGLqOd1TK8jMHpE0niArwV0NvRF
         N01A==
X-Gm-Message-State: AOAM532zVVXFeOtUEYdEu747yWaMWGy79IGNOoaIdsM4Y5DilgT9UWcR
        lSKAn5Php+FKv03OYje7dWLP9nECB/M6kqSN
X-Google-Smtp-Source: ABdhPJzyy8hUpxfUgXMdVa0NTlMiwFkbPMkl1TjMr6JrL2kQlzmPMxl+tKyDE0QtDKCtF1Yz9Q6G6w==
X-Received: by 2002:a62:503:0:b029:1c0:aed7:c88 with SMTP id 3-20020a6205030000b02901c0aed70c88mr6099543pff.76.1612411375635;
        Wed, 03 Feb 2021 20:02:55 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id lw4sm3069092pjb.16.2021.02.03.20.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 20:02:54 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:02:47 +0800
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] Documentation: coresight: Add PID tracing
 description
Message-ID: <20210204040247.GG11059@leoy-ThinkPad-X240s>
References: <20210202163842.134734-1-leo.yan@linaro.org>
 <20210202163842.134734-8-leo.yan@linaro.org>
 <451d58bd-e79d-5fb4-a67f-962da02a3937@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451d58bd-e79d-5fb4-a67f-962da02a3937@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 11:24:48PM +0000, Suzuki Kuruppassery Poulose wrote:
> On 2/2/21 4:38 PM, Leo Yan wrote:
> > After support the PID tracing for the kernel in EL1 or EL2, the usage
> > gets more complicated.
> > 
> > This patch gives description for the PMU formats of contextID configs,
> > this can help users to understand how to control the knobs for PID
> > tracing when the kernel is in different ELs.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >   Documentation/trace/coresight/coresight.rst | 37 +++++++++++++++++++++
> >   1 file changed, 37 insertions(+)
> > 
> > diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
> > index 0b73acb44efa..771558f22938 100644
> > --- a/Documentation/trace/coresight/coresight.rst
> > +++ b/Documentation/trace/coresight/coresight.rst
> > @@ -512,6 +512,43 @@ The --itrace option controls the type and frequency of synthesized events
> >   Note that only 64-bit programs are currently supported - further work is
> >   required to support instruction decode of 32-bit Arm programs.
> > +2.2) Tracing PID
> > +
> > +When the kernel is running at EL2 with Virtualization Host Extensions (VHE),
> > +perf records CONTEXTIDR_EL2 in the trace data and can be used as PID when
> > +decoding; and if the kernel is running at EL1 with nVHE, CONTEXTIDR_EL1 is
> > +traced for PID.
> > +
> > +To support tracing PID for the kernel runs at different exception levels,
> > +the PMU formats are defined as follow:
> > +
> > +  "contextid1": Available on both EL1 kernel and EL2 kernel.  When the
> > +                kernel is running at EL1, "contextid1" enables the PID
> > +                tracing; when the kernel is running at EL2, this enables
> > +                tracing the PID of guest applications.
> > +
> > +  "contextid2": Only usable when the kernel is running at EL2.  When
> > +                selected, enables PID tracing on EL2 kernel.
> > +
> > +  "contextid":  Will be an alias for the option that enables PID
> > +                tracing.  I.e,
> > +                contextid == contextid1, on EL1 kernel.
> > +                contextid == contextid2, on EL2 kernel.
> > +
> > +The perf tool automatically sets corresponding bit for the "contextid" config,
> > +therefore, the user doesn't have to bother which EL the kernel is running.
> > +
> > +  i.e, perf record -e cs_etm/contextid/u -- uname
> > +    or perf record -e cs_etm//u -- uname
> > +
> > +will always do the "PID" tracing, independent of the kernel EL.
> > +
> > +When the kernel is running at EL2 with VHE, if user wants to trace both the
> > +PIDs for both host and guest, the two configs "contextid1" and "contextid2"
> > +can be set at the same time:
> > +
> > +  perf record -e cs_etm/contextid1,contextid2/u -- uname
> > +
> 
> To make this case clear, we could change the command from uname to
> something like:
> 
>     perf record -e cs_etm/contextid1,contextid2/u -- vm

Exactly, will refine.

> Otherwise looks good to me.
> 
> With the above fixed,
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks,
Leo
