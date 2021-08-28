Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E762A3FA60A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 15:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhH1N1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 09:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhH1N07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 09:26:59 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAAEC061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 06:26:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o10so20587011lfr.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 06:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6uDsCE/I1mz2dgB3p/UOzI+ahRGDoiEn1DEziUtrHT8=;
        b=BU5bZPCoYgUCaamr94UcUImt3GYGfzrPEspvSfdrbVMFjZy7CmnrMWumK0k9MdUCsJ
         t61wahvUqzU5YZSYaX9fV/lfB1eIo4nou26DwjM+5wgluGQVuQmQdpyrvr3IofrvpIL2
         NFm/NcZHHLw+8DdUoVcchQTzfeAWk9sWH0jrVcFsPY9OfrzdYuNlEwiwEaUtfsCmKxHG
         b/cyPtnGzqMy9cZVx9++7PBzMgYM6P7mmrgcX0/ZktTFClCMBsHJFJFlGjHlegwYm7QC
         AMh6YFhSHmV8ch9YrW3F7AyI7HPgGzkfNLgj+YDb9/DiFLT4dOlxaXKypKY45WsjmGxz
         Mrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uDsCE/I1mz2dgB3p/UOzI+ahRGDoiEn1DEziUtrHT8=;
        b=JE4mBtrco4W4rgo+KXLKnOIaqNvj0QRUkmKzdztUKfPruY0wbRqv/ZiSRcJjuakInu
         sYWVtcXNqs6aBd2ZbOKZeamCVgNMwaVwPzi3M3C74bUMfHTltQdj3+nO/QPNxquVmBdr
         RtseNCpqkpWYG1gMan0L8zw0zp6wp5vqI0Whh841mtYENpqBvACPs2a9z1bRbolngI1K
         tCSQUt9Ksjncp6hOKvNquy31BbwF9oMdHgcIxiTWr1CMiN1kfvc86/bomKktJwQSot9A
         hFBNUK1wWYfHZBPF0dWNtBDCPHLCdpuFd9jsT+gSD5d8bj6rRm6yj1Aks+YLFs4eUI0M
         gcmg==
X-Gm-Message-State: AOAM532t5uO1/BC0e8iEQRFOYn13/3x5zqBWHsQMkUR9AJFBnzJk4y3M
        lQAzLk1IMo1MCzCFAxS/WkSiKvxj8R/zQxr6h1Uncw==
X-Google-Smtp-Source: ABdhPJw8SZc3osLOhZt6mPC7SQCpDXLLie8AUFqMpy2Yk/eWnNAswY30dUvGkml3IEACxty3BmpC4uzC4I03PxjMDC4=
X-Received: by 2002:a05:6512:1501:: with SMTP id bq1mr10955598lfb.286.1630157167253;
 Sat, 28 Aug 2021 06:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210810144145.18776-1-ricardo.neri-calderon@linux.intel.com>
 <20210810144145.18776-7-ricardo.neri-calderon@linux.intel.com>
 <CAKfTPtArtmhLG5QYR6TzKevDrEuiQu2HJxm_C3pe549XdGU-1g@mail.gmail.com> <20210827194503.GB14720@ranerica-svr.sc.intel.com>
In-Reply-To: <20210827194503.GB14720@ranerica-svr.sc.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sat, 28 Aug 2021 15:25:56 +0200
Message-ID: <CAKfTPtAKYyy4asSBEcv3=1KWXWvDafrv=A_rh6BR9MgY17WdXA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] sched/fair: Consider SMT in ASYM_PACKING load balance
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2021 at 21:45, Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Fri, Aug 27, 2021 at 12:13:42PM +0200, Vincent Guittot wrote:
> > On Tue, 10 Aug 2021 at 16:41, Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:
> > > @@ -9540,6 +9629,12 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> > >                     nr_running == 1)
> > >                         continue;
> > >
> > > +               /* Make sure we only pull tasks from a CPU of lower priority */
> > > +               if ((env->sd->flags & SD_ASYM_PACKING) &&
> > > +                   sched_asym_prefer(i, env->dst_cpu) &&
> > > +                   nr_running == 1)
> > > +                       continue;
> >
> > This really looks similar to the test above for SD_ASYM_CPUCAPACITY.
> > More generally speaking SD_ASYM_PACKING and SD_ASYM_CPUCAPACITY share
> > a lot of common policy and I wonder if at some point we could not
> > merge their behavior in LB
>
> I would like to confirm with you that you are not expecting this merge
> as part of this series, right?

Merging them will probably need more tests on both x86 and Arm so I
suppose that we could keep them separate for now

Regards,
Vincent

>
> Thanks and BR,
> Ricardo
