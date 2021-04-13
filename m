Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBCA35DE27
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 14:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbhDMMBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240873AbhDMMBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:01:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322BBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 05:00:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id v140so26930038lfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 05:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0GnFL9OvVqSzFnctvfhGyk13QLE8bBC7HQ1OMcc74s=;
        b=flvEdbD+XPAPAnT/pYuVolYcFe5r9RMXwV4zGrsrJ07+j566bIakCbdwgRY4l8s/EN
         guk4QmyCpsq1jOJos9WUVcG8tzPw2tNcGMW+J9OXwbQBHhVRQeRF6jt51FlkAu3FFRqs
         6dTYh8lwUcB/A+EvfxVN+QB24lZEopm+hhKVTiRtggrjo5T1CztCT5xrQT5i7qxy5+fn
         j+TsLW0V51dDo+XaKAM+VuPpVkhwHdmHbsLM+GCnN6BSdxUAnknfpVm2C1blmfSdmOvr
         p8Hj6v2MXIwzZtR1WHMZ0+oRrHuv3Yr7TuombuEx85etIGAlJtq2WURnjqUWE5lHAy0t
         PIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0GnFL9OvVqSzFnctvfhGyk13QLE8bBC7HQ1OMcc74s=;
        b=G1jKr/d9j1O/kKdYe51OhoL4+RJcpDZboF4OoGj0YRbuN0Vlbqni1bz1sMb7d9hsTJ
         cC4iPyzwfXgvQ0kvyyULiqgLkl7s6xkjxq1QUHYRAIGxfWyaqGEnLsOdF21/zS4Kt/Ew
         S0hXnZZ/4ZBxT2c55Vsw9rD9sJgcjdgCGBhec+rNKCD3VcylK1fDB087CKT9+mxHzd1h
         PihJm9Rfg52h/uDWNIJwmNloN7z9oOV3MJN0CGNJSaX0sXpfJQBrKWkY+NTrq+2tUlJ7
         gwIqXfMrR60rRJWuSrmokLikDPVvGkF8HyrcZstNNTn+2wlWUayOMLdyIlyYIVqdyb7A
         ejUw==
X-Gm-Message-State: AOAM530TCv3IGYFSIrLA37o9CAvzhtJn+fpPkGAmkg46qcJbwaOrFMtQ
        nlBll/FGN/ENcwVoQl1c4ZWt6whHpiW+u4PrnZw=
X-Google-Smtp-Source: ABdhPJzQWvlR+hBlFdOfAJAeT1Gwtd8eb+vV7nwXlHHVTPJTD5QJed+Ug+CXtuUprbyopZ//pX45gFH8xPJt2/eHcvQ=
X-Received: by 2002:a19:6a17:: with SMTP id u23mr16876955lfu.95.1618315238390;
 Tue, 13 Apr 2021 05:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210330052154.26861-1-xuewen.yan94@gmail.com>
 <YGLzQAvVqlrKb8AB@google.com> <34ce11ad-9c20-7ba7-90d8-4830725bf38a@arm.com>
 <CAB8ipk9JATYxJBnpVFfH_XHLqh=yHesbo73wx=Mm7t8mSqW_Gg@mail.gmail.com>
 <1ebddd33-4666-1e6e-7788-a3fe28c9e99c@arm.com> <CAB8ipk9+fdGMY6cYoHnicPUOdd+meJo+EaGaaVZTgoxQ84+Wiw@mail.gmail.com>
 <d85a1db9-4680-1d31-d3e7-6a081f652c5e@arm.com> <CAB8ipk_J-W35+iZqsmAm+VO2=OUXRR3EsW6BuhYmvmBiPcHxMA@mail.gmail.com>
 <d80b7b3e-7eb3-4d0a-99fd-167e14ab86bc@arm.com> <CAB8ipk8RhhBvRq3jUnP2ENfSG_L=LonnVfweymYkQJrZQyA9jQ@mail.gmail.com>
 <b4631807-9b10-ce11-c206-ba347980f771@arm.com> <CAB8ipk_vgtg5d1obH36BYfNLZosbwr2k_U3xnAD4=H5uZt_M_g@mail.gmail.com>
 <d017749a-697e-9cda-4940-df4cdbdd3a55@arm.com>
In-Reply-To: <d017749a-697e-9cda-4940-df4cdbdd3a55@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 13 Apr 2021 19:59:26 +0800
Message-ID: <CAB8ipk-qe0sWQ97afgaZ_kg5675TBafUgOT4tkf4NT-yvhSh2Q@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: use signed long when compute energy delta in eas
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
> > >
> > > In fair.c:select_task_rq_fair(), if feec() returns a error (< 0), then
> > > prev_cpu is selected. I think it's better to still let feec() signal
> > > that something happened and let select_task_rq_fair() select prev_cpu by
> > > itself.
> > In fair.c:select_task_rq_fair(), when feec() returns a error (< 0),
> > the new_cpu = find_idlest_cpu() or select_idle_sibling().
> > In your patch, you should return prev_cpu instead of -1 if you want to
> > select the prev_cpu.
> Having a negative delta doesn't imply that prev_cpu is still available.
> E.g.: If prev_cpu cannot receive the task (and is skipped), and a
> negative delta appears when evaluating the other CPUs. In such case
> feec() cannot select prev_cpu. dst_cpu must be selected by another function.
In this case, would it be better to add a condition "prev_delta == ULONG_MAX" ?
Returnig(-1)  could avoid the negative delta, but I still think this
is not the fundamental way to solve the problem.
But I think you can send a V2 with the bail out mechanism.

Regards
