Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E252838FFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhEYLYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:24:46 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:20769 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhEYLYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:24:44 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 14PBMqPQ015643
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 20:22:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 14PBMqPQ015643
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1621941773;
        bh=e3I5tcZjuWv588TkG9hTTFqte/LCOhraM5uF3Hlb/bo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kq5ZhWTJuF6r7/vvvJnir3exOAlse6bm6yWaKqa2YAfmlsePtHzQ5lvUhik+a+iaa
         XD2SEc5EfAKkl+8rErcG4CBge2OFMJ5FK3dho7JHm1wjawo1R9cS3eK7WYkUkaXCg6
         M9BDks/LFDczZwby7+bJrMOnbo9w+Htjf2Zk+x0wm/zRQWLtSrTB+r1mTW4f0uWdbM
         xsYJyULh5JethO6O/Mn0ix0g9sFRiRjGIMLwZE8fkOk1K//Bp8Wsgifa5jkDBp/Aej
         vP9SQ8BNbzmgNc8C9GCcC9GTfFWsUHwpggyyilkF2hg+e0SLhFYcWScsbeenoog5C6
         w/4pDwSzsTONQ==
X-Nifty-SrcIP: [209.85.210.174]
Received: by mail-pf1-f174.google.com with SMTP id f22so14989636pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 04:22:52 -0700 (PDT)
X-Gm-Message-State: AOAM532E8p8G8ksjrrHibyvOKBLOA2OD8Hy+TIR2GaiGHZ7Oej3xVsd5
        OMo6NjXFMbL0tau4hbmIZi+/LNl64/EP3v8UfjA=
X-Google-Smtp-Source: ABdhPJwIdjotQg4s469zaiVhc2T4yKzWArhwKAD41DnMMNy9+oOczz9tedErXHDJ2jf4RZIECwah48FJu08EWne8ECk=
X-Received: by 2002:a63:a547:: with SMTP id r7mr18740751pgu.7.1621941770469;
 Tue, 25 May 2021 04:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210524181707.132844-1-brgerst@gmail.com> <20210524181707.132844-2-brgerst@gmail.com>
In-Reply-To: <20210524181707.132844-2-brgerst@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 25 May 2021 20:22:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS1-4+PrP15ZRpkWB0boX-2b_gYa9gg8_HR5jOmG4HWiw@mail.gmail.com>
Message-ID: <CAK7LNAS1-4+PrP15ZRpkWB0boX-2b_gYa9gg8_HR5jOmG4HWiw@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/uml/syscalls: Remove array index from syscall initializers
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 3:17 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> Commit 44fe4895f47c ("Stop filling syscall arrays with *_sys_ni_syscall")
> removed the index from the initializers for native x86 syscall tables, but
> missed the UML syscall tables.


Ah, right.
I missed cleaning up this in UML. Thanks.

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>






> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>  arch/x86/um/sys_call_table_32.c | 2 +-
>  arch/x86/um/sys_call_table_64.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
> index f8323104e353..0575decb5e54 100644
> --- a/arch/x86/um/sys_call_table_32.c
> +++ b/arch/x86/um/sys_call_table_32.c
> @@ -31,7 +31,7 @@
>  #include <asm/syscalls_32.h>
>
>  #undef __SYSCALL
> -#define __SYSCALL(nr, sym) [ nr ] = sym,
> +#define __SYSCALL(nr, sym) sym,
>
>  extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
>
> diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
> index 5ed665dc785f..95725b5a41ac 100644
> --- a/arch/x86/um/sys_call_table_64.c
> +++ b/arch/x86/um/sys_call_table_64.c
> @@ -39,7 +39,7 @@
>  #include <asm/syscalls_64.h>
>
>  #undef __SYSCALL
> -#define __SYSCALL(nr, sym) [ nr ] = sym,
> +#define __SYSCALL(nr, sym) sym,
>
>  extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
>
> --
> 2.31.1
>


--
Best Regards
Masahiro Yamada
