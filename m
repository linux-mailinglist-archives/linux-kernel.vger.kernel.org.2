Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0286B440074
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 18:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhJ2Qml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 12:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2Qmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 12:42:40 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E51BC061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 09:40:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id iq11so640666pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 09:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c6+ds4Tn9y5weSl8KX7rHPNlWblR7xngjs6inEmr3LY=;
        b=ocOtS2Kbu8kOKqCeC8gdn+X/qhYZO2n8bIAtJHSYMcTojyeRVppMBFnum9nAxnBpEC
         PS3UQlmQm6o5oOwsk6Mcq0hY5n8I8xt6xheheQJxwp1aB9B5YQ+YT5O75On1GmR801LO
         X+yQD5IzealGhoKHtZjWLc5zMJV14R3wXKqzjW2d9wvwI/6+Ci9z6chjTPyAlMZrazy7
         DQOWktgeQA4YTPstd344x+de6wOZ6ysZnXX25ziPlvJK2G+YVBqO2hTnbEI3jvPSohqW
         ZJ5/CrMSn4dp0fRxUPOGS/T5R/xbjXBcRs5jvL+Ly2XBuGzkZn3pEBKnWO50leCaff52
         FYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6+ds4Tn9y5weSl8KX7rHPNlWblR7xngjs6inEmr3LY=;
        b=ud+0zMC/ObX/1RDHNjp4V5+C2E7xEY6rhjwi2dXu6K69RJWqShWBL4yx4vL7y3EL6+
         8cxMdjI8MvwiiVnCAWB9TyUOOsPdI2yhcFIC5J9f800Lyuc12eKGQYYbgS/F7824383Q
         yMk8Xp5Y8juX0MZUb9oCaqKvjcMfYqTv+zN/yS5nX6I2NTq814aybtMV8Y6noDiuT7yr
         yHoXkY2DQdwH+A5MNLMHJfXEPNxgYDfZkX9592U4X8RW+Daw9W+r1zKHPoBrskQaWPDe
         9P+Rvh+WnJRNIulSvqpErB+fDg0Fq6bSzFP7bOjNTGux8Wgl/vRP0atiqRFpeRCYOnO2
         Db5A==
X-Gm-Message-State: AOAM531nMG7/4qaNkMcbznmf5lNRDdWK3BsoBw8TbVDPZC9rWJCu2RME
        BX1n2tcVDkyf0bzJU8kT8ziChkfn1b7xRD8b2j/NGQ==
X-Google-Smtp-Source: ABdhPJzYfzPvuPJ6oy1uqu62yYXlVZZn7YQNWn90Y+U+TdmP81rOWN+C2vtp9IdaUsbJ1XhBkp8YGyto6vPkewlUJ2I=
X-Received: by 2002:a17:90b:3e8e:: with SMTP id rj14mr12691280pjb.170.1635525611436;
 Fri, 29 Oct 2021 09:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211028032854.2458440-1-kaleshsingh@google.com> <20211028220134.23e2d840@rorschach.local.home>
In-Reply-To: <20211028220134.23e2d840@rorschach.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Fri, 29 Oct 2021 09:39:59 -0700
Message-ID: <CAC_TJvfkGOMeZGDo8o=si=DyZfbF7TJ7XOj5dz+taCrt+h3foQ@mail.gmail.com>
Subject: Re: [PATCH] tracing/histogram: Optimize division by constants
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, mhiramat@kernel.org, zanussi@kernel.org,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 7:01 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 27 Oct 2021 20:28:54 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > +/*
> > + * Returns the specific division function to use if the divisor
> > + * is constant. This avoids extra branches when the trigger is hit.
> > + */
> > +static hist_field_fn_t hist_field_get_div_fn(struct hist_field *divisor)
> > +{
> > +     u64 div;
> > +
> > +     if (divisor->flags & HIST_FIELD_FL_VAR_REF) {
> > +             struct hist_field *var;
> > +
> > +             var = find_var_field(divisor->var.hist_data, divisor->name);
> > +             div = var->constant;
> > +     } else
> > +             div = divisor->constant;
> > +
> > +     if (!div)
> > +             return div_by_zero;
>
> Do we really need a div_by_zero constant function? What about just
> erroring here and perhaps return -EDOM?

Good point. We can detect this if the divisor is a constant and print
an error message instead. It'll also warrant a small update to the
tests and documentation. I'll send out a new version addressing these.

Thanks,
Kalesh

>
> -- Steve
>
> > +
> > +     if (!(div & (div - 1)))
> > +             return div_by_power_of_two;
> > +
> > +     /* If the divisor is too large, do a regular division */
> > +     if (div > (1 << HIST_DIV_SHIFT))
> > +             return div_by_not_power_of_two;
> > +
> > +     divisor->div_multiplier = div64_u64((u64)(1 << HIST_DIV_SHIFT), div);
> > +     return div_by_mult_and_shift;
> > +}
> > +
