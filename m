Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6DD3F0A4F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 19:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhHRRcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 13:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhHRRck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:32:40 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F00C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 10:32:05 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id k19so2868136pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 10:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cZiGf9NqEbSIzjZ0ZsTq8YmVi8aldxtom00P1asafmc=;
        b=YTc6jfMCddIaLswA48fTheTTk8fBRyNo12VVvmvmb1+vhmdXGY+Hu+5jkTk4rG3YT8
         BuuZKeur8vRJFleLgiRPeT2BWk+mpY7QdhWg6vQd2s16RPW/k9ZUEkcral3lvl6Z8v9b
         Dmr74QBXC7h9gFNxwncahDmGpC7yInXnBfXO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cZiGf9NqEbSIzjZ0ZsTq8YmVi8aldxtom00P1asafmc=;
        b=kNyqFhYchSvbwf+9ZE+FVGUxNT7FRQjssoT9Rz7ulz/GqVJwkcOj6w4YD36OAPW1dn
         z/g87hH6HKV2fcVBSfcj0mpQEj1DX7Kp05cDGuZE3nwnczXZ+tfPNydECOzexm4dLz/u
         EThQJPkSPr2WvoFFN0vhCTEfA2xIHIxT3sPqD7/ulQrGGChUAFbV1XIv8YXrGdgTPBaI
         U98qYvJQB+LpT9TPb+ywy7dmdy2A95FH+htCCFlKcb/ZSAiEY97AWchzbpI5n2r7FuR4
         VMbzcaLjajcRJeF2ZPJQPvqbA9gnuVkZ7Ly1dEUOidPb1Kxl6ekKmgA/KN1zK1iIaCyB
         b/GQ==
X-Gm-Message-State: AOAM532zUhy4qhgMChCAQCtY+bLJ4JTT3VbI+M+DTafKhC+CAAW55hfL
        MYcv4tiF8V99OrB9W8ZX+99T/w==
X-Google-Smtp-Source: ABdhPJw3y3hOsBlnISbJmmR0FIih7/OTc8YLhCrxI1K0la+zMdPFouSsc1sZrAwK4Xct8Z3BNdpEiA==
X-Received: by 2002:a65:62cb:: with SMTP id m11mr9965214pgv.425.1629307925514;
        Wed, 18 Aug 2021 10:32:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b14sm361257pfo.76.2021.08.18.10.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:32:04 -0700 (PDT)
Date:   Wed, 18 Aug 2021 10:32:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lkdtm/heap: Avoid __alloc_size hint warning
Message-ID: <202108181030.F007BCE205@keescook>
References: <20210818044540.1601664-1-keescook@chromium.org>
 <YR0StuqeKm1vbaM5@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR0StuqeKm1vbaM5@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 04:01:26PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 17, 2021 at 09:45:40PM -0700, Kees Cook wrote:
> > Once __alloc_size hints have been added, the compiler will
> > (correctly!) see this as an overflow. We are, however, trying to test
> > for this condition, so work around it with a volatile int.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/misc/lkdtm/heap.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
> > index 3d9aae5821a0..e59fcbe00ae0 100644
> > --- a/drivers/misc/lkdtm/heap.c
> > +++ b/drivers/misc/lkdtm/heap.c
> > @@ -12,6 +12,8 @@ static struct kmem_cache *double_free_cache;
> >  static struct kmem_cache *a_cache;
> >  static struct kmem_cache *b_cache;
> >  
> > +static volatile int __offset = 1;
> 
> Perhaps a comment here as to why volatile is ok to use?  That feels like
> it is a hack around the compiler of today, what happens tomorrow when
> newer versions decide to ignore volatile as it "knows" no one ever
> changes it?

Sure, I can do that. LKDTM uses this a lot because it, by definition,
means the compiler cannot assume it knows anything about its value. (And
as such reloads from memory at every use, which is why it's frowned upon
anywhere else in the kernel.)

-- 
Kees Cook
