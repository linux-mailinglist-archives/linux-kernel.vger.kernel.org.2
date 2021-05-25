Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1FE390081
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhEYMEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:04:07 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:46305 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhEYMEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:04:02 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 14PC2AjM007640
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 21:02:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 14PC2AjM007640
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1621944133;
        bh=e7A10QJ9hFFFi81B003RUSBE28HBLOTm/XCpb/4t66s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xTNVvcUcEqsBbV0oYwav4t+k1rYeqq2UL+kIGLTLZHj3zwA0ZxY7peyiwnXQqvRIw
         iAuHKYJOtmupCRBgV+PH+V46WFgh5Mr37OLmJV7N+RvkuWImfnLjf0041TxRZDKPdR
         hrDxbs5A6/MmS5/tJ5qxH+aO2QuzFdY9N3qjJH4lsDTg2HhMV3pEnJdBnuSKPdveAK
         e4RVcC1e74XkAHXKpen5Nh95zP2akVkPneN0/tf3+hOvw3botuY+Bs7UPX6g6pJjDr
         Cm8c/7/sSmDWV+GHX8Q2ISWgljiauN/qYOSrEMT8oYchCRnDgtfs5ShCaaFc8qS2By
         qMSSdr0ecSINw==
X-Nifty-SrcIP: [209.85.210.177]
Received: by mail-pf1-f177.google.com with SMTP id f22so15060776pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 05:02:12 -0700 (PDT)
X-Gm-Message-State: AOAM531Oywi+6NNmA/M1Ms5/5bR7LPVea4P7GrStdGjS0g2JOtgtSWKG
        S+wvP2YMEZ+R2IZQY41NIytlow5H2F1ZucBJEGk=
X-Google-Smtp-Source: ABdhPJxCv4KbHc4MHn9ApsKPvgSFIpE/lIUL3uGz64R5krRd4QknRAM8I6neH8IBvXo4n7vb8oOJCEG8zfcKvit0yhA=
X-Received: by 2002:a05:6a00:2394:b029:2e0:a27:ba26 with SMTP id
 f20-20020a056a002394b02902e00a27ba26mr29802834pfc.63.1621944128843; Tue, 25
 May 2021 05:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210524181707.132844-1-brgerst@gmail.com> <20210524181707.132844-3-brgerst@gmail.com>
In-Reply-To: <20210524181707.132844-3-brgerst@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 25 May 2021 21:01:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNATV7J9afWf46QGA2QqGScFVGhLc-ey9+DqN31qUF=zcCw@mail.gmail.com>
Message-ID: <CAK7LNATV7J9afWf46QGA2QqGScFVGhLc-ey9+DqN31qUF=zcCw@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/syscalls: Remove -Wno-override-init for syscall tables
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
> removes the need for -Wno-override-init, since the table is now filled
> sequentially instead of overriding a default value.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


>  arch/x86/entry/Makefile | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
> index 08bf95dbc911..94d2843ce80c 100644
> --- a/arch/x86/entry/Makefile
> +++ b/arch/x86/entry/Makefile
> @@ -17,10 +17,6 @@ CFLAGS_syscall_64.o          += -fno-stack-protector
>  CFLAGS_syscall_32.o            += -fno-stack-protector
>  CFLAGS_syscall_x32.o           += -fno-stack-protector
>
> -CFLAGS_syscall_64.o            += $(call cc-option,-Wno-override-init,)
> -CFLAGS_syscall_32.o            += $(call cc-option,-Wno-override-init,)
> -CFLAGS_syscall_x32.o           += $(call cc-option,-Wno-override-init,)
> -
>  obj-y                          := entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
>  obj-y                          += common.o
>
> --
> 2.31.1
>


--
Best Regards
Masahiro Yamada
