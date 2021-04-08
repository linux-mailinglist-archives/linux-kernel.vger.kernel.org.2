Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613AE357BEC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 07:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhDHFnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 01:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhDHFnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 01:43:09 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5BDC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 22:42:57 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id c6so789036lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 22:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WAbHD5FLaaImjGxxXZNniR8HkY+ORAvhOIs7PHZqNLk=;
        b=Cw5mlMMpJ+/GY97BE2TxX6SQyUpuRnqetJyQSONYQsvtcWHLoLF7tEkT1vp2Pwm9mu
         Rv87xjwrYSK9LA7H+VWDMNhQ+Jk2SXT+zb+WSc3QzWehwvBulvKlhxuVuoLFGYKWsWRL
         V47Y6hhSYPfHOvWJ+HheFQ7T4crHxnsCaBUGl+O6xbdpK59UDkpIMh1b0IhtUP0MWNoY
         GwdXcVB1yN+/IMXgfrhIRKTCNVFEBW4KB4KWwWoiYGaeHs+PT+Tqm22dDK3alz95A1c0
         6WrHo3NHVjAleRbFeit5b3NgBP0UFcRXObCBBgoJqj2fuAEzoQQE2p4UXuw3XLJfrMus
         nT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WAbHD5FLaaImjGxxXZNniR8HkY+ORAvhOIs7PHZqNLk=;
        b=l2HxECXoAjDa0YtAfhYYdQI5BqIUJeuWsgIy047XJiVKH3DWiF2HRvFpfFZvHLMq6x
         eAKAPfMNeg+Dp75Zgh4HN3bbIe1h2eqcJkN/2id9UGweLqPk38Sqoa0c95/anzRh5zJ8
         5NxwpLD4O0cYa8VQ1XCHjdYZiw2C7i6y3FJcUYrhFR4B322dIwzA0Q0wsLml7oBkwC09
         RQMfaiVbRSgA0Ot57RO+oNbIrWzs0K62tcWjfBicOXY9uGGhNF9xkkpbQY6Aohnr2Zfo
         4sv4I//f3cwte1GAeHEeObPST1FJBJwXb+f061s5nxyURx+i735pqrrDXxr+Rh+mKwxM
         IcpQ==
X-Gm-Message-State: AOAM532rdn8NiV1FIlLuQWEu8xta7QZRQ8MvKNquygzsVPTOJmNL6aox
        DQB39TsrPAHTEIYhpi43roDS2BSv1hDwsfpmGkM=
X-Google-Smtp-Source: ABdhPJw5egDHQEVfBkzJoq+dVf4KUFxlnAe9nJsBc3TAki5FfDnDXQP3ZaUZBqoeiMyDQWIdBA1gG14xEbf++TwrRDA=
X-Received: by 2002:a2e:5747:: with SMTP id r7mr4423864ljd.227.1617860575808;
 Wed, 07 Apr 2021 22:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210330052154.26861-1-xuewen.yan94@gmail.com>
 <YGLzQAvVqlrKb8AB@google.com> <34ce11ad-9c20-7ba7-90d8-4830725bf38a@arm.com>
 <CAB8ipk9JATYxJBnpVFfH_XHLqh=yHesbo73wx=Mm7t8mSqW_Gg@mail.gmail.com> <1ebddd33-4666-1e6e-7788-a3fe28c9e99c@arm.com>
In-Reply-To: <1ebddd33-4666-1e6e-7788-a3fe28c9e99c@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Thu, 8 Apr 2021 13:41:47 +0800
Message-ID: <CAB8ipk9+fdGMY6cYoHnicPUOdd+meJo+EaGaaVZTgoxQ84+Wiw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: use signed long when compute energy delta in eas
To:     Pierre <pierre.gondois@arm.com>
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

On Wed, Apr 7, 2021 at 10:11 PM Pierre <pierre.gondois@arm.com> wrote:
>
> Hi,
> > I test the patch, but the overflow still exists.
> > In the "sched/fair: Use pd_cache to speed up find_energy_efficient_cpu()"
> > I wonder why recompute the cpu util when cpu==dst_cpu in compute_energy(),
> > when the dst_cpu's util change, it also would cause the overflow.
>
> The patches aim to cache the energy values for the CPUs whose
> utilization is not modified (so we don't have to compute it multiple
> times). The values cached are the 'base values' of the CPUs, i.e. when
> the task is not placed on the CPU. When (cpu==dst_cpu) in
> compute_energy(), it means the energy values need to be updated instead
> of using the cached ones.
>
well, is it better to use the task_util(p) + cache values ? but in
this case, the cache
values may need more parameters.

> You are right, there is still a possibility to have a negative delta
> with the patches at:
> https://gitlab.arm.com/linux-arm/linux-power/-/commits/eas/next/integration-20210129
> Adding a check before subtracting the values, and bailing out in such
> case would avoid this, such as at:
> https://gitlab.arm.com/linux-arm/linux-pg/-/commits/feec_bail_out/
>
In your patch, you bail out the case by "go to fail", that means you
don't use eas in such
case. However, in the actual scene, the case often occurr when select
cpu for small task.
As a result, the small task would not select cpu according to the eas,
it may affect
power consumption?

> I think a similar modification should be done in your patch. Even though
> this is a good idea to group the calls to compute_energy() to reduce the
> chances of having updates of utilization values in between the
> compute_energy() calls,
> there is still a chance to have updates. I think it happened when I
> applied your patch.
>
> About changing the delta(s) from 'unsigned long' to 'long', I am not
> sure of the meaning of having a negative delta. I thing it would be
> better to check and fail before it happens instead.
>
> Regards
>
