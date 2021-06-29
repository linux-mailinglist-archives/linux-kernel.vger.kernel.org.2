Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8639A3B779E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 20:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbhF2SKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 14:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbhF2SJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 14:09:59 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D42C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 11:07:31 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a15so33176119lfr.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RrPyRQ5IO5eewgSwjbnscAxAW9L+6cXFp6QTzBqY4/w=;
        b=DwLkNq7SHWRjgUjXov7smOgfFqoIqfdHao/1+I+k6kXqTB0ouzJ2e3lTxDYIKpVJtx
         36G6M4NcrwNK/ZnKdheqPNTEAHi9hS4WBY4wAUpV8OHUzqzjYLXvUEa2URrzj4q0A4gL
         GDI1gvURikS6TbLfSGHymcR86Fx1v041Ly1Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RrPyRQ5IO5eewgSwjbnscAxAW9L+6cXFp6QTzBqY4/w=;
        b=HxrfDpC+1V5WvhJil7WDdmP8MXSCmRyGs4AV0BaRQTYmXSnli6f8/Q0xbIim86T2C1
         xByXuiynrzcB4rDXkIJ8MIBEhtGLPuPLkTixdR4KmISnL11hBT5hqm6y9Rh59/vAEoZ+
         XHS3moGzX+O9oRL/t5YG9M87l/P2xmke3JnYTBmdP5N48Mfsd4z11RmotATM+XM18cis
         IIR4NG/2eQpKQlQy67rX8UJED39/XQf1/chJ3IccI6yT0Hq8ZLkCa4mlB9bK2aC4aU0W
         r9dBrWeSjLh8JZt1dlM+Tp5ASz1xLRDqAkfbilR0Yr1a06ukIG8BajO0TGX6/YHuBmTC
         QXUw==
X-Gm-Message-State: AOAM533Lll316eX4VmqsTcZNBCeRXMJb6UpwKiIHI4/95D0ipa+OVq2g
        PdzW9IsHp5bJ6hoTJ8DpNqUcvHAP5NFGSzJySuM=
X-Google-Smtp-Source: ABdhPJwmVt0IGwA+vvlKMagvglcW07ZYGUaQsgFR7Cy31agwN+tvwTfMwTcC6LXwCBs7UGA3m7k4nQ==
X-Received: by 2002:a19:f70b:: with SMTP id z11mr25308278lfe.156.1624990049567;
        Tue, 29 Jun 2021 11:07:29 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id q15sm1627593ljg.126.2021.06.29.11.07.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 11:07:27 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id r16so32158779ljk.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 11:07:27 -0700 (PDT)
X-Received: by 2002:a2e:b553:: with SMTP id a19mr4820656ljn.507.1624990047466;
 Tue, 29 Jun 2021 11:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <87fsx1vcr9.fsf@disp2133> <CAHk-=wj1z-NKxedgZvSS37iH=EKE47PkL=+BYccAUtsuB1sySQ@mail.gmail.com>
 <20210629171757.shyr222zjpm6ev5t@example.org>
In-Reply-To: <20210629171757.shyr222zjpm6ev5t@example.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Jun 2021 11:07:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcpK3XdFKJ98b_YucXbQMJMgJssAk=sQ-XUo-tyiMjVg@mail.gmail.com>
Message-ID: <CAHk-=wgcpK3XdFKJ98b_YucXbQMJMgJssAk=sQ-XUo-tyiMjVg@mail.gmail.com>
Subject: Re: [GIT PULL] ucounts: Count rlimits in each user namespace
To:     Alexey Gladkov <legion@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 10:18 AM Alexey Gladkov <legion@kernel.org> wrote:
>
>
> > And why test for "ucounts" being non-NULL in
> >
> >                 if (ucounts && dec_rlimit_ucounts(ucounts,
> > UCOUNT_RLIMIT_SIGPENDING, 1))
> >                         put_ucounts(ucounts);
> >
> > when afaik both of those should be happy with a NULL 'ucounts' pointer
> > (if it was NULL, we certainly already used it for the reverse
> > operations for get_ucounts() and inc_rlimit_ucounts()..)
>
> The get_ucount() can theoretically return NULL. It increments the
> reference counter and if it overflows, the function will return NULL.

.. but my point is that dec_rlimit_ucounts() and put_ucounts() should
be fine with whatever get_ucounts() returned. No

It looks like put_ucounts() is unhappy with a NULL ucounts argument,
but I think _that_ is what should get fixed.

I think that conceptually we should have two clear alternatives:

 (a) either "get_ucounts()" returning NULL should be an error, and we
would have returned long before

or

 (b) a NULL uncounts is usable, and a sequence like
put_ucounts(get_ucounts()) should just always work.

And honestly, a lot of the other ucounts funcrtions seem to take that
(b) approach. Example in that very function:

        ucounts = task_ucounts(t);
        sigpending = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING, 1);

which at no point tested for NULL or returned an error.

(And that also implies that the comment in dec_rlimit_ucounts() about
"Silence compiler warning" should just go away, because it's not just
a compiler warning, it's a required initialization).

              Linus
