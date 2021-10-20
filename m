Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D6E435010
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhJTQYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhJTQYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:24:50 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C9FC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:22:35 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f11so3369295pfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AsIANaDEnDuXhpKm7gwaOuH/xV04ul7CfvYlvZYub/g=;
        b=hIa98Nzm4wn5I0bee4rK8AjEp+Da/+KCCvTIWp0IckELqd5QXd74SwY8Gm2KbieChy
         XDHimuoSI362xp30cEAny/C/6K9RCJm0Q3VMe6tfn3/ag3oBHx6tOB4jwvU1QFz83uFG
         Ru4BV+gFudVG9y+kRTPjqNE9YIlmd1FYSEB6Fs4W7M1p50QN48giWiG/pvQ29+iWcLyq
         HklKXIYrj8l6Z1qJTFvvt/kG2uCHhnE51/rQJWFm5vXdU0js2S+U9Ak1UW/L5zKtgJwz
         Ox+jEwVdlkmAa+Eey0SGIlWq1EUDhY2/LujQp/MNi9WlrBtwEw9NFZLtLavG8/wlpG0T
         dbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AsIANaDEnDuXhpKm7gwaOuH/xV04ul7CfvYlvZYub/g=;
        b=X9pFY60tfh6+Pl17WTTbsZuQHS0U1yzg8bK8EfC49sbqIQmHQJy3HxchuOJc8a4ihO
         FqtRJLrWGL5utnOWXGI0S4qGWFyFBPkpjr2zAvPd2TzQS2mktCK1av/RhsB5jO79magq
         vM019GkDdM/T7N0cwiymBTSLLgKf/4Jaeq24f+U8mmOW7/0q9nGN6Jr1lFmAA3HJzB96
         nvRpF0umMxjBQBgXeRbNJ5ln86RSPP6+2IYU/odmvwA6SGbFkU62TAi0GwuF+hKh1EmG
         aGZb4rhmiuAMMLwz0uy/8evrVciOx6wUtDKZfdHhTWcN29Ru3b6EpU3oMe9g5XLpyrsR
         jnOw==
X-Gm-Message-State: AOAM533MW/VyhEi8aBzUe2bIgnXlXboQtZrYHJWIv7g7wE2zcABxtGwf
        rXfC0b/8HSP1NCbxOk12qSyFhGx93Jf8VyBhigm62g==
X-Google-Smtp-Source: ABdhPJzDP63xIcRb7NLHWlf3Xvnc+3zPfYVH0FR2foc/lDhPfVuY0gBMEp9v0ZbSoOHhCWpqAm60kyfZi7arrtXi9/A=
X-Received: by 2002:a63:3483:: with SMTP id b125mr181088pga.79.1634746954789;
 Wed, 20 Oct 2021 09:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211020013153.4106001-1-kaleshsingh@google.com>
 <20211020013153.4106001-4-kaleshsingh@google.com> <20211020114805.3fbb7d94@gandalf.local.home>
In-Reply-To: <20211020114805.3fbb7d94@gandalf.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 20 Oct 2021 09:22:24 -0700
Message-ID: <CAC_TJvceZ=+QoRM2Qt4uRtikG5WZ_+KEjbPreg3ss=OOHFV7QA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] tracing: Fix operator precedence for hist triggers expression
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 8:48 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 19 Oct 2021 18:31:40 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > @@ -2391,60 +2460,61 @@ static int check_expr_operands(struct trace_array *tr,
> >  static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
> >                                    struct trace_event_file *file,
> >                                    char *str, unsigned long flags,
> > -                                  char *var_name, unsigned int level)
> > +                                  char *var_name, unsigned int *n_subexprs)
> >  {
> >       struct hist_field *operand1 = NULL, *operand2 = NULL, *expr = NULL;
> >       unsigned long operand_flags;
> >       int field_op, ret = -EINVAL;
> >       char *sep, *operand1_str;
> >
> > -     if (level > 3) {
> > +     if (*n_subexprs > 3) {
>
> Why limit the sub expressions, and not just keep the limit of the level of
> recursion. We allow 3 levels of recursion, but we could have more than 3
> sub expressions.
>
>
> If we have:  a * b + c / d - e * f / h
>
> It would break down into:
>               -
>        +            /
>    *       /     *     h
>  a   b   c  d  e  f
>
>
> Which I believe is 6 "sub expressions", but never goes more than three deep
> in recursion:
>
>    "a * b + c / d - e * f / h"
>
> Step 1:
>
>   op = "-"
>   operand1 = "a * b + c / d"
>   operand2 = "e * f / h"
>
> Process operand1: (recursion level 1)
>
>   op = "+"
>   operand1a = "a * b"
>   operand2a = "c / d"
>
> Process operand1a: (recursion level 2)
>
>   op = "*"
>   operand1b = "a"
>   operand2b = "b"
>
> return;
>
> Process operand1b: (recursion level 2)
>
>   op = "/"
>   operand1b = "c"
>   operand2b = "d"
>
> return;
>
> return;
>
> Process operand2: (recursion level 1)
>
>   op = "/"
>   operand1c = "e * f"
>   operand2c = "h"
>
> Process operand1c: (recursion level 2)
>
>   op = "*"
>   operand1c = "e"
>   operand2c = "f"
>
> return;
>
> return;
>
>
>
> > +
> > +     /* LHS of string is an expression e.g. a+b in a+b+c */
> > +     operand1 = parse_expr(hist_data, file, operand1_str, operand_flags, NULL, n_subexprs);
> >       if (IS_ERR(operand1)) {
> >               ret = PTR_ERR(operand1);
> >               operand1 = NULL;
>
> I wonder if we should look for optimizations, in case of operand1 and
> operand2 are both constants?
>
> Just perform the function, and convert it into a constant as well.

I think we achieve something like this by propagating up the
HIST_FIELD_FL_CONST flag. Thanks for the suggestions. I'll update this
in the next version.

Thanks,
Kalesh

>
> -- Steve
