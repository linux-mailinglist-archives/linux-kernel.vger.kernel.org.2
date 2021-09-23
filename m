Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FB64160F2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbhIWOYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbhIWOYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:24:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A25CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:23:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t20so4552335pju.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=taPbk04DJ+AuvTDnEkIKoCK28PDej9hsSm0BYsMill0=;
        b=IMsj/H1EVm4zmfRg1QxsGzbDkQUyuVmwfkMcWQkcmj1MgJI4W031xMwAc9inItbwGm
         s99hLKNJdqWHgtnRjlwHVHFl6OjUib/19mMKG1l3ItNAiCeRSB+sDVpCDQ+wTv1yuSk9
         DI+2HPSj6cr4YQw35lwUISTPzdkBSJ8H66IEoJm8ZfoLieXPSgWHYYz8Jq1N6q65LQWl
         HsnEdWWTYtsHEd+P1qiVVuUBRw254tklylKkRaPkprqQfKzFPBBqSByc8M+qKGyYNX8a
         eIQAv1vDVSi88rjEzmcOChgqH71RySNu8SpDOv+rMuuMrQz27cWsZJcVQn2+Qdfsa+wc
         +18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=taPbk04DJ+AuvTDnEkIKoCK28PDej9hsSm0BYsMill0=;
        b=qKoi2q6CV4vFY3ZZbcR1KH8/l6gzYBWuFoVZHN3O7R9HIwTPzoty3sDQqjiBKJHv73
         tIrdbsPAB3C2spuHfKcH8hCwRCDMQ9r/xSEh/pWJq3IwdT6qz44l7ESPFaX1fYSgPFy1
         Ou5UuTYF4TH6Xo0TIF7zKh68HEcZZvxCu1Stc6qx3yBmapel9pDhwSzHBXcNu+dCH9JK
         Nh1wWq3L7GiXu0mvyBJQ+VU0nkBSbECfYN7eZO//ogt7lqrplTmhzln4R3Z2JPmdSjyh
         80Qj19dDVKd/SK7/Ve+AkqDTQx1kmJQuLR85WrILJ1gWFQZUhwN+9wRsVDtyQT8U8zFd
         ircw==
X-Gm-Message-State: AOAM530PwYv2DFExNuxlMaBUbxhVXlOD7eSgGB42tfX/1Qc1oeET5Pe1
        Vo0bydEmiPlcofblIDXODdOSHQ==
X-Google-Smtp-Source: ABdhPJz41kmHUOcWoY8Cq+w1n6tjekpdTzLetkZw6qYtpd7asM1jLJTK5sGPgj3fI3VV4ldreM53EA==
X-Received: by 2002:a17:902:db05:b0:13c:81ce:1ea4 with SMTP id m5-20020a170902db0500b0013c81ce1ea4mr4154374plx.44.1632406991471;
        Thu, 23 Sep 2021 07:23:11 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([213.173.35.225])
        by smtp.gmail.com with ESMTPSA id n66sm6261874pfd.21.2021.09.23.07.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 07:23:10 -0700 (PDT)
Date:   Thu, 23 Sep 2021 22:23:05 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
Message-ID: <20210923142305.GA603008@leoy-ThinkPad-X240s>
References: <20210916001748.1525291-1-namhyung@kernel.org>
 <20210916135418.GA383600@leoy-ThinkPad-X240s>
 <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Thu, Sep 16, 2021 at 02:01:21PM -0700, Namhyung Kim wrote:

[...]

> > Before we had discussion for enabling PID/TID for SPE samples; in the patch
> > set [1], patches 07, 08 set sample's pid/tid based on the Arm SPE context
> > packets.  To enable hardware tracing context ID, you also needs to enable
> > kernel config CONFIG_PID_IN_CONTEXTIDR.
> 
> Thanks for sharing this.
> 
> Yeah I also look at the context info but having a dependency on a kconfig
> looks limiting its functionality.  Also the kconfig says it has some overhead
> in the critical path (even if perf is not running, right?) - but not sure how
> much it can add.

Yes, after enabled config PID_IN_CONTEXTIDR, the kernel will always
write PID into the system register CONTEXTIDR during process context
switching.  Please see the flow:

  __switch_to() (arch/arm64/kernel/process.c)
    `-> contextidr_thread_switch(next)

> config PID_IN_CONTEXTIDR
>     bool "Write the current PID to the CONTEXTIDR register"
>     help
>       Enabling this option causes the kernel to write the current PID to
>       the CONTEXTIDR register, at the expense of some additional
>       instructions during context switch. Say Y here only if you are
>       planning to use hardware trace tools with this kernel.
> 
> >
> > At that time, there have a concern is the hardware context ID might
> > introduce confusion for non-root namespace.
> 
> Sounds like a problem.
> 
> >
> > We also considered to use PERF_RECORD_SWITCH_CPU_WIDE event for setting
> > pid/tid, the Intel PT implementation uses two things to set sample's
> > pid/tid: one is PERF_RECORD_SWITCH_CPU_WIDE event and another is to detect
> > the branch instruction is the symbol "__switch_to".  Since the trace
> > event PERF_RECORD_SWITCH_CPU_WIDE is coarse, so it only uses the new
> > pid/tid after the branch instruction for "__switch_to".  Arm SPE is
> > 'statistical', thus it cannot promise the trace data must contain the
> > branch instruction for "__switch_to", please see details [2].
> 
> I can see the need in the Intel PT as it needs to trace all (branch)
> instructions, but is it really needed for ARM SPE too?
> Maybe I am missing something, but it seems enough to have a
> coarse-grained context switch for sampling events..

The issue is that the coarse-grained context switch if introduces any
inaccuracy in the reported result.  If we can run some workloads and
prove the coarse-grained context switch doesn't cause significant bias,
it will be great and can give us the confidence for this approach.

Even enabling PERF_RECORD_SWITCH_CPU_WIDE event, I think it's good to
give priority for hardware PID tracing in Arm SPE trace data, if detects
the hardware PID tracing is enabled, then we can rollback to use
context packets from hardware trace data to set sample's PID.

How about you think for this?

Thanks,
Leo
