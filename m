Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1B93A8B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 00:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhFOWFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 18:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhFOWFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 18:05:22 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6572C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:03:16 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i13so683697lfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hoQkSnA6XRE+cBEiih5+9r6Hum8C///uGbJ9Kw2ELY0=;
        b=g/G9Q+2q40OzWZg7EFc4fouy9Igftb3L4Bk0mo8X1bGB4ay1i3Hzx7gDAXF7I9BNha
         YY8Tb63PTEjuFPLmasFyOxKTcxDVfcgS07QY91o7V0JoZ5Vat/JBFwVsnn2A0xh999aU
         tK9zqa7kM5VekQfnZejDxEUyMFWO9psHM4igQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hoQkSnA6XRE+cBEiih5+9r6Hum8C///uGbJ9Kw2ELY0=;
        b=qC4DVUp2BjpeaU71kbo4wnWe7+1Oep1psshCPL36m7aiqJN5wiFkLONEEgZh4ErCgr
         qYQfPLnqTKtsM/cAQckaKY9RLcZgCK0TMuZUbu6NAr6lSkwLNuSEEzSyynQuIlIwVTtA
         /fAwt+XhyyEeWouqvh2i0ce2fl79Mf2zC1zKDiHItI1KmZhfrWa2Ai/UusMfNnCOKw1C
         HLK6D7rXyHGJKnMD68bOHPQytuSn+8nOoUcdEMT2Sg4r7DGGMbSCG+79ae5NEof7m7y2
         PcDkhVAY1y8GvsjTGt1HdDKph0GGAad+iJfQrh4CKQqREAUuJO5njQX8x2lf7ZheRriJ
         l4EQ==
X-Gm-Message-State: AOAM531GOXNbKM2Xrd1/j/hFWrxrxQun/0d1dQk6loBZ+gcbXMxZgzAY
        ZhwaXbRHagRC8co8uLlck6zGm/67iagJKY1h
X-Google-Smtp-Source: ABdhPJxdkONpcJ3W0TK4VIWqbr5MYjiJM7Fj64ZmyN/FcA6kbBHRfhio5DE+Bdtd6CW0O40qBQM2kA==
X-Received: by 2002:a05:6512:c23:: with SMTP id z35mr1067176lfu.549.1623794594806;
        Tue, 15 Jun 2021 15:03:14 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id m8sm30982lfh.198.2021.06.15.15.03.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 15:03:14 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 131so825842ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:03:13 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr1520639ljh.507.1623794593506;
 Tue, 15 Jun 2021 15:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <87sg1p30a1.fsf@disp2133> <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
 <87pmwsytb3.fsf@disp2133> <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133> <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com> <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133> <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133> <87zgvqor7d.fsf_-_@disp2133>
In-Reply-To: <87zgvqor7d.fsf_-_@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Jun 2021 15:02:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
Message-ID: <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
Subject: Re: [PATCH] alpha: Add extra switch_stack frames in exit, exec, and
 kernel threads
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 12:36 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> I looked and there nothing I can do that is not arch specific, so
> whack the moles with a minimal backportable fix.
>
> This change survives boot testing on qemu-system-alpha.

So as mentioned in the other thread, I think this patch is exactly right.

However, the need for this part

> @@ -785,6 +785,7 @@ ret_from_kernel_thread:
>         mov     $9, $27
>         mov     $10, $16
>         jsr     $26, ($9)
> +       lda     $sp, SWITCH_STACK_SIZE($sp)
>         br      $31, ret_to_user
>  .end ret_from_kernel_thread

obviously eluded me in my "how about something like this", and I had
to really try to figure out why we'd ever return.

Which is why I came to that "oooh - kernel_execve()" realization.

It might be good to comment on that somewhere. And if you can think of
some other case, that should be mentioned too.

Anyway, thanks for looking into this odd case. And if you have a
test-case for this all, it really would be a good thing. Yes, it
should only affect a couple of odd-ball architectures, but still... It
would also be good to hear that you actually did verify the behavior
of this patch wrt that ptrace-of-io-worker-threads case..

           Linus

               Linus
