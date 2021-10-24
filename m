Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D859443884F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 12:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhJXK2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 06:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhJXK2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 06:28:03 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C21C061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 03:25:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fv3so49804pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 03:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iGbgQOCj+oOFbXt9SNh5T326Ohx0VeTB83ysW3crHq4=;
        b=ZpaNlTJVE9SqNuE3roG2fOTn1h1LCC6cadV/n51nWUQf/ij4fyBn3zbbZ6DVJqC3eF
         q1zwIcA6BgLRPe+Monfd+MZuneGdETiXG0TwomI717i2yaTrpQ5k7Z+E50k/hrEp9V/m
         68Ej0tlsblvLPj0GlzgtZxitFLE44catnBca1/y331ahbGzf0rPbzXGHmy73hbMdKiMG
         yjYu1kgDY9z6ptZdaoj4Nc8C0imm5eq9qUuDkORi1nbiSDsZjr+cgsCQ6tOppVRRBxbI
         NDrVivpYePU7na8ORZa4smSSSB6xfoO9xR3nzgB3NUTbhxvtGB4l2yOL2ybW9F9puyHi
         EhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iGbgQOCj+oOFbXt9SNh5T326Ohx0VeTB83ysW3crHq4=;
        b=Wv6IVF6OvJlgWPK/ChqjYrvJQ/Iq6D+08Qoch157xqG9QZkDM1xLf8LLbpnMEQNg68
         a82bhpc7Zop8ZHII511B5IQnU+7QtNgUy+T9zKM9pv98+w6lKlhfXj5NZvG10Dcf6dTO
         aMSbrm6FcpLEOUupiIljpWGUJi4YjKfKH3zQGRR9OqujhAde2U8jPX0CDvPX2nlcNdIO
         A8w3DannbZ8G1+tstO1djyzICO968BXOGKNdXKlwAkhxYpO6kPp4EuUaAv0EgZOvk292
         8tqDBisli1UZB/RnvXdB6SPemTpAtEdYG3n38ZHQkMNuf1SULb8PYblYfJz70oBv1ukV
         tldw==
X-Gm-Message-State: AOAM531ft4eU0w71dSt/SiaYmjO4vvNKNgc3aziCZMLlJFLEBiFwfCvm
        GcrYYs0B1GLcQ8Hll59cM61jfA==
X-Google-Smtp-Source: ABdhPJx7xGCImrwIIU5NtCCRc0JJd5vvNjByWn2LVwUmGWeXBpQYu8NjDbna0Iet2lZZ47hjTx5xdg==
X-Received: by 2002:a17:902:aa02:b0:13a:6c8f:407f with SMTP id be2-20020a170902aa0200b0013a6c8f407fmr9745675plb.59.1635071142161;
        Sun, 24 Oct 2021 03:25:42 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id q8sm16587197pfu.167.2021.10.24.03.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 03:25:41 -0700 (PDT)
Date:   Sun, 24 Oct 2021 18:25:30 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv1 4/4] perf: arm_spe: Dynamically switch PID tracing to
 contextidr
Message-ID: <20211024102530.GI213960@leoy-ThinkPad-X240s>
References: <20211021134530.206216-1-leo.yan@linaro.org>
 <20211021134530.206216-5-leo.yan@linaro.org>
 <854fb1a2-e5f1-f237-685f-8ddb0557c98b@arm.com>
 <0a53529a-576c-05b0-4fe5-906195faf243@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a53529a-576c-05b0-4fe5-906195faf243@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, Oct 22, 2021 at 05:23:23PM +0100, James Clark wrote:
> On 22/10/2021 16:36, James Clark wrote:
> > 
> > 
> > On 21/10/2021 14:45, Leo Yan wrote:
> >> Now Arm64 provides API for enabling and disable PID tracing, Arm SPE
> >> driver invokes these functions to dynamically enable it during
> >> profiling when the program runs in root PID name space, and disable PID
> >> tracing when the perf event is stopped.
> >>
> >> Device drivers should not depend on CONFIG_PID_IN_CONTEXTIDR for PID
> >> tracing, so this patch uses the consistent condition for setting bit
> >> EL1_CX for PMSCR.
> > 
> > Hi Leo,
> > 
> > I've been testing this change, but I'm seeing something strange. Not sure
> > if it's a problem on my side or not yet. With this command:
> > 
> >  sudo ./perf record -vvv -e arm_spe//u -- taskset --cpu-list 1 bash -c ls
> > 
> > I'm only seeing 0 values for context:
> > 
> >  sudo ./perf report -D | grep CONTEXT
> > 
> > .  00038dce:  65 00 00 00 00                                  CONTEXT 0x0 el2
> > .  00038e0e:  65 00 00 00 00                                  CONTEXT 0x0 el2

Good catch!  I reproduced this issue at my side and looked into the
flow, the root cause is relevant with timing.

When perf launches the program 'taskset --cpu-list 1 bash -c ls', it
forks a new process and 'ls' program is scheduled in, then function
arm_spe_pmu_start() invokes contextidr_enable() to enable the PID
tracing in contextidr.  Since 'ls' program executes very short and it
simply runs to the end (so in the middle of 'ls' there have no any
context switching on the CPU), there have no any new PID is written
into contextidr and CPU's contextidr keeps zero.  This is the reason
we see the context packets contain zeros for PID.

To fix this issue, we should enable PID tracing when setup AUX ring
buffer, at this phase, the profiled program has not been started yet.
So when the profiled program is scheduled in at the first time, PID
traing is getting ready and we can see the expected context packet in
Arm SPE trace data.   So this patch should be updated as below, I will
apply it in next spin if no objection.

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index c21cf1385cc0..85aa2eab0c2e 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -876,6 +867,13 @@ static void *arm_spe_pmu_setup_aux(struct perf_event *event, void **pages,
        buf->nr_pages   = nr_pages;
        buf->snapshot   = snapshot;

+       /*
+        * Enable tracing PID to contextidr if profiling program runs in
+        * root PID namespace.
+        */
+       if (perfmon_capable() && (task_active_pid_ns(current) == &init_pid_ns))
+               contextidr_enable();
+
        kfree(pglist);
        return buf;

@@ -890,6 +888,9 @@ static void arm_spe_pmu_free_aux(void *aux)
 {
        struct arm_spe_pmu_buf *buf = aux;

+       if (perfmon_capable() && (task_active_pid_ns(current) == &init_pid_ns))
+               contextidr_disable();
+
        vunmap(buf->base);
        kfree(buf);
 }

Thanks a lot for detailed testing!

Leo
