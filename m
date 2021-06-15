Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C3A3A8B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 00:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhFOWHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 18:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhFOWHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 18:07:20 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1DEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:05:15 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id og14so255253ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0l26BC8IhPfrvU9uGo+au3BoxNgDLxCiG8UoyUZG3Ik=;
        b=TFaqMa9trH0+DcltUOWD9SDg1O0XP/L7I2lYUz0Glh+HYXXZcxcD6sfjwxWfuZY+Ok
         eLw6VyrExA7gBNmYpfm8IdtmzqFEznbO1gHxDtyivDlT8jzLszkwtH4h94NAyR3n3R/V
         cMVr5dZELWDG4zkytARwyq6x21dhxpBfi5ra4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0l26BC8IhPfrvU9uGo+au3BoxNgDLxCiG8UoyUZG3Ik=;
        b=EFE0tQMeAEsYIVxyo6W1kqbXto6dHb9Ooz87Q+SxHTWqLtyV58bXht4SRTzDhytWzQ
         tESycsNwqpSXJUGWgU2wHD9Xp9xEBKaQ45JCiUlmR3hqOKonUCNw+sE1R5qxjvtN0+pw
         arg5oSWZKL17EyzIaUbjXFB9mPN6v4ZuaE91new8yNjrzhEe1KtWxFhv/N8yzF2eKrjv
         oL9d+zLtOKs81ZCt1JFIFGeiqOFwzIYQH2vKYT5gJSHQNnLyZNePzIgDZ1x6fU0wbFig
         XvxLHGEY3FwXkXdwB8vGNoSmFVQKvdTNV8V3T+FmZy7ngve95w9Dol7pq7xE/8ka5Irh
         A2DA==
X-Gm-Message-State: AOAM530IeMaU2VwJmRQUutdR36HEdHglbV7VArWgEQvn0LTTsqdtfg6/
        fxQ5lv9E70nwxB2lHmuB0AXbqJvmvRkU6hKyXBM=
X-Google-Smtp-Source: ABdhPJxK1kyCXtNJspBdqR+69e77Sm2s7Xf8K5M4L9RTO4acaJJsvzeC65CTvwKgvoDisF5XmF7TuA==
X-Received: by 2002:a17:906:f289:: with SMTP id gu9mr1697268ejb.157.1623794713924;
        Tue, 15 Jun 2021 15:05:13 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id e6sm199811edk.63.2021.06.15.15.05.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 15:05:13 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id k25so220741eja.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:05:13 -0700 (PDT)
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr1069877lfl.253.1623794308417;
 Tue, 15 Jun 2021 14:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <87sg1p30a1.fsf@disp2133> <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
 <87pmwsytb3.fsf@disp2133> <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133> <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com> <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133> <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com> <87fsxjorgs.fsf@disp2133>
In-Reply-To: <87fsxjorgs.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Jun 2021 14:58:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
Message-ID: <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
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

On Tue, Jun 15, 2021 at 12:32 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> I had to update ret_from_kernel_thread to pop that state to get Linus's
> change to boot.  Apparently kernel_threads exiting needs to be handled.

You are very right.

That, btw, seems to be a horrible design mistake, but I think it's how
"kernel_execve()" works - both for the initial "init", but also for
user-mode helper processes.

Both of those cases do "kernel_thread()" to create a new thread, and
then that new kernel thread does kernel_execve() to create the user
space image for that thread. And that act of "execve()" clears
PF_KTHREAD from the thread, and then the final return from the kernel
thread function returns to that new user space.

Or something like that. It's been ages since I looked at that code,
and your patch initially confused the heck out of me because I went
"that can't _possibly_ be needed".

But yes, I think your patch is right.

And I think our horrible "kernel threads return to user space when
done" is absolutely horrifically nasty. Maybe of the clever sort, but
mostly of the historical horror sort.

Or am I mis-rememberting how this ends up working? Did you look at
exactly what it was that returned from kernel threads?

This might be worth commenting on somewhere. But your patch for alpha
looks correct to me. Did you have some test-case to verify ptrace() on
io worker threads?

             Linus
