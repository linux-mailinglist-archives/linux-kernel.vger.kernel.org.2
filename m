Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADFB3EAC22
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhHLUyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbhHLUyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:54:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4151AC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:53:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z20so15911388lfd.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9RfJTrGHwJUwvzLhHrIbGQA08huI6dzioQ3vdmozHz8=;
        b=na6Fi0rSI2rLLK64yvV6CbdZqt7hkfyYZAYj0AwXG3vJy5/HfjDhtg9nXxK8j95c7T
         dWfG6/cghm+y3wG5foWV0MC8XuwoBlAsTmNK4ysMaiCFDZnoNaX9edYR/Omz9goAIBaQ
         LudzJ3LBHt659vx78zb3ru+03UAYUjVXr+fTY+xlrYlKDuKZrFGqQmNM5Yy7kMIVcHxK
         1AyQivcokhPLzvOuqg+CwM1+S5AtOtHkuoMajCB/xbrsC+XyRn2XxlFFNFgX7IfKjCJU
         s4333A5bIHbLDYq+5H8X7Ifs0grku54xMo96dRdUWBA4DU6t9kTOXZMUAhhcxXf6C9x9
         PDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9RfJTrGHwJUwvzLhHrIbGQA08huI6dzioQ3vdmozHz8=;
        b=STGCQvt70jyKT/d4Wx3VbdDeXVa2PyQslXA7LNzm1fvUr4CdnWJulyWzNkeqXBcQke
         zYDuQ+mXnx7yKoE9vzXhs+BLtlTasvlYr2gsCKXaTGZTwRWrThUQbMJXbWGntRzLOXAd
         58zrhPclFRj3n/ucuSgVitfJv2p1IacA9jmObEIg1TzkL7hBLqPH+1WwRah0pHtbtp9g
         5GS8B+VZHramFpzSpbyG+9qulaw7bGbgIbP5Io6E8qh4b8XO5W4VTdiK2+ftyCDbogyL
         wjOvj7C3uHg4ltHfFKLiakiduC/2J8c0XK6iknEuyQN+uGylU0njZmwgxUcNpIAlfYvP
         AAbw==
X-Gm-Message-State: AOAM533FZjcAZHgSFwXy5KFd2fMkvpx7RRIYWWWp9RB1Hfcupbb+mx8Y
        revFld6zCD1Sd44FomyJZ9UGB8Focl0dFyn88IYftw==
X-Google-Smtp-Source: ABdhPJzSfb2zL6p4h6mr9zvtdf09aJL2UzLWyGpzFgoKtJP4f7uX8Ov4OP5v83ZcsQUbgZX+2v47ZLMJi3WTEJ2itIw=
X-Received: by 2002:a05:6512:3989:: with SMTP id j9mr3957811lfu.73.1628801624318;
 Thu, 12 Aug 2021 13:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210812204951.1551782-1-morbo@google.com>
In-Reply-To: <20210812204951.1551782-1-morbo@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 12 Aug 2021 13:53:32 -0700
Message-ID: <CAKwvOdm8R1zh-NPCRZX=_BZhUEey5v=0jjz=ca82tzMn2kFqYg@mail.gmail.com>
Subject: Re: [PATCH] ppc: add "-z notext" flag to disable diagnostic
To:     Bill Wendling <morbo@google.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, itaru.kitayama@riken.jp
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 1:49 PM Bill Wendling <morbo@google.com> wrote:
>
> The "-z notext" flag disables reporting an error if DT_TEXTREL is set on
> PPC with CONFIG=kdump:
>
>   ld.lld: error: can't create dynamic relocation R_PPC64_ADDR64 against
>     local symbol in readonly segment; recompile object files with -fPIC
>     or pass '-Wl,-z,notext' to allow text relocations in the output
>   >>> defined in built-in.a(arch/powerpc/kernel/misc.o)
>   >>> referenced by arch/powerpc/kernel/misc.o:(.text+0x20) in archive
>       built-in.a
>
> The BFD linker disables this by default (though it's configurable in
> current versions). LLD enables this by default. So we add the flag to
> keep LLD from emitting the error.
>
> Signed-off-by: Bill Wendling <morbo@google.com>

Link: https://github.com/ClangBuiltLinux/linux/issues/811
Reported-by: Itaru Kitayama <itaru.kitayama@riken.jp>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> ---
> The output of the "get_maintainer.pl" run just in case no one believes me. :-)

LOL!

>
> $ ./scripts/get_maintainer.pl arch/powerpc/Makefile
> Michael Ellerman <mpe@ellerman.id.au> (supporter:LINUX FOR POWERPC (32-BIT AND 64-BIT))
> Benjamin Herrenschmidt <benh@kernel.crashing.org> (reviewer:LINUX FOR POWERPC (32-BIT AND 64-BIT))
> Paul Mackerras <paulus@samba.org> (reviewer:LINUX FOR POWERPC (32-BIT AND 64-BIT))
> Nathan Chancellor <nathan@kernel.org> (supporter:CLANG/LLVM BUILD SUPPORT)
> Nick Desaulniers <ndesaulniers@google.com> (supporter:CLANG/LLVM BUILD SUPPORT)
> linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT))
> linux-kernel@vger.kernel.org (open list)
> clang-built-linux@googlegroups.com (open list:CLANG/LLVM BUILD SUPPORT)
> ---
>  arch/powerpc/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 6505d66f1193..17a9fbf9b789 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -122,6 +122,7 @@ endif
>
>  LDFLAGS_vmlinux-y := -Bstatic
>  LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
> +LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) += -z notext
>  LDFLAGS_vmlinux        := $(LDFLAGS_vmlinux-y)
>
>  ifdef CONFIG_PPC64
> --
> 2.33.0.rc1.237.g0d66db33f3-goog
>


-- 
Thanks,
~Nick Desaulniers
