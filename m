Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9160C3BA023
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 13:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhGBMCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231912AbhGBMCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:02:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F3EC6141D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 11:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625227185;
        bh=8rtNsvaI1RHggmsZdI3pAW+DctsXAHwCkT27YexpT/A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DwP+PEktSgVq7gQ0gXyZW4ifnc/xeGi9nAVp5X0zWMubqTIyzWtFT6n4sgqIEIP1M
         LWBgndsYwMal8kuvn3fyKB5ShJAglxOMh0VT632WFbb0We9OG5rgv/7VEeL64wgYCl
         /llI6RMuBW9opalCMOY2/6fHgGQb8VUN6zN+g+pm6+exbIDT9QD/MJqpFC6kK5afSS
         G0pM5SS0fV5qsljOgu8ZuO0zARQeH9yitr5bsuMvMLBc4D6bWUVzSEYavI/YBjfSE1
         af/5NUaJwNR784XPVrBWqMOL1cJWfBcwZcC2kpddEl0sNRGgrzjdR9u+u28QYEikkw
         Zt9GYMFLLvcNQ==
Received: by mail-wm1-f43.google.com with SMTP id b14-20020a1c1b0e0000b02901fc3a62af78so2339574wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 04:59:45 -0700 (PDT)
X-Gm-Message-State: AOAM5315k7saPUjjXEKkQ0V4yEKD6OniIzTCRFA2zaQG4I4QlKwuK0xw
        WKMsIG6gByELBzPdX2Te5Krs+BrREku1JkiLTnM=
X-Google-Smtp-Source: ABdhPJwF4kuxfZztdywzrGPdXLkjpSbnED1hOv6IrSdBVWuLbGYJ6rUssgt2qq2BTVDOAypw3hqCPBCEvvuuGwxdhgE=
X-Received: by 2002:a05:600c:3205:: with SMTP id r5mr6678910wmp.75.1625227184199;
 Fri, 02 Jul 2021 04:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210701235505.1792711-1-ndesaulniers@google.com>
In-Reply-To: <20210701235505.1792711-1-ndesaulniers@google.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 2 Jul 2021 13:59:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1EfBNxaMbsp+s2BiYHGKPK4NeRR+ugM82jfY43Pq7-Uw@mail.gmail.com>
Message-ID: <CAK8P3a1EfBNxaMbsp+s2BiYHGKPK4NeRR+ugM82jfY43Pq7-Uw@mail.gmail.com>
Subject: Re: [PATCH] arm64: drop CROSS_COMPILE for LLVM=1 LLVM_IAS=1
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 1:55 AM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> +ifneq ($(LLVM),)
> +ifneq ($(LLVM_IAS),)
> +ifeq ($(CROSS_COMPILE),)
> +CLANG_TARGET   :=--target=aarch64-linux
> +CLANG_FLAGS    += $(CLANG_TARGET)
> +KBUILD_CFLAGS  += $(CLANG_TARGET)
> +KBUILD_AFLAGS  += $(CLANG_TARGET)
> +endif
> +endif
> +endif

I think only the "CLANG_TARGET   :=--target=aarch64-linux" line should
go into the
per-architecture Makefile. It doesn't hurt to just set that
unconditionally here,
and then change the CLANG_FLAGS logic in the top-level Makefile to use this
in place of $(notdir $(CROSS_COMPILE:%-=%)).

       Arnd
