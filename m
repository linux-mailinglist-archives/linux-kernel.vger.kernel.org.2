Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFC0403F32
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 20:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348737AbhIHSqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 14:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbhIHSqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 14:46:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA25C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 11:45:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so1778410wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 11:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=78b/o4FTri/T8m3ByDrpuRiUFjFJpaUAFqCBQ5K0Pjk=;
        b=UVeeR/Y3ITAN9om9eB3OxTSyvuFCFCCuxlvXCP4h4QeWb2ADncJOxHdH6S0mbs0j+w
         t8IsraP+rwZF6KHDPsHBO8WzHf/xPqm8paFKOxlwdjbHWvnJmKGtKeNZXkwlCNWq+enb
         bm3w7WpDgpKfS4r9cuQ30bRglqnsF7e0ynIxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=78b/o4FTri/T8m3ByDrpuRiUFjFJpaUAFqCBQ5K0Pjk=;
        b=o4B7QOpJG/9A5dZkkeCp6OCqmxsbkBFugLKXRpyIbdIyjSOHFIbKeg7Ne6/iVf0KJp
         I/u/JfT4wSHYUDLrsabGafZv6WPPUm2Po1jPOLk4luuxxH/JWOsg/0EAm/BzeA2eVyfJ
         HJfHXCrdDz0gtwR10t/3skpobUvuJQP0HxzQ4alSR340sY/S2Xs4CkUdYNXdzucr+8jE
         b1BzMaTc4KH8yaEJIEs7fZaiDuMt1/fZPdEbTzbkwj0zzgL9oMMP9YWUMTIW0VrjFYfZ
         XC79pvy2kq5e8pMwx91Z85WMOuXffnAdBjWsH8G8qpBXM89i9uyK34F9UXS57H6Wv9Yi
         SJZg==
X-Gm-Message-State: AOAM533qfs6/UZTlMmafsFcctuBLHeVG57lsGQ59uqp/EnHH1gAZGjnZ
        MGia2et3uQ+S5+Mz+DDw1B63Fg==
X-Google-Smtp-Source: ABdhPJwIEz0ip15hEKr6eUCycgYpJg6anoTgQJjUALCzYl2FdIeNCN0HtocfjTwKahuI2GWk6V0Zlw==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr4928583wmp.93.1631126730071;
        Wed, 08 Sep 2021 11:45:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m5sm2789859wmi.1.2021.09.08.11.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 11:45:29 -0700 (PDT)
Date:   Wed, 8 Sep 2021 20:45:27 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 7/9] dma-buf/fence-chain: Add fence deadline support
Message-ID: <YTkExzW4QWBC6hMa@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210903184806.1680887-1-robdclark@gmail.com>
 <20210903184806.1680887-8-robdclark@gmail.com>
 <YTj4yPk1YuFk3oeL@phenom.ffwll.local>
 <CAF6AEGs3DhSKhDkft58VqkM6GwMMSq87GZkQAaPf_LLavDdacA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGs3DhSKhDkft58VqkM6GwMMSq87GZkQAaPf_LLavDdacA@mail.gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 11:19:15AM -0700, Rob Clark wrote:
> On Wed, Sep 8, 2021 at 10:54 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Fri, Sep 03, 2021 at 11:47:58AM -0700, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > >  drivers/dma-buf/dma-fence-chain.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > >
> > > diff --git a/drivers/dma-buf/dma-fence-chain.c b/drivers/dma-buf/dma-fence-chain.c
> > > index 1b4cb3e5cec9..736a9ad3ea6d 100644
> > > --- a/drivers/dma-buf/dma-fence-chain.c
> > > +++ b/drivers/dma-buf/dma-fence-chain.c
> > > @@ -208,6 +208,18 @@ static void dma_fence_chain_release(struct dma_fence *fence)
> > >       dma_fence_free(fence);
> > >  }
> > >
> > > +
> > > +static void dma_fence_chain_set_deadline(struct dma_fence *fence,
> > > +                                      ktime_t deadline)
> > > +{
> > > +     dma_fence_chain_for_each(fence, fence) {
> > > +             struct dma_fence_chain *chain = to_dma_fence_chain(fence);
> > > +             struct dma_fence *f = chain ? chain->fence : fence;
> >
> > Doesn't this just end up calling set_deadline on a chain, potenetially
> > resulting in recursion? Also I don't think this should ever happen, why
> > did you add that?
> 
> Tbh the fence-chain was the part I was a bit fuzzy about, and the main
> reason I added igt tests.  The iteration is similar to how, for ex,
> dma_fence_chain_signaled() work, and according to the igt test it does
> what was intended

Huh indeed. Maybe something we should fix, like why does the
dma_fence_chain_for_each not give you the upcast chain pointer ... I guess
this also needs more Christian and less me.
-Daniel

> 
> BR,
> -R
> 
> > -Daniel
> >
> > > +
> > > +             dma_fence_set_deadline(f, deadline);
> > > +     }
> > > +}
> > > +
> > >  const struct dma_fence_ops dma_fence_chain_ops = {
> > >       .use_64bit_seqno = true,
> > >       .get_driver_name = dma_fence_chain_get_driver_name,
> > > @@ -215,6 +227,7 @@ const struct dma_fence_ops dma_fence_chain_ops = {
> > >       .enable_signaling = dma_fence_chain_enable_signaling,
> > >       .signaled = dma_fence_chain_signaled,
> > >       .release = dma_fence_chain_release,
> > > +     .set_deadline = dma_fence_chain_set_deadline,
> > >  };
> > >  EXPORT_SYMBOL(dma_fence_chain_ops);
> > >
> > > --
> > > 2.31.1
> > >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
