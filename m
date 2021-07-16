Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394053CB043
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 03:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhGPBHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 21:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbhGPBH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 21:07:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D570CC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 18:04:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x25so13141673lfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 18:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OHH9lYUaBVj6TC0lbiFZ8mDVTJDCbXfy64O8dU0tYU=;
        b=cQSH4075UaaLzmUmJos2RUBlOMIycIPXTYPbPDrEtz0NEbwxZzOfxFt7yqvezst2RJ
         vZRGo4vsFQFviWOZ2Z+6CW729b4ZfU+2+tcL9xQ0pb3yOOwdnHMw5RV+COg6uuk0vJcx
         /Bkz5ltlvbpW9CCy1QuwRzHrFooFk/BTJpv6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OHH9lYUaBVj6TC0lbiFZ8mDVTJDCbXfy64O8dU0tYU=;
        b=D0mYpbuDaPb8sEuLxHRn85c5lRrSoTQMgaaoIrh6WRT0zqnMm1JXGxzVsfs1o/IQ8+
         +yiwXQWN6I3CKQ/yWXjuqwjIPEs2+pey1piym6EiGRUIbYc7YPIV827ZZK4h3ELsPKEL
         peRejIYUgHiUEgiKxP0DL90Bmpy8ZBhcyq4SmJxi0rILztBks5ylxuRGlomNLf3+JrLr
         XbsesNtxXBdY2wky6eJKzj5CryMaBCvRPDigmNKzkBtRgToQ4cWQJ5SYLQ8iwPdP2evj
         Y0GEljtl19Qg4MGEmV1lkK8aqZsXfFgNLXgh/pF7xttIvIEGaWlyy05OWn7GudZOuegb
         CD3A==
X-Gm-Message-State: AOAM531f8rKWM7F/0g+IzaIb+J8+3HcADYex+T6gpdlug5M7z4Zxd0/x
        EXqM+66XU0rIG50uLz4mpBKzF7uDcKThdUSX
X-Google-Smtp-Source: ABdhPJz083kxBkGdKIwqQoyFwLsnkRwSucMpO3sp+WfTrRImf8Hw6Jz/+2sZw7VFgjV55tGFx94zeQ==
X-Received: by 2002:a05:6512:1518:: with SMTP id bq24mr5380022lfb.271.1626397471994;
        Thu, 15 Jul 2021 18:04:31 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id u26sm522921lfi.305.2021.07.15.18.04.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 18:04:31 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id u13so13154981lfs.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 18:04:31 -0700 (PDT)
X-Received: by 2002:ac2:44ad:: with SMTP id c13mr5390249lfm.377.1626397471252;
 Thu, 15 Jul 2021 18:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210714200523.GA10606@embeddedor>
In-Reply-To: <20210714200523.GA10606@embeddedor>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Jul 2021 18:04:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQeeUiv+P_4cZfCy-hY13yGqCGS-scKGhuJ-SAzz2doA@mail.gmail.com>
Message-ID: <CAHk-=wjQeeUiv+P_4cZfCy-hY13yGqCGS-scKGhuJ-SAzz2doA@mail.gmail.com>
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.14-rc2
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 1:03 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-clang-5.14-rc2

Grr.

I merged this, but when I actually tested it on my clang build, it
turns out that the clang "-Wimplicit-fallthrough" flag is unbelievable
garbage.

I get

   warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]

and the stupid warning doesn't even say WHERE THE PROBLEM HAPPENS.

No file name, no line numbers. Just this pointless garbage warning.

Honestly, how does a compiler even do something that broken? Am I
supposed to use my sixth sense to guide me in finding the warning?

I like the concept of the fallthrough warning, but it looks like the
clang implementation of it is so unbelievably broken that it's getting
disabled again.

Yeah, I can

 (a) build the kernel without any parallelism

 (b) use ">&" to get both output and errors into the same file

 (c) see that it says

    CC      kernel/sched/core.o
  warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
  1 warning generated.

and now I see at least which _file_ it is that causes that warning.

I can then use my incredible powers of deduction (it's almost like a
sixth sense, but helped by the fact that there's only one single
"fallthrough" statement in that file) to figure out that it's
triggered by this code:

                case cpuset:
                        if (IS_ENABLED(CONFIG_CPUSETS)) {
                                cpuset_cpus_allowed_fallback(p);
                                state = possible;
                                break;
                        }
                        fallthrough;
                case possible:

and it all makes it clear that the clang warning is just incredibly
broken garbage not only in that lack of filename and line number, but
just in general.

Yeah, I'm a bit pissed off at this. This clang warning really is
WRONG. It's so wrong in so many ways that I don't know what to say.

Except "yeah, that broken option is getting reverted again, because
the clang people messed up completely".

It's sad to see that people wasted time and effort on trying to make
clang happy, when it turns out that clang just gets this so _totally_
wrong.

                     Linus
