Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CB030D3EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 08:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhBCHLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 02:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhBCHLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 02:11:21 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8D3C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 23:10:41 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id h12so31793212lfp.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 23:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jhX/iP2BIje25rSEtkXl+gf7vWLktseUoLjC5655Ogc=;
        b=WoCYlofriopgTQlhztwNhls5M+Vuxb2QUkzBx7g+2dT/cJEafXtg+Ol3RDmknsYh3R
         5K1JqUIPCKdlOXe3GV5O5La9AMWyUKNYN6ie2q/uytlDWAI3YLvMc9xHSM9k1GbWpt+r
         AmQsK1DdzO3A8z2CCmGjSGQMUXH6vSkYRFhw+i/pR5pBUsSwuTKR69pRkf2zEP34RL/P
         Mfsb6i6fcX26C3mAa2hkPAQQd0bnkZtPIhQVgd3yIYqdF3nr/cxq80xSvQlnHSSlbhlq
         AfmIHJSUL/ZB7LkrMXQCkPKSzO6DVoKFDxWBAU8bvBMdYksLZocQlIS+CtL7QN2x1+GA
         //TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jhX/iP2BIje25rSEtkXl+gf7vWLktseUoLjC5655Ogc=;
        b=hlfSvtl6FqM+A8ufnf3FeB4PxlAIVAkSWNUofFWH2OUA59O2Oxvl0ulJ4XFRVedwV2
         JK9yznPLnclCwjNPE3F6c6Ap1Lk4w2WnqHHKxL/cSZYnlqYeEQWB1fQX9DxFl57OD7tJ
         fMI1ivK/OyqyviUhZbiM5gU9ePuJbvhefH3TTMgEE+reBGmcdjWF7yRNjcW/FSY29De/
         YufGItbBiP5dPQQde8ZvDPfSPVUhnbSxn4+CC05lf02hsjIWtrYDcQk2QmGzuXOtYaDW
         KuboZ/+6BdPpctwcvyqc6SPGM54IgQtLgDNi3OzdUmZhHPkepdgPWYtzYiYEalKJ1b15
         kNEA==
X-Gm-Message-State: AOAM531eo3eEwzChoWkJbKWX2PLq9pvWoepc1o8lL9j0EUYpd8/7tBG2
        vH4MAklLocsbH/mD5iFnnL4OMQ==
X-Google-Smtp-Source: ABdhPJx7qRdRSv4bF3X0su5sZ00X7oTRtyMjIcGa7Kvu0mxshlpY1UPGWVtYJur2tvzTP/WHDszOEg==
X-Received: by 2002:a05:6512:1310:: with SMTP id x16mr959000lfu.19.1612336239572;
        Tue, 02 Feb 2021 23:10:39 -0800 (PST)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id c16sm148416lfb.36.2021.02.02.23.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 23:10:38 -0800 (PST)
Date:   Wed, 3 Feb 2021 08:10:36 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tee: optee: remove need_resched() before cond_resched()
Message-ID: <20210203071036.GA3603358@jade>
References: <20210125095445.1524477-1-jens.wiklander@linaro.org>
 <0100017738faac80-87e5cf40-6a5a-4727-9c36-382fb909c8ff-000000@email.amazonses.com>
 <CAHUa44GsbxO=wJ_o-AZsxNvKOhn=y=dexkrN17zCy=7+0=1ZQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHUa44GsbxO=wJ_o-AZsxNvKOhn=y=dexkrN17zCy=7+0=1ZQg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 02:29:33PM +0100, Jens Wiklander wrote:
> Hi Rouven and Sumit,
> 
> On Mon, Jan 25, 2021 at 10:58 AM Jens Wiklander via OP-TEE
> <op-tee@lists.trustedfirmware.org> wrote:
> >
> > Hi Rouven and Sumit,
> >
> > On Mon, Jan 25, 2021 at 10:55 AM Jens Wiklander
> > <jens.wiklander@linaro.org> wrote:
> > >
> > > Testing need_resched() before cond_resched() is not needed as an
> > > equivalent test is done internally in cond_resched(). So drop the
> > > need_resched() test.
> > >
> > > Fixes: dcb3b06d9c34 ("tee: optee: replace might_sleep with cond_resched")
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > ---
> > >  drivers/tee/optee/call.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > Can you please test to see that this works in your setups too?
> 
> Does this work for you? I'd like to get this patch ready for v5.12.

Thanks for the help with this patch. I'll submit this up for v5.12.

Cheers,
Jens
