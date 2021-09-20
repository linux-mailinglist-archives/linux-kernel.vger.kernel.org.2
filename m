Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBEB411346
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbhITLDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232312AbhITLDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:03:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9585761019
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632135744;
        bh=Qo9OH3OatSxQ6mVNwV+oYOI8e3ZP4NEIs/O92VWL8QY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Of+QBHJkJqgVW0lN0Y+CY+p0EfquB4/mU1LidHhGp+KaaO0sHEubX4oj+T9wPF+KT
         Q+YL9g8g7ft4WJoOUAD/rN6+eUjRSul9EBMfBEJlebtlkTFLNtR9EstKLgtKwcomf4
         PSNEpW/+sg7/2NuE7CPxSXaMGOcWnj3+KMuzoxDCPfUG+nkpoT7cfc6ThUJxsjkDB7
         wdO6iNjeXLwZDePIIfAp0A4exH7RkytFwGGZ+Owz4RSLmNkgcV41W+ELJysthIpO70
         5xzmXpvIBNtP4U2raClEGlU8XapdzXcXfFFbnW19lbJfoaEzDHc/wKYFWJCGB32N/D
         gFxttdT2Dr03g==
Received: by mail-wr1-f54.google.com with SMTP id t8so21402231wri.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 04:02:24 -0700 (PDT)
X-Gm-Message-State: AOAM531qZXOkVaUcoA1dW7Y1rx/ExZoCShyXxy+A75JDKNjdCPhRNAni
        RQVWSv21N2eRHadgQl1vgz4NLHId1wFdeEtRNg8=
X-Google-Smtp-Source: ABdhPJxfkRg5shmH9v95CIjg4TUKIpUlkm75p5gAZM+RJbH7lOfNTwCOBfp3Js3eDG1d15O/1qzb4Vr9bQIOWI/eZJM=
X-Received: by 2002:a1c:7413:: with SMTP id p19mr24126896wmc.98.1632135743242;
 Mon, 20 Sep 2021 04:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <202108160330.T1EbbpCi-lkp@intel.com>
In-Reply-To: <202108160330.T1EbbpCi-lkp@intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 20 Sep 2021 13:02:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3qhfxUC-7y-_q35-tNrs2L93htjuVzSukqZO0hDhOAuw@mail.gmail.com>
Message-ID: <CAK8P3a3qhfxUC-7y-_q35-tNrs2L93htjuVzSukqZO0hDhOAuw@mail.gmail.com>
Subject: Re: [linux-next:master 3857/7963] arch/x86/crypto/sm4-aesni-avx-asm_64.o:
 warning: objtool: sm4_aesni_avx_crypt8()+0x8: sibling call from callable
 instruction with modified stack frame
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2021 at 9:41 PM kernel test robot <lkp@intel.com> wrote:
>
> CC: Linux Memory Management List <linux-mm@kvack.org>
> TO: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> CC: Herbert Xu <herbert@gondor.apana.org.au>
>
> Hi Tianjia,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   4b358aabb93a2c654cd1dcab1a25a589f6e2b153
> commit: a7ee22ee1445c7fdb00ab80116bb9710ca86a860 [3857/7963] crypto: x86/sm4 - add AES-NI/AVX/x86_64 implementation
> config: x86_64-randconfig-r024-20210816 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7776b19eed44906e9973bfb240b6279d6feaab41)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=a7ee22ee1445c7fdb00ab80116bb9710ca86a860
>         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>         git fetch --no-tags linux-next master
>         git checkout a7ee22ee1445c7fdb00ab80116bb9710ca86a860
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> arch/x86/crypto/sm4-aesni-avx-asm_64.o: warning: objtool: sm4_aesni_avx_crypt8()+0x8: sibling call from callable instruction with modified stack frame

I see the same thing in my randconfig builds using gcc. This is an
assembler file,
my interpretation is that objtool has found an actual code bug:

.macro FRAME_BEGIN
        push %_ASM_BP
        _ASM_MOV %_ASM_SP, %_ASM_BP
.endm
.macro FRAME_END
        pop %_ASM_BP
.endm

SYM_FUNC_START(sm4_aesni_avx_crypt8)
        /* input:
         *      %rdi: round key array, CTX
         *      %rsi: dst (1..8 blocks)
         *      %rdx: src (1..8 blocks)
         *      %rcx: num blocks (1..8)
         */
        FRAME_BEGIN

        cmpq $5, %rcx;
        jb sm4_aesni_avx_crypt4;
        ....

SYM_FUNC_START(sm4_aesni_avx_crypt4)
        /* input:
         *      %rdi: round key array, CTX
         *      %rsi: dst (1..4 blocks)
         *      %rdx: src (1..4 blocks)
         *      %rcx: num blocks (1..4)
         */
        FRAME_BEGIN
        ...
        FRAME_END
        ret;
SYM_FUNC_END(sm4_aesni_avx_crypt4)


sm4_aesni_avx_crypt8() starts a frame and conditionally branches to
sm4_aesni_avx_crypt4(), which starts another frame and returns from
that without cleaning up the parent frame.

        Arnd
