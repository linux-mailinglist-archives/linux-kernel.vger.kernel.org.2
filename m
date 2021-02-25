Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B360325776
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhBYUSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbhBYURZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:17:25 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360F2C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:16:42 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h4so4528627pgf.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mr0qfRB0Ik/agsf3L0HG3xZ8g9VBKc2G+9roJzfPeiY=;
        b=euraqYIpl64XJWU+m2Fw7Fyq+kDa7eJRiurKUHe2oMGf4JZeSakNYjP5Zg9jvV2Y7i
         dJiYfNpaLC8ukwM3GczFJRylLgC4twIIVyuMxLgJYzja/cJ+/0R5UQPG7WddojrljFxZ
         EmncsucyA2xWo3DbkTZiRg0sSr53Zfo49Yiwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mr0qfRB0Ik/agsf3L0HG3xZ8g9VBKc2G+9roJzfPeiY=;
        b=c1pnb0KMP1oxHZx0QVza+RwBMjykox3bGW7qWorBMuVmn7W1wfcw0L2XsC61VBJMz8
         mEWB2h6fv4tQpJUsjO+ZVMIjhfvZVyEp1Pm4gpDF7NG7tZQ5kuGKBT9EI4cka66tPO1K
         MQ/Qkf1j/7fJkfiC4jV5C9YoUcwomGyEi+CT240tOhVkCKBsTpFDCPlSe9ZC2rxQykad
         RNmcZJ3JecQtRtAZ9L3Nyllvp5J/BW9aopMVp7djQy8WLhVSAl5Uwhsi0Pg2gZgtg8AP
         CV+okfMslUM0LTdKqnF8RtAo2cHFCY4I3Rx5ngI5DTOxz2jxOnkKUB2B0zOlgR3YtjOV
         iuEA==
X-Gm-Message-State: AOAM530PCc2SsucKWiVhYNhtosAEVdvIRC0ElgVZ0HPpBlBvG9K38Cit
        /cMd12vkvhCz0QbeRcyJ7TmdoQ==
X-Google-Smtp-Source: ABdhPJzu0QIjDXTR7OQR9Z1qCNxRIOUORSgg7eUBcP4OkAwlJhANLNn18mAIXKIhEeF1cPgAQ3sF1w==
X-Received: by 2002:a62:187:0:b029:1da:e323:a96b with SMTP id 129-20020a6201870000b02901dae323a96bmr5028766pfb.28.1614284201699;
        Thu, 25 Feb 2021 12:16:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h3sm6888983pgm.67.2021.02.25.12.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 12:16:41 -0800 (PST)
Date:   Thu, 25 Feb 2021 12:16:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <202102251216.935EFD7F@keescook>
References: <20210225112122.2198845-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225112122.2198845-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 12:20:56PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When looking at kernel size optimizations, I found that arm64
> does not currently support HAVE_LD_DEAD_CODE_DATA_ELIMINATION,
> which enables the --gc-sections flag to the linker.
> 
> I see that for a defconfig build with llvm, there are some
> notable improvements from enabling this, in particular when
> combined with the recently added CONFIG_LTO_CLANG_THIN
> and CONFIG_TRIM_UNUSED_KSYMS:
> 
>    text    data     bss     dec     hex filename
> 16570322 10998617 506468 28075407 1ac658f defconfig/vmlinux
> 16318793 10569913 506468 27395174 1a20466 trim_defconfig/vmlinux
> 16281234 10984848 504291 27770373 1a7be05 gc_defconfig/vmlinux
> 16029705 10556880 504355 27090940 19d5ffc gc+trim_defconfig/vmlinux
> 17040142 11102945 504196 28647283 1b51f73 thinlto_defconfig/vmlinux
> 16788613 10663201 504196 27956010 1aa932a thinlto+trim_defconfig/vmlinux
> 16347062 11043384 502499 27892945 1a99cd1 gc+thinlto_defconfig/vmlinux
> 15759453 10532792 502395 26794640 198da90 gc+thinlto+trim_defconfig/vmlinux
> 
> I needed a small change to the linker script to get clean randconfig
> builds, but I have not done any meaningful boot testing on it to
> see if it works. If there are no regressions, I wonder whether this
> should be autmatically done for LTO builds, given that it improves
> both kernel size and compile speed.
> 
> Link: https://lore.kernel.org/lkml/CAK8P3a05VZ9hSKRzVTxTn+1nf9E+gqebJWTj6N23nfm+ELHt9A@mail.gmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
