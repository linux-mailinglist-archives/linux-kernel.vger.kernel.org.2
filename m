Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552E23145C0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhBIBlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhBIBkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:40:10 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB43C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 17:39:29 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id r65so2496763lff.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 17:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVJrtVbOEkQeZbesRKYhsTkz4bxOuNAN5R8eee3+3BA=;
        b=A9C7faioXC/fE/JHCjjNXXeup9N2pj9pgGlkMaDFLHdW6VbqfxjF2m28Fs4fMD7VJz
         EQX+Fyr4WeCSUCnDknnv4NWOPoi98V9msOapcD9zRNuNyw7VbG3N0n+ZrBt1bDxVYhej
         EHFCC7a6JQAi41nA31435arAczg+rcyuyXHugOfQuBrmSQzr87nGOoV3pZbW3YBSNX9e
         /Ok2+sKFVQU3kffsuFzs6wMnIt+jeYgVisEubx/fJUa51eXsCpA7dwi/dC1XlFMrGTiC
         dax08cTimOLylckl178BBvWHs3Z5s3g+baIYAt1571DcPDxtEStosJpSX8Tp8ISD2byK
         NU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVJrtVbOEkQeZbesRKYhsTkz4bxOuNAN5R8eee3+3BA=;
        b=btm1/+Z0kMwaDpvYVcV4ZrgE/cZ4s5Cg4huZj95PJ7xYn0/NVaJRs236CfnHLousqr
         0nbGNDq/SqizneNolPeHo1pmzzbriOmfxdmNwxKlVO5ahTDlVwLxFCGf2iRuofgvYggt
         xBLX+GYiIV9nXngRkyaNDNzG3RUrhcz4DcnGuXaJeLYBejBfF3o0u1W10Kc98kMSoeUC
         TZkhYduwpnpRvQrkTcbN+EYyQsOnuqa5lnw0V+ynk8L7F98238JlAhRvIZHvuLb/jK8Q
         xTX8LYBA6JMrLprlNtp70ax25nreTPd9Gsgp15pnTsBA6BuJqjBZh+//A78wGTLyuU5d
         o+/g==
X-Gm-Message-State: AOAM530+il5X08a9vNZfLjBVUphXoW+9+DB8OpCQwf1xYQVhJBLTFXrO
        ghLUhFHsNbKkD3fx77Qkv4bXZ3q0qMAo/2Pbi3zp8Q==
X-Google-Smtp-Source: ABdhPJwB0FaJ86DVhtYlvTWzKa0rxanMYJOHyVD/WotNYmG0znQdQeGFeRiqHZv0cevJP331wFbLkAfH4TrH8GiZBx4=
X-Received: by 2002:ac2:5e90:: with SMTP id b16mr11605061lfq.122.1612834768181;
 Mon, 08 Feb 2021 17:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20210202022441.1451389-1-nathan@kernel.org> <20210209005719.803608-1-nathan@kernel.org>
In-Reply-To: <20210209005719.803608-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 8 Feb 2021 17:39:16 -0800
Message-ID: <CAKwvOdkwoF8OqSY0mJbPh658N3QBPHARgiHP6K3H+=gPT6+R8g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: Make CPU_BIG_ENDIAN depend on ld.bfd or ld.lld 13.0.0+
To:     Nathan Chancellor <nathan@kernel.org>,
        Fangrui Song <maskray@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 4:58 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Similar to commit 28187dc8ebd9 ("ARM: 9025/1: Kconfig: CPU_BIG_ENDIAN
> depends on !LD_IS_LLD"), ld.lld prior to 13.0.0 does not properly
> support aarch64 big endian, leading to the following build error when
> CONFIG_CPU_BIG_ENDIAN is selected:
>
> ld.lld: error: unknown emulation: aarch64linuxb
>
> This has been resolved in LLVM 13. To avoid errors like this, only allow
> CONFIG_CPU_BIG_ENDIAN to be selected if using ld.bfd or ld.lld 13.0.0
> and newer.
>
> While we are here, the indentation of this symbol used spaces since its
> introduction in commit a872013d6d03 ("arm64: kconfig: allow
> CPU_BIG_ENDIAN to be selected"). Change it to tabs to be consistent with
> kernel coding style.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/380
> Link: https://github.com/ClangBuiltLinux/linux/issues/1288
> Link: https://github.com/llvm/llvm-project/commit/7605a9a009b5fa3bdac07e3131c8d82f6d08feb7
> Link: https://github.com/llvm/llvm-project/commit/eea34aae2e74e9b6fbdd5b95f479bc7f397bf387
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

LGTM, thanks for implementing BE support for aarch64 in LLD, Fangrui!
(And Nathan for the kernel patch+testing)
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> v1 -> v2:
>
> * Conditionally disable CONFIG_CPU_BIG_ENDIAN for older versions of
>   ld.lld now that proper support has been added to ld.lld 13+ (thanks to
>   the quick work of Fangrui Song).
>
>  arch/arm64/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index f39568b28ec1..912da4e2ab59 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -952,8 +952,9 @@ choice
>           that is selected here.
>
>  config CPU_BIG_ENDIAN
> -       bool "Build big-endian kernel"
> -       help
> +       bool "Build big-endian kernel"
> +       depends on !LD_IS_LLD || LLD_VERSION >= 130000
> +       help
>           Say Y if you plan on running a kernel with a big-endian userspace.
>
>  config CPU_LITTLE_ENDIAN
>
> base-commit: 92bf22614b21a2706f4993b278017e437f7785b3
> --
> 2.30.1
>


-- 
Thanks,
~Nick Desaulniers
