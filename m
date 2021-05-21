Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FB638CF96
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 23:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhEUVFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 17:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEUVFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 17:05:31 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E14C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:04:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x188so15792608pfd.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2b/KRjftYllCrfZajZzV4R38guHyJnFNR03CY9/Mz+M=;
        b=fmlz3F4EdHX3C/Ls3bPnMZZo6Mqrz+vACNZXiRShjdSRP/43Tnch6Kg40n6ApOmtKu
         fKn9+hBW/B/OWJ+8or/v84+XcFTdDXYqNWTiu1p5uUOT3rG9ER/SRAdJgwBgcWaV7abJ
         9n3XcD9rk27D1h1LZwBFrhzmbwH7VLwGegWu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2b/KRjftYllCrfZajZzV4R38guHyJnFNR03CY9/Mz+M=;
        b=NqVvMfah9l5sLolvX2z8X7DRvBDFI2wZCEwiWbZ8YrJfs6BOvG4G9JZ44F9f2fDPOE
         LqdwwOMQNzZKx4ctlH5cBXZzAn1+fa6fUfSapvXoAOo6wQEfAl28d5lPxznQ/68QVsTH
         lTn84wOUIp9t2MDcFK9DIu9RR7mSaLHFB38XPyKSrA7P5TOtMzD2FUUylFTKChHaGuRi
         rkn7KNJnccfMQ03un6Npeu0L4y1ZHKsSr6DP5EBb69PrrnYKLkBqDmGrnezV33L4kOFb
         LcgE/BgMfmYm8tkUcZ72yGBwr2D1izvobzPiwunD/i12hfzaLxJlL8QO5Os7npvJL4e3
         4Wyg==
X-Gm-Message-State: AOAM530CGy8OoHNG3yLLV/Xe8PpHwPXAAORC7QUQf562YMzgxOTOME5a
        DmdkJeBc2cXtgOWPPi8/c4w+aw==
X-Google-Smtp-Source: ABdhPJy9u6sJFjQGEJyHyxWVL36bm+wHN9tc2Qebqks+sUuvLfHgV46dbwOtr3M8TzDb3OuldGsryA==
X-Received: by 2002:a62:7ad4:0:b029:2dc:d1a2:b093 with SMTP id v203-20020a627ad40000b02902dcd1a2b093mr11791082pfc.66.1621631046887;
        Fri, 21 May 2021 14:04:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 126sm5107901pfv.82.2021.05.21.14.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 14:04:06 -0700 (PDT)
Date:   Fri, 21 May 2021 14:04:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        clang-built-linux@googlegroups.com,
        Anthony Ruhier <aruhier@mailbox.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: Fix location of '-plugin-opt=' flags
Message-ID: <202105211403.6E5ACDD@keescook>
References: <20210518190106.60935-1-nathan@kernel.org>
 <162161994470.2028902.331062863146834934.b4-ty@chromium.org>
 <YKf8mvg4diHLSJDt@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKf8mvg4diHLSJDt@archlinux-ax161>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 11:31:54AM -0700, Nathan Chancellor wrote:
> On Fri, May 21, 2021 at 10:59:10AM -0700, Kees Cook wrote:
> > On Tue, 18 May 2021 12:01:06 -0700, Nathan Chancellor wrote:
> > > Commit b33fff07e3e3 ("x86, build: allow LTO to be selected") added a
> > > couple of '-plugin-opt=' flags to KBUILD_LDFLAGS because the code model
> > > and stack alignment are not stored in LLVM bitcode. However, these flags
> > > were added to KBUILD_LDFLAGS prior to the emulation flag assignment,
> > > which uses ':=', so they were overwritten and never added to $(LD)
> > > invocations. The absence of these flags caused misalignment issues in
> > > the AMDGPU driver when compiling with CONFIG_LTO_CLANG, resulting in
> > > general protection faults.
> > > 
> > > [...]
> > 
> > (I've slightly adjusted the title.)
> > 
> > Applied to for-next/clang/features, thanks!
> > 
> > [1/1] x86: lto: Fix location of '-plugin-opt=' flags
> >       https://git.kernel.org/kees/c/5d6c8592ee5f
> > 
> 
> Ingo picked this up in x86/urgent so you should not need to carry it.
> 
> https://git.kernel.org/tip/0024430e920f2900654ad83cd081cf52e02a3ef5

Ah-ha, thanks! I didn't see a reply on the thread.

-- 
Kees Cook
