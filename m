Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F7039AFDE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 03:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFDBeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 21:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhFDBet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:34:49 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF56C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 18:32:56 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x73so6285252pfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 18:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UiAxhnimbmXnxAuRj/8TCD8fSvPmZD3AhoE3rfTP8PM=;
        b=D2KZ3evI4gHDjz1em6dcmAuOicfefbtBAH177EkHOnfqibkq26bZn4+fHwr02f6avk
         OLBhrQtdWRppWr2xPg3yJTInAgm29b0++w7RICeZsf82Z/wICMH2YiM9cqyBDJv5Z7/J
         shVnpyjKNf/IODiDeQVKD4rvk5pl9M0KL1SS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UiAxhnimbmXnxAuRj/8TCD8fSvPmZD3AhoE3rfTP8PM=;
        b=CTGnVs/BlMYT/ZBzepjgJgX6py6zAKkZedoA2OeslWR4YlDYFFewkbgpTjsPjvgn5o
         lQssjBrhpl//KtlvtKA20+YpLQPzVmHQxaG4GKPYl5kl4oDhy5/rLPrym+nXvTIGrz/q
         VQZyp3xxBQg/FyY05wMAM9K0WmWr0cgUvvm2p9G7DQjc9s+ZtU0C62inJIo2oqFd9oii
         epGHvNtWz6Pnf1l1zQjkUZPLrfx5OeheGtezq871V4TLLsL3GtjwJaQDkLheGom5WuR3
         wli5l8X+Fi4AxMcj1SHMzm1NT8cFxaW0+1U0p4xxlMCFsIen1cGUxxDNST0+4L4QYqQP
         TqJA==
X-Gm-Message-State: AOAM530lCD3bBbUCRLSIcvtJC1/XoJuSHv99iRywuc6ua3XKDnMIgDtB
        Qrb4CwJE8ZcCFN5VS0mDAzxp6OuK+L3baQ==
X-Google-Smtp-Source: ABdhPJwzKItwTs5aNFact08HbH8Xrrtq5lTEOKEIPhbLiqcwnb646XtOtDqHY+HE/Kqw/ijoFehkZw==
X-Received: by 2002:a63:1a49:: with SMTP id a9mr2301475pgm.63.1622770376209;
        Thu, 03 Jun 2021 18:32:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z6sm266653pfr.99.2021.06.03.18.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 18:32:55 -0700 (PDT)
Date:   Thu, 3 Jun 2021 18:32:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/pl111: Actually fix CONFIG_VEXPRESS_CONFIG depends
Message-ID: <202106031832.1868B1C@keescook>
References: <20210603215819.3904733-1-keescook@chromium.org>
 <CAKMK7uG7tDVUV3cVmtYMFdwVx1SuEWh6i+VsQ3nLP0Rb=-f0aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uG7tDVUV3cVmtYMFdwVx1SuEWh6i+VsQ3nLP0Rb=-f0aw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 12:30:00AM +0200, Daniel Vetter wrote:
> [gmail is funny]
> 
> On Thu, Jun 3, 2021 at 11:58 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > VEXPRESS_CONFIG needs to either be missing, built-in, or modular when
> > pl111 is modular. Update the Kconfig to reflect the need.
> >
> > Cc: Emma Anholt <emma@anholt.net>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Fixes: 4dc7c97d04dc ("drm/pl111: depend on CONFIG_VEXPRESS_CONFIG")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/gpu/drm/pl111/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
> > index c5210a5bef1b..b84879ca430d 100644
> > --- a/drivers/gpu/drm/pl111/Kconfig
> > +++ b/drivers/gpu/drm/pl111/Kconfig
> > @@ -2,7 +2,8 @@
> >  config DRM_PL111
> >         tristate "DRM Support for PL111 CLCD Controller"
> >         depends on DRM
> > -       depends on VEXPRESS_CONFIG
> > +       depends on ARM || ARM64 || COMPILE_TEST
> > +       depends on !VEXPRESS_CONFIG || VEXPRESS_CONFIG=DRM
> 
> I thought the canonical way to represent optional dependencies was
> depends on FOO || FOO=n

Ah-ha! So it is:

drm/Kconfig:    depends on (AGP || AGP=n) && !EMULATED_CMPXCHG && HAS_DMA
drm/Kconfig:    depends on FB_SIS || FB_SIS=n
drm/msm/Kconfig:        depends on QCOM_OCMEM || QCOM_OCMEM=n
drm/msm/Kconfig:        depends on QCOM_LLCC || QCOM_LLCC=n
drm/msm/Kconfig:        depends on QCOM_COMMAND_DB || QCOM_COMMAND_DB=n

I'll resping and retest. Thanks for the pointer!

-Kees

-- 
Kees Cook
