Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409273EB695
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240560AbhHMONo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbhHMONm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:13:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E782C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 07:13:16 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b7so12151676plh.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=qX/JChnLXlyObYVqGeKWhDoJp7v9J6Kqnss11iHK/7U=;
        b=dKp0vQV7R1+npo6tAVzsGn8tYIalp1aIGDIPOj3XmQYMJya9hzE08a+ZWBpKKiYTru
         +O5TGgbcdtY9uQxh7Rq4R3T/+azsUKqW104KC8XF3KXhgREOts+nhk4Pld1YCcTORRO4
         Qe0NFO7ZRWBNGQyf087+bJBxHSq1ZZfGVxAPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qX/JChnLXlyObYVqGeKWhDoJp7v9J6Kqnss11iHK/7U=;
        b=aBcts1tCatfSEncfXjSpTx6GXkvJvQcdXk9swq3jjM+iXMbSGEV82cRA3Q0m9fMijx
         3c+q8GeJZeopzNNBrk50FoLy4mxvDMsbcB8ldodRQcTnXwmvV/PjHAXlNdGLdSsnYuIz
         eimI/+DLTekEP/8uJEnmLnrJbXgO3ALKN2D137ynf7y8LydMgZxRy9rROSgunyPQNBCE
         SSKOxIKjjK68kjrQeepAvHBaLkpTr5hgz8gMsWafgE4pFD2+78V4wbvQN/OCk+HNL3jG
         Np+Inqq5DkR062sJUdUlG/Q8fGl8wkBF5OjlMdTstjE9BFzbgEm5USGu/G85prfhqt74
         cXww==
X-Gm-Message-State: AOAM530Vki0Z1QnoMvgGW1WBAjSu6tHSvLLzGayIutAyU5OuMr+VhwMk
        qHISRRc48RO87aCFOQxR0jVzWw==
X-Google-Smtp-Source: ABdhPJwF8LJN/sdYnjZyTEuBKiH/d5kecrBt7FUxTDbZIMxbarCsexTwnCvXt76At8sb3Tp8OJrJbg==
X-Received: by 2002:a63:4d18:: with SMTP id a24mr2462947pgb.324.1628863995693;
        Fri, 13 Aug 2021 07:13:15 -0700 (PDT)
Received: from localhost ([2001:4479:e200:df00:e80c:91ad:1614:aeef])
        by smtp.gmail.com with ESMTPSA id k3sm2611155pfc.16.2021.08.13.07.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 07:13:15 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Bill Wendling <morbo@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Bill Wendling <morbo@google.com>
Subject: Re: [PATCH] ppc: add "-z notext" flag to disable diagnostic
In-Reply-To: <20210812204951.1551782-1-morbo@google.com>
References: <20210812204951.1551782-1-morbo@google.com>
Date:   Sat, 14 Aug 2021 00:13:11 +1000
Message-ID: <87sfzde8lk.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Wendling <morbo@google.com> writes:

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

You didn't provide a huge amount of context but I was able to reproduce
a similar set of errors with pseries_le_defconfig and

make ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu- CC="ccache clang-11" LD=ld.lld-11 AR=llvm-ar-11 -j4 vmlinux

I also checked the manpage, and indeed the system ld does not issue this
warning/error by default.

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

Is there any reason this should be gated on CONFIG_RELOCATABLE? (I tried
without it and got different but possibly related linker errors...)

Also, is this behaviour new?

Kind regards,
Daniel

>  LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
>  
>  ifdef CONFIG_PPC64
> -- 
> 2.33.0.rc1.237.g0d66db33f3-goog
