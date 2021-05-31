Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D800395A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 14:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhEaMQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 08:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbhEaMP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 08:15:56 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDFBC061761
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 05:14:15 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id f12so14749941ljp.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 05:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/KWdRrmmQUUdShTYgF7N8YHkQMQeJcSbu2C2nHtMqGU=;
        b=rPbHFz8KHO8hT6NGvD8FDUegbYXzFW7CwBdAcvbOsVMGsFbruuLsU0t+/dIxYqnDg3
         AwU6BmbMSgVEjo10g4ffph+/MI0BxsmOoDQA0pnk5h+h9/NLd+KzdZnWBOdH3Q63JzN3
         qOjA/8KXwvqW03o+DutluDDTXhdFJrXEIY/KaLqieleaWDzq2lvmXjiriY6ta+yWbfkC
         IcfLKu4CUceHw5eiDkF4TEmXrpvgR1VPTkvVyVBOqbrPWuDOzUe32ws9zx+pBma5/mCn
         ygaMt6kRU1AOssL0eA1GxFLLmKh5mEzkxnpj6ZnaWMvBQm+NAWaBMH3lm3urLi+PRuvu
         6pJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/KWdRrmmQUUdShTYgF7N8YHkQMQeJcSbu2C2nHtMqGU=;
        b=P/npxdfZEwesahpXLwgXzOxzgZj/AyrQhy0lZG4pVnmWHnJL7qzx6M3pibn0iDsGCg
         zruiYDLHHNKkF3itRCvJQpA963NPWvKuYv+rKq8xwqBeTFXUbERNbEstkHW8h0+/dvBA
         sqY+AOOr518d6NFoEBAXiRqxwfK38pv81Jcf/s61Sgi530zsV/DJHoLID8VIKvVIP9lc
         RQfzfUspzdeaImsyGGMmGw+BALuN5axjnz7d3i54tSWRgM1Fa8GAkr2l8+BlzAfvOum1
         2yduGrEoREkP6kcsd9p0hbhaMGEVU292P7T+d4AT9QQTaNWr/jyr63EfxqvJs8P4TuIP
         lqZA==
X-Gm-Message-State: AOAM533zsbnIRN5S1i+dk2IPPQhhSEe+JkyxuqCngSnYMe1N1earsvqf
        CWwe7/ZdE9S0jo4ekvT+0hz0ZD+Y9ZKhdAINmTA3IQ==
X-Google-Smtp-Source: ABdhPJyvLD06YGTA0HPbe+GRQR+7zENZnT2n3jtljEwYxE5gwf+uqYntGcOHUJDRFtbAzyvOdfv0nKianVTzIm4WDdc=
X-Received: by 2002:a2e:a7c8:: with SMTP id x8mr16237409ljp.209.1622463253572;
 Mon, 31 May 2021 05:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210518125202.78658-1-odin@uged.al> <20210518125202.78658-3-odin@uged.al>
 <CAKfTPtCiV5LMoXBQVdSsvNq-vurFVVd4aVWW-C=8Tza8uJTCjg@mail.gmail.com>
 <CAFpoUr0x=tgayPWYPORR+-h8gNhiE1t12Ko2o15Y8JwOCLp=yw@mail.gmail.com>
 <CAKfTPtA6AyL2f-KqHXecZrYKmZ9r9mT=Ks6BeNLjV9dfbSZJxQ@mail.gmail.com> <CAFpoUr04ziEzvNBJx0xKSuuEnapGzyABwaM-FU3TUaCZkQ4WPw@mail.gmail.com>
In-Reply-To: <CAFpoUr04ziEzvNBJx0xKSuuEnapGzyABwaM-FU3TUaCZkQ4WPw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 31 May 2021 14:14:02 +0200
Message-ID: <CAKfTPtAwErfdVwdHFULGwbZj5D1axiB-A_AeY49R=aD9p6cezw@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched/fair: Correctly insert cfs_rq's to list on unthrottle
To:     Odin Ugedal <odin@uged.al>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2021 at 11:34, Odin Ugedal <odin@uged.al> wrote:
>
> Hi,
>
> > normally tg_load_avg_contrib should be null when cfs_rq_is_decayed()
>
> Yeah, I think that is an ok assumption of how it _should_ work (given
> the other patches in flight are merged).
>
> > The reason of this list is to ensure that the load of all cfs_rq are
> > periodically updated  as it is then used to share the runtime between
> > groups so we should keep to use the rule whenever possible.
>
> Yeah, right.
>
> > we probably need to keep (cfs_rq->nr_running >= 1) as we can have case
> > where tg_load_avg_contrib is null but a task is enqueued
>
> Yeah, there is probably a chance of enqueuing a task without any load,
> and then a parent gets throttled.
> So (cfs_rq->tg_load_avg_contrib || cfs_rq->nr_running) is probably the
> way to go if we want to avoid
> a new field. Will resend a patch with that instead.

Thanks

>
> In case the new field is the main issue with the original solution, we
> could also change the on_list int to have three modes like; NO, YES,
> THROTTLED/PAUSED, but that would require a bigger rewrite of the other
> logic, so probably outside the scope of this patch.
>
> Thanks
> Odin
