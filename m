Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3086E415E97
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241183AbhIWMnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241123AbhIWMnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:43:02 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8B7C061767
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 05:41:18 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 194so21223618qkj.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0GWvNudSvOsNq1z9e3rrCS7rGXQnler1Q9GZARzjsOE=;
        b=UtjhCVmEmMisTpTnxznpACr8MS2kOzLEWDLWLd6Gr1mz5hs8doZbdeapQuugdl8+t1
         ZDp1aSI9O/paJXFybAxY9dg3D7OVG2WKN/3Yj7kAAsSswLDTwgFsQuph65Z9AYdzJ3gH
         X0Rxj4EP7sZXnEOzjpDI7R1cIEodvlqp+fzcCVQS3D2rJ00LHXUm4Lp2iSdnqXuPp5p5
         tWLLWW+RiNEfAHam6JMp7ph77+9LE3UettkIHmtf10Reweu5NknO/pyI6hkoJ4mjqFyR
         p4FkWptSVtP6PBt8BVIc5gRltxZXIUK19G4ljbd3xWYDYuWlrU85pdQVAidQPAWWggpq
         aRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0GWvNudSvOsNq1z9e3rrCS7rGXQnler1Q9GZARzjsOE=;
        b=feZwWe+N83mfWvWn/etDIMck6FbTcHPH7c78MDz3G4FWP9AcJkPc3uC9v4ytu3b240
         7F29lTTLvii3SwkGoWxm2B6WT+7i7qFJg2jSAJdVFK2Js/tTnjTEhi10CPMtQsVXveKU
         P1HGXDYPUq3eT9M9QNY/J4v6fNbOhD8P4+lQ+6IG66io21blQqvmlk7QGYLdlUU8u32z
         gZh6SUuy8hM3bgBaG387Oyyr2mjyoGsd5NTZlORrX6FzdvgIe4m36/Q2LSuJJgXNlYq8
         a9o3T07cXivmw6SJC1+zBMSo/b4lHKhkhOiWNgbUiVTs7FvhQN97IuMYhlqiA3Wl8eh1
         30uQ==
X-Gm-Message-State: AOAM533Pg19HLFQA6BCOw+i1gNAzs1bF1+l6aoMDFeTATE2O7iOvVkzN
        uomTx3XrJn8QZ7TLfkAB6XGyTYXgSM1C27DOw7p5iw==
X-Google-Smtp-Source: ABdhPJz1clN4zz0saOqOV6ZxjyivQ7mrjQVyrJbrxaVvEVpHpFOK2xoFDHdRuoK6rb3QaMLyb+D388UG0ogoGKuNNUM=
X-Received: by 2002:a25:d9c8:: with SMTP id q191mr5537297ybg.61.1632400877314;
 Thu, 23 Sep 2021 05:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-3-mgorman@techsingularity.net> <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
 <20210921103621.GM3959@techsingularity.net> <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
 <20210922132002.GX3959@techsingularity.net> <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
 <20210922150457.GA3959@techsingularity.net> <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
 <20210922173853.GB3959@techsingularity.net> <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
 <ba60262d15891702cae0d59122388c6a18caaf53.camel@gmx.de> <CAKfTPtBBqLghrXrayyoBQQyDqdv6+pdCjiZkmzLaGvdNtN=Aug@mail.gmail.com>
 <50400427070018eff83b0782d2e26c0cc9ff4521.camel@gmx.de>
In-Reply-To: <50400427070018eff83b0782d2e26c0cc9ff4521.camel@gmx.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 23 Sep 2021 14:41:06 +0200
Message-ID: <CAKfTPtDHYtskM7wR0w=fDry+6JJae2_q8Lw7ETcW_gBJ+n4NBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to nr_running
To:     Mike Galbraith <efault@gmx.de>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sept 2021 at 11:22, Mike Galbraith <efault@gmx.de> wrote:
>
> On Thu, 2021-09-23 at 10:40 +0200, Vincent Guittot wrote:
> >
> > a 100us value should even be enough to fix Mel's problem without
> > impacting common wakeup preemption cases.
>
> It'd be nice if it turn out to be something that simple, but color me
> skeptical.  I've tried various preemption throttling schemes, and while

Let's see what the results will show. I tend to agree that this will
not be enough to cover all use cases and I don't see any other way to
cover all cases than getting some inputs from the threads about their
latency fairness which bring us back to some kind of latency niceness
value

> it was trivial to get promising results, my scheme always managed to
> harm something.  Everything I ever tried, I ended up tossing.
>
>         -Mike
