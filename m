Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690223F6D79
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 04:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbhHYCoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 22:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbhHYCow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 22:44:52 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD1DC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 19:44:07 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so43195040otg.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 19:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SxC1+YhfNm3L+87e5dL6LciurChnpO9y5/7AeLBJ6Yg=;
        b=SHMH4CZkEaQGscoY3Q5gncthJNAp99J/t2p992voK8qZ7mrp4aNHVhXV3rFxFGuPOp
         XDtXilswms9fF5NyT1ZDTdniAeBC4PUOY4UvZb3JpTZ3Y/kUf3I4nB39ptJUwJIr9jCF
         Rn1m3ZJfwMGvk1ukIyTsceHCXn6jLTLJLpBhsFXQJs1HHLyrLdgEO17KL/MDHvO+kwgd
         Yk2B+/90B4kk05mmLKRF72pOJ1r+ksXgUGOdxK/Ow+JJFDiGWGGTmzDv/BsgzK2xL6oZ
         Jw3IzkfA6UkAuf3MfVrFAvH3F/Ap/XNLVkMOxDmDGdFujME4rUPgxSz60fvgpLfDY4Ih
         RcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SxC1+YhfNm3L+87e5dL6LciurChnpO9y5/7AeLBJ6Yg=;
        b=dnkLzTZm9GDKtuimvT3p83vlQt3OYxxYd9GmV83Ke/XYEzdhjWEBnjoasB4fHcdXHw
         2XYtvl6/ItFj0c/Sh4pkJlqhCKAmxbMl02p0d5xXbEOnwdSytdeeUvIarfHX8jZ3VoV3
         vCZ6Yk+IO4D+rRBMfH7zYJOg7XAASDkv/krnhy2fq15148+E6XqOX3T9V9CzYPt2IJyI
         U8aRSoB4WyDQDob7ylEYhxESCxXSmXgSlBkLIK5/h0YD4wP9XvCN+vMMsDw7ZvePSaQi
         ArzKWBg8xZzSLdV8AgQtMXj/stmPOmv26bih1aNO/KyKD8JA/OgON12jhSDVf5Nqee8z
         GZmQ==
X-Gm-Message-State: AOAM5338DY01xpu1XgymKyNzOk2HGelwgnLQ/haSCZcJiBq90cYgN11q
        iRDYgn7OFBnRsbGXQ+m9F3/AsZ0xUxCgvZFxcjY=
X-Google-Smtp-Source: ABdhPJxjwKNG6k3PeFCQehMoFGPebKgDKNZ6m7919vUwQ4+LIRGKuHwpChC1hKOS51Skd/F574ioZ21Rjt0G9oOlqSo=
X-Received: by 2002:a05:6830:1f55:: with SMTP id u21mr34984801oth.4.1629859447082;
 Tue, 24 Aug 2021 19:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210820010403.946838-1-joshdon@google.com> <20210820010403.946838-4-joshdon@google.com>
 <CAPJCdBm1vkbkK_0WqYTpw7dCWbW2dkE=ygTu5UxyHvwCRpUAJQ@mail.gmail.com> <CABk29NtVaUehs2gChfFPJmjxzbTn0eM49ivHr=a9F2+X20vAtg@mail.gmail.com>
In-Reply-To: <CABk29NtVaUehs2gChfFPJmjxzbTn0eM49ivHr=a9F2+X20vAtg@mail.gmail.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Wed, 25 Aug 2021 10:43:56 +0800
Message-ID: <CAPJCdBk-8vjg6GtGx3ft3KoyeeXvovxF53kwE7vJGY2eTYOwyg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] sched: reduce sched slice for SCHED_IDLE entities
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021 at 01:04, Josh Don <joshdon@google.com> wrote:
>
> Hi Jiang,
>
> On Tue, Aug 24, 2021 at 3:25 AM Jiang Biao <benbjiang@gmail.com> wrote:
> >
> > Why not just ignore min granularity when normal entities compete with
> > a SCHED_IDLE entity? something like this,
> >
> > @@ -697,8 +710,14 @@ static u64 sched_slice(struct cfs_rq *cfs_rq,
> > struct sched_entity *se)
> >                  slice = __calc_delta(slice, se->load.weight, load);
> >          }
> >
> >  -       if (sched_feat(BASE_SLICE))
> >  -               slice = max(slice, (u64)sysctl_sched_min_granularity);
> >  +       if (sched_feat(BASE_SLICE)
> >  +          && (!se_is_idle(init_se) || sched_idle_cfs_rq(cfs_rq)))
> >  +               slice = max(slice, (u64)sysctl_sched_min_granularity);
> >
> >          return slice;
> >   }
> > If so, there seems no need to introduce sysctl_sched_idle_min_granularity? :)
>
> Ignoring min_gran entirely could lead to some really tiny slices; see
> discussion at https://lkml.org/lkml/2021/8/12/651.
Got it, tiny slices could be a problem in SCHED_HRTICK case.
But the sysctl_sched_idle_min_granularity used in sched_slice() and
sysctl_sched_min_granularity used in check_preempt_tick would have
different semantics for SCHED_IDLE task, which could be functional ok
but a little confusing.

Regards,
Jiang
