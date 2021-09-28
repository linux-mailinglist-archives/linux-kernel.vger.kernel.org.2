Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F401341B991
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242996AbhI1VqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242987AbhI1VqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:46:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E23C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:44:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id bd28so493382edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/OvWBlXIC3vAiOn884UWZV20fUxwEJyO2lDA28+sf/E=;
        b=hVZm+Iba9fHNkhnmfNB1AbH1LpNEe7jMDaK4jiHnsjnThMdsYOmFjWOfwdHpdznSz9
         WV/equMm28tsPhg8snenVYB2KQg6gi7ZPfV/jNGbD2cQr9hZFtFfFxdUClVCPDgno5DN
         +2FcYUj2ijocVOFQSFOHa+BBegr9dTBOayzGGvAxKo2ZV1cLqX/P/Go7JPTYn0pqDBpZ
         YrX/1Zs72RSN5J5H1vYjw3/yUY05b3/FD0VR7OUVEz//KizuGcdcg2e5p5m8QfW60IKH
         +3YvN2yhht53qOXlnE2ydKzznLYhMJdSXGakGHu+rtGMb5k3gYPGeyCQ7wRee+AC+CIz
         04QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OvWBlXIC3vAiOn884UWZV20fUxwEJyO2lDA28+sf/E=;
        b=WWTPZspmsXxhfbUoRZvQGzC0ptu6dr+lQre/ClxWEBfdnagf0sFpDjjkF6k6/K91Ij
         g6Jn/YDU1xFkPIugmBstBQIPRl9gNkuE0XNTj+yPEnnyywximB9zuDlm+0lDwabhWnxT
         BGfuLeNiPPWJ8u9RtnrCFSXzk7GqtyPtKkJe9vOyph0dv/QW59mbG5JVqBf1l6i/0Ugw
         /pKz8GRj/EySddrASVppWhH088iWnEInumqGjos60Di8MDrgzsOc/ANNkb9UDhi0Kp6D
         ffWqkN24YnD3PqurMv6GN9XN7rw2VUyQecqRsEskNxmyalPbrNHZvIHenuVGHz9xebsw
         6vbA==
X-Gm-Message-State: AOAM532qL/MILd8TQIbQ6a4ypRGB046PyL4Fqrgz2XplnHeXeAWZFCXV
        DduslJAblzZYyRPwUA2XRHFYtvMylaTHm7yiPvPqrA==
X-Google-Smtp-Source: ABdhPJzMysAzvEEoqbdkqUNii2z3Bkjw4Co1mDyvel80h8sKftwI/zcnhzdgGdWA1oucJ2HRG9U7hQ/xqa2+puwgLgs=
X-Received: by 2002:a17:906:8618:: with SMTP id o24mr6798492ejx.189.1632865461191;
 Tue, 28 Sep 2021 14:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210928154143.2106903-1-arnd@kernel.org> <20210928154143.2106903-13-arnd@kernel.org>
In-Reply-To: <20210928154143.2106903-13-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Sep 2021 23:44:10 +0200
Message-ID: <CACRpkdZ+v4BPSJhmztd5Visyo3tMmJXDBXOt5B_c7BdtvBQuQQ@mail.gmail.com>
Subject: Re: [PATCH 12/14] ARM: add CONFIG_PHYS_OFFSET default values
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, Nicolas Pitre <nico@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 5:42 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> For platforms that are not yet converted to ARCH_MULTIPLATFORM,
> we can disable CONFIG_ARM_PATCH_PHYS_VIRT, which in turn requires
> setting a correct address here.
>
> As we actualy know what all the values are supposed to be based
> on the old mach/memory.h header file contents (from git history),
> we can just add them here.
>
> This also solves a problem in Kconfig where 'make randconfig'
> fails to continue if no number is selected for a 'hex' option.
> Users can still override the number at configuration time, e.g.
> when the memory visible to the kernel starts at a nonstandard
> address on some machine, but it should no longer be required
> now.
>
> I originally posted this back in 2016, but the problem still
> persists. The patch has gotten much simpler though, as almost
> all platforms rely on ARM_PATCH_PHYS_VIRT now.
>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Link: https://lore.kernel.org/linux-arm-kernel/1455804123-2526139-5-git-send-email-arnd@arndb.de/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

BTW thanks for this very nice cleanup patch set!

Yours,
Linus Walleij
