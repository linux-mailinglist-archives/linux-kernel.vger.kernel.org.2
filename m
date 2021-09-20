Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71CA410ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 05:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhITDov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 23:44:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhITDou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 23:44:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EAB160EE0;
        Mon, 20 Sep 2021 03:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632109404;
        bh=p7Ma5NlNd/XzVcB4FIQKl7ZT6RMFembGdKgtyqS11/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aQiMuFIsCXfDdFq8hsjpQWdJtId+IqassqcmizLf3Ac1NK8Bp4H2pDqXtpCtDaxHX
         vWEiutV8JZGZ8AM3aeTHfqmVEh5RH3Nh9AkCCdBJ1OrxW7oO+1JLZpJeHbdxSfvgaJ
         XpPfDwDt6FVCMUc9GvbmhEXHYbcPW6+lVTDnPNXLAWyF4sre6hkBkpDAcOeQviAZ0N
         tdJsCDoQTH1Gm2iZw93d6D8Z/p2Jqu8Qv5kkh5+0/WioUCVrkUhx6zZ7DMdxnR1Cpt
         i1mv+thd9eCu1ATm0OB4CAmWGg+MLtUiAhsv51XDKYV6q2EoK07C/FOm1hiQfPD1qg
         cTpy0j+DRgc0Q==
Date:   Sun, 19 Sep 2021 20:43:19 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        llvm@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: x86_64: clang-10: <instantiation>:2:2: error: unknown use of
 instruction mnemonic without a size suffix
Message-ID: <YUgDV31uzAQy5IcN@archlinux-ax161>
References: <CA+G9fYvoyDqbCnmcVMHCO3Zxn9=FGTjyTH9u=7FT7rCz-dh6JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvoyDqbCnmcVMHCO3Zxn9=FGTjyTH9u=7FT7rCz-dh6JA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

On Mon, Sep 20, 2021 at 08:55:46AM +0530, Naresh Kamboju wrote:
> [Please ignore this email if it is already reported ]
> 
> Following build warnings/ errors noticed while building linux mainline
> master branch
> with clang-10 for x86_64 architecture.
> But clang-11, clang-12 and clang-13 build pass.
> 
> <instantiation>:2:2: error: unknown use of instruction mnemonic
> without a size suffix
>  lsl %rax, %rax
>  ^
> <instantiation>:1:1: note: while in macro instantiation
> LOAD_CPU_AND_NODE_SEG_LIMIT %rax
> ^
> <instantiation>:2:2: note: while in macro instantiation
>  GET_PERCPU_BASE %rax
>  ^
> /builds/linux/arch/x86/entry/entry_64.S:887:2: note: while in macro
> instantiation
>  SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
>  ^
> make[3]: *** [/builds/linux/scripts/Makefile.build:379:
> arch/x86/entry/entry_64.o] Error 1
> arch/x86/entry/entry_64_compat.o: warning: objtool: .entry.text+0x215:
> can't find jump dest instruction at .entry.text+0x21a
> make[3]: Target '__build' not remade because of errors.
> make[2]: *** [/builds/linux/scripts/Makefile.build:540: arch/x86/entry] Error 2
> make[2]: Target '__build' not remade because of errors.
> make[1]: *** [/builds/linux/Makefile:1868: arch/x86] Error 2

Thanks for the report. This is another case where the implicit switch to
the integrated assembler exposed a previously fixed issue in LLVM:

https://github.com/ClangBuiltLinux/linux/issues/1079

This cannot be fixed in the LLVM 10 branch as it is no longer updated so
if you want to keep testing with clang-10 for x86_64 on mainline, please
add 'LLVM_IAS=0' to your make command like we did in our own CI.

As a quick aside, would you mind updating my email address in your
system for reports to nathan@kernel.org? It will ensure it gets sent to
the correct inbox so that I do not miss things, as I do not use my
personal address for kernel development anymore.

Cheers,
Nathan
