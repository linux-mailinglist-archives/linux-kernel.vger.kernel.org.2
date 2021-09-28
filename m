Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177A341B952
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242934AbhI1VfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242917AbhI1VfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:35:20 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C161AC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:33:40 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y26so1751382lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zAK5KWONO/Z7HLFe2Uv80i/fStPUDPzXZXg2mThOE4o=;
        b=vXjvDduX8Iyl6bM/yznsWEvsPMgEbgx9IlDYrdNaTNvP0HMwe129N9WgEzIfyCGNKX
         UFr0ie9SnOxPmXQfypPg3olY5I+3sDILif4FYnDDdACQ1BFkSlunw1sIn7fPN4FuPOcr
         R+uY2KZr6KnLUHt+cXKsXwWU3dLprFgqwLzn0tWG0tf7NIOdrzoLR4WaUOD7a6uxcMJM
         hosBJGe6FfhMWOjprNTQ06w+1vRYVpvjbU5CUkvvfZtJHWXoc0y0Rch4gdCp/9AZxLDw
         fczhVyjJnF/54YWqtyNOtvn+kiuQt8QA830LEFeHsovnNSk8717WpxQM/r+CYNS4yQ31
         goYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAK5KWONO/Z7HLFe2Uv80i/fStPUDPzXZXg2mThOE4o=;
        b=JOSNURVHd6U9kvqjryp+M5856hcPjQLctC/ePqr4Fjc4MidvaJKx0XeIgBYMdQxlg+
         vsFESFQwnOOSaN1INRxhBiPagmDuszk9AnpqiVAJWgOe7r08xC0+ShLS2XLWclbyTe4m
         4T7YxS0Hjanp6ol6C7QiFdFgie2wrOD921s/Xyw3tE/UhLPNta8tZK3z4Vm2yMREbXH0
         ffSP1vUEYp6sf0l4BuUy0E9yINWJ3u+Rolr6qu/ntG2FVbuT8ncohUkihr0P+lnMMd/o
         zJrsGyE14bOgocv2D/ZDONYhEiLDSDHyJb7OuVkXRNs+rGUZmQxcVkAPUw3DwOxz/BhF
         EM8w==
X-Gm-Message-State: AOAM532bJiSjX2qhJPuxhR78BYqwfUd4xcxMKIGAFAIqdyjW6kzXPAHF
        3skuPewNjJIfVdFJphdQIlr0R+UH/C2OwB8RijhxzQ==
X-Google-Smtp-Source: ABdhPJzxOmJ4vA/QR0y62A+k8pNNEjGO4hO5qkA0b5HDkhnTghJMoX9c8iVn83p2LEJa2c8W6qfmS+k1z7OJGgZ1FFI=
X-Received: by 2002:a05:6512:e82:: with SMTP id bi2mr7767870lfb.95.1632864819075;
 Tue, 28 Sep 2021 14:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210928154143.2106903-1-arnd@kernel.org> <20210928154143.2106903-3-arnd@kernel.org>
In-Reply-To: <20210928154143.2106903-3-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Sep 2021 23:33:28 +0200
Message-ID: <CACRpkdY2cjyzCtAwzuOE-4XoGNcxEzP+xEUWmUUs-b9wW+pjsA@mail.gmail.com>
Subject: Re: [PATCH 02/14] ARM: patch: fix BE32 compilation
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 5:42 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> On BE32 kernels, the __opcode_to_mem_thumb32() interface is intentionally
> not defined, but it is referenced whenever runtime patching is enabled
> for the kernel, which may be for ftrace, jump label, kprobes or kgdb:
>
> arch/arm/kernel/patch.c: In function '__patch_text_real':
> arch/arm/kernel/patch.c:94:32: error: implicit declaration of function '__opcode_to_mem_thumb32' [-Werror=implicit-function-declaration]
>    94 |                         insn = __opcode_to_mem_thumb32(insn);
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~
>
> Since BE32 kernels never run Thumb2 code, we never end up using the
> result of this call, so providing an extern declaration without
> a definition makes it build correctly.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
