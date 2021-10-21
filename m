Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1806D435D29
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhJUIpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhJUIp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:45:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C86C061749
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:43:10 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q10-20020a17090a1b0a00b001a076a59640so5385378pjq.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SJY6DwBxYVl+QUdSNsoZifHerg6QBwwY0i9CzwdxMWE=;
        b=T6xp/4rRQ2ni9q4hjRUv5sDCw9v4MnNb+VFqHyZqOYewUPxK/LVPnMxmI3w5PbfnGZ
         1b9C389vnxyBOT6zkE1fZkYJexriIRsISNnH2pBsEuQUmrY0nlRB227dDn3XWVzzFs0V
         pw8/Kn7PWpJh89aONGsn483tz7zWbvc6zxPu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SJY6DwBxYVl+QUdSNsoZifHerg6QBwwY0i9CzwdxMWE=;
        b=axAgPUwdKWsqiDo6FiuMTy2ZEyLska0ow+hW6ZN2+lXp6D+g8KNTwV+zXO8nDJKvCm
         u7dncf3uLGJaLEUtT4ViuWvn2y45vJmrDDY2k2TPuNoe8wUiWioXgPzHUW/9dahTIrK4
         MRqS59/qcp4W/6heRyg7YNlSVjQHy1dxaMETWmgzXXLKcwcbRvOjCACzxPe2yqiOyMru
         hztwgrm63i2dXLopmDLatZ+nUzgUv6K0mjOvHBr8ZJ64C/QHQTIwNWeHMYO/TgMKNi1S
         1Ln+8dv0Cm24Sl1VAJO+FMI+afOcdN5Tt5GZFy+JcMhvOTQKPPKXsxHarvge8ZNCMfNf
         qoEA==
X-Gm-Message-State: AOAM533c3FrIjxjSI/DALmccwjyrSOf+6RcDbLQNsJgsJgyAkrsVc5bC
        6YP7ozq+Vwq0k/kAh0OjBJIv3g==
X-Google-Smtp-Source: ABdhPJwKksNtvd87HgI8byZ/durqgLmVyRb9ZDF76nF52vVCj2GiqVG6kl88Ug3GJFwvR3Dve+viFw==
X-Received: by 2002:a17:90b:4f88:: with SMTP id qe8mr4919558pjb.223.1634805790444;
        Thu, 21 Oct 2021 01:43:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d71sm4494239pga.67.2021.10.21.01.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 01:43:10 -0700 (PDT)
Date:   Thu, 21 Oct 2021 01:43:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH] compiler-gcc.h: Define __SANITIZE_ADDRESS__ under
 hwaddress sanitizer
Message-ID: <202110210141.18C98C4@keescook>
References: <20211020200039.170424-1-keescook@chromium.org>
 <CANpmjNMPaLpw_FoMzmShLSEBNq_Cn6t86tO_FiYLR2eD001=4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMPaLpw_FoMzmShLSEBNq_Cn6t86tO_FiYLR2eD001=4Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 08:00:00AM +0200, Marco Elver wrote:
> On Wed, 20 Oct 2021 at 22:00, Kees Cook <keescook@chromium.org> wrote:
> > When Clang is using the hwaddress sanitizer, it sets __SANITIZE_ADDRESS__
> > explicitly:
> >
> >  #if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
> >  /* Emulate GCC's __SANITIZE_ADDRESS__ flag */
> >  #define __SANITIZE_ADDRESS__
> >  #endif
> 
> Hmm, the comment is a little inaccurate if hwaddress sanitizer is on,
> but I certainly wouldn't want compiler-clang.h to start emulating gcc
> here and start defining __SANITIZE_HWADDRESS__ if the places where we
> check it are the same as __SANITIZE_ADDRESS__. So this patch is the
> right approach.

Yeah, I agree. I think that was Arnd's thinking as well.

> 
> > Once hwaddress sanitizer was added to GCC, however, a separate define
> > was created, __SANITIZE_HWADDRESS__. The kernel is expecting to find
> > __SANITIZE_ADDRESS__ in either case, though, and the existing string
> > macros break on supported architectures:
> >
> >  #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
> >           !defined(__SANITIZE_ADDRESS__)
> >
> > where as other architectures (like arm32) have no idea about hwaddress
> > sanitizer and just check for __SANITIZE_ADDRESS__:
> >
> >  #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
> 
> arm32 doesn't support KASAN_SW_TAGS, so I think the bit about arm32 is
> irrelevant.

Right -- I had just picked an example.

> Only arm64 can, and the reason that arm64 doesn't check against
> "defined(CONFIG_KASAN)" is because we also have KASAN_HW_TAGS (no
> compiler instrumentation).
> 
> > This would lead to compiler foritfy self-test warnings when building
> > with CONFIG_KASAN_SW_TAGS=y:
> >
> > warning: unsafe memmove() usage lacked '__read_overflow2' symbol in lib/test_fortify/read_overflow2-memmove.c
> > warning: unsafe memcpy() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-memcpy.c
> > ...
> >
> > Sort this out by also defining __SANITIZE_ADDRESS__ in GCC under the
> > hwaddress sanitizer.
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Marco Elver <elver@google.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Arvind Sankar <nivedita@alum.mit.edu>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: llvm@lists.linux.dev
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Other than that,
> 
>   Reviewed-by: Marco Elver <elver@google.com>

Thanks! (Oh, BTW, it seems "b4" won't include your Reviewed-by: tag if
it is indented like this.)

-Kees

-- 
Kees Cook
