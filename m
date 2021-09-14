Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5654A40B781
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhINTKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbhINTKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:10:47 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB0CC061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:09:29 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y17so197174pfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NUiE7iilYmE7MbD1+o2gz67DNOIV0kE2Y4aAlCCuwls=;
        b=D2JMZBGtUDI1RURmHc7xoLIbAhrH8eT9ekFTaK/ni3kY3uCG7KxsJh9H3KRLdMF4ba
         swiDqFjzHwWcAp2Djupwm7BJB8eSSnkZ+5PoneRctLLlNFK4H4NayWY9+9NzfEkiCD3v
         v4dR9UmF+CQQCAiEXmasVRlgqAVIN3+5DH1r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NUiE7iilYmE7MbD1+o2gz67DNOIV0kE2Y4aAlCCuwls=;
        b=afl1DoujeSCx2j7cdKqgOvTLKmR/gx2egD6BD6w95Aqi6ycm66xWZgVO/JHcszd0pg
         J+WP6B/KzdkYNKJrJVZ0JvE65DneHdk2NrU8l1Y2vD7VjTImzeUQjoxfISG76cai5/pP
         vHzmeicpAeae4mYoOM+Uuv2n5leOjrfjcc1w3itiSlvbHAoCysAqhNj0ZzPvXtWGCj9D
         566gSfG/hTMdt322Bjx1TufTBzlP/DUL2tePv+LNz51i25hnqBQsTaqzm+BF/BhxIef8
         L8l7FhLqLZ2/EUZCzeQRV1VAspk51T66A7gXwMptdIDv4pZIG2R4b1tB+T24kGbKgvPK
         tSvw==
X-Gm-Message-State: AOAM533UtSeKacLu+MwExYYLIwYhaJN/iaJmaw/PNvrwRxNbyITAat7g
        /coNzBtE2VdyjXdwIpua/gkbCg==
X-Google-Smtp-Source: ABdhPJxvaf48h7qDcs9BTud3oPrKECFKRynUtPs/dlNdB/o3E9DNuxPnb8YFG1lOvTo7G0s3xm60tA==
X-Received: by 2002:a63:ed03:: with SMTP id d3mr16863346pgi.24.1631646568928;
        Tue, 14 Sep 2021 12:09:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t14sm11904243pga.62.2021.09.14.12.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 12:09:27 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:09:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] hardening: Default to INIT_STACK_ALL_ZERO if
 CC_HAS_AUTO_VAR_INIT_ZERO
Message-ID: <202109141207.BA9EAD8@keescook>
References: <20210914102837.6172-1-will@kernel.org>
 <01f572ab-bea2-f246-2f77-2f119056db84@kernel.org>
 <202109140958.11DCC6B6@keescook>
 <CAKwvOdnrO7X8h-g9Pn8RmfJhqj2zn3HJwpQ0p2EONNtFF0w-uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnrO7X8h-g9Pn8RmfJhqj2zn3HJwpQ0p2EONNtFF0w-uA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 11:53:38AM -0700, Nick Desaulniers wrote:
> `On Tue, Sep 14, 2021 at 10:21 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Sep 14, 2021 at 08:58:12AM -0700, Nathan Chancellor wrote:
> > > On 9/14/2021 3:28 AM, Will Deacon wrote:
> > > > CC_HAS_AUTO_VAR_INIT_ZERO requires a supported set of compiler options
> > > > distinct from those needed by CC_HAS_AUTO_VAR_INIT_PATTERN, Fix up
> > > > the Kconfig dependency for INIT_STACK_ALL_ZERO to test for the former
> > > > instead of the latter, as these are the options passed by the top-level
> > > > Makefile.
> > > >
> > > > Cc: Kees Cook <keescook@chromium.org>
> > > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > > Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Fixes: dcb7c0b9461c ("hardening: Clarify Kconfig text for auto-var-init")
> > > > Signed-off-by: Will Deacon <will@kernel.org>
> > >
> > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > >
> > > One comment below.
> > >
> > > > ---
> > > >
> > > > I just noticed this while reading the code and I suspect it doesn't really
> > > > matter in practice.
> > > >
> > > >   security/Kconfig.hardening | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> > > > index 90cbaff86e13..341e2fdcba94 100644
> > > > --- a/security/Kconfig.hardening
> > > > +++ b/security/Kconfig.hardening
> > > > @@ -29,7 +29,7 @@ choice
> > > >     prompt "Initialize kernel stack variables at function entry"
> > > >     default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
> > > >     default INIT_STACK_ALL_PATTERN if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT_PATTERN
> > > > -   default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_PATTERN
> > > > +   default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_ZERO
> > > >     default INIT_STACK_NONE
> > > >     help
> > > >       This option enables initialization of stack variables at
> > > >
> > >
> > > While I think this change is correct in and of itself,
> > > CONFIG_INIT_STACK_ALL_ZERO is broken with GCC 12.x, as
> > > CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO won't be set even though GCC now supports
> > > -ftrivial-auto-var-init=zero because GCC does not implement the
> > > -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
> > > flag for obvious reasons ;) the cc-option call probably needs to be
> > > adjusted.
> >
> > GCC silently ignores the -enable flag, so things actually work correctly
> > as-is.
> 
> So then would that mean that CC_HAS_AUTO_VAR_INIT_ZERO_WITH_ENABLE
> evaluates to true then, in your patch below?

No, I exclude it based on the results from
CC_HAS_AUTO_VAR_INIT_ZERO_WITHOUT_ENABLE.

here:
> > +       def_bool !CC_HAS_AUTO_VAR_INIT_ZERO_WITHOUT_ENABLE && \

> Rather than create 2 new kconfigs with 1 new invocation of the
> compiler via cc-option, how about just adding an `ifdef
> CONFIG_CC_IS_CLANG` guard around adding the obnoxious flag to
> `KBUILD_CFLAGS` in the top level Makefile?

That is a bit more sensible, yes. :) Let me try that...

-- 
Kees Cook
