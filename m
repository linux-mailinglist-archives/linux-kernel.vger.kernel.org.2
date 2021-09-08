Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1014040CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 23:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbhIHWAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 18:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbhIHWAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 18:00:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2409AC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 14:59:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n5so5350908wro.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 14:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+LR8frgXEe3ow5R83HHc128uph7ex7SBJh9j6e+S9jU=;
        b=Db08IbxJ13EWKYQNGZ2BEuYsakhUSoIWFEo23AxCjh0j+YYZUAYir81XobnmhdiQFC
         1iSVB74cCVzPUS1vGu59yP4rT4pCrd4YDNYH7j7c3dsrwlrdxSnP4oy0loI6+6CtalWJ
         LKXTNXMJVTgRiy0U9o3cqCOmJTqWvfPGpCabxpOLQ71sUgtL4uo66+t8MWgMPhYieet8
         sbMaCQLCKSjeTPhIL7lYpAIf6SX9Jo+Y3p5sQFLYc1YSIVTP9WSd2LfIphpbBDvU1LVL
         4TTP9wwvFOJnOuTkfJZQqhMJ1gBJZD4IDEXw290MmI/VunlC/CDYSxsp1JwZn9nDgCqs
         99DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+LR8frgXEe3ow5R83HHc128uph7ex7SBJh9j6e+S9jU=;
        b=EIQ97BjWXdybGC2Bv9cAHRW0hdJsC926FS5cVSY0RAVhqmx4yCjfXb3uxe4TMy+nNN
         a7YKfBlwCfHE9o+ASlmiihAieicieWDRROG5hkOjrn/iF7q7+Ix8aiTOF6K2MWPVeSwD
         j5bFTRz9CdMsz2lutkG+In485CFY9UJygiukM7vTTE1MIszATnZ0BOOmWzuL8tbt4rRb
         Sh07zmIuKLdFUZSQReYkofTGbmwF8nvPVy4U+v1W2E4DyACuDeOB399qwFi00IfwTOM2
         K5ox4fiNBSMdR3whbzobdG+YPgzGJ14gEGR7j/BTgvrUmV9W0dLsXtnWEqRkwNhxzM2D
         N13A==
X-Gm-Message-State: AOAM532OKJv2GpKJtTZypgkne7ZverBXZTftHTSxAaHk1SxAxYeUAmJF
        b7UDAAaJ6mQyRslQHfYTtGPgD61PJ1KPxA==
X-Google-Smtp-Source: ABdhPJy9LuBylSkfGDLomcMbGliUY/gfERj/SWVa0XWOQWuMBf30BqzMK/CEeBFTW6NaaPpKmnfwMg==
X-Received: by 2002:adf:f208:: with SMTP id p8mr418298wro.379.1631138342436;
        Wed, 08 Sep 2021 14:59:02 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:6c42:a08d:7652:61ef])
        by smtp.gmail.com with ESMTPSA id o10sm358689wrc.16.2021.09.08.14.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 14:59:01 -0700 (PDT)
Date:   Wed, 8 Sep 2021 23:58:56 +0200
From:   Marco Elver <elver@google.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
Message-ID: <YTkyIAevt7XOd+8j@elver.google.com>
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
 <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <YTkjJPCdR1VGaaVm@archlinux-ax161>
 <75a10e8b-9f11-64c4-460b-9f3ac09965e2@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75a10e8b-9f11-64c4-460b-9f3ac09965e2@roeck-us.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 02:16PM -0700, Guenter Roeck wrote:
> On 9/8/21 1:55 PM, Nathan Chancellor wrote:
[...]
> > I have started taking a look at these. Most of the allmodconfig ones
> > appear to be related to CONFIG_KASAN, which is now supported for
> > CONFIG_ARM.
> > 
> 
> Would it make sense to make KASAN depend on !COMPILE_TEST ?
> After all, the point of KASAN is runtime testing, not build testing.

It'd be good to avoid. It has helped uncover build issues with KASAN in
the past. Or at least make it dependent on the problematic architecture.
For example if arm is a problem, something like this:

--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -71,7 +71,7 @@ config ARM
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
-	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
+	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL && (!COMPILE_TEST || !CC_IS_CLANG)
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_PFN_VALID
 	select HAVE_ARCH_SECCOMP

More generally, with clang, the problem is known and due to KASAN stack
instrumentation (CONFIG_KASAN_STACK):

 | config KASAN_STACK
 |         bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
 |         depends on KASAN_GENERIC || KASAN_SW_TAGS
 |         depends on !ARCH_DISABLE_KASAN_INLINE
 |         default y if CC_IS_GCC
 |         help
 |           The LLVM stack address sanitizer has a know problem that
 |           causes excessive stack usage in a lot of functions, see
 |           https://bugs.llvm.org/show_bug.cgi?id=38809
 |           Disabling asan-stack makes it safe to run kernels build
 |           with clang-8 with KASAN enabled, though it loses some of
 |           the functionality.
 |           This feature is always disabled when compile-testing with clang
 |           to avoid cluttering the output in stack overflow warnings,
 |           but clang users can still enable it for builds without
 |           CONFIG_COMPILE_TEST.  On gcc it is assumed to always be safe
 |           to use and enabled by default.
 |           If the architecture disables inline instrumentation, stack
 |           instrumentation is also disabled as it adds inline-style
 |           instrumentation that is run unconditionally.

This is already disabled if COMPILE_TEST and building with clang. As
far as I know, there's no easy fix for clang and it's been discussed
many times over with LLVM devs.

Thanks,
-- Marco
