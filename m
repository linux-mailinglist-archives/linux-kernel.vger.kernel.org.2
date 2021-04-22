Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4720B368719
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 21:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbhDVTWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 15:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbhDVTWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 15:22:10 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28734C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 12:21:35 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id z16so33524784pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L67ALFFmot+NMgvYIfYllNjpngT6fRjIvKK8Ya35Duo=;
        b=UXe3BeIdc9I17JF1X8VpKUYyHU0qLrmwt/Lb3nH2kMSYSH8GRuS7HaFJUHUdaYPpzF
         Om5ObbIz+MsO+gTAJdX6KSJU/3XTMwUELFKIj7hfAL5aS3FOPS6Rv1n78adzCASJCoqe
         EdyDir1tZ6fQxT3MjYPtUTj5ZgAeOT4oUvK2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L67ALFFmot+NMgvYIfYllNjpngT6fRjIvKK8Ya35Duo=;
        b=JZnICoPP+TEwlqYBmklve3OHsWu54Ou3ZEaLQwRSTSw24rAV6H4BBjGX4gPJ7Z48DH
         r6+nyj5t0igXnZVehO3oeKx8m5TjVH9Uwrqn7Ia/2MdBr4jMgOrLjTaFyvJLCplqcf+F
         t25IBPc8YSG3fGHOU3cSy9LbVigw3CLmkEi4M39UPTVblhpPmB2V5k4HRt3SPKsK3Nnq
         WOTjsGPOu0JDWsmprnv0/HitZYdziGtTGFBZFqLgp/zmolaw5F8ITbqk8UZb3G9GKU7y
         eGnaBnDm+1+kCnhcIIIAVb7Tj0IInha/4oZ152oAWeZm3F/mvp+xdXUI67k3y9SBx8Vj
         uEAg==
X-Gm-Message-State: AOAM531fm4KxgY9AnbSYbRSkfjLN+MqrCajZ/NyevWj6pNPfYDlXGzAF
        MoiI8sHkI994RftRcdQivPfZIA==
X-Google-Smtp-Source: ABdhPJxF1q1uHLoaMBm/Wwy3ZTXxncyGfUjtXwScEhQ/0nJumHLrcpcZ6ei3qpt1GdbNikZYzw5Iww==
X-Received: by 2002:a63:4c4b:: with SMTP id m11mr178690pgl.245.1619119294612;
        Thu, 22 Apr 2021 12:21:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b21sm3052029pji.39.2021.04.22.12.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 12:21:34 -0700 (PDT)
Date:   Thu, 22 Apr 2021 12:21:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Joe Perches <joe@perches.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Joerg Roedel <jroedel@suse.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/compressed: enable -Wundef
Message-ID: <202104221221.44A0CCD70D@keescook>
References: <20210422190450.3903999-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422190450.3903999-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 12:04:42PM -0700, Nick Desaulniers wrote:
> A discussion around -Wundef showed that there were still a few boolean
> Kconfigs where #if was used rather than #ifdef to guard different code.
> Kconfig doesn't define boolean configs, which can result in -Wundef
> warnings.
> 
> arch/x86/boot/compressed/Makefile resets the CFLAGS used for this
> directory, and doesn't re-enable -Wundef as the top level Makefile does.
> If re-added, with RANDOMIZE_BASE and X86_NEED_RELOCS disabled, the
> following warnings are visible.
> 
> arch/x86/boot/compressed/misc.h:82:5: warning: 'CONFIG_RANDOMIZE_BASE'
> is not defined, evaluates to 0 [-Wundef]
>     ^
> arch/x86/boot/compressed/misc.c:175:5: warning: 'CONFIG_X86_NEED_RELOCS'
> is not defined, evaluates to 0 [-Wundef]
>     ^
> 
> Simply fix these and re-enable this warning for this directory.
> 
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Joe Perches <joe@perches.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/570
> Link: https://lore.kernel.org/lkml/67f6cd269684c9aa8463ff4812c3b4605e6739c3.camel@perches.com/
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
