Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0132F4158B8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 09:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbhIWHGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 03:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29426 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239358AbhIWHGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 03:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632380672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sHWe/4xEkfiCD6fVR0vhWpP/mCzT888yzZbNxm0TXDw=;
        b=HX8/gKkn/bu9LovOtCZEpVf6npKfCCc0WZVmaKk3wLoiRHRbY1j7OYys1vbeJ8ZKePjRLV
        b8I+ZXJe3akHuWhAbDj1NNyP0M77dkHnUDO9voPaYXXyO2gfrlBjrEXGqzpNtMsLdlhM8D
        2jK+f6KUsXU7VuyRtXarz1q+YycvA2g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-6CrNlILcNIqFbHozZZIHtA-1; Thu, 23 Sep 2021 03:04:31 -0400
X-MC-Unique: 6CrNlILcNIqFbHozZZIHtA-1
Received: by mail-wr1-f72.google.com with SMTP id j16-20020adfa550000000b0016012acc443so4304122wrb.14
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sHWe/4xEkfiCD6fVR0vhWpP/mCzT888yzZbNxm0TXDw=;
        b=C2MAoQVrMDMd/XU824aJpl+Z0T1TpHbtlaQ0p1WfR+J8w7fU+eKpCSirL11XnJxQPZ
         KbYWOVe5ZEG1C1y96o9Qn0tDnIQpJmLL9Xq94DqGMM9IdQCOf3OMUHJrwDgAoM7e5VEH
         jzUjO6RwYKCMXYYMxwE0LSlfK9/GxAnBy58OwzOgO+PJ/tWv6XfcdcCZEnqFtnE58cb3
         1J2MFyWGiFYFCUUJPSVnBfkAIPBsl7ya4HwXcN2QPvupNGpDtvE0hs03PJvjWyH5fJNT
         l8N75fLpQ899hFZq0Wq4GR2LY+PN242+GjTzpC/TFLjAs7NpB+hhOXSPl/asT84giykM
         QDgg==
X-Gm-Message-State: AOAM53259CNB49c4QBrE5113OutZyBChTyVjoYz+gaIJDB3euR0oeUAz
        7g3XCivVuR7dXX64QDv1BYE50YUEhK2AbpjXSjhxmbMw3C5uAl67Vj067gTVA8Pv7px9LpABcG8
        VChL9Qs4t10gx98Y2eoc6/sYU
X-Received: by 2002:adf:d1eb:: with SMTP id g11mr3231298wrd.194.1632380669937;
        Thu, 23 Sep 2021 00:04:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyhNcyRrQ0UISVsN6EX3ylQ1wmCRTHutBo4vW6SvawXhtq0ItioLRisgG4k4kuB/oaOyTIpg==
X-Received: by 2002:adf:d1eb:: with SMTP id g11mr3231280wrd.194.1632380669659;
        Thu, 23 Sep 2021 00:04:29 -0700 (PDT)
Received: from redhat.com ([2.55.11.56])
        by smtp.gmail.com with ESMTPSA id o26sm8181379wmc.17.2021.09.23.00.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 00:04:28 -0700 (PDT)
Date:   Thu, 23 Sep 2021 03:04:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        linux-crypto@vger.kernel.org, Dmitriy Vyukov <dvyukov@google.com>,
        rusty@rustcorp.com.au, amit@kernel.org, akong@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matt Mackall <mpm@selenic.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/4] hwrng: virtio - add an internal buffer
Message-ID: <20210923030026-mutt-send-email-mst@kernel.org>
References: <20210922170903.577801-1-lvivier@redhat.com>
 <20210922170903.577801-2-lvivier@redhat.com>
 <20210922145651-mutt-send-email-mst@kernel.org>
 <0dd338bb-0fbe-b9d5-0962-d47ac2de4c4e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dd338bb-0fbe-b9d5-0962-d47ac2de4c4e@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 08:26:06AM +0200, Laurent Vivier wrote:
> On 22/09/2021 21:02, Michael S. Tsirkin wrote:
> > On Wed, Sep 22, 2021 at 07:09:00PM +0200, Laurent Vivier wrote:
> > > hwrng core uses two buffers that can be mixed in the
> > > virtio-rng queue.
> > > 
> > > If the buffer is provided with wait=0 it is enqueued in the
> > > virtio-rng queue but unused by the caller.
> > > On the next call, core provides another buffer but the
> > > first one is filled instead and the new one queued.
> > > And the caller reads the data from the new one that is not
> > > updated, and the data in the first one are lost.
> > > 
> > > To avoid this mix, virtio-rng needs to use its own unique
> > > internal buffer at a cost of a data copy to the caller buffer.
> > > 
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > ---
> > >   drivers/char/hw_random/virtio-rng.c | 43 ++++++++++++++++++++++-------
> > >   1 file changed, 33 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> > > index a90001e02bf7..208c547dcac1 100644
> > > --- a/drivers/char/hw_random/virtio-rng.c
> > > +++ b/drivers/char/hw_random/virtio-rng.c
> > > @@ -18,13 +18,20 @@ static DEFINE_IDA(rng_index_ida);
> > >   struct virtrng_info {
> > >   	struct hwrng hwrng;
> > >   	struct virtqueue *vq;
> > > -	struct completion have_data;
> > >   	char name[25];
> > > -	unsigned int data_avail;
> > >   	int index;
> > >   	bool busy;
> > >   	bool hwrng_register_done;
> > >   	bool hwrng_removed;
> > > +	/* data transfer */
> > > +	struct completion have_data;
> > > +	unsigned int data_avail;
> > > +	/* minimal size returned by rng_buffer_size() */
> > > +#if SMP_CACHE_BYTES < 32
> > > +	u8 data[32];
> > > +#else
> > > +	u8 data[SMP_CACHE_BYTES];
> > > +#endif
> > 
> > Let's move this logic to a macro in hw_random.h ?
> > 
> > >   };
> > >   static void random_recv_done(struct virtqueue *vq)
> > > @@ -39,14 +46,14 @@ static void random_recv_done(struct virtqueue *vq)
> > >   }
> > >   /* The host will fill any buffer we give it with sweet, sweet randomness. */
> > > -static void register_buffer(struct virtrng_info *vi, u8 *buf, size_t size)
> > > +static void register_buffer(struct virtrng_info *vi)
> > >   {
> > >   	struct scatterlist sg;
> > > -	sg_init_one(&sg, buf, size);
> > > +	sg_init_one(&sg, vi->data, sizeof(vi->data));
> > 
> > Note that add_early_randomness requests less:
> >          size_t size = min_t(size_t, 16, rng_buffer_size());
> > 
> > maybe track how much was requested and grow up to sizeof(data)?
> 
> I think this problem is managed by PATCH 3/4 as we reuse unused data of the buffer.

the issue I'm pointing out is that we are requesting too much
entropy from host - more than guest needs.

> > 
> > >   	/* There should always be room for one buffer. */
> > > -	virtqueue_add_inbuf(vi->vq, &sg, 1, buf, GFP_KERNEL);
> > > +	virtqueue_add_inbuf(vi->vq, &sg, 1, vi->data, GFP_KERNEL);
> > 
> > 
> > BTW no longer true if DMA API is in use ... not easy to fix,
> > I think some changes to virtio API to allow pre-mapping
> > s/g for DMA might be needed ...
> 
> Is there something I can do here?
> 
> Thanks,
> Laurent

We can let it be for now, but down the road I think we should
support a way to pre-map memory for DMA.

-- 
MST

