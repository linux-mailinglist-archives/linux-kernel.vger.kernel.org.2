Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BB94361FB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 14:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhJUMod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 08:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhJUMob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:44:31 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD51C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:42:15 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id y10so1050256qkp.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BiQuOAgT8bf0Gqc3SNvxUfomKy6p8NVPFxxm4Pd9on4=;
        b=fHIDggIX6AoIzwFryDzDFpdpk6ZM6gEKJ0WjsCdKKXFXm0b9XZRjEUibd19RuNDtiQ
         YoghFveEtWMRIbcBHMkZs4sRPxTLngeHpGzB1gO1eRs/mAHvIQcPPYwZdf2gIEXuV/ap
         RTcnLNBHrhMBxOilJX8Usvzja0PCLIt1YoaktLCDRviJi2dorm25/e6AzbIVhx81jzC8
         hRuN2lNjhBhPX7xt4fp/kzb+27UO9pmRT6HmrMiAz8J1v0H/pRfsrFtBh9f55wogrlr4
         Oie1MXwZLWzZ57JNOf6Mk3a+kodz3BDCZnMaOTDNcQeJB9yYM0ohtC2uOy7qgYhbtrNq
         A6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BiQuOAgT8bf0Gqc3SNvxUfomKy6p8NVPFxxm4Pd9on4=;
        b=xPLOritUZnmxmyN0Ut8etQpwu8vx7uLgRVn1gGbA04Lf9PQ0F4wCBH6jaGlF3F7B2J
         e1vh6i2buwb5yfoStqKIaFmrcRCVk7Zs08VECzj5V9nd55Ib5mCSYXUHGl9oRNx2f2Zx
         cHRMFCwchi91lrgEKc1o3oQaFzZoBWash35dltPacQKERSWX+xL6NP+qWWUsO3dXzWAp
         hmtv1F7zMhg7JU/nD6wvbzKMpZ9RRCCFOk6PCApQkPRhGPoyXQM3ia/lDbeHvGdutUbi
         zwGUefzza7Qcmfe4ZmNHk3U7b1U2AZysnEqL8A37M/tLSF0/Ug8MHa1RgsZf5me9WXkq
         z46A==
X-Gm-Message-State: AOAM533eOG8AeS8ll/ZhfzJ3LBF9W/q3nE3V5ay7YNi7SWQCLNhxwLqP
        5eZctcFeGLuAcjxBiHVJU9pIW+xvy04tKJQTZV0iNhOvmfY=
X-Google-Smtp-Source: ABdhPJybXXEDfTU/yQ7WoXn8fXgWo8ZU2WpVitExz9LlBRi+hW0lh5lG1EsC755vFgrALvQkoLYDoY3wze+qY0RI46s=
X-Received: by 2002:a25:73c5:: with SMTP id o188mr5845471ybc.61.1634820135059;
 Thu, 21 Oct 2021 05:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211019123537.17146-1-vincent.guittot@linaro.org> <20211021095219.GG3891@suse.de>
In-Reply-To: <20211021095219.GG3891@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 21 Oct 2021 14:42:03 +0200
Message-ID: <CAKfTPtAHoC6DLP1b4=Xc9=RO6m83uYFhNtCsa_Bp8x4a266DCA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Improve newidle lb cost tracking and early abort
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 at 11:52, Mel Gorman <mgorman@suse.de> wrote:
>
> On Tue, Oct 19, 2021 at 02:35:32PM +0200, Vincent Guittot wrote:
> > This patchset updates newidle lb cost tracking and early abort:
> >
> > The time spent running update_blocked_averages is now accounted in the 1st
> > sched_domain level. This time can be significant and move the cost of
> > newidle lb above the avg_idle time.
> >
> > The decay of max_newidle_lb_cost is modified to start only when the field
> > has not been updated for a while. Recent update will not be decayed
> > immediatlybut only after a while.
> >
> > The condition of an avg_idle lower than sysctl_sched_migration_cost has
> > been removed as the 500us value is quite large and prevent opportunity to
> > pull task on the newly idle CPU for at least 1st domain levels.
> >
> > Monitoring sd->max_newidle_lb_cost on cpu0 of a Arm64 system
> > THX2 (2 nodes * 28 cores * 4 cpus) during the benchmarks gives the
> > following results:
> >        min    avg   max
> > SMT:   1us   33us  273us - this one includes the update of blocked load
> > MC:    7us   49us  398us
> > NUMA: 10us   45us  158us
> >
> >
> > Some results for hackbench -l $LOOPS -g $group :
> > group      tip/sched/core     + this patchset
> > 1           15.189(+/- 2%)       14.987(+/- 2%)  +1%
> > 4            4.336(+/- 3%)        4.322(+/- 5%)  +0%
> > 16           3.654(+/- 1%)        2.922(+/- 3%) +20%
> > 32           3.209(+/- 1%)        2.919(+/- 3%)  +9%
> > 64           2.965(+/- 1%)        2.826(+/- 1%)  +4%
> > 128          2.954(+/- 1%)        2.993(+/- 8%)  -1%
> > 256          2.951(+/- 1%)        2.894(+/- 1%)  +2%
> >
>
> I read the patches earlier but had queued tests and waiting on the results
> before Acking. The hackbench results were not bad, not a universal win,
> but wins more than it loses with small decreaseds in system CPU usage.

Thanks for running tests

>
> Most other results showed small gains or losses, nothing overly dramatic
> and mostly within the noise.
>
> --
> Mel Gorman
> SUSE Labs
