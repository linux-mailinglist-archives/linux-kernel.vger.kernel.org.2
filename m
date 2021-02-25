Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3FD325762
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhBYUPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBYUO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:14:59 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09606C06178B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:14:19 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o6so4231892pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zvcw89WwnBGHGgFAGR9HWVcW1flA9Xzl577WVAqCD78=;
        b=b4JTddy5ZgIX5TyNAyX/EEuoNzxOG0Ow6i26OWTw8EyLQHndl+mLZKBhliG57ThFoa
         Itked0FH9fWMyBenWUMsZfa/zlwigfp55KoaxBZKMiW5Lap7oOBSDmqTK6nAnthr8AsR
         HcpsajH5997DalFpyc3an0eLbNF7w35iQBXxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zvcw89WwnBGHGgFAGR9HWVcW1flA9Xzl577WVAqCD78=;
        b=QMX6vfbQ/I0LSBxa4KhzdV9gSn4bNe+5Zco7b1/l3f3d44+cBlNxlTvnyOk42nj3JZ
         +MtC9ENdbwWnvVACWFUEzCmacZ2dfUjjltHbyHbhSUZtTUldOX9nilCv9jBe5AE+F4f+
         nuYH9C39KwPMmy0+SSNPrifk+w+M7sEYaMIkqHwlKnS4qdomdp6Uf/OIf5NwEFETvaty
         HbowMoPXeWBs5bEO9Rs1HQPOqrlZYEhWBhMLVnmSwv+hhABV6Ju0jOtol/5C/AL0Myor
         taOep8M3TUVdoHB+BI1k17JFMQDnGqbxEMQMVIQeIWQ0ECv/PF2OocegNWEr3RAT8ijU
         +Fmg==
X-Gm-Message-State: AOAM532B9SQuFzoyc2Fg3wBuwqha2ihgjomLW+bzeA0KHtGPNxcFansY
        QLVWBn9eFw9f7orpCbWVuhRvyA==
X-Google-Smtp-Source: ABdhPJylDG8+tqcto0h9+3bfWwYB8oRjR+U7cKhN2xS+7Y5aCUPDf5wc7wqmvuTYEVT9LWttGO4qvQ==
X-Received: by 2002:a17:90b:4c8c:: with SMTP id my12mr100914pjb.35.1614284058580;
        Thu, 25 Feb 2021 12:14:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d124sm7012807pfa.149.2021.02.25.12.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 12:14:18 -0800 (PST)
Date:   Thu, 25 Feb 2021 12:14:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Marco Elver <elver@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux/compiler-clang.h: define HAVE_BUILTIN_BSWAP*
Message-ID: <202102251213.5815C9B33@keescook>
References: <20210225164513.3667778-1-arnd@kernel.org>
 <202102251203.03762F77@keescook>
 <20210225120637.8e2a234f192952829fc5f471@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225120637.8e2a234f192952829fc5f471@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 12:06:37PM -0800, Andrew Morton wrote:
> On Thu, 25 Feb 2021 12:03:48 -0800 Kees Cook <keescook@chromium.org> wrote:
> 
> > On Thu, Feb 25, 2021 at 05:45:09PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > Separating compiler-clang.h from compiler-gcc.h inadventently dropped the
> > > definitions of the three HAVE_BUILTIN_BSWAP macros, which requires falling
> > > back to the open-coded version and hoping that the compiler detects it.
> > > 
> > > Since all versions of clang support the __builtin_bswap interfaces,
> > > add back the flags and have the headers pick these up automatically.
> > > 
> > > This results in a 4% improvement of compilation speed for arm defconfig.
> > > 
> > > Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Cc: stable@vger.kernel.org
> 
> I figured 4% better compile time isn't significant enough to justify a
> backport.  Thoughts?

It's a trivial change, so I think it's worth it?

> 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> 

-- 
Kees Cook
