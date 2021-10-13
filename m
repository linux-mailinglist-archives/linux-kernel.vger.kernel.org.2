Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC57842B9BC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbhJMH5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:57:36 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:42945 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbhJMH5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:57:35 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N63NQ-1mpv7j0IB6-016Pg7 for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021
 09:55:31 +0200
Received: by mail-wr1-f47.google.com with SMTP id y3so5307652wrl.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 00:55:31 -0700 (PDT)
X-Gm-Message-State: AOAM531XBqxaCqlQ8Gr2WWaJyPDCtNWMWkdtRaoLvgUSRyM8+3nxZKzo
        HxkZhQZb2uEZeT5+GTUZp4QSEVh6/KCEd+OrsGs=
X-Google-Smtp-Source: ABdhPJyiEJBpgNDpB6GmM5rJOFTTTfiFTaFUlnEWP59JJxhNZAk4i37kRw3Rf+g9OE/qnJqBSX5RUghnoccWBlIuMYo=
X-Received: by 2002:a1c:2358:: with SMTP id j85mr11030180wmj.1.1634111730691;
 Wed, 13 Oct 2021 00:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211012234606.91717-1-ndesaulniers@google.com> <20211012234606.91717-2-ndesaulniers@google.com>
In-Reply-To: <20211012234606.91717-2-ndesaulniers@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Oct 2021 09:55:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3UBEJ0Py2ycz=rHfgog8g3mCOeQOwO0Gmp-iz6Uxkapg@mail.gmail.com>
Message-ID: <CAK8P3a3UBEJ0Py2ycz=rHfgog8g3mCOeQOwO0Gmp-iz6Uxkapg@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: vdso32: drop the test for dmb ishld
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, llvm@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Christian Biesinger <cbiesinger@google.com>,
        Simon Marchi <simon.marchi@polymtl.ca>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:npAKHHmy7bOHdeDloam/+UPWm73dwd3it0I4/b1SHn/eOt0goGq
 mDx6C6x5Woseo6ocOE830/63W1Ew4LKawT0R/bZ4CJJ/Wu66TxqHlOZl3XxGQALJA2FY3+i
 INI5iHZw627IDCRCXbs56GHPQiWyASoQD0txQ80qZ60xYT3BQJOMPdpsasinhHl6Roftsxl
 MfUEru/tBQ4lmnjtQwAzw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3gMqScMmDwI=:ORNUdJU1H3UEuFK2BmB0Ht
 DTUvcZEfD5IRNkr45JzFwuPqAShvgDN3Nt9Mo/H6hE5ruOvAGPe7DxEENvAIo1b/t67XtH3iN
 gUocGAWQ+us6Bg9mpftI8Tc1cIeuSTY9RE0GV+Aa6oa3mlL03uXg8pEEz8BOkSOF6bgdQYi0o
 8fm/yzaMOHGp3PGdUhKgotbWPhI6QL23rAzG1oKcYZQ5PyZQjbflGm8GB3iYprxUhAF3RCN/O
 jfEy7VSOAoC5EYiw7BzcX81LmhSIa7veZYHnwPfqiFeMCH8Q6VFvX2w3o7dqY4IQgfgtdKBdZ
 NxcnMPww2tkWRUebeO6DfVXp4WFuep2zJKM9RQlJXpRfYDfw9vQL0ZxaQ+es81fVmwp9R8mMO
 gENN95IcvCgSFpnd2Apgi8WxKYVFd0j8tbElMtJC7/rI3VjjlhSfe1QNHITyPtlxWq4WdzeGH
 WJRIFDN8ez/Bdid5waZQqdV3OVJJvN4yALIZQJQ4T8X9Yl4iAniudcYBgZ2Sr37YaBaXSqfb0
 Rq8jzkkaq2uOXfOEHmXcOT7iUVF5A3FGMejml8Sn8F9QvNjaeRhRMTuSQANxcypm2qZyDxcvx
 tkMKxi9RVwnCFTZbFJ4r2GI79UJQaLm2LzK5qxZS9RttaINf/C49nKyqPxgS1Iw+o+dXDeEO4
 NzDqlseC1PhoVGSYyZsQuEt6+2R48ILbxscrOyyiecGUn/SLAsv+pt8sYv1ksUubdE6/qnE/p
 rKFVCUytvcieW69dUp2Pzarr7nA9y02oYLv05UaC8PYLN1BCMJhLiNmIlTFOf6hs56vBLijQz
 Pvdvzz3JkVrS9eVZ8yIdyrsBVV0QbtJUFHudyqU4UNE/ZYBHUhu9UGcTVMppkRtGkGtxKdwoW
 GPXOSIsiGdUo4LmdrDFQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 1:46 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Binutils added support for this instruction in commit
> e797f7e0b2bedc9328d4a9a0ebc63ca7a2dbbebc which shipped in 2.34 (just
> missing the 2.33 release) but was cherry-picked into 2.33 in commit
> 27a50d6755bae906bc73b4ec1a8b448467f0bea1. Thanks to Christian and Simon
> for helping me with the patch archaeology.
>
> According to Documentation/process/changes.rst, the minimum supported
> version of binutils is 2.33. Since all supported versions of GAS support
> this instruction, drop the assembler invocation, preprocessor
> flags/guards, and the cross assembler macro that's now unused.
>
> This also avoids a recursive self reference in a follow up cleanup
> patch.
>
> Cc: Christian Biesinger <cbiesinger@google.com>
> Cc: Simon Marchi <simon.marchi@polymtl.ca>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

This change looks good, but I think we should do the same for the gcc
version check:

> -#if __LINUX_ARM_ARCH__ >= 8 && defined(CONFIG_AS_DMB_ISHLD)
> +#if __LINUX_ARM_ARCH__ >= 8
>  #define aarch32_smp_mb()       dmb(ish)
>  #define aarch32_smp_rmb()      dmb(ishld)
>  #define aarch32_smp_wmb()      dmb(ishst)

gcc-4.8 already supported -march=armv8, and we require gcc-5.1 now, so both
this #if/#else construct and the corresponding "cc32-option,-march=armv8-a"
check should be obsolete now.

       Arnd
