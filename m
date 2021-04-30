Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40033703E7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 01:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhD3XFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 19:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhD3XFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 19:05:40 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437E6C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 16:04:51 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id p12so50386880pgj.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 16:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hmaCHaUk/YcKYLYa52m832mn6ybhsaP/KRRlkFyOLOs=;
        b=BUaCL8hOuOxlk6vmAXiekInsJ7YsmLO9DV6ANp4BNsjh2didT586C9KpjEqSwVKubQ
         Ooyn4MGMnj5nnjPzf2+NTbJ8gTvMKqR/LTfeEnMEj8Yh8BXgfSPwuWzbQEEptiNR9ydh
         Iu+mRIhztckLssZkc/qbwpG6Gc6JITQ6bt6ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hmaCHaUk/YcKYLYa52m832mn6ybhsaP/KRRlkFyOLOs=;
        b=IIwpCBg+w55/MNXXKJ1j8ZUUfMydBKAL91TC1VV8UJNJyLCdzAAl6Gywxd5PiNIVji
         Qo4Qh1XIIAr706gFwvUo9R6A3zOuYYZWeMpmxdIMEFnvol0WjGsRXWgYrb8TWmoGCrLo
         lmDU31sraqQAD8ELN5pixNDjX7AXq9AeOsu+b/fwOY3hsW6+IyWwdXTBRNvWIxF3O7gH
         /ENFHpO4v9Q8ibmVh2WfLtg8hh99+AoujLwjOInydl1O3SPJP5/4I31VXY9LvQoR64Vh
         48C/4PnH/bAYkpgRfqXlf7wyt9hYKzEWJS3zaMBh2pvZlitTJHD073oXtXl+YZHvYCGo
         k9Qw==
X-Gm-Message-State: AOAM530YP2opr6wiOYB4vNOZzm5Q+JaAETodU6RfgRcgz5lOuZQAozqQ
        shpYF1QjKE0d9aWqZlKPwJk3zg==
X-Google-Smtp-Source: ABdhPJxoQklkKAplHV5Na7MkLfOcYqzOxuuZRw2NTYnA9OVxOlGUfGxtVxEYhUznqTTzTNII7TTDyQ==
X-Received: by 2002:aa7:82cc:0:b029:213:db69:18d9 with SMTP id f12-20020aa782cc0000b0290213db6918d9mr7361399pfn.36.1619823890715;
        Fri, 30 Apr 2021 16:04:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q8sm4146721pgn.22.2021.04.30.16.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 16:04:50 -0700 (PDT)
Date:   Fri, 30 Apr 2021 16:04:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] x86: Enable clang LTO for 32-bit as well
Message-ID: <202104301604.9FB001A9@keescook>
References: <20210429232611.3966964-1-nathan@kernel.org>
 <CAKwvOdngd5inT_sQP-PgqaMpVzfSdwoyhCcUSdS+09u=PKUEyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdngd5inT_sQP-PgqaMpVzfSdwoyhCcUSdS+09u=PKUEyA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 01:58:57PM -0700, Nick Desaulniers wrote:
> On Thu, Apr 29, 2021 at 4:26 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Commit b33fff07e3e3 ("x86, build: allow LTO to be selected") enabled
> > support for LTO for x86_64 but 32-bit works fine as well.
> >
> > I tested the following config combinations:
> >
> > * i386_defconfig + CONFIG_LTO_CLANG_FULL=y
> >
> > * i386_defconfig + CONFIG_LTO_CLANG_THIN=y
> >
> > * ARCH=i386 allmodconfig + CONFIG_LTO_CLANG_THIN=y
> 
> For allmodconfig
> HAS_LTO_CLANG cannot be selected unless
> FTRACE
> GCOV_KERNEL
> are disabled.
> 
> I was able to run through similar tests, though I only did so for ToT LLVM.
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> I additionally tried full LTO allmodconfig.  Full LTO allmodconfig can
> be tested by disabling CONFIG_COMPILE_TEST (in addition to the above),
> though I hit https://github.com/ClangBuiltLinux/linux/issues/1215 (the
> xfs tests aren't building under LTO).  I think this change though is
> fine, and enables another avenue to help us debug that failure.

Awesome; thank you both! I'll collect this for -next once -rc2 is
released.

-- 
Kees Cook
