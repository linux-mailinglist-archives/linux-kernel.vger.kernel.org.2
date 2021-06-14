Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468533A6DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhFNSIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbhFNSIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:08:06 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2649CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 11:05:49 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z22so21336666ljh.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d5pPoPmj9czkJzeqD7niUpuqvNetFuH2gRB1nv/63Lg=;
        b=WulI38RKNnZlBBntcxUPt8JAxXnE3uJz5pzHXyWBRCRnTnG0Yu+ABA74Cgy+565IuD
         6GKLQY0dbRxxfsP8xoZwSyknoEn29YNQ936sqO8H+6wb6ewjwQqYzQ/GIyrz3lK35gpm
         qDvYpFBB762tCwzj1T2osyCCoegBTHWpb8d4XdHogBgo1s6Tk8PaMItaSP46RE2G+lhA
         B0lTjFaUo5/PVXYCJvEXQIzG4HaaTso9UBEFqBnAqqHon/niuMFWoIJL4NTyPfYl/1iX
         X3srhtdMyPG+K3HCAaHDYJ45kSB4k6E4Kx0RQzQjERQ9aZSVTu5TgUALrI/iudoVkd5U
         Zl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d5pPoPmj9czkJzeqD7niUpuqvNetFuH2gRB1nv/63Lg=;
        b=pQ1diJ2KelAqK1Y+qED8boMdPPQdiUGwg59UhHbS0hYkx1KSPZDvS2iUmGXgoxLePN
         7qqkT+vXUFbxi3wM5CzoXlg5NQNWddCPm/d0fzHvMotyB8uYJPnf2Os8nRGYIa0yRZnT
         sn7fjDK8fvVuGdXknJu7ft2zCDHZrbUEQY3PelMFFpL7oI8SRtxCYUE2NatvgSFGBJnS
         ePGic9ifLZRM9PraDVQ/lHZDkOTyBWAh9/fpUel+IesS8hvwUW+pGV/rLV7wAIR41PMC
         s+9E1/Uw6/xtpf3ioM31A/oxkQmwP8duLyaKUt9j++YErH4XPvDC6+gxxdysyhtZbJkT
         3CHw==
X-Gm-Message-State: AOAM531jsOM+NPmH8igWRmRBPVCRZFhwOzqjQ7CMmK/jIDc9YYUgtA9M
        n+OEpiBP4ha90nWUZykKghCQfxuFiEE0nrJWdlTACw==
X-Google-Smtp-Source: ABdhPJxT6fGU9LBJjpuJtMAYqRljcpSX3hAlY6mPBfgyAlt3TlLFHY1dfeHOgj1XAYqFDW2MrEtfmZmk18/o8Zn7hNw=
X-Received: by 2002:a2e:9990:: with SMTP id w16mr14391549lji.341.1623693947260;
 Mon, 14 Jun 2021 11:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <YMcssV/n5IBGv4f0@hirez.programming.kicks-ass.net>
 <CAKwvOd=PYrMnNOu060T3Z26RJriNXqu3iM85Daink4-BN__2sQ@mail.gmail.com> <20210614162018.GD68749@worktop.programming.kicks-ass.net>
In-Reply-To: <20210614162018.GD68749@worktop.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 14 Jun 2021 11:05:35 -0700
Message-ID: <CAKwvOdmPTi93n2L0_yQkrzLdmpxzrOR7zggSzonyaw2PGshApw@mail.gmail.com>
Subject: Re: [PATCH] gcov,x86: Mark GCOV broken for x86
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 9:20 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jun 14, 2021 at 09:05:04AM -0700, Nick Desaulniers wrote:
> > On Mon, Jun 14, 2021 at 3:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > >
> > > As recently discovered, there is no function attribute to disable the
> > > -fprofile-generate instrumentation. As such, GCOV is fundamentally
> > > incompatible with architectures that rely on 'noinstr' for correctness.
> >
> > Is there context for comment, or is this patch meant as a joke?
>
> Only if you think recursion in exception entry code is funny.
>
> noinstr *MUST* disable any and all compiler generated instrumentation,
> currently it that isn't the case for -fprofile-gnerate, nor
> -fprofile-arc.
>
> Look for all the fun we had with KCOV back then. Luckily KCOV
> instrumentation was trivial to patch out using objtool, so that's what
> x86 is currently doing.
>
> Luckily both compilers grew a __no_sanitize_coverage recently and we no
> longer have to rely on objtool fixing up the compiler output for much
> longer.
>
>   https://lkml.kernel.org/r/20210527194448.3470080-1-elver@google.com
>
> Now all we need is one more such attribute to kill -fprofile-* stuff.

__attribute__((no_instrument_function)) is already wired to not emit
calls to mcount()/fentry().  I think extending it to also apply to
coverage (-fprofile-arcs) and instrumentation based profiling
(-fprofile-generate) is reasonable.

-- 
Thanks,
~Nick Desaulniers
