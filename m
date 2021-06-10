Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE4F3A36DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 00:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFJWNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 18:13:49 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:46972 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFJWNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 18:13:45 -0400
Received: by mail-ej1-f48.google.com with SMTP id he7so1398979ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 15:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IH1SveIFJ5wJ6kocsX0s8v3WiB0uqtridXReuF2KUMY=;
        b=Qzof8FNEW2Ba5XPZGpDfZSR6rdtd6WGsu717h8Er0yjM+Qrz/xmDEYF47olKQxMaDV
         /WuPvFIxyme1vchmGP1HhMrAqH5OzNDJ6D669STTMCTBS8PPP8U2SeAmmSAiNv3xHWUT
         sYS5gTDilCKxc+IrHBQDdFNyeZ8axOedobMUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IH1SveIFJ5wJ6kocsX0s8v3WiB0uqtridXReuF2KUMY=;
        b=A3QZp3UgOzkirYvEauz+LwrgkkVeL+iC3DIrMQ9FOF4uWrnKDLKLYBmslZcR1yms61
         hJx1FmIIK4BhYCPOJQf40O9PQdERTREGERJ7Q2x3IBU7vI8ltvyvuYh3SuPdCfnFMmqX
         hxCNPIvruTJmTwQog/NoJ7juQdfmkemAiERl6K6an5LeWzSQ1daHKdx1eAJ6X6O4/M0H
         su2NDIOjAKqCAa8wfTGlu0H0STe6kFTi5ox737c8XV/gDOm64GYSUjHemuVVc4Iy7UIQ
         Hkk1ILZOtPNgGBZB3kuhVONmfbBg+Sz4ckVdUwMvHjHhweJBAZsySmyAIu8Rij1JzbO7
         cQyg==
X-Gm-Message-State: AOAM533/tNxTLaM2R6ck+dmFHdLnjH+cfYlyda412OwFg/CSmx1vJ8+N
        yAEWPEai1i+Y/+tjmTWVUseuoJEA4TDEQV6vacc=
X-Google-Smtp-Source: ABdhPJxcP+Y+74mF5ic2l1V/7ohuFsbNnz1lbGOm8VDySkRNviFRTktkXap5wlfW4XbCiAjTRQIS/g==
X-Received: by 2002:a17:906:b212:: with SMTP id p18mr595521ejz.109.1623363034818;
        Thu, 10 Jun 2021 15:10:34 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id s2sm1956381edu.89.2021.06.10.15.10.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 15:10:34 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id og14so1454829ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 15:10:34 -0700 (PDT)
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr578806lfl.253.1623362689248;
 Thu, 10 Jun 2021 15:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <87sg1p30a1.fsf@disp2133>
In-Reply-To: <87sg1p30a1.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jun 2021 15:04:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
Message-ID: <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
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
        Tejun Heo <tj@kernel.org>,
        Daniel Jacobowitz <drow@nevyn.them.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 1:58 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The problem is sometimes we read all of the registers from
> a context where they are not all saved.

Ouch. Yes. And this is really painful because none of the *normal*
architectures do this, so it gets absolutely no coverage.

> I think at this point we need to say that the architectures that have a
> do this need to be fixed to at least call do_exit and the kernel
> function in create_io_thread with the deeper stack.

Yeah. We traditionally have that requirement for fork() and friends
too (vfork/clone), so adding exit and io_uring to do so seems like the
most straightforward thing.

But I really wish we had some way to test and trigger this so that we
wouldn't get caught on this before. Something in task_pt_regs() that
catches "this doesn't actually work" and does a WARN_ON_ONCE() on the
affected architectures?

               Linus
