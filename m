Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054183B8A73
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 00:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhF3Wcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 18:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbhF3Wci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 18:32:38 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D16C0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 15:30:08 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id w13so2781692qtc.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 15:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hiptwy9TUvWyDXIfvAtOM6Kej8lazuA4fp4IHXgFEhA=;
        b=l0phQZTqmoJDi9w/25alZe0CUOgvyrerAYN4ksIjN3XQzYhjFywzQQM9zLWORpjAHY
         TR/bgReRORJbKHhGgEy3CRtXOMHFbyS2fvJH69GKHNPOjrF58lBBGX/5o7lNtvZA8Yau
         XrPJEba8gk0NpHC3uBuNjlyrVQME5lCs3bgODUU5QVhZOoyR8NPCOuEFbPgT3GYfCMYy
         ARXPYd/u+oeYXlIA0SpGqGJtFCUkTEYfGPZQGrfllgrGqI+j8FM0CiPaW2qMfEKO3FXZ
         Lm4/MgZCo/QeYjY2F9A8gdhdqYJ+Lu6NQ1ZEz7M7dcBZxWUGg7kSjAFNZEhTwNJGvRys
         WjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hiptwy9TUvWyDXIfvAtOM6Kej8lazuA4fp4IHXgFEhA=;
        b=K8QvgOipQY41aRX6lQIumbrsPzgSTano3UYXXHRpKYaZWnNAXz+51ARQn8ZN7jL0Wu
         YQQ4wC90lXXPupLPqDTRsbfdoGU+P9w3tl198zwtllt+PeL9UPkUgyfl1AK7Flrx/yIa
         3KJ3kzDhHlajMNehu+cSmp5oosu+KXHTDP/7HUvzVQWL8E6okKOI0piY9TkmT24BixmJ
         xHPF4h/FmqRfNyim6GPYQzrMvO7ajzJz4I/F2uli/Y3jfZT85WVIRcl42rzuPTvmqYqT
         4Gd+nvz/x2ydUVuhS8/J3HY4AmP952cuec5aRjOFFwNJqZDakf50Q94L/oTiRot13o6Q
         5/GQ==
X-Gm-Message-State: AOAM530IoNIOAz6nB5Yyj4LaIIL+hc/dX1+NwXVVk4tzuW36vFefZyPX
        AQJwKgx4Qr1VsFs7MtOXJh94VaiFTe1MaH2HWnV5xg==
X-Google-Smtp-Source: ABdhPJxaKRUyPs4V1DSgIvmJq4TKnBpdyjCHx41DHlWJ5jxaPeUqodvfc4mqeHL+zXsZzsJQvDEkpuOiY4kYLWBnAG8=
X-Received: by 2002:a05:622a:316:: with SMTP id q22mr33689033qtw.153.1625092206907;
 Wed, 30 Jun 2021 15:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210630003406.4013668-1-paulburton@google.com>
In-Reply-To: <20210630003406.4013668-1-paulburton@google.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 30 Jun 2021 18:29:55 -0400
Message-ID: <CAJWu+ooRQ6hFtaA4tr3BNs9Btss1yan8taua=VMWMopGmEVhSA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tracing: Simplify & fix saved_tgids logic
To:     Paul Burton <paulburton@google.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 8:34 PM Paul Burton <paulburton@google.com> wrote:
>
> The tgid_map array records a mapping from pid to tgid, where the index
> of an entry within the array is the pid & the value stored at that index
> is the tgid.
>
> The saved_tgids_next() function iterates over pointers into the tgid_map
> array & dereferences the pointers which results in the tgid, but then it
> passes that dereferenced value to trace_find_tgid() which treats it as a
> pid & does a further lookup within the tgid_map array. It seems likely
> that the intent here was to skip over entries in tgid_map for which the
> recorded tgid is zero, but instead we end up skipping over entries for
> which the thread group leader hasn't yet had its own tgid recorded in
> tgid_map.
>
> A minimal fix would be to remove the call to trace_find_tgid, turning:
>
>   if (trace_find_tgid(*ptr))
>
> into:
>
>   if (*ptr)
>
> ..but it seems like this logic can be much simpler if we simply let
> seq_read() iterate over the whole tgid_map array & filter out empty
> entries by returning SEQ_SKIP from saved_tgids_show(). Here we take that
> approach, removing the incorrect logic here entirely.

Looks reasonable except for one nit:

> Signed-off-by: Paul Burton <paulburton@google.com>
> Fixes: d914ba37d714 ("tracing: Add support for recording tgid of tasks")
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>  kernel/trace/trace.c | 38 +++++++++++++-------------------------
>  1 file changed, 13 insertions(+), 25 deletions(-)
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d23a09d3eb37b..9570667310bcc 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5608,37 +5608,20 @@ static const struct file_operations tracing_readme_fops = {
>
>  static void *saved_tgids_next(struct seq_file *m, void *v, loff_t *pos)
>  {
> -       int *ptr = v;
> +       int pid = ++(*pos);
>
> -       if (*pos || m->count)
> -               ptr++;
> -
> -       (*pos)++;
> -
> -       for (; ptr <= &tgid_map[PID_MAX_DEFAULT]; ptr++) {
> -               if (trace_find_tgid(*ptr))
> -                       return ptr;

It would be great if you can add back the check for !tgid_map to both
next() and show() as well, for added robustness (since the old code
previously did it).

With that change:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

-Joel


> -       }
> +       if (pid > PID_MAX_DEFAULT)
> +               return NULL;
>
> -       return NULL;
> +       return &tgid_map[pid];
>  }
>
>  static void *saved_tgids_start(struct seq_file *m, loff_t *pos)
>  {
> -       void *v;
> -       loff_t l = 0;
> -
> -       if (!tgid_map)
> +       if (!tgid_map || *pos > PID_MAX_DEFAULT)
>                 return NULL;
>
> -       v = &tgid_map[0];
> -       while (l <= *pos) {
> -               v = saved_tgids_next(m, v, &l);
> -               if (!v)
> -                       return NULL;
> -       }
> -
> -       return v;
> +       return &tgid_map[*pos];
>  }
>
>  static void saved_tgids_stop(struct seq_file *m, void *v)
> @@ -5647,9 +5630,14 @@ static void saved_tgids_stop(struct seq_file *m, void *v)
>
>  static int saved_tgids_show(struct seq_file *m, void *v)
>  {
> -       int pid = (int *)v - tgid_map;
> +       int *entry = (int *)v;
> +       int pid = entry - tgid_map;
> +       int tgid = *entry;
> +
> +       if (tgid == 0)
> +               return SEQ_SKIP;
>
> -       seq_printf(m, "%d %d\n", pid, trace_find_tgid(pid));
> +       seq_printf(m, "%d %d\n", pid, tgid);
>         return 0;
>  }
>
>
> base-commit: 62fb9874f5da54fdb243003b386128037319b219
> --
> 2.32.0.93.g670b81a890-goog
>
