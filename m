Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041EF3BA0DD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhGBNGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhGBNGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:06:22 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5D5C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 06:03:50 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bu19so17946411lfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 06:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Aa/jq9YI+x1KrryZAVhVE7EOEsppjIR0uL1Rz6taMM=;
        b=oc5zdTAaxOMZ069Jm12x2LhhLcTy9yAK+I4qT6kVK62wlNFSXompxgLU7DE13phAjk
         G41xl8nuHAWztfx809kJPUNPA6BPVDyIH5AVR0CnhZYaakq5LA+iG+Yg3ghg3qErEevp
         aODfAFU9en2UCks7eRjUp336caCNsrKTx5tADuaYU8D2L3ePGaYw/dCNYEPadBYHrr59
         KMPVH5p/dsoC1axXFMaiXt412zXXZ77uEcPIPzVWVm3vq9xWLjbSzq51pdphPf4BGbWD
         +fx15VV82sq5sVAZsucs5JU3Jnx9ulZDX80OVwwZyTXbn4/li5bEFLPlSrZbtI0jivVB
         r0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Aa/jq9YI+x1KrryZAVhVE7EOEsppjIR0uL1Rz6taMM=;
        b=gy9hQVbwlkZtU1EgJ40ijL0l02/ZCdGgyiTDteHYljNHkiZFDIN9rW/TJdx3pr/8T+
         qZhTB0xk4cWWUkZceh1oe7qgu/M8sHxnK52Ul/+Mn8wfF5KnYXr8U05a8gN0gAWJCYwv
         enWwj2dbQb79tOijAnc8YBGNf1PbacfeYkC4Lvt/HBuMjmlvoog/jHJC3yqFOazBbV1o
         ZBZdyJOD9rrq/APklR92wmPai/0hP4zs5VzAjYUEsv3muvGPFSjJjeeJNpQ8cg1y4WKT
         ArZ5uECZpP+Jq9dWLivVLvCtKN07ZOIL+KWKQ/5Wa7o0fjTHuLJaAD4DheEoNoQZzfeY
         7Cfw==
X-Gm-Message-State: AOAM530ryd///B4jhu0SBRLIr4JLG/tJQyXFm08oGnmP70OXo/GKbBBd
        Zf/kkREsJl1k5wNGXy9NJzYTJa1GoruLRTVinDY=
X-Google-Smtp-Source: ABdhPJwQc++fHCClEDuSMd1fZcwLFEYwjl8BDOkmt94mM+q6OIOycPWB0ch0v+GFiaTXYpnfWFZYHMLt5x+DfeUVdEI=
X-Received: by 2002:a05:6512:2629:: with SMTP id bt41mr3747956lfb.95.1625231028775;
 Fri, 02 Jul 2021 06:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210630141204.8197-1-xuewen.yan94@gmail.com> <YN70sbUGh2pViWEQ@hirez.programming.kicks-ass.net>
 <20210702115421.gcju2vluhof6rp6f@e107158-lin.cambridge.arm.com> <87wnq87w3q.mognet@arm.com>
In-Reply-To: <87wnq87w3q.mognet@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Fri, 2 Jul 2021 21:03:31 +0800
Message-ID: <CAB8ipk-+BRXg_2=-=NXWr_OEi0rAN4Eo8hHwfOjo_YbkQCvVmg@mail.gmail.com>
Subject: Re: [PATCH v2] sched/uclamp: Avoid getting unreasonable ucalmp value
 when rq is idle
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 8:12 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 02/07/21 12:54, Qais Yousef wrote:
> > sched/uclamp: Ignore max aggregation if rq is idle
> >
> > When a task wakes up on an idle rq, uclamp_rq_util_with() would max
> > aggregate with rq value. But since there is no task enqueued yet, the
> > values are stale based on the last task that was running. When the new
>
> Nit: those values are "intentionally stale" for UCLAMP_MAX, per
>
>   e496187da710 ("sched/uclamp: Enforce last task's UCLAMP_MAX")
>
> for UCLAMP_MIN we'll set uclamp_none(UCLAMP_MIN) == 0 upon dequeueing the
> last runnable task, which DTRT.
>
> > task actually wakes up and enqueued, then the rq uclamp values should
> > reflect that of the newly woken up task effective uclamp values.
> >
> > This is a problem particularly for uclamp_max because it default to
>                     ^^^^^^^^^^^^
> Per the above, it's "only" a problem for UCLAMP_MAX.
>
> > 1024. If a task p with uclamp_max = 512 wakes up, then max aggregation
> > would ignore the capping that should apply when this task is enqueued,
> > which is wrong.
> >
> > Fix that by ignoring max aggregation if the rq is idle since in that
> > case the effective uclamp value of the rq will be the ones of the task
> > that will wake up.
> >

Thanks!
xuewen
