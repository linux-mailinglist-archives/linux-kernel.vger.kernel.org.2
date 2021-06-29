Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10BF3B7982
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 22:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbhF2UrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 16:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhF2UrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:47:20 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E452C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 13:44:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id in17-20020a17090b4391b0290170ba0ec7fcso2465433pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 13:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QTbTjV7KRsVKAu1VwHOJKbrx5NoERdSq3JOZOY+nE0I=;
        b=K534EASLNAKHoCsYl9cpXX+MSdYH4heYejdUuL86PE769cXiLKPgGNkGiebudspzr4
         KxE92HY7gkDh3L9aLFfbNceBdNsmn9nCm4k7mu6L3h2rF+UczfL+owjodfAriknhnXbh
         XBh8S3UIThCqGAFLqYRsAHU/WM6+cmPazKDt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QTbTjV7KRsVKAu1VwHOJKbrx5NoERdSq3JOZOY+nE0I=;
        b=jltckxaF3a4H4SzdJ4vW9oLajICpXzEySBwjYNbaV427JqTq10uh5kHV6aAsFf1jBV
         IU0xEFkSgGOSGlhOqHM+1soEVESCRP6pcG853riZj6zOzGgKxyKcILE7YpcMNjGWbTEJ
         j0X7FanBVRLEPIBnE3YUfzK2Gby6PlR+cPGcW2DYHFnu4bUu+uqRLDN3+zKmORUREb03
         L83keoT37gQCDOd8iT73wgUp1TZUIV7PQTP8Z7ZGm/nfvvFUAqk7vZi7ZbjCK/DnpiQM
         G6irjgI72iHhJeDbTYkye15KBMuB+g2P6PjuFh8byHHTEtHDgVi3pHw7gqp2pfa5OIc6
         PtlQ==
X-Gm-Message-State: AOAM531kVqfAfk3idaXfyYE3M3GEA7eJdRv/o8OxWsGDDGgRZNno6rn0
        7OwFQa/n/mU+yx/28FTlRtIbBg==
X-Google-Smtp-Source: ABdhPJw1wnIIAGvekomCdtc0VpUjsFMssIiRDvsldABWkLn5zyXCXoNBW9WdJxZXtrMhBHxrtHLc6A==
X-Received: by 2002:a17:902:6ac5:b029:128:ad84:c7b0 with SMTP id i5-20020a1709026ac5b0290128ad84c7b0mr19874994plt.19.1624999492442;
        Tue, 29 Jun 2021 13:44:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w14sm19755138pjb.3.2021.06.29.13.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 13:44:51 -0700 (PDT)
Date:   Tue, 29 Jun 2021 13:44:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill Wendling <morbo@google.com>,
        Bill Wendling <wcw@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL] Clang feature updates for v5.14-rc1
Message-ID: <202106291311.20AB10D04@keescook>
References: <202106281231.E99B92BB13@keescook>
 <CAHk-=whqCT0BeqBQhW8D-YoLLgp_eFY=8Y=9ieREM5xx0ef08w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whqCT0BeqBQhW8D-YoLLgp_eFY=8Y=9ieREM5xx0ef08w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 07:49:04PM -0700, Linus Torvalds wrote:
> On Mon, Jun 28, 2021 at 12:32 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > The big addition for this merge window is the core support for Clang's
> > Profile Guided Optimization, which lets Clang build the kernel for
> > improved performance when running specific kernel workloads. This
> > currently covers only vmlinux, but module support is under active
> > development. (Sami Tolvanen, Bill Wendling, Kees Cook, Jarmo Tiitto,
> > Lukas Bulwahn)
> 
> Am I misreading this?
> 
> The PGO data seems to be done by using clang instrumentation, instead
> of done sanely using sample data from a regular "perf" run?

Right, yes. My understanding is that PGO is measurably better than
sample-based profiling. Additionally, it's arch-agnostic (not that that's
meaningful here with only x86 finished), and can gain other analysis
features that aren't possible with perf. I'll let Nick, Fangrui, Bill,
or Sami answer this more directly.

In the meantime I will split the pull request into "PGO" and "everything
else".

> That odd decision seems to not be documented anywhere, and it seems
> odd and counter-productive, and causes all that odd special buffer
> handling and that vmlinux.profraw file etc.
> 
> And it causes the kernel to be bigger and run slower.

Right -- that's expected. It's not designed to be the final kernel
someone uses. :)

-Kees

-- 
Kees Cook
