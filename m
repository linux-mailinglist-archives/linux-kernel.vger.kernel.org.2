Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE693829AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbhEQKTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbhEQKTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:19:33 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10680C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:18:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m11so7990052lfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QpD2zMBxw5znlPKt4SJEqzKdA2fPgb5vzD+kazPbf2Q=;
        b=YW8aguL1Or6+vxZUZkBLdiM0tAjt2lRGVb2q7Un8iQZCfMuLZ2s8l9onWyOmLEsvC2
         RwXXtW47esnkr/mlxu3DOWSA42AjLpTbAnm03enYxdFOJS30ZdBaRz4V3m5kqPh8wO+e
         bP6ouEwKpEOmN5KZ91tONBJCRfXitJt2PPXzLmPLcik0JewIp1qw2qP+SKdC/g+1iYSX
         tjA1aSLFOg1/7qFlAqANS4ZDVVaJu4fdn+U+eSYObQSbNxoMo27nxIOS1x8AlhvfqQjR
         4uDfcuUAbBvrIjjFa3/5nmwLwPi3KHmFYu4J6V+HcwT9C6d3e6N3vQIpUCmDPtW07MEZ
         dmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QpD2zMBxw5znlPKt4SJEqzKdA2fPgb5vzD+kazPbf2Q=;
        b=K0Napnw0wxdNebFbqP35YcZohbofacDZh7+bXKtLibn/p6nfcMJ+M0GHgHV2IOOnjS
         w4NfG0ORzoxGAhHjNPPhU9zzYn5AMiJPow9TDvQQW6r9CCF8Qloau8U0AVVKTSMMepUT
         T5+JxZGJ/OAsPSguHQUUxIXbCgex5YZwA4MZrMD15RmSn7RwqvgU6Ad27FeKZ2hYODZT
         Wl1pGg4aN4GWB58BcDv2FAb1yjP2SPxLlKP56mNhSw44K+X6XgZQ1cphX61DbyoUz3kW
         VVeR8niZif3PVEw2ZN0xRLrQnNXPWQrSLYNm6ABc0lxx2EUhj4DLlj3q4rUN7o83ymEw
         s+5Q==
X-Gm-Message-State: AOAM530kB0Dl/Rxd0rfLYGFu3q1pi4grwO6i5NF42rLmcdiXgklD6cJi
        gs88VvZKBJcwLrqOvj9dipSeCc4J9qi2OSiGoqgMRA==
X-Google-Smtp-Source: ABdhPJzT4oOH3/URfeXgpdb2qfPLVl7Vky9lNpykIEHlPPjpp1cuGfZpwwmjydsYIVL9+54HTwIFWa7+cUxSgD2UsVI=
X-Received: by 2002:a05:6512:11ea:: with SMTP id p10mr89321lfs.157.1621246695068;
 Mon, 17 May 2021 03:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210512081211.200025-1-arnd@kernel.org>
In-Reply-To: <20210512081211.200025-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 May 2021 12:18:04 +0200
Message-ID: <CACRpkdbpYkLeh3bJ9U42fCHMLj=XY17Of-vvt_1JxEukYWPSHg@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix gcc-10 thumb2-kernel regression
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, stable <stable@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mike Rapoport <rppt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 10:13 AM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> When building the kernel wtih gcc-10 or higher using the
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y flag, the compiler picks a slightly
> different set of registers for the inline assembly in cpu_init() that
> subsequently results in a corrupt kernel stack as well as remaining in
> FIQ mode. If a banked register is used for the last argument, the wrong
> version of that register gets loaded into CPSR_c.  When building in Arm
> mode, the arguments are passed as immediate values and the bug cannot
> happen.
>
> This got introduced when Daniel reworked the FIQ handling and was
> technically always broken, but happened to work with both clang and gcc
> before gcc-10 as long as they picked one of the lower registers.
> This is probably an indication that still very few people build the
> kernel in Thumb2 mode.
>
> Marek pointed out the problem on IRC, Arnd narrowed it down to this
> inline assembly and Russell pinpointed the exact bug.
>
> Change the constraints to force the final mode switch to use a non-banked
> register for the argument to ensure that the correct constant gets loaded.
> Another alternative would be to always use registers for the constant
> arguments to avoid the #ifdef that has now become more complex.
>
> Cc: <stable@vger.kernel.org> # v3.18+
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Reported-by: Marek Vasut <marek.vasut@gmail.com>
> Fixes: c0e7f7ee717e ("ARM: 8150/3: fiq: Replace default FIQ handler")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Wow. Nice bug hunt here, hats off!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
