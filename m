Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251C7391A15
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhEZO01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:26:27 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:63408 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbhEZO00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:26:26 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 14QEOXr6005846;
        Wed, 26 May 2021 23:24:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 14QEOXr6005846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622039073;
        bh=S3cdbLKJzcvU+k2/cClSUE7D/oDU/mnDHQ9eZ1mSmYs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iuiY9bXmzgMFxyv8kuk8ZPG/qtKaNvj7NGgZFynyvOqEEffIagdAMaV8pq0sPA8zB
         ccQO/WRcN9q2IitG7BWuLrRyUY9BekYvrWby0386PSL27qp1gwP59U+PpkrMQLSEot
         LplMTAD13fqsefSFyzdPtScvAomZrMsthhRrPlDVBH9Jab6KNCYuQcdqb+c50IWmdY
         AosjTwviJGig05PbTaj3muvu2KKaXF1Has7WRkZdw8EAJusQUv6wrxO0hTLEIxPMgH
         JqjlDV6hqar3sSJdtZdtvk6hXQ3ZgBl+agVhC+kZNPzlzcyoLeX7jll/4YXvLmrl1w
         LQGOWu/vmXTrw==
X-Nifty-SrcIP: [209.85.210.176]
Received: by mail-pf1-f176.google.com with SMTP id y15so1026832pfn.13;
        Wed, 26 May 2021 07:24:33 -0700 (PDT)
X-Gm-Message-State: AOAM532rnVNe0fgDSUeR/JyJEpALI/NcsHDn49fHFNBrb3q1Ytg692U3
        GIgAmLsbvYq7rBRh+fo3n78+FNeq2+CcAPpTxUA=
X-Google-Smtp-Source: ABdhPJz2Unzkmjt4AewHB8f4XFBaX31iEQ+tyeMgiGCHUZSjTNXZ/IrQYtN5evWSxdXKCtVjmcQSj4nUUF5dqCCxBFw=
X-Received: by 2002:a63:164f:: with SMTP id 15mr25296029pgw.175.1622039072606;
 Wed, 26 May 2021 07:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084536.1454449-1-geert@linux-m68k.org>
In-Reply-To: <20210526084536.1454449-1-geert@linux-m68k.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 26 May 2021 23:23:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNARq87zoD9-r4YfY5rewwieBOBJYETs4MLwBz9vddxMsRA@mail.gmail.com>
Message-ID: <CAK7LNARq87zoD9-r4YfY5rewwieBOBJYETs4MLwBz9vddxMsRA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Drop duplicate "core-y += arch/m68k/" rule causing
 link failures
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 5:45 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>     Makefile:1949: target 'arch/m68k' given more than once in the same rule
>     [...]
>       LD      vmlinux.o
>     m68k-linux-gnu-ld: arch/m68k/kernel/entry.o: in function `system_call':
>     (.text+0x160): multiple definition of `system_call'; arch/m68k/kernel/entry.o:(.text+0x160): first defined here
>     [...]
>
> All "core-y += arch/<arch>/" rules were dropped from the corresponding
> arch/<arch>/Makefiles, but m68k was forgotten.
>
> Reported-by: noreply@ellerman.id.au
> Fixes: 7d9677835b10b5de ("kbuild: require all architectures to have arch/$(SRCARCH)/Kbuild")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

I will squash this.
Thanks.


>  arch/m68k/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
> index c54055a3d28450aa..dd0c0ec67f67064d 100644
> --- a/arch/m68k/Makefile
> +++ b/arch/m68k/Makefile
> @@ -97,7 +97,6 @@ head-$(CONFIG_SUN3)           := arch/m68k/kernel/sun3-head.o
>  head-$(CONFIG_M68000)          := arch/m68k/68000/head.o
>  head-$(CONFIG_COLDFIRE)                := arch/m68k/coldfire/head.o
>
> -core-y                         += arch/m68k/
>  libs-y                         += arch/m68k/lib/
>
>
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada
