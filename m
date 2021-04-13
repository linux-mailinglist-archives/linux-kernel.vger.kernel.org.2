Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1381335E2CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344008AbhDMPZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346708AbhDMPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:25:11 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0666CC06138F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:24:49 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 82so18566243yby.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4mf7XVdjFYlVzcsu46/lq1ZJMjNmlJbOjyzyRkt7VCc=;
        b=qpfZin+exKoquYlxUINwv8WgBcOPJOThRsNfiQrdk7kIDzyy3ZQlgcACAahmx+YLcc
         sZq15r6Vx/VSDhH9u51blFakZ480PRmHGLvBCcgffPgxo8cRMEKy7XTuNVdsfXS+YDSJ
         wzWZNel0bwNlO4jMGBHqPxuOrP0vHa48/Wse4MHr7NkfIlE22Mx3XJwQgJqt47m0oYUJ
         nzND7JK4nymntoVwTRX1AwdudLNWbwbccaiKHwtNYlkQnqkyk+5NSYIJDeLMX0uPa5qw
         ajnH4FQNZHAuxWzOpOLYllUWTzbfor5Lo2+idTWaZDpgeZnvOacsBqSRjCt7YxsEldNp
         ds4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4mf7XVdjFYlVzcsu46/lq1ZJMjNmlJbOjyzyRkt7VCc=;
        b=VxuQ4Pk5lobuSFu5Ci5wR4TqYuFp8jtFzFYXhgKKL6qJVu8ETHI8B6duN5LRru7lxi
         +poZkiN7Xy6VVssXkFXRlIc9oF720D1rdMs/IWkfYg87OYKebkQqGh8S+lTKPNqjvhec
         WVBLkzQTBmd0JyH0atfAnKsKAW3EGjseu9lk5lHRTBYZzUa3H5Gw/aS6DOUbKLq86btu
         +RfFZpON0kyKzF8155lzxNgWQJGQdSDkCFPtC56o/P/v0QaPcpznqVJzBpwivO/97Jt8
         GpjmmgRQy8Lz3EMRAi1nq7VtOZ+Mr7jaPvoI6jXMl86qFQei4j5W9CYHp3vBrRgs4SCA
         dHCQ==
X-Gm-Message-State: AOAM531NvTtl+r/p+6fFr+qkn8yi+pj1qcgfE2yHp8SjlstM7KHrPNA5
        3/00gzFv1UYWNOSB2h18HhplgpRFzVJfDriaeKDDUA==
X-Google-Smtp-Source: ABdhPJwifVL/MP+4WBpqCDMNXTGfEmcfssRyLlrvbAmHhanHAR9esqWnWz/VFyYhidiM7QiiEoqJp7ELNNgv9KhQy1I=
X-Received: by 2002:a25:b906:: with SMTP id x6mr43118295ybj.504.1618327488921;
 Tue, 13 Apr 2021 08:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210413073657.2308450-1-eric.dumazet@gmail.com>
 <20210413073657.2308450-2-eric.dumazet@gmail.com> <643243714.71310.1618324178021.JavaMail.zimbra@efficios.com>
In-Reply-To: <643243714.71310.1618324178021.JavaMail.zimbra@efficios.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 13 Apr 2021 17:24:37 +0200
Message-ID: <CANn89iJ28npWmB5F4haTz-PxV0=Vxm7DV9bkEkVJ=aPn=bVT0A@mail.gmail.com>
Subject: Re: [PATCH 1/3] rseq: optimize rseq_update_cpu_id()
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 4:29 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Apr 13, 2021, at 3:36 AM, Eric Dumazet eric.dumazet@gmail.com wrote:
>
> > From: Eric Dumazet <edumazet@google.com>
> >
> > Two put_user() in rseq_update_cpu_id() are replaced
> > by a pair of unsafe_put_user() with appropriate surroundings.
> >
> > This removes one stac/clac pair on x86 in fast path.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Arjun Roy <arjunroy@google.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > ---
> > kernel/rseq.c | 15 +++++++++++----
> > 1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/rseq.c b/kernel/rseq.c
> > index
> > a4f86a9d6937cdfa2f13d1dcc9be863c1943d06f..d2689ccbb132c0fc8ec0924008771e5ee1ca855e
> > 100644
> > --- a/kernel/rseq.c
> > +++ b/kernel/rseq.c
> > @@ -84,13 +84,20 @@
> > static int rseq_update_cpu_id(struct task_struct *t)
> > {
> >       u32 cpu_id = raw_smp_processor_id();
> > +     struct rseq *r = t->rseq;
>
> AFAIU the variable above should be a struct rseq __user *.
>
> Elsewhere in the file we use "rseq" rather than "r" for struct rseq __user *
> variable name, it would be better to keep the naming consistent across the file
> if possible.

Absolutely, thanks for the feedback.
