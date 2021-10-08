Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE294272F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 23:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243428AbhJHVSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 17:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242456AbhJHVSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 17:18:16 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02170C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 14:16:21 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id q19so8720323pfl.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 14:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FFhUuMyEWSiHssipR32HBHlOkuAhbMJqyLCYePgaltI=;
        b=XwEeTQEj9C25q3Be6AxZgpwU/xpv7M3dk2CGBP2/4hLXFHJRnOOm/VEYTLRRkjg2VP
         HrMKjukQ1pTEDTLo0POdJQhKKHuGGUPlxVye2ghkzk8TVph1VY/AcZeop9mAcspFeuiP
         WXj6pxbkQkM3z+2L1xT3bzl9wCfFhl6qpsJAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FFhUuMyEWSiHssipR32HBHlOkuAhbMJqyLCYePgaltI=;
        b=VPn8zvAmYNiV9H8lVg6L62+OmnbZUf/c67xL2VApk7KE8Yr3I69bPoavYXfQtzua1m
         RsFGQGwG/3EnOIoQfDcvs1zRKdxHPVYQE/YHr12A8V7D1CTtqLma5T3zO46Hs81hFGPf
         Nhd9IfJqGtruKSFjIagJVXX1n9OZIhuHzyTfHhWwBcfWftcOWpml/TBmRiSFerdHBQ+h
         9DN2lI3XdsacDHurVL5a9213dfR/IXafppr8MBfua32CF2hP3QNBE+lfZ3hmr8AqONN7
         QWcAz5NUnSErUN/xiJob5NEUmQzS1CI1i40th9MX5v2uK4lld1508bXifHq4ZQfVrZyM
         jn/g==
X-Gm-Message-State: AOAM531YtiyQi717MlaMa1Q/vlLP3LgfL0nQTUnsrnLaBgJvaNn1UerN
        vzmplbCeEhGn3Sjn+ZyhHykX8lhziXQa4A==
X-Google-Smtp-Source: ABdhPJy8fSvRAxviOIXMJWotcF0SS+LrTBEyTOzBnHu49xQwq1LFTd3RfNNEPl87TJRFTU/0RrUVMQ==
X-Received: by 2002:a63:724b:: with SMTP id c11mr6572687pgn.9.1633727780506;
        Fri, 08 Oct 2021 14:16:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t28sm223137pfq.158.2021.10.08.14.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 14:16:20 -0700 (PDT)
Date:   Fri, 8 Oct 2021 14:16:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] lkdtm: Fix content of section containing
 lkdtm_rodata_do_nothing()
Message-ID: <202110081415.E36B67FA@keescook>
References: <8900731fbc05fb8b0de18af7133a8fc07c3c53a1.1633712176.git.christophe.leroy@csgroup.eu>
 <CAKwvOdnWbKdBuSGtmu2DURy5dtVGUYWJ_mwxSL6N5OfbmjU3EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnWbKdBuSGtmu2DURy5dtVGUYWJ_mwxSL6N5OfbmjU3EA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 11:09:47AM -0700, Nick Desaulniers wrote:
> On Fri, Oct 8, 2021 at 9:59 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
> >
> > On a kernel without CONFIG_STRICT_KERNEL_RWX, running EXEC_RODATA
> > test leads to "Illegal instruction" failure.
> >
> > Looking at the content of rodata_objcopy.o, we see that the
> > function content zeroes only:
> >
> >         Disassembly of section .rodata:
> >
> >         0000000000000000 <.lkdtm_rodata_do_nothing>:
> >            0:   00 00 00 00     .long 0x0
> >
> > Add the contents flag in order to keep the content of the section
> > while renaming it.
> >
> >         Disassembly of section .rodata:
> >
> >         0000000000000000 <.lkdtm_rodata_do_nothing>:
> >            0:   4e 80 00 20     blr
> >
> > Fixes: e9e08a07385e ("lkdtm: support llvm-objcopy")
> 
> Thanks for the patch; sorry I broke this.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Hah! Whoops; sorry I don't have an inverted version of this test! I
should have caught this when it broke. :|

-Kees

-- 
Kees Cook
