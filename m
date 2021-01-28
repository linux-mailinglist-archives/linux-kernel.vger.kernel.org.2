Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DE2306BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 05:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhA1EFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 23:05:06 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:27114 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhA1EEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 23:04:09 -0500
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 10S42Yie023770
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 13:02:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 10S42Yie023770
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1611806554;
        bh=UGFEFBZO6XyE53sikxcKH18p4Hi/bQ7cwfMaMlbekaw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p1GoLVJtc6WAUhXop6XjMbAfaAGuj2ucB7PePaZf8RjP7a/xAS7Y0Q+CtkCiiw7s7
         hxPk7DMFZWb4JJ01ukPwfaouXxFRBXrLnRtVwYuoVnRp42F4jlzYin/7+hywIvHCv5
         E20P7nNm5z69P3uklPsgHIteYVrsjyd88Z313r+myyhSyWKfo35ZBWDfg/rH0+Pdo1
         gSQRHzsQsLG55mXJ1KEm6kqQpekjOqlKJcP17kAwSrz2DOtN0hqvRz5Ontyzlb8rev
         SatdqeLJLJ/J01VfEwAFHIi9sLjdKGfXmVl7pkV949G+CGcaho3jkpXz4HbYpXx3Q4
         rBsamdaS6IfEg==
X-Nifty-SrcIP: [209.85.215.173]
Received: by mail-pg1-f173.google.com with SMTP id c132so3429484pga.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 20:02:34 -0800 (PST)
X-Gm-Message-State: AOAM53255KgiUyKi3VHyA0IaRYcMKfxBL0TgmQwC+PtHwdUiTbShBxsO
        hUp2+rJ2b+fiSiDvVI9Qb56F0Zzq7K0QDMkSHeE=
X-Google-Smtp-Source: ABdhPJydqxki6OSEnMrqa1NZ5TxUJLm2/BivHYqaw1ccMRHfmLbg3Xxtl5/PfyePwq4wmVGWu1nRz4xdTcu7k/HCCD8=
X-Received: by 2002:aa7:8602:0:b029:1bb:4dfd:92fc with SMTP id
 p2-20020aa786020000b02901bb4dfd92fcmr14034248pfn.63.1611806553757; Wed, 27
 Jan 2021 20:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20201223171142.707053-1-masahiroy@kernel.org> <20201223171142.707053-2-masahiroy@kernel.org>
In-Reply-To: <20201223171142.707053-2-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 28 Jan 2021 13:01:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS_vvLwjBG=MSJv=-n-Y4-AgsiPsj2VpH7qO4KLkUA2dw@mail.gmail.com>
Message-ID: <CAK7LNAS_vvLwjBG=MSJv=-n-Y4-AgsiPsj2VpH7qO4KLkUA2dw@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/vdso64: remove meaningless vgettimeofday.o
 build rule
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 2:12 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> VDSO64 is only built for the 64-bit kernel, hence vgettimeofday.o is
> built by the generic rule in scripts/Makefile.build.
>
> This line does not provide anything useful.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>


Michael, please take a  look at this too.



> ---
>
>  arch/powerpc/kernel/vdso64/Makefile | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
> index b50b39fedf74..422addf394c7 100644
> --- a/arch/powerpc/kernel/vdso64/Makefile
> +++ b/arch/powerpc/kernel/vdso64/Makefile
> @@ -32,8 +32,6 @@ asflags-y := -D__VDSO64__ -s
>  targets += vdso64.lds
>  CPPFLAGS_vdso64.lds += -P -C -U$(ARCH)
>
> -$(obj)/vgettimeofday.o: %.o: %.c FORCE
> -
>  # link rule for the .so file, .lds has to be first
>  $(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday.o FORCE
>         $(call if_changed,vdso64ld_and_check)
> --
> 2.27.0
>


-- 
Best Regards
Masahiro Yamada
