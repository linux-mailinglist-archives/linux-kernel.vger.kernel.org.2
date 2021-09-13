Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23544098DA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbhIMQXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236244AbhIMQW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:22:56 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23EFC061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:21:40 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f129so9939406pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IKFED9y0v7w+FhMaqd2QIA2eUP5bCbT2SCT49mPxoTQ=;
        b=HCLOGlBq7MF6o8jKgFWWRIU4KSTMhQLrYDiW6j7kEwXvWCbDnQATyXEIJYuLlqQRHk
         XFChA0ly+uvX8gd7pXobRS1fKuuS++LPbjPsARkcV9BEH4GJGJn2aZ6+TqpJs38pHdSX
         r+EpLKHBGSfIHj26xJPcEBL12cZM2JRiScAcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IKFED9y0v7w+FhMaqd2QIA2eUP5bCbT2SCT49mPxoTQ=;
        b=cjOzCJ1hC+gaOi160cAayPUA1ThbL4KhHInqeCeMyB5gz4rLLg04bPNB/+VNCHhp+O
         +g4+LLdOkNP+eqMZoY7syaBeG/F3vhd8Z7xwfVtqcqMtmQwvaCmIyqtJXbfT1yYs/Rwo
         5kAtdcdGWnNg3ZTvBYthtPg4HtitaZEJMD4Kaah8NW58KFeioivlcWsmkyOHUYEHhCdB
         wMJC4O5cPYpf7c1xU9hgQWfaV56evZl1J2wkHc63RsL1Kp9r01dR4OZI15dpXUo2SXlN
         68dhecyRI6oEE0N8vSbc2mgnYalMFIyt7LoTJkCeeRZPH1Xf2JlNYZv9VW/uGKBQ9ga4
         6cnQ==
X-Gm-Message-State: AOAM533++c6k4iK/MN4qk23lpgowGzZ8/T/VHL2l3MIxk4sjz3OWXNnC
        rjgfaWDNfMc0xXD3J+e0OgKAtg==
X-Google-Smtp-Source: ABdhPJxnGP1kflyzFYPVzBgUMBLquG5UxHgd7HMXFZ68h+oy5s9G+QJ8KqObmwV16Y9egJHSVzwwtw==
X-Received: by 2002:a05:6a00:c3:b0:43d:e6be:b2a6 with SMTP id e3-20020a056a0000c300b0043de6beb2a6mr261966pfj.34.1631550100562;
        Mon, 13 Sep 2021 09:21:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o6sm7514071pjk.4.2021.09.13.09.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:21:40 -0700 (PDT)
Date:   Mon, 13 Sep 2021 09:21:39 -0700
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
Subject: Re: [PATCH 02/10] compiler.h: drop fallback overflow checkers
Message-ID: <202109130921.D423C72@keescook>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-3-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910234047.1019925-3-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:40:39PM -0700, Nick Desaulniers wrote:
> Once upgrading the minimum supported version of GCC to 5.1, we can drop
> the fallback code for !COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW.
> 
> Effectively a revert of
> commit f0907827a8a9 ("compiler.h: enable builtin overflow checkers and
> add fallback code")
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1438#issuecomment-916745801
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

With Nathan's comments addressed:

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
