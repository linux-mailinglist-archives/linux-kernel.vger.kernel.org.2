Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A645453FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 05:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhKQEkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 23:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhKQEkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 23:40:22 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4813EC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 20:37:24 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id m15so1091668pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 20:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CkWPTiS/0euPMX9GKx6w6gxcLFcldMolJRQ5Svdh770=;
        b=SRhmUPamj+GO/ZstAD9i/lcJR/dCNub/E7KP0ghYz4KeQLR0Zh5g9b1y4HoZ+Ac2HA
         UQG9ycBdwELzLcE2YBI94hHUuMPJ20oW16n9YKm7kmLEcAPButM/sa7a1qVgbRVefWyd
         vupANS55zkoGIWwXtIAqvZK1y/c2qeAKYQgIY/0MUB0IlsKlNJcfzbPgfopy7xJ4JynI
         UD+hTmzy3yJ/5qsA6tLI0mAb2koXzT7a9s+mw5AkzaRipRvt5G8aQm7bp4Xqlk0/NYF0
         VTAe5lyaLxOmvPKKB9TDp8a9N+ncA7LH+XVqB8yCeXgtMikZMgEDBGqO+MF0WL9OEpDr
         mdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CkWPTiS/0euPMX9GKx6w6gxcLFcldMolJRQ5Svdh770=;
        b=NBctC1IfwFGDf+z4riQQ9tRh/ui399f29MxJTlMMX1FAHYL7gKOUSADV+to9T38Rnv
         LePWkRAYFzVaAdqHo4onelIkMN5reJzv2MlNpVH93UKjotCB6qqrSU0aD2RoZ7pttHop
         FG7jPwFWKnmnwPLLcfZySBmJm5NMcIYbeT7cgh1kzlhzSi1qwtYyfv+Is4Ic1ATpd4RG
         oL6hQFg7VYSMi+L1raII20JT6CgTpaBws8CqLJzEUD4GjlB6QPUqgy7EKjXnKWNuRrvk
         M+zegQKbLbUJdI1ocbiQd7/kDAmDzUnfZBMY8LcgKoPDrIBoZjEPaeWuP475R4/XDAhS
         k9bg==
X-Gm-Message-State: AOAM530N+RwxHJ1KTmHTkDFfZhveh3wsaarT7Zl4p7hp0yOX52e+7vB1
        FQApUYemsF2qyYUBYAP+zhSSI6NNtzxdBvxPzZenwQ==
X-Google-Smtp-Source: ABdhPJwIVaqEzvWbw7T8WcswxeJQ6zhkiiR+KSYj4uklSY7HjnOOOBKh/QUl1rX70mDf6grbTWSfe3XgsJou56pe9Qs=
X-Received: by 2002:a05:6a00:b4c:b0:481:2a:f374 with SMTP id
 p12-20020a056a000b4c00b00481002af374mr4569987pfo.60.1637123843514; Tue, 16
 Nov 2021 20:37:23 -0800 (PST)
MIME-Version: 1.0
References: <20211117021223.2137117-1-kaleshsingh@google.com> <20211116224703.133f1750@rorschach.local.home>
In-Reply-To: <20211116224703.133f1750@rorschach.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 16 Nov 2021 20:37:12 -0800
Message-ID: <CAC_TJveGzESpuzGWhyF+31=c4iLJ=TdNeivJyVf_Et-cyQUX3w@mail.gmail.com>
Subject: Re: [PATCH] tracing/histogram: Fix UAF in destroy_hist_field()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel-team@android.com, mhiramat@kernel.org, zanussi@kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 7:47 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 16 Nov 2021 18:12:22 -0800
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > Calling destroy_hist_field() on an expression will recursively free
> > any operands associated with the expression. If during expression
> > parsing the operands of the expression are already set when an error
> > is encountered, there is no need to explicity free the operands. Doing
> > so will result in destroy_hist_field() being called twice for the
> > operands and lead to a use-after-free (UAF) error.
> >
> > Fix this by only calling destroy_hist_field() for the expression if the
> > operands are already set.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > Fixes: 8b5d46fd7a38 ("tracing/histogram: Optimize division by constants")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > ---
> >  kernel/trace/trace_events_hist.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index 5ea2c9ec54a6..e3856eaf2ac3 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -2669,7 +2669,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
> >               if (!divisor) {
> >                       hist_err(file->tr, HIST_ERR_DIVISION_BY_ZERO, errpos(str));
> >                       ret = -EDOM;
> > -                     goto free;
> > +                     goto free_expr;
> >               }
> >
> >               /*
> > @@ -2709,7 +2709,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
> >               expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
> >               if (!expr->type) {
> >                       ret = -ENOMEM;
> > -                     goto free;
> > +                     goto free_expr;
> >               }
> >
> >               expr->name = expr_str(expr, 0);
> > @@ -2719,6 +2719,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
> >  free:
> >       destroy_hist_field(operand1, 0);
> >       destroy_hist_field(operand2, 0);
> > +free_expr:
> >       destroy_hist_field(expr, 0);
> >
> >       return ERR_PTR(ret);
> >
> > base-commit: 8ab774587903771821b59471cc723bba6d893942
>
> Wouldn't this be a simpler and more robust fix?
>
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 5ea2c9ec54a6..aab69b4ffe11 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -2717,8 +2717,10 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
>
>         return expr;
>  free:
> -       destroy_hist_field(operand1, 0);
> -       destroy_hist_field(operand2, 0);
> +       if (!expr || expr->operand[0] != operand1)
> +               destroy_hist_field(operand1, 0);
> +       if (!expr || expr->operand[1] != operand2)
> +               destroy_hist_field(operand2, 0);
>         destroy_hist_field(expr, 0);

Hi Steve,

Agreed. What you suggested is simpler to work with. I'll respin a new version.

Thanks,
Kalesh

>
>         return ERR_PTR(ret);
>
>
> I'm worried about the complexity of having to know where to free what,
> and not just figuring it out at the end.
>
> -- Steve
