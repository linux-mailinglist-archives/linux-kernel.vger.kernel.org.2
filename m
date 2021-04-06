Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24143558EF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346300AbhDFQNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244267AbhDFQNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:13:31 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FBDC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 09:13:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u10so17142633lju.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 09:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WkHVrRJ8zLqwntW1swcQ+u0WQTIpa1PHnxqat0womr4=;
        b=OuIV2tkDOhL7K4S7I1Tsq0UNfIQFEpEaUjFXonNhBL9wOW4KoZqpATc8ViS+9C85w6
         shN4N9ap7KFmV9AyuWwVimy9Kc5iNLjYTVD08qgPHaI0yyYcYykNSTfFmP6SLIiQuMT6
         LNRUIMAkISj79uWTb+rpl8e86J6XieEfhtp1H/3ScHhgu9Pno4ChMoZLMnmjjodVw++w
         UmseUKMGY9VoAywk09neLDqEBpZXLPdJ49tBjwirkaxefRODn+uf8fDM74NkxtmOCi75
         ML97l6Ac9DYD2K4OA768pkC84fWyglz7Cz9okotvijzB24vLi9py7fTZ3gpX+zJi+57x
         Fyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkHVrRJ8zLqwntW1swcQ+u0WQTIpa1PHnxqat0womr4=;
        b=mhHhZNn2PGKgc6AwIE/Kkk7x52lrpQWzmEGkOs0EH3ojl45FVOHtnUnynB+dcCxnG5
         qJjTT6UFCMYbGib0SK2cghMFH/lNlNEFAFhAifjkIr1tGrAOCnBEmTS8Hmf4odWL9xHV
         pEi1ddey03wWVL0pA0BQg+tJLIvK7p/wSqdJfiRfVDt9HL/x3K58BpJXip9Z+iApaMwg
         JLA8yg3VM3dx7xgvM0Zdt53+7UNJuL+IY0ZAm8rrDB/WGRFSxwWLKnWM8W+dZ6G1WFoO
         5h/8MxUjiF6vccoDbe/RiJUqj1ld1bQqbFBpXxZuNgoO8fnEwOqh1AOTg+vcj8zX7kb1
         5cLw==
X-Gm-Message-State: AOAM531HprKPjlE1+XgK+KKhamrTiMWwZpJNO7T9e57cKu5tftr50S+e
        7dCvykyQVCRzuQI5X5NR1cOetOAeIOOinIWx/1cQEQ==
X-Google-Smtp-Source: ABdhPJxPBhNN2G2EFi3e+Hkkw+mdZk84j03K/90ZSzXfkJwnwu02KTLiuSIR4MM47ac8jygjXOesq/VxXQr2puuRpHk=
X-Received: by 2002:a05:651c:124b:: with SMTP id h11mr19490110ljh.401.1617725602090;
 Tue, 06 Apr 2021 09:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210321150358.71ef52b1@imladris.surriel.com> <20210322110306.GE3697@techsingularity.net>
 <20210326151932.2c187840@imladris.surriel.com> <CAKfTPtBvy3Wv=-d5tjrirO3ukBgqV5vM709+_ee+H8LWJsnoLw@mail.gmail.com>
 <1e21aa6ea7de3eae32b29559926d4f0ba5fea130.camel@surriel.com>
 <CAKfTPtC2Cnr=SoD9t+dLh01ux_bc8PAcHTXxxiBqbqykLphBNw@mail.gmail.com> <300f7c0dac300e2c3a8dc7f57fd0a834383152ff.camel@surriel.com>
In-Reply-To: <300f7c0dac300e2c3a8dc7f57fd0a834383152ff.camel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 6 Apr 2021 18:13:10 +0200
Message-ID: <CAKfTPtDKwe-rxsVrAFDzJT6j+Mtu2aB73fGFygCWOuKQRKyvUw@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: bring back select_idle_smt, but differently
To:     Rik van Riel <riel@surriel.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2021 at 17:55, Rik van Riel <riel@surriel.com> wrote:
>
> On Tue, 2021-04-06 at 17:31 +0200, Vincent Guittot wrote:
> > On Tue, 6 Apr 2021 at 17:26, Rik van Riel <riel@surriel.com> wrote:
> > > On Tue, 2021-04-06 at 17:10 +0200, Vincent Guittot wrote:
> > > > On Fri, 26 Mar 2021 at 20:19, Rik van Riel <riel@surriel.com>
> > > > wrote:
> > > >
> > > > > -static int select_idle_cpu(struct task_struct *p, struct
> > > > > sched_domain *sd, int target)
> > > > > +static int select_idle_cpu(struct task_struct *p, struct
> > > > > sched_domain *sd, int prev, int target)
> > > > >  {
> > > > >         struct cpumask *cpus =
> > > > > this_cpu_cpumask_var_ptr(select_idle_mask);
> > > > >         int i, cpu, idle_cpu = -1, nr = INT_MAX;
> > > > > @@ -6136,23 +6163,32 @@ static int select_idle_cpu(struct
> > > > > task_struct *p, struct sched_domain *sd, int t
> > > > >
> > > > >         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > > > >
> > > > > -       if (sched_feat(SIS_PROP) && !smt) {
> > > > > -               u64 avg_cost, avg_idle, span_avg;
> > > > > +       if (!smt) {
> > > > > +               if (cpus_share_cache(prev, target)) {
> > > >
> > > > Have you checked the impact on no smt system ? would worth a
> > > > static
> > > > branch.
> > > >
> > > > Also, this doesn't need to be in select_idle_cpu() which aims to
> > > > loop
> > > > the sched_domain becaus you only compare  target and prev. So you
> > > > can
> > > > move this call to select_idle_smt() in select_idle_sibling()
> > >
> > > After Mel's rewrite, there no longer are calls to
> > > select_idle_core() or select_idle_smt() in select_idle_sibling().
> >
> > select_idle_smt() had even disappeared that why it was not in
> > select_idle_sibling
> >
> > > Everything got folded into one single loop in select_idle_cpu()
> >
> > but this is done completely out of the loop so we don't need to
> > complify the function with unrelated stuff
>
> Not entirely. The call to select_idle_smt() is still
> conditional on test_idle_cores() returning false.
>
> We only look for the
> other sibling if there is no idle
> core in the LLC. If there is an idle core, we prefer
> that.
>
> Pulling the select_idle_smt() call out of select_idle_cpu()
> would mean having to test_idle_cores() twice.

In this case passes  the results test_idle_cores as a parameters instead of prev

>
> --
> All Rights Reversed.
