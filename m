Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79B140B8A2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhINUDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhINUDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:03:35 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C59FC061768
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:02:14 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id i28so789679ljm.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbWkolcm+ANzoV9xuDvSV9WrohIVsxKiIB6DNRxGuYQ=;
        b=AumVqFTPEOpwx/P01HDSDl0Xyg9EZjukpRm4GjNnTxYi4iflx8ADSvZYffaWzo6YRX
         ZlUPMpQATGWyZ1ymbyqu+Y6A8p/ZyiaEjbs8428eLfoRyWqoArZf0Lgc0mv2n3fHfuA7
         QdHyKbFtIF6C2xzsgZHoB67ZBy2bxmxdrQVKZvTQdPzS0LgRbGylCT5dQszKRQb1btUP
         TKMz1/TYe9Mokaf2zDFhR7pOhOlu661WSTCEWEyGBh9JZ0l84CoOTMDjeeocYnZdCbiH
         5sJq0K/cPviZeLfsgxoWFa3mOqyNIgDWabCPWdMZ1es8uEpGhWgrBm9rmUpF3iGlRS2J
         QUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbWkolcm+ANzoV9xuDvSV9WrohIVsxKiIB6DNRxGuYQ=;
        b=v6WI1QVi8kEPnpPtJvguCa51XMdqL//K5cb48krOYaBXAY4amyXoCa694YSrQnGpN3
         EEFAEYC2OQG9EBWFKXfOfWMchITyTPoSSR88mV+OWmynnRtXn3VG1tge7szEnH0kL8Jp
         PsrUz4PWJbjT089RcglPRIc/97OWNksC41qUZ8xJRBTFhpucXYki8PyWSEn++iSgFoF9
         5VFC3nqv5yA5OF4EIQzoq1NgnyajoT3ufSEfgreF6v8+h+bVtHcIDhzyPNdHGDraPY4e
         LoAhS+9yGAC/CI5W8gKQzbXX93BpnWMG41TRzkoW3HV9Ru78zI+5IZTRgihBmRlPVdr2
         bXbw==
X-Gm-Message-State: AOAM531wzz9GerjKu0wNmiGZ+bP/T0FNOU6orQUenraSOWXNY/PpNNo6
        kZOXIuweZs4KWjVnidLT5zHKXrjk/rSIJsgrh02vxg==
X-Google-Smtp-Source: ABdhPJw4LtQ05rJ+hXSjPwQcTef45Tg42XsJIXLFX5Za0EUr6bqFR/mLTAL/6ZogeLtnD6KV3CulDGGwOquR7AbFCUA=
X-Received: by 2002:a2e:750e:: with SMTP id q14mr16766504ljc.338.1631649732696;
 Tue, 14 Sep 2021 13:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com> <20210914191045.2234020-12-samitolvanen@google.com>
In-Reply-To: <20210914191045.2234020-12-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Sep 2021 13:02:01 -0700
Message-ID: <CAKwvOd=OvR8iZogXhMxkbt5qT7jbhaARgk5NsCzhpkjoZ7yy5Q@mail.gmail.com>
Subject: Re: [PATCH v3 11/16] x86/purgatory: Disable CFI
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:11 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

I kind of prefer the existing convention that has explicit guards on
specific configs (ie. CONFIG_FUNCTION_TRACER, CONFIG_STACKPROTECTOR,
CONFIG_STACKPROTECTOR_STRONG, CONFIG_RETPOLINE); it's more obvious
which configs may introduce which flags that are problematic. This
patch is ok as is, but it kind of makes this Makefile more
inconsistent.  I would prefer we had the explicit checks.

Does CFI actually do any instrumentation in these object files? I
guess issues in purgatory cause silent/hard to debug kexec failures?

> ---
>  arch/x86/purgatory/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 95ea17a9d20c..ed46ad780130 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -31,7 +31,7 @@ KCOV_INSTRUMENT := n
>  # These are adjustments to the compiler flags used for objects that
>  # make up the standalone purgatory.ro
>
> -PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
> +PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel $(CC_FLAGS_CFI)
>  PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
>  PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
>  PURGATORY_CFLAGS += -fno-stack-protector
> --
> 2.33.0.309.g3052b89438-goog
>


-- 
Thanks,
~Nick Desaulniers
