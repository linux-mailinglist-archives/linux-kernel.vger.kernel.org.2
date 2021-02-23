Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A6C32322D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbhBWUfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbhBWUeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:34:05 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8988DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 12:33:24 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id q23so4751169lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 12:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3sg+OeCgz4GLRdZpy+L4bmO3J9UzrCn26WKgjdPuNfw=;
        b=g1Pn72u5uL74P2H2LCF7WVGA4wVJ5dAWk76MTdDNlQ6+LHll4AkW3pC9L82QYdt5Kc
         gulxLmF5GqzvV+zgpfowsgbVo+M2kryg9VHTFeqCev/aDQdpSTUu24bq4SgLj3sOPpFb
         Aozd8vPMflkbqsbsMz29ykAi16L9cZ75EwLGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3sg+OeCgz4GLRdZpy+L4bmO3J9UzrCn26WKgjdPuNfw=;
        b=YSLtAUGqMspcHapLuVY+833EPLLLceA4OCi7gKTwqYnR+8giWQYcKuBKJl30Fhlnuw
         GKzV6XehXn/NXmencK3LH+mPmEA1r6K3ZLLCj/K0iq/ZseFhIKQiBSZ2NsBWxoaEaRHA
         YXfyTy91nUuuJ/ROnD3wogJIeVjA+BZCb81O9NcRoTCQ6Fk+lRqT5wXw3C6fvCW6GdH/
         grWRM+tLWFHDU1GHsuhkCpyVa/7juAThMHPUy7AMjOSJPAbjiJRiNe+Px4CpJDeyDm3W
         1gwuk8y7PdMq3+qgRH+FLSk+7MmvaW1GjdPYClCBEvJq97iJraVi0jpNuFsQjM0jask0
         nnWA==
X-Gm-Message-State: AOAM532V1ITj2dzuwROtvy2a1wqtsqoPYkes79hbZwo43Y6NS7tTLCOj
        cWndyUb8WP0mlZxIbl8cv4SWRHtPRA7J0w==
X-Google-Smtp-Source: ABdhPJwJy+yjH/nytPRhHr542i3Dt0zWY6hnyqgTV0G9+KoXKYqyhrrkGXBUjL+YN656ZfzTPyjx4A==
X-Received: by 2002:a2e:3e08:: with SMTP id l8mr10267917lja.69.1614112402802;
        Tue, 23 Feb 2021 12:33:22 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id t14sm3141340ljc.70.2021.02.23.12.33.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 12:33:22 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id r23so64749267ljh.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 12:33:21 -0800 (PST)
X-Received: by 2002:a05:651c:110e:: with SMTP id d14mr18756015ljo.220.1614112401658;
 Tue, 23 Feb 2021 12:33:21 -0800 (PST)
MIME-Version: 1.0
References: <202102221504.0418BE2D1@keescook> <CAHk-=wgUS-vqCk_d0wwBWgk4tRgFpYvfyob5y28c85msqpbjuw@mail.gmail.com>
In-Reply-To: <CAHk-=wgUS-vqCk_d0wwBWgk4tRgFpYvfyob5y28c85msqpbjuw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Feb 2021 12:33:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgQ=oaLD_ybzhOP+8LFNZH3Qzpc-dp4XB4cXxXLReCdnQ@mail.gmail.com>
Message-ID: <CAHk-=wgQ=oaLD_ybzhOP+8LFNZH3Qzpc-dp4XB4cXxXLReCdnQ@mail.gmail.com>
Subject: Re: [GIT PULL v2] clang-lto for v5.12-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <morbo@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        George Burgess IV <gbiv@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 9:49 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Feb 22, 2021 at 3:11 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > While x86 LTO enablement is done[1], it depends on some objtool
> > clean-ups[2], though it appears those actually have been in linux-next
> > (via tip/objtool/core), so it's possible that if that tree lands [..]
>
> That tree is actually next on my list of things to merge after this
> one, so it should be out soonish.

"soonish" turned out to be later than I thought, because my "build
changes" set of pulls included the module change that I then wasted a
lot of time on trying to figure out why it slowed down my build so
much.

But it's out now, as pr-tracker-bot already noted.

              Linus
