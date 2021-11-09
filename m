Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3034444B929
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 23:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242143AbhKIXCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 18:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241379AbhKIXCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 18:02:31 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794E5C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 14:59:45 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 131so1443385ybc.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 14:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ACJM4+6Xw0gfPwaSwMU+2ySa2D4Bc6rwbvm+XKlAeyc=;
        b=lBLaGSq0emH4aqCCx6ALAR5IhbPfR0w3GftkcHvq47hqpmyaFuT7SlVycS3vQzgril
         zFjy2aHY83o0liSLdazDdb1y2sHNJzWUnQs11uDCIB+zOpMHQIWn8clPppc3vDC2t2vl
         ioAM+/SSE3ffrqmPIgxoLmX7Fxogwq5WrofIfdWqEnKEX4CaAaX4jVNqW9IAYEcnVixK
         ev1UfpPl2fkx4w7RhY9dENs5Qi9ECMJWa4pOXabdmil4+9Jt2urR4QaE/Fomc7NZeqcl
         NjTsomv86Gw3p1wWtoVyzp8nhYtmEzdCqPsA1kmP9REvlMLdAoVKVL7kYgluSyAmgeIk
         91kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACJM4+6Xw0gfPwaSwMU+2ySa2D4Bc6rwbvm+XKlAeyc=;
        b=w/MXcPPJbEPYU1x0lt7g1XHZ89KCYxsuz++pdDX9dyOF/vktOnG1pNZoV8DDuOt1kO
         9aaeuc+KvSMewi2KsaEZpNez6eWnoFgh08qqr3w8kV5SufNJBJgpmJpzqBHoHTyFkcn7
         vY6xhsCFmTGQqM+2nlQ0X56geBYibPU0F+PWv9HRwgjrQsnSy6VTHzXtWdf3nADL1Xjm
         GdCmzLvjJDIFnioAb6kRJDw6fr+Zk68akhjPOqJB2Z1ix7S3jjKMatbXW+RtmOyY9ZCG
         H6Wk7fVlSe8GxdKZnV/ACUbk+9dsqd0SOGFcYUfRihyals8NfZctLiVSnxMBZCrzFdbu
         BOOw==
X-Gm-Message-State: AOAM531598WQmXP3CMvSM31/9DOmccX62CT07VT5cAwLjyh/UOXHCQGd
        wtuGzCyMkWfqtJSb5mlcPqn5SSI3lqrAP35WM39imQ==
X-Google-Smtp-Source: ABdhPJxI2c+0dYKJ+RuaJd0mU8XAjHuaxiIsNce7o8rhOlVPQeFMrkU3Gw7NMafV0k001ALMekPRUCL1s12B51zir1c=
X-Received: by 2002:a25:b7d3:: with SMTP id u19mr12066453ybj.158.1636498784531;
 Tue, 09 Nov 2021 14:59:44 -0800 (PST)
MIME-Version: 1.0
References: <20211018203428.2025792-1-joshdon@google.com> <YYpLiWCDBIOj4nvz@hirez.programming.kicks-ass.net>
In-Reply-To: <YYpLiWCDBIOj4nvz@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 9 Nov 2021 14:59:33 -0800
Message-ID: <CABk29NsaiO=4fG=0qGpQoSVgBMfw_rSo2DsC5mfgJvAvQcNQzQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/core: forced idle accounting
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Hao Luo <haoluo@google.com>, Tao Zhou <tao.zhou@linux.dev>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 2:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 18, 2021 at 01:34:28PM -0700, Josh Don wrote:
> > @@ -280,6 +288,8 @@ static void __sched_core_flip(bool enabled)
> >               for_each_cpu(t, smt_mask)
> >                       cpu_rq(t)->core_enabled = enabled;
> >
> > +             cpu_rq(cpu)->core->core_forceidle_start = 0;
> > +
> >               sched_core_unlock(cpu, &flags);
> >
> >               cpumask_andnot(&sched_core_mask, &sched_core_mask, smt_mask);
>
> Not specific to this patch, but perhaps we should do better here and
> explicitly initialize more state...

The others are not needed for correctness, but I do agree it makes
sense to keep the state consistent. I think that set is

core_pick
core_cookie
core_forceidle_count
core_forceidle_occupation

I can throw another patch on top of this to reset those as well.
