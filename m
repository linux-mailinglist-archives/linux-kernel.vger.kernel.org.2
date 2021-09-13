Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6D74098D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhIMQVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhIMQVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:21:45 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3125C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:20:28 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k23-20020a17090a591700b001976d2db364so414877pji.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=msy8N0GkHxRCMazso14Qqx2R9J2qwwNe7Lt82w0ANmc=;
        b=lley3eyu4spj7H4dEjr8NFNnBCNc+3EQCeu7XpvXwZNYBUuMF9r6zukjuh0erOk5+p
         31b4wC9bktr36kzNJ703H3MHTxvicyKhx1vHJGpb+YPjpCNUYvy8v72wP/EWSbH5M7P3
         s1yFU2eyFFbdLldtfoq44XSHCY4Mcc62Y2Jds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=msy8N0GkHxRCMazso14Qqx2R9J2qwwNe7Lt82w0ANmc=;
        b=PacGWzG5AyqYSfYC9uASM5P9sZuUzJ7xkY6NjCs/vfei5SmHtJoZ3ZOA/cUXYZ37ny
         PcfQ7JE6UhY7y9wFR9+we/r0SjcQ50F/XAl0HSvF3EuGh6EqfLvEhWMbwjUq9NSINDBs
         hENwiDy82OT2GSdJPJVVdirbsV4HQ35X4vusscuBQoT/1SiJW6LdcyR4H7UqS67amO/U
         LacHd3CUqgu034wF53T4j+/n4aOSgDJGcR9fPH5UM5hr4GgXOKQ3SpKrdxICF7eZ4uKT
         7+AGC8jwwQfmo+rajXhlrryVuwaZEegO8qXSwQw+xxLWvXChvfUoMp2iwQXYecZ8EriS
         Lm1g==
X-Gm-Message-State: AOAM533yfgpvkW5JN9vGYjFUtZ9cEXs/KfcF+nMZdZOChvTbNQBgJrVa
        7n26CxvLwoudzT2Xw15izZg/BQ==
X-Google-Smtp-Source: ABdhPJwxOxyWISCASsXbrCfmHdtTek9uPx66pVPtOC93QcT9xh0VdJFDn4ZsY7AL4N51Vp4uFDni9Q==
X-Received: by 2002:a17:902:ab16:b0:13a:356c:6a03 with SMTP id ik22-20020a170902ab1600b0013a356c6a03mr11041877plb.38.1631550028483;
        Mon, 13 Sep 2021 09:20:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t14sm8492195pga.62.2021.09.13.09.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:20:27 -0700 (PDT)
Date:   Mon, 13 Sep 2021 09:20:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] raise minimum GCC version to 5.1
Message-ID: <202109130918.D359A43@keescook>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210913094947.GB12225@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913094947.GB12225@amd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 11:49:48AM +0200, Pavel Machek wrote:
> Hi!
> 
> > commit fad7cd3310db ("nbd: add the check to prevent overflow in
> > __nbd_ioctl()")
> > 
> > raised an issue from the fallback helpers added in
> > 
> > commit f0907827a8a9 ("compiler.h: enable builtin overflow checkers and add fallback code")
> > 
> > Specifically, the helpers for checking whether the results of a
> > multiplication overflowed (__unsigned_mul_overflow,
> > __signed_add_overflow) use the division operator when
> > !COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW. This is problematic for 64b
> > operands on 32b hosts.
> 
> Please don't. gcc 4.9.2 is still in use here.
> 
> Plus, someone will want to prevent overflow in -stable, too, and you
> can't really raise gcc version there.

These changes won't go to prior stable kernels.

-- 
Kees Cook
