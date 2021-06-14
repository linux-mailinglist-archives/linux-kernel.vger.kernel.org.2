Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0405D3A7194
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 23:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhFNVwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 17:52:54 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:43738 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhFNVwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 17:52:53 -0400
Received: by mail-pl1-f179.google.com with SMTP id v12so7342886plo.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 14:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z+SsS0U38s/fJi9qjHupa5g0l6XG7YiyozghO0iYXTQ=;
        b=eHTPUTjEh2GUAbGujgV0/SJPWgjHqUGhvDz5/lmWhNscCwedE+GR/UIZLUQyszZFk9
         JoBe+/dG91AK8hXs2JDpSPREPMxoGaosjzAmRbPeJBPFWrak/qpP9FHyKde4q2C3qIV+
         Y3blvxAQwXIhk/NWHVauidUY14rUulUFLxobc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z+SsS0U38s/fJi9qjHupa5g0l6XG7YiyozghO0iYXTQ=;
        b=qkKWuHJkiJFsraqlLIN1DsOj9UToNZXnZnffRwuiEGzTT9H7oifycIZfChciKYyICr
         H7dEZdCvemWt+sK6ByQBFRdHpo2JFCfYcqnegWuj/7gDFGQsyMjpxctETELDe95R6vJD
         Lvq42YBsTKiGCTJFXwLjjK7qm3TlNBwZv6HtALut17TYdW3nJs/PwYBbE42EfHv0XGdD
         k2iPBu2ldZB6IIE1CpeiWgm4AhNwZRUy6HvnVhS3enE9B7UCt1vN8bV7fSusv+KuUj2/
         eSSLXuE4bayH1uhQrJA3C7r15fvoDeUklHrhCHpSaWV6HjKRx19JGOaEG6MPJMzDuMgU
         Py/Q==
X-Gm-Message-State: AOAM530T0xBTtGw51R8AxbTESSsPDtgdF7w7G9vT0gfPo0LVzp/6ar11
        UvLYXXUtukEof91Fio2itufSpw==
X-Google-Smtp-Source: ABdhPJzFKgxFS5RI/pCPCRNOnMfP65yaSPG4oxKn0iigWBwn/LZUwurjCVArBrs2elgaZkVHFJtTlA==
X-Received: by 2002:a17:90a:b792:: with SMTP id m18mr2250081pjr.140.1623707390005;
        Mon, 14 Jun 2021 14:49:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o186sm13307906pfb.59.2021.06.14.14.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 14:49:49 -0700 (PDT)
Date:   Mon, 14 Jun 2021 14:49:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tor Vic <torvic9@mailbox.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org, Nathan Chancellor <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 1/1] Makefile: Pass -warn-stack-size only on LLD < 13.0.0
Message-ID: <202106141448.A0BD79129@keescook>
References: <7631bab7-a8ab-f884-ab54-f4198976125c@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7631bab7-a8ab-f884-ab54-f4198976125c@mailbox.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 01:07:49PM +0000, Tor Vic wrote:
> Since LLVM commit fc018eb, the '-warn-stack-size' flag has been dropped
> [1], leading to the following error message when building with Clang-13
> and LLD-13:
> 
>     ld.lld: error: -plugin-opt=-: ld.lld: Unknown command line argument
>     '-warn-stack-size=2048'.  Try: 'ld.lld --help'
>     ld.lld: Did you mean '--asan-stack=2048'?
> 
> In the same way as with commit 2398ce80152a ("x86, lto: Pass
> -stack-alignment only on LLD < 13.0.0") , make '-warn-stack-size'
> conditional on LLD < 13.0.0.
> 
> [1] https://reviews.llvm.org/D103928

Is there a way Clang can just warn instead of breaking the kernel build
when it moves these kinds of options around? That would make things must
less disruptive to the CI, etc. :)

-Kees

> Fixes: 24845dcb170e ("Makefile: LTO: have linker check -Wframe-larger-than")
> Cc: stable@vger.kernel.org
> Link: https://github.com/ClangBuiltLinux/linux/issues/1377
> Signed-off-by: Tor Vic <torvic9@mailbox.org>
> ---
>  Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 144d4f8b7eb3..51a1b6b2c2ab 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -929,11 +929,14 @@ CC_FLAGS_LTO	+= -fvisibility=hidden
>  # Limit inlining across translation units to reduce binary size
>  KBUILD_LDFLAGS += -mllvm -import-instr-limit=5
> 
> -# Check for frame size exceeding threshold during prolog/epilog insertion.
> +# Check for frame size exceeding threshold during prolog/epilog insertion
> +# when using lld < 13.0.0.
>  ifneq ($(CONFIG_FRAME_WARN),0)
> +ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 130000; echo $$?),0)
>  KBUILD_LDFLAGS	+= -plugin-opt=-warn-stack-size=$(CONFIG_FRAME_WARN)
>  endif
>  endif
> +endif
> 
>  ifdef CONFIG_LTO
>  KBUILD_CFLAGS	+= -fno-lto $(CC_FLAGS_LTO)
> -- 
> 2.32.0

-- 
Kees Cook
