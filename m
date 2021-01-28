Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3818307A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 17:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhA1QQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 11:16:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231233AbhA1QQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:16:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC2E164E07
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 16:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611850531;
        bh=Bf8FGjgHMZZQbBqF/RyoAVCwsQFjmzA+aLlGG8ewick=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LQx+MfLkWxwe8AEdJqQ7+nZXcQ56oMK22Mf7TduQYvPyXWM2yKrgVC7jVy3P9p+8D
         a8yMj+pJ7MtdeovESRJ1lqyVOthIRxXPwyhvUke9FrbD0yuU4LhgFTbtC7MR9BzEWR
         L9d0v1KR3u43WjhocoiVfpJhdlvkiNMDc4rrUpMmyvn9fkTSIdQcG0/P1xWdtqlZ5f
         ZEU0eAPeRMUQuJdRTCVlaRJ3Xe7GDMvOE1Y5y1exvpWJIMxhYGf+uUWxD+qcEFIh21
         jXaPK+ZrrX4s3KYdJ4AHSpQXnsQ8OxM+9Lz3L8APXKVIWDKnjtAINsixdXnpPww1fz
         Up7mUMin2FupA==
Received: by mail-oo1-f47.google.com with SMTP id u7so1554908ooq.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 08:15:30 -0800 (PST)
X-Gm-Message-State: AOAM530Cx+kzR7CaQVxjZjdmNwDtWtZPXtCzIQGDd8zel7acpsnq79FN
        jdMH0Cm32NxurljP8j9su5nMFXwmWMP4YZvkMoQ=
X-Google-Smtp-Source: ABdhPJztAGHg/Ija/0BNN0/p16vx3WFptcgZ+GPHCTPTPxaZHtGJVx0dTrhlcnnxi5C9+7ujlXgl3Q3hmZSUvC8sSa4=
X-Received: by 2002:a4a:88c9:: with SMTP id q9mr237072ooh.26.1611850530253;
 Thu, 28 Jan 2021 08:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20210128044356.38419-1-ndesaulniers@google.com>
In-Reply-To: <20210128044356.38419-1-ndesaulniers@google.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 28 Jan 2021 17:15:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0MbxMC9iLe0NGR0ttLY7sZDjsrgKvfRZOXVJLjzDNKmA@mail.gmail.com>
Message-ID: <CAK8P3a0MbxMC9iLe0NGR0ttLY7sZDjsrgKvfRZOXVJLjzDNKmA@mail.gmail.com>
Subject: Re: [PATCH] ARM: kprobes: rewrite in UAL
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 5:44 AM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Clang's integrated assembler only accepts UAL syntax, rewrite the
> instructions that were changed by RVCTv2.1.
>
> The document "Assembly language changes after RVCTv2.1" was very
> helpful.
>
> This exposed a bug in Clang's integrated assembler, which hopefully will
> land in clang-12, but is required to test this patch with LLVM_IAS=1.
>
> Link: https://developer.arm.com/documentation/dui0473/c/writing-arm-assembly-language/assembly-language-changes-after-rvctv2-1
> Link: https://github.com/ClangBuiltLinux/linux/issues/1271
> Link: https://reviews.llvm.org/D95586
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/arm/probes/kprobes/test-arm.c | 288 ++++++++++++++---------------
>  1 file changed, 144 insertions(+), 144 deletions(-)

This mostly works, but I see one extra case in some configurations:


arch/arm/probes/kprobes/test-arm.c:453:2: error: invalid instruction,
did you mean: swpb?
        TEST_R( "swpvsb r0, r",1,VAL1,", [sp]")
        ^
arch/arm/probes/kprobes/test-core.h:235:2: note: expanded from macro 'TEST_R'
        TEST_INSTRUCTION(code1 #reg code2)              \
        ^
arch/arm/probes/kprobes/test-core.h:155:17: note: expanded from macro
'TEST_INSTRUCTION'
        "50:    nop                                     \n\t"   \
                                                          ^
<inline asm>:20:5: note: instantiated into assembly here
        1:      swpvsb  r0, r1, [sp]
                ^~~~~~

Plus a lot of extra errors when building with CONFIG_THUMB2_KERNEL,
as that uses tests in arch/arm/probes/kprobes/test-thumb.c.

        Arnd
