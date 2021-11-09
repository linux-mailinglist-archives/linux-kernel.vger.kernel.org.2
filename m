Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE61A44B926
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 23:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbhKIXCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 18:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhKIXB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 18:01:59 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08107C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 14:59:13 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id s186so1372593yba.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 14:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTJX/5Xkjh5EL6JX4tHk9Z5EmkU1y+mQlvK4hQjGWag=;
        b=Qbz+CFX9yfyAXlHo4IAlhzkKE35UxEZcBQUGJMn2WKpbVyh95mzR6DlY+nCtqshM9w
         hQQ2y61z9haiwDz+2dEZXAI7X4jL8jtorV/LF8fLf5DoNO86+hWQRzVGRZ8KyDkimhyD
         CKDVOH0s7/hQSpCOF5qNF1Ud3I3AlDHSYz80A+CT011+NQzXQDUj2v46SN/HyJKi0et9
         erxjm6owQ+nyZgqLrL4JGLtBvhhgYQYB83WCliiFQbA/41JfMtPcBjPSKBr9yojZaCjP
         +h7CginZrylKMdCMKO9B9wYtJqhHJT+K03ZMkH1RspvUYv9jz2sIEW9JUPClvPTraugM
         /kRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTJX/5Xkjh5EL6JX4tHk9Z5EmkU1y+mQlvK4hQjGWag=;
        b=VURo166UIK0cysE+peaoveAOB8qmumLMgBxctr+rARV/rdA/3fsmrN9g0NyUvQWNPH
         LeEZdy0OuFJLcqa4RDCz9Z/Fq86///qALpF4MmrjF0JF2uTM5+mmULI9hPhlQK6abFNk
         cFogcowvvooL/BnZZsMw7PglDtbHW6Hhcz6HXyBXUKG3kCcl7oRWjLz+rWurstSz6tgk
         mFV0/Fn07/8NcrIgXfu506+LLWh7CmF2jr9Dboot6AyAm9HT4pUI4qR6S5mDjhJ/mea8
         PAQRCUvOfpyAK3Zal/1071rwQLW0kMIlWObcdQfT1OAV3bsPIgeZkC8tay7lXmma1Vog
         zCWw==
X-Gm-Message-State: AOAM532f0YV8qin3vVbq/EL6+fzr6RzyKXVMVAhtMiLOj1rx15o02VIw
        J7oNYLT77u6iGEU5b9qmBgPQdpG6balm3JMxZwt63Q==
X-Google-Smtp-Source: ABdhPJxulDuw07L++t1dPHV6xv2C+VbSV/EBF14HIyFALALmJ3f5E+LnbYoy6oGjtm0VJd8ctdnEKdzLkkfMh/vG0eg=
X-Received: by 2002:a25:9847:: with SMTP id k7mr12960115ybo.170.1636498752018;
 Tue, 09 Nov 2021 14:59:12 -0800 (PST)
MIME-Version: 1.0
References: <20211018203428.2025792-1-joshdon@google.com> <YYpYP919xlC0NX7/@hirez.programming.kicks-ass.net>
In-Reply-To: <YYpYP919xlC0NX7/@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 9 Nov 2021 14:59:00 -0800
Message-ID: <CABk29NucnFxyPQ==n8-v=_hti2THkybrEkxruqJ_v8rvW4yacg@mail.gmail.com>
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

On Tue, Nov 9, 2021 at 3:15 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 18, 2021 at 01:34:28PM -0700, Josh Don wrote:
> > @@ -5804,6 +5830,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >               }
> >       }
> >
> > +     if (rq->core->core_forceidle_count) {
>
> Does this want to be something like:
>
>         if (schedstat_enabled() && .. ) ?
>
> afaict without schedstat on this is dead code.
>

Makes sense to me, and similarly we can bail out of sched_core_tick()
early in the disabled case.
