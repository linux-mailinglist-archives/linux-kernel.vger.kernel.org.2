Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376D0390C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 00:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhEYWbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 18:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhEYWbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 18:31:40 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD1EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 15:30:10 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id t24so16287632oiw.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 15:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRai1FABwcG3qj1sZ1sAYvilNEmlVeCZF91PHh6OwVY=;
        b=ABiL69p7DpymrzTzefq+Ldtsg4kNOO0yvkKh9JLXXNM8QRPXYi3wnJln4B9ZhNTVKe
         dOIZgxHEz/R569knkBfPb8YRD6lQUs7KJapkMzhPVRrcGJbqHuzBqFAHVsHX3r6JiS/o
         Gu3sJXEvP4XfKNljzu3u3moBSme+0BZGHWUtJumXpIb0kTrK56V/+1V1AX+3nGC5eL8g
         oM20HqoMV/GyqmN8CrJ1dKiYjJv7toOIZ6JcFwWO9QbbWOh1+De1CIztKlf8CaFhxhgx
         0y8e9cYA9xIFVnLNz0lg4hnH8GgOwK9akQrqDGCCef4MP7L2zjpnHJO5ely2rWLO2mqC
         6gOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRai1FABwcG3qj1sZ1sAYvilNEmlVeCZF91PHh6OwVY=;
        b=j5/a43LRXtDo4vdRXKGwvCoMZ2ajX3NjU/TPxPiX6g+l9ayOon3nIgUid9wtV7t7u8
         DtqOu3GmYvuhVe7bOwHwTIYoIJgaqj//Ljcl8sZ9EaHKvwjdr+MyP9WftPZH+0J3tgdu
         PwuseC/dmrW30pIk9+YQY8AFut7VYgvlHoWU+yPK4RGhuYPEEvLOhCS5FmsE0owvSLHF
         L3f2ZTJKmV3+Tpm0Ajf+cjbxIMWF87gx1zIB7uTzhMl+JwP/mHybCI0gfXFLbApNLPUz
         kqcsw9FShqfuPargt75sVH4euxBx4xuRVrZsDjSe3JFzbAZo5VU/KeCQ/1ZFVkF7YGfE
         KF/A==
X-Gm-Message-State: AOAM532RdhaF25AEcE+wEeTaLgU2sMyqJa/YSQvPzFvaOk5dcoeknObD
        fggUOFx5AeJvc6JHYZ2LlBsCM/IEbbchJEZKBOOV7g==
X-Google-Smtp-Source: ABdhPJyYUUYdIO3NltesNXilMOlQNA5nHhciFqjIUPvEzjEBsn6S6p7pyfyaJXSHDv3c/BRW0vZPYNEmcXXVgCYcaNY=
X-Received: by 2002:a05:6808:144f:: with SMTP id x15mr15631888oiv.172.1621981809478;
 Tue, 25 May 2021 15:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210525175819.699786-1-elver@google.com> <202105260629.X6n5yc4D-lkp@intel.com>
In-Reply-To: <202105260629.X6n5yc4D-lkp@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 26 May 2021 00:29:58 +0200
Message-ID: <CANpmjNMT=HQQpK9U4bnoGb-=+KJC246dSZ3u2VB0TXw4itsB-w@mail.gmail.com>
Subject: Re: [PATCH] kcov: add __no_sanitize_coverage to fix noinstr for all architectures
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021 at 00:23, kernel test robot <lkp@intel.com> wrote:
[...]
> [auto build test WARNING on linux/master]
> [also build test WARNING on kees/for-next/pstore linus/master v5.13-rc3 next-20210525]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Marco-Elver/kcov-add-__no_sanitize_coverage-to-fix-noinstr-for-all-architectures/20210526-020046
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git dd860052c99b1e088352bdd4fb7aef46f8d2ef47
> config: s390-randconfig-r002-20210525 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 99155e913e9bad5f7f8a247f8bb3a3ff3da74af1)

^^^ you're using a Clang pre-release, breakages are expected until
Clang 13 is final.

I think there was a thread about this at some point. I guess LKP has
decided that testing Clang pre-releases is fair game? I guess it's
useful, but this warning here needs to be ignored. It'll go away when
you rebuild your pre-release Clang 13 from the latest LLVM main
branch.

[...]
> >> arch/s390/kernel/nmi.c:182:6: warning: unknown sanitizer 'coverage' ignored [-Wunknown-sanitizers]
>    void noinstr s390_handle_mcck(void)
>         ^
>    include/linux/compiler_types.h:213:35: note: expanded from macro 'noinstr'
>            __no_kcsan __no_sanitize_address __no_sanitize_coverage
>                                             ^
>    include/linux/compiler-clang.h:49:59: note: expanded from macro '__no_sanitize_coverage'
>    #define __no_sanitize_coverage __attribute__((no_sanitize("coverage")))
>                                                              ^

Clang 13 will support the attribute, but this is a pre-release Clang
13 -- so please ignore the report. FWIW, I tested my patch of course
with a version of Clang 13 that supports the attribute. :-)

Thanks,
-- Marco
