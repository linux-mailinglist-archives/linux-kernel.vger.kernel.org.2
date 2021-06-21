Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CF43AEC9C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFUPkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUPku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:40:50 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA13C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:38:35 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id c11so25848082ljd.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R/gsr/Z80fSxEB0qmGqShvDUtlhm4ESakW3xcimnUEw=;
        b=a39nbPZCP+nWMeIZ/x5qt0slwYnbNb/TvhmNaAml5kNvhs0i32rgF44OFGvy4ACZ5M
         SfNAyRTK1aJ1m7aW6sC2No3kMhETcLZ7kUjianICGGeVyVPSyizOAaXDDMbjMew6KcRK
         SAT8eIJUsUOJFoDNwA7oyYdllQrDrIWi08wng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R/gsr/Z80fSxEB0qmGqShvDUtlhm4ESakW3xcimnUEw=;
        b=D303n3PqZGZuwrpeUKw+hHPRRIvDvOWpQbeox4A5DlsTLMufd9mk+54GY59dXRjw74
         IGy+DWsSXafbGThkC3g6clm0hQ91vzw+xj/plHmgQRanRxxPH1JYc/bSTrfdGZneP24D
         kDo8l88D0XOiYJSNp5kxyudQMG97GY8HVFJo+2jbH3CaQPZRQrAIgQAxqstYUgOC6Z2V
         1u7TjWwy69Vuw4ItxyDxTxGVr6yE5snjc1/VIlXUYiZZ00zWPPu/3hmFyNJDEGABc+G1
         Eu9snGSpQGZ1SrJMr4eK9Eb1YdBDEAqfdSzmHMKmzeZ4g/QW7stllYuDAvlmw3aMT22p
         Nbqg==
X-Gm-Message-State: AOAM533us4QVQlwwwY8Dmvi5Kp2oJq9nLLZmP7pnRVzloN8YS/5Lw5hV
        3yw4WEuxEgrIDM8utcAcCm3I4tnO2IReMcWj
X-Google-Smtp-Source: ABdhPJxHA26kM3LyCl9Bqunqau4IEYjAf7a+hw3p5m6PPOZvup6YsqhyHaD4XkirkWinRDu2J0qRWw==
X-Received: by 2002:a2e:891a:: with SMTP id d26mr22144454lji.392.1624289911757;
        Mon, 21 Jun 2021 08:38:31 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id o16sm1491073lfb.98.2021.06.21.08.38.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 08:38:30 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id a21so693227ljj.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:38:30 -0700 (PDT)
X-Received: by 2002:a2e:b618:: with SMTP id r24mr22042332ljn.48.1624289909978;
 Mon, 21 Jun 2021 08:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <87pmwsytb3.fsf@disp2133> <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133> <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com> <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133> <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133> <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
 <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
In-Reply-To: <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Jun 2021 08:38:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjC_=iwj61vSZ0orPGjrxhDK3Ob2D4eaRpXXFdAbF6coQ@mail.gmail.com>
Message-ID: <CAHk-=wjC_=iwj61vSZ0orPGjrxhDK3Ob2D4eaRpXXFdAbF6coQ@mail.gmail.com>
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
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

On Mon, Jun 21, 2021 at 6:55 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Jun 15, 2021 at 02:58:12PM -0700, Linus Torvalds wrote:
>
> > And I think our horrible "kernel threads return to user space when
> > done" is absolutely horrifically nasty. Maybe of the clever sort, but
> > mostly of the historical horror sort.
>
> How would you prefer to handle that, then?  Separate magical path from
> kernel_execve() to switch to userland?  We used to have something of
> that sort, and that had been a real horror...

Hmm. Maybe the alternatives would all be worse. The current thing is
clever, and shares the return path with the normal case. It's just
also a bit surprising, in that a kernel thread normally must not
return - with the magical exception of "if it had done a
kernel_execve() at some point, then returning is magically the way you
actually start user mode".

So it all feels very special, and there's not even a comment about it.

I think we only have two users of that thing (the very first 'init',
and user-mode-helpr), So I guess it doesn't really matter.

            Linus
