Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A03B40749C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 04:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhIKCVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 22:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKCVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 22:21:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4F2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 19:19:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso2681192pjq.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 19:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8EtnMLMiIHFJFlHVYJRwro8IIw7R7Mbb5z4Gwszkp08=;
        b=BbotpxrciNC6SLvdNT0vPAdnHOozYpyuu22S0J6+K2/O8L53liWOZknXR9DBQDQ2PZ
         DKRakMqGivp6SZgZNJ2cEoN6fALWQ3mfW6bZp7H3RDlqwJFFUC2FHks34P+JiYgPE4u4
         4GQrBSH3MyNE0gz12/vBib3BIsm7m5bVLabbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8EtnMLMiIHFJFlHVYJRwro8IIw7R7Mbb5z4Gwszkp08=;
        b=YnxF2voOV7Qt6wD2WoQhZH/9LphIR65h1o5N0EkLC81V8amaz71RZZ27+mlibclOcF
         d6Dhc7TTIe+lx8nlZNzBuw0D06HhjrL3K2EmDm33B5kzf3iel1iFpyxCqs8eo8x9iVer
         vIHrTjxpDocxWDuTu0Ci5UpNMZSSOaTYyhsc5g2gzyUOnlURuqspvvLLyXv2Q9JVe8cM
         x/RZyh1hxBJf1X87iKmCJNeisGSrdDdiclTkH0m6uINE6Bcu+YsBP2aDsYAj9gKWSJyF
         vj4198xSse96bkWpS/r6LaPCgr/PqAUQB9J7BcyzHkMFN7nJnpoQxY4he5U5Yuxiu0M4
         FAnw==
X-Gm-Message-State: AOAM532eYdoiQeOkOBEOVyXyvStMLq3tBJPRPK3kpeesFEvr+0kPgG1i
        5S7iC3B6HTFgCH4kkl21yqAmhg==
X-Google-Smtp-Source: ABdhPJy/InJUYPMpMexX3Psdt1AmnK19JNfdvpcE0XYYJRXi/47uXSBR/fUN+csumHsnFG1R3G06qw==
X-Received: by 2002:a17:902:db01:b0:13a:7afa:f9b6 with SMTP id m1-20020a170902db0100b0013a7afaf9b6mr607405plx.43.1631326791529;
        Fri, 10 Sep 2021 19:19:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e13sm175429pfc.137.2021.09.10.19.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 19:19:51 -0700 (PDT)
Date:   Fri, 10 Sep 2021 19:19:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] raise minimum GCC version to 5.1
Message-ID: <202109101917.5BA95B87E0@keescook>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210910234047.1019925-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:40:37PM -0700, Nick Desaulniers wrote:
> commit fad7cd3310db ("nbd: add the check to prevent overflow in
> __nbd_ioctl()")
> 
> raised an issue from the fallback helpers added in
> 
> commit f0907827a8a9 ("compiler.h: enable builtin overflow checkers and add fallback code")
> 
> Specifically, the helpers for checking whether the results of a
> multiplication overflowed (__unsigned_mul_overflow,
> __signed_add_overflow) use the division operator when
> !COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW. This is problematic for 64b
> operands on 32b hosts.
> 
> Also, because the macro is type agnostic, it is very difficult to write
> a similarly type generic macro that dispatches to one of:
> * div64_s64
> * div64_u64
> * div_s64
> * div_u64

Given that it's all compile-time type-aware goo, this isn't so bad. The
gist[1] you linked off the bug report is pretty close. Needs some
bikeshedding. ;)

> Raising the minimum supported versions allows us to remove all of the
> fallback helpers for !COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW, instead
> dispatching the compiler builtins.
> 
> arm64 has already raised the minimum supported GCC version to 5.1, do
> this for all targets now. See the link below for the previous
> discussion.

That said, I'd much prefer raising the minimum GCC -- no one appears
to actually be building on 4.9 -- there are close to 200 errors (neé
warnings) on x86_64 allmodconfig there currently.

-Kees

[1] https://gist.github.com/nickdesaulniers/2479818f4983bbf2d688cebbab435863

-- 
Kees Cook
