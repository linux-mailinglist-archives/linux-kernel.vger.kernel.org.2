Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA9C36EF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241066AbhD2RwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241007AbhD2RwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:52:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D185C61460
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 17:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619718683;
        bh=k8vm1xb1TV8BKDiblYpNsmnSnjC+JE3s7D/l56gk21k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GdvgBm7ELuRUoXrBUrTqCvu77A9zcI/bZbNWvUE5/jbpplGq8ItxkO+wCIqEl9hKO
         m1FNxwz6jFwC8qc9SuPjCUO2aA14mfbAMKkjIH+bG6dHzXx77myJbZdDg0srhnxuzi
         FZxKcM8jB29u4qU5Z2L04pjcFqr8Aqj2BGv+mFcmjip3hTmQZtQrECQPsOuvz0CaoE
         8EdP/6rWNj6Ifrmv2XJaJazVeRInix0bw+ReoTEymjlEX8XBf9NWPdfNy1Kf/PiiXX
         GfhIWYkgExgLV3Dpp3m8AR6WFDvv77NZZKz3ZoXH3lTOM0bBm3ONzDc0Lx47SHGFR6
         Mv9YaRerz4geg==
Received: by mail-wr1-f47.google.com with SMTP id d11so9941463wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:51:23 -0700 (PDT)
X-Gm-Message-State: AOAM531guY6xWFrPj1PUvxwlXDxV72rCFOg5BZWenHOe1+swUUZq1nF2
        UXe5I8m9S+WICqFDyCtFRr6KrmGNUGUOmZvZTqE=
X-Google-Smtp-Source: ABdhPJznqRz/sdYoaTZ26WmYkNCAlFwhDZgvz1gbGGOowZpPKgx27qiJg7XXPzUBlmyL78a4akx6Fj510K+MH6JLjzQ=
X-Received: by 2002:adf:d223:: with SMTP id k3mr1096320wrh.99.1619718682219;
 Thu, 29 Apr 2021 10:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210429145752.3218324-1-arnd@kernel.org> <dff8cbd8-8c56-ae6e-ecc2-9ca183113ab2@arm.com>
In-Reply-To: <dff8cbd8-8c56-ae6e-ecc2-9ca183113ab2@arm.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 29 Apr 2021 19:50:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3-XoDQ6BfTBUof5ST2H1_6JOL+rK-BQqWXAV0H5jMm9Q@mail.gmail.com>
Message-ID: <CAK8P3a3-XoDQ6BfTBUof5ST2H1_6JOL+rK-BQqWXAV0H5jMm9Q@mail.gmail.com>
Subject: Re: [PATCH] [v2] coresight: etm4x: avoid build failure with unrolled loops
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Qi Liu <liuqi115@huawei.com>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        coresight@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 7:37 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> On 29/04/2021 15:57, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > clang-12 fails to build the etm4x driver with -fsanitize=array-bounds,
> > where it decides to unroll certain loops in a way that result in a
> > C variable getting put into an inline assembly
> >
> > <instantiation>:1:7: error: expected constant expression in '.inst' directive
> > .inst (0xd5200000|((((2) << 19) | ((1) << 16) | (((((((((((0x160 + (i * 4))))) >> 2))) >> 7) & 0x7)) << 12) | ((((((((((0x160 + (i * 4))))) >> 2))) & 0xf)) << 8) | (((((((((((0x160 + (i * 4))))) >> 2))) >> 4) & 0x7)) << 5)))|(.L__reg_num_x8))
> >        ^
> > drivers/hwtracing/coresight/coresight-etm4x-core.c:702:4: note: while in macro instantiation
> >                          etm4x_relaxed_read32(csa, TRCCNTVRn(i));
> >                          ^
> > drivers/hwtracing/coresight/coresight-etm4x.h:403:4: note: expanded from macro 'etm4x_relaxed_read32'
> >                   read_etm4x_sysreg_offset((offset), false)))
> >                   ^
> > drivers/hwtracing/coresight/coresight-etm4x.h:383:12: note: expanded from macro 'read_etm4x_sysreg_offset'
> >                          __val = read_etm4x_sysreg_const_offset((offset));       \
> >                                  ^
> > drivers/hwtracing/coresight/coresight-etm4x.h:149:2: note: expanded from macro 'read_etm4x_sysreg_const_offset'
> >          READ_ETM4x_REG(ETM4x_OFFSET_TO_REG(offset))
> >          ^
> > drivers/hwtracing/coresight/coresight-etm4x.h:144:2: note: expanded from macro 'READ_ETM4x_REG'
> >          read_sysreg_s(ETM4x_REG_NUM_TO_SYSREG((reg)))
> >          ^
> > arch/arm64/include/asm/sysreg.h:1108:15: note: expanded from macro 'read_sysreg_s'
> >          asm volatile(__mrs_s("%0", r) : "=r" (__val));                  \
> >                       ^
> > arch/arm64/include/asm/sysreg.h:1074:2: note: expanded from macro '__mrs_s'
> > "       mrs_s " v ", " __stringify(r) "\n"                      \
> >   ^
> >
> > This only happened in a few loops in which the array bounds sanitizer
> > added a special case for an array overflow that clang determined to be
> > possible, but any compiler is free to unroll any of the loops in the
> > same way that breaks the sysreg macros.
> >
> > Introduce helper functions that perform a sysreg access with a
> > non-constant register number and use them in each call that passes
> > a loop counter.
>
> You don't need to add this special helper. We have the exact
> infrastructure already. So these could simply be replaced with:
>
> csdev_access_xxx(csa, ...)
>
> see :
>
> include/linux/coresight.h

Ah, nice!

Do you mean replacing only the ones that use a nonconstant
offset, or all of them? I guess changing all would avoid some
really ugly magic macros, but the indirect function call and the
switch() adds a few cycles of overhead every time and the code
looks like it is micro-optimized for fast register access here.

      Arnd
