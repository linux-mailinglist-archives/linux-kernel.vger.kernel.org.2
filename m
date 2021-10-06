Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E5D423945
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbhJFIAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237384AbhJFIAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:00:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807E4C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 00:58:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v18so6396421edc.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 00:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XQWQgm5VcZfwx8EzNe7mxtfcL9BKDaqUq1fkeXHfikM=;
        b=go2U0cZ/aA/3NlaoPZZ6FEAxyPlr7Aag5bsPxBltHNCGKtsLteGuw3p0Zm0tpT6nDg
         LVfkjy3shRzmwvTA1cpZYw6dwe2DiZOxoYOjxFL0ahoYDvRMk5bKKx00bQOq/4bk8+5z
         OwVLwtxs/1Cwsb8tqqDuoq4cbU+tHuIDRhNwcXCYIKWvL/NhvK0JKeGIUs3bsFKq+vG3
         DjOXpLRTOMv4lj57RyY/J2DwfZlONcbFfzb9dDYCWXZY1acpXIhuGBd4plNXejMKtpUf
         Zh5hCdzayuLXMmXN5fvMdgRUn+wDH/U/qC0hj85S6xmLCVVnbZljjFGOH68U2iIdcAFS
         jMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XQWQgm5VcZfwx8EzNe7mxtfcL9BKDaqUq1fkeXHfikM=;
        b=Z4kOsBw1bmGfT8LFkWrpC1xt+3Htp3Bxdz0X4LFYoUkc/RzVqoc0JoKEkdSAekE/5H
         H1if8EtUIiK8Pk0epWbPGnd1beqsiDAcMhUOsp6W/Sq4xTPvnYlrlEHlOjIS2FJk3TEs
         s8GYUxXBfS7xLREpM0jyuMHuQjAtSkxaPVMd1586djWlb6L1+gz2gDPUsauRlYjKBhdw
         FkbreyNsGFMFTz4QviCX9HQnwdTEO7j43uM61xzRAS52KLkvJ/K/0xul6Di36s6peGcW
         /Gx8gAgYnFEnJLtRR6rzxIm7MXNiMhnMuoWmaKz2FoBQsUK2wJaCO44IkPjRghkbUqdl
         tq1g==
X-Gm-Message-State: AOAM533bAt7g4zMH38GKeKpACqcW3D0xLRMJOJq0ThuRFqRZwafeaPRG
        tpU+4+9gauM814a0dvxECDgDxYNm7GzKP/PH1d8=
X-Google-Smtp-Source: ABdhPJywczBI9jhEPZFGmv+cCh3Y4y0E1Q5f7f64/ji6b1R1/AHKHuAeI+tOuJbvNj3FJdtxuUAPLUMgj3BjWxJnVlE=
X-Received: by 2002:a50:dacf:: with SMTP id s15mr32715768edj.385.1633507107111;
 Wed, 06 Oct 2021 00:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211004143650.699120-1-tvrtko.ursulin@linux.intel.com>
 <20211004143650.699120-2-tvrtko.ursulin@linux.intel.com> <562d45e1-4a27-3252-f615-3ab1ef531f2b@huawei.com>
In-Reply-To: <562d45e1-4a27-3252-f615-3ab1ef531f2b@huawei.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 6 Oct 2021 20:58:15 +1300
Message-ID: <CAGsJ_4w5Y4=v93YmTrXJ6hDgjKshxiAZ-ox-Nz_7uRwe4ECtdw@mail.gmail.com>
Subject: Re: [RFC 1/8] sched: Add nice value change notifier
To:     "Wanghui (John)" <john.wanghui@huawei.com>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 5:15 PM Wanghui (John) <john.wanghui@huawei.com> wro=
te:
>
> HI Tvrtko
>
> On 2021/10/4 22:36, Tvrtko Ursulin wrote:
> >   void set_user_nice(struct task_struct *p, long nice)
> >   {
> >       bool queued, running;
> > -     int old_prio;
> > +     int old_prio, ret;
> >       struct rq_flags rf;
> >       struct rq *rq;
> >
> > @@ -6915,6 +6947,9 @@ void set_user_nice(struct task_struct *p, long ni=
ce)
> >
> >   out_unlock:
> >       task_rq_unlock(rq, p, &rf);
> > +
> > +     ret =3D atomic_notifier_call_chain(&user_nice_notifier_list, nice=
, p);
> > +     WARN_ON_ONCE(ret !=3D NOTIFY_DONE);
> >   }
> How about adding a new "io_nice" to task_struct=EF=BC=8Cand move the call=
 chain to
> sched_setattr/getattr, there are two benefits:

We already have an ionice for block io scheduler. hardly can this new io_ni=
ce
be generic to all I/O. it seems the patchset is trying to link
process' nice with
GPU's scheduler, to some extent, it makes more senses than having a
common ionice because we have a lot of IO devices in the systems, we don't
know which I/O the ionice of task_struct should be applied to.

Maybe we could have an ionice dedicated for GPU just like ionice for CFQ
of bio/request scheduler.

>
> 1. Decoupled with fair scheduelr. In our use case, high priority tasks of=
ten
>     use rt scheduler.

Is it possible to tell GPU RT as we are telling them CFS nice?

> 2. The range of value don't need to be bound to -20~19 or 0~139
>

could build a mapping between the priorities of process and GPU. It seems
not a big deal.

Thanks
barry
