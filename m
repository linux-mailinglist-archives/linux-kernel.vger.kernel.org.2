Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256634205DD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 08:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbhJDG2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 02:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhJDG2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 02:28:33 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E324C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 23:26:45 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id u7so13569453pfg.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 23:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lldwxdk4W1G3ywdj9msOYMypt5nPXO6LwPIxOMZiJgk=;
        b=raZ1JvI9opcJPgs8LXMlbhlqCAFgxPZ8zzJ2jEYWBsC6RkkXnNRMk00fh/m1ma9WAa
         9y+DH469cv9USNSMLUSxn9bqi0Wt5Wc9jNfnC87joGL+sVXYk65k7ReWKs9xUi2+aerp
         ODQoygniZ4/xEMjFwLo3IKhAVcsOKf8X7Q/Shl/lleinwKze6a14VKYwv5guT67/159E
         4bJfhtxot7jKDuexro9M7EpavYgz9lnwN/1Jw4SNT1y0evXvBATF8PcbDmi6ApSec9sr
         CXp54+iTSv3pZ1MIOgOPMOZd9qL98cr0Rp8yGUc3y7yl73cCaWdhDDcvkqrQC0sgcQZF
         Cr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lldwxdk4W1G3ywdj9msOYMypt5nPXO6LwPIxOMZiJgk=;
        b=PHaC2tg6VMPg75Licvn1rAd4g3dQJ9hb8DItHib+Ak9a2UzBBBAGjllwCXmrYtiSyO
         kTMCb6qCT7CFlardBce402sy5EWhpARgVXJhkBuILs67617W1UCqCntQurpyTwPHHAG7
         n7MttqLoFNEl1vZkb9/xXxBMB/msQTDjGDXFtOJz3SztYYCniPOopZDg0nV4s9+m6n7N
         70oeiYV+N3Umsl5Gy3y7AyRp9v2GlbmNI0IYrbkP0GJ7CCw7ZHz6SNjtul2W5fknDxxA
         rVXh3cX+e5kyEhxIOIrdFyUsiFSYimv27aBCsPXhk6VTvman/ITYzOIv5irD8SMTV/eD
         neug==
X-Gm-Message-State: AOAM5313wR04vQoC/F3VSp8VotLXZHHRfhi6hA9l75y3dgyG9fHby/6t
        yAdBiIdKrUgrSIzk3IntqrKifw==
X-Google-Smtp-Source: ABdhPJxcg4Fq/d465AxP95ZTo/FTkvMJ0NGcXsZ3jm/rVY++k8s2enNOL/MTAmgZ5faGDq3QQQiJaA==
X-Received: by 2002:a65:404d:: with SMTP id h13mr9514277pgp.130.1633328804244;
        Sun, 03 Oct 2021 23:26:44 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.181.210])
        by smtp.gmail.com with ESMTPSA id g8sm13237805pfv.51.2021.10.03.23.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 23:26:43 -0700 (PDT)
Date:   Mon, 4 Oct 2021 14:26:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>, german.gomez@arm.com
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
Message-ID: <20211004062638.GB174271@leoy-ThinkPad-X240s>
References: <20210916001748.1525291-1-namhyung@kernel.org>
 <20210916135418.GA383600@leoy-ThinkPad-X240s>
 <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com>
 <20210923142305.GA603008@leoy-ThinkPad-X240s>
 <363c4107-fc6f-51d0-94d8-a3f579c8f5a2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363c4107-fc6f-51d0-94d8-a3f579c8f5a2@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thu, Sep 30, 2021 at 04:08:52PM +0100, James Clark wrote:
> On 23/09/2021 15:23, Leo Yan wrote:
> > On Thu, Sep 16, 2021 at 02:01:21PM -0700, Namhyung Kim wrote:

[...]

> >>> We also considered to use PERF_RECORD_SWITCH_CPU_WIDE event for setting
> >>> pid/tid, the Intel PT implementation uses two things to set sample's
> >>> pid/tid: one is PERF_RECORD_SWITCH_CPU_WIDE event and another is to detect
> >>> the branch instruction is the symbol "__switch_to".  Since the trace
> >>> event PERF_RECORD_SWITCH_CPU_WIDE is coarse, so it only uses the new
> >>> pid/tid after the branch instruction for "__switch_to".  Arm SPE is
> >>> 'statistical', thus it cannot promise the trace data must contain the
> >>> branch instruction for "__switch_to", please see details [2].
> >>
> >> I can see the need in the Intel PT as it needs to trace all (branch)
> >> instructions, but is it really needed for ARM SPE too?
> >> Maybe I am missing something, but it seems enough to have a
> >> coarse-grained context switch for sampling events..
> > 
> > The issue is that the coarse-grained context switch if introduces any
> > inaccuracy in the reported result.  If we can run some workloads and
> > prove the coarse-grained context switch doesn't cause significant bias,
> > it will be great and can give us the confidence for this approach.
> 
> It sounds like it's worth testing. Do you think the inaccuracy would only
> apply to code in the kernel around the time of the switch? Or do you think
> it could affect userspace as well?

The inaccuracy should only apply to the kernel code.  There would be
some samples will be wrongly accounted for the next task between the
function prepare_task_switch() and switch_to().

> It seems to me that the switch event
> would have a timestamp that would precede _all_ userspace code, but I'm not
> 100% sure on that.

Yes, the switch event is generated in the scheduler which precede
exiting to userspace:

  __schedule()
    `> context_switch()
         `> prepare_task_switch()
              `> perf_event_task_sched_out()

> I suppose it's easy to test.

I'd like to use the comparison method for the test:
We should enable PID tracing and capture in the perf.data, when decode
the trace data, we can based on context packet and based on the switch
events to generate out two results, so we can check how the difference
between these results.

> German Gomez actually starting looking into the switch events for SPE at the
> same time, so I've CCd him and maybe he can do some testing of the patch.

Cool!  German is welcome to continue the related work; since I am in
holiday this week, I will try this as well, if I have any conclusion
will get back to you guys.

If the test result shows good enough, I personally think we need finish
below items:

- Enable PID tracing and decode with context packets;
- Provide interface to user space so perf tool knows if should use
  hardware PID or rollback to context switch events;
- Merge Namhyung's patch for using switch events for samples.

Thanks,
Leo
