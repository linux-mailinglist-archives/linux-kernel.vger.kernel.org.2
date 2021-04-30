Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCB736FBFF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhD3OSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhD3OR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:17:59 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5067DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:17:11 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x19so80010172lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tnW3u+GigqDOcp1lhiXKBs3xNXaI55kZNeSkREJXf/k=;
        b=nQ/HlXRmGNwviRvr5FIrQM0OXGyOrjQ6CpWosdjYQs9ErMpgniG3YEPgEVIMgwJekQ
         r11KThVKnIC+TTb1zP6yePlQxV0cq4FFyZ+kmkJwNBnmivIY/QO8iFZnXx7SfjJRV/tc
         7Hk+p0gPXQIQL2VO7MxD+Zxb0hqZxYFNvuL5tvg1T7vBM6eR/SnuZQvjRMFM/djtCDu/
         A7z4pltuMTNgRTcbihUIbfxUHNEUmV9CKNd+0l1GR2olem99C1QPlpjxcdP63WYLQ5hh
         Q7dslKcxUVC33T2NjY2/eYY/xgg2rLxNKHPNUTr7Hoe48NYgv54kKVNxjy4cvRF0Z9K5
         BXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tnW3u+GigqDOcp1lhiXKBs3xNXaI55kZNeSkREJXf/k=;
        b=klkVCzcpopt2n4lsaixgrilwDDiIXzFLkI6CvUu+RkuCoTIXCLDA4l4OzZ5EcOPCY8
         3dYWq0UMiB0ojltkHHfrQFKe38bD7Qyu82ml8eroVUXHrNdywo/KMisoZZS/KahoH6wc
         f8oV2+zLaK2wG3XL/MFPCP+yQ56V54ZMbHdmrhYN6wU9bZ6qDe7WS7P5Bj2Azh7Db1Rd
         V6k/C2fI7oNANvZXOaqKeM/4f0FQ+39QhUiNg3O9uhczCVtIvUJGaNsTwAbMHFbp7JsC
         ic/XPnXJp1Fza1Lqcc+yqmDEtosg4FyIZdSJo7rO1FZd0hKi+LMMyvKkTa5qK6t9r6nh
         kyNA==
X-Gm-Message-State: AOAM530zSAOLLTRCpTwseb6zn83XpAiMWM1Tqh9WImLq8wkCimEkSKjz
        S7zTm1Fmu6M5ANbJeWDPSF2O/agLpujsWf728hNWkg==
X-Google-Smtp-Source: ABdhPJx8XkbRtpZFopR+Qo3KBAu/dnuW6yrEkP/BEqQsbl3FvN2CLjq7YbaUPEsLka7jwYh+AOxwThbJQKmPNdaGOwY=
X-Received: by 2002:ac2:4f03:: with SMTP id k3mr3443750lfr.254.1619792229818;
 Fri, 30 Apr 2021 07:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210429152656.4118460-1-qperret@google.com> <CAKfTPtAfgVnMYkY_M+SDmNQDb_EsxSctQw-fkt2WJhczZakOjQ@mail.gmail.com>
 <YIu/EjZ8QsEl9sum@google.com> <CAKfTPtDOuB0UzZM5OtNzCUABftz_A40Z4W1z9OAORzFitfPDEQ@mail.gmail.com>
 <YIvQoG52Vk96DJQ/@google.com> <CAKfTPtB-0N7ogk0snCgj78zDrXRWgFUL=G7MoRDn+Bg8Hnk-PQ@mail.gmail.com>
 <b6737247-ca02-e197-70c7-020952d95c1b@arm.com> <YIwCvkfrPGkyk17d@google.com>
In-Reply-To: <YIwCvkfrPGkyk17d@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 30 Apr 2021 16:16:58 +0200
Message-ID: <CAKfTPtBNsarv7REyNFeU5e=-K6OiaR2hxPFm6Ttca5UcnWB6Wg@mail.gmail.com>
Subject: Re: [PATCH v2] sched: Fix out-of-bound access in uclamp
To:     Quentin Perret <qperret@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2021 at 15:14, Quentin Perret <qperret@google.com> wrote:
>
> On Friday 30 Apr 2021 at 15:00:00 (+0200), Dietmar Eggemann wrote:
> > On 30/04/2021 14:03, Vincent Guittot wrote:
> > IMHO, this asks for
> >
> > min_t(unsigned int, clamp_value/UCLAMP_BUCKET_DELTA, UCLAMP_BUCKETS-1);
>
> Yep, that's what I have locally.
>
> > >>  }
> > >>
> > >>  static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
> >
> > Looks like this will fix a lot of possible configs:
> >
> > nbr buckets 1-4, 7-8, 10-12, 14-17, *20*, 26, 29-32 ...
> >
> > We would still introduce larger last buckets, right?
>
> Indeed. The only better alternative I could see was to 'spread' the
> error accross multiple buckets (e.g. make the last few buckets a bit
> bigger instead of having all of it accumulated on the last one), but not
> sure it is worth the overhead.

I don't think it's worth the overhead.

>
> Suggestions are welcome though.
>
> > Examples:
> >
> > nbr_buckets   delta   last bucket size
> >
> > 20            51       +5 = 56
> >
> > 26            39      +10 = 49
> >
> > 29            35       +9 = 44
>
> Yes the error can become worse in the relative sense with a large number
> of buckets, but again the max is 20 so we should be fine?
>
> Thanks,
> Quentin
