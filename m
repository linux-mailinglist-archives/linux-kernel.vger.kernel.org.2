Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5666C4207DD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 11:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhJDJJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 05:09:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230238AbhJDJJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 05:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633338442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KUYZD9Kgpaky1z7hVZXMbU8Alpvzhtxgb9yTTSNBD4U=;
        b=h4wD2CdxcvcjgInim1MfJ4b79q2TTpdZKg8RoxR20+bV4t7Qr7ID0c4L31fGtt9qEWf/Cz
        9Lr2GXPlrExdnCr4eHR4EsiGIhlBYWCJrgcXjYMvabYvcTyHKevXX0VY+NLUR2D8mzz+p6
        PwVE52W9KODtxd3f0ejepLkfFpWtm5s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-LzZG3tNRMnmomfsRf62CXA-1; Mon, 04 Oct 2021 05:07:19 -0400
X-MC-Unique: LzZG3tNRMnmomfsRf62CXA-1
Received: by mail-wr1-f71.google.com with SMTP id d13-20020adf9b8d000000b00160a94c235aso827300wrc.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 02:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KUYZD9Kgpaky1z7hVZXMbU8Alpvzhtxgb9yTTSNBD4U=;
        b=zyrNvGtJZolNJFDCZ9CpB5bPMIfHa6kfWKshamtEf+ZQriPWCRTP8xKxytjZswGuFP
         /il0mq1X888p4qDXCTUci377Zf53mua7mPKW8pThRiB3c8kTdK4u5JLHkP2HswyPdon7
         5/gzC56STToRA0PXdKa9fA1rXrM6C4PMrxoInIsCFMzFG0P9cYQDdBz5znyZObrhUT+Q
         hmGK4QI3ZjhSHK9OmtNGrdqx7OyUgMjDNo70YebRfW2IlihOFRLMxah/1tL+Z8Sv3y+t
         G1YtyVm4/G2ZKObdz8nizeMfAEJnxZA5aAVyf1j7rbdS308Vs5gh42UBQq/KhsXSbqL4
         ERfQ==
X-Gm-Message-State: AOAM533IO7pEMYTl1gmCjh+VMEm8C5moHw1LiqiejiieJ+YNJKesCGha
        NdZK95qzSAcPFGhCt832u6dH8X36SbOt2vSM8m7F3U0HsXcrzspBO2SopO0OcT9zmgl2TPG5i8f
        o5BNI980rinGn6lkKhPblpeHV
X-Received: by 2002:adf:e309:: with SMTP id b9mr12638353wrj.81.1633338438602;
        Mon, 04 Oct 2021 02:07:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxetp1mwKHklXMBwe56BuI1PQiGNQTpk0T6hYH6FfLDl0lEWTgrKFExLyVwgcM3KL58TXci1w==
X-Received: by 2002:adf:e309:: with SMTP id b9mr12638322wrj.81.1633338438386;
        Mon, 04 Oct 2021 02:07:18 -0700 (PDT)
Received: from redhat.com ([2.55.134.94])
        by smtp.gmail.com with ESMTPSA id t15sm4510863wru.6.2021.10.04.02.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 02:07:17 -0700 (PDT)
Date:   Mon, 4 Oct 2021 05:07:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, stefanha@redhat.com,
        qemu-devel@nongnu.org,
        Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211004040937-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <87r1d64dl4.fsf@redhat.com>
 <20210930130350.0cdc7c65.pasic@linux.ibm.com>
 <87ilyi47wn.fsf@redhat.com>
 <20211001162213.18d7375e.pasic@linux.ibm.com>
 <87v92g3h9l.fsf@redhat.com>
 <20211002082128-mutt-send-email-mst@kernel.org>
 <20211004042323.730c6a5e.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004042323.730c6a5e.pasic@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 04:23:23AM +0200, Halil Pasic wrote:
> On Sat, 2 Oct 2021 14:13:37 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > Anyone else have an idea? This is a nasty regression; we could revert the
> > > patch, which would remove the symptoms and give us some time, but that
> > > doesn't really feel right, I'd do that only as a last resort.  
> > 
> > Well we have Halil's hack (except I would limit it
> > to only apply to BE, only do devices with validate,
> > and only in modern mode), and we will fix QEMU to be spec compliant.
> > Between these why do we need any conditional compiles?
> 
> We don't. As I stated before, this hack is flawed because it
> effectively breaks fencing features by the driver with QEMU. Some
> features can not be unset after once set, because we tend to try to
> enable the corresponding functionality whenever we see a write
> features operation with the feature bit set, and we don't disable, if a
> subsequent features write operation stores the feature bit as not set.

Something to fix in QEMU too, I think.

> But it looks like VIRTIO_1 is fine to get cleared afterwards.

We'd never clear it though - why would we?

> So my hack
> should actually look like posted below, modulo conditions.


Looking at it some more, I see that vhost-user actually
does not send features to the backend until FEATURES_OK.
However, the code in contrib for vhost-user-blk at least seems
broken wrt endian-ness ATM. What about other backends though?
Hard to be sure right?
Cc Raphael and Stefan so they can take a look.
And I guess it's time we CC'd qemu-devel too.

For now I am beginning to think we should either revert or just limit
validation to LE and think about all this some more. And I am inclining
to do a revert. These are all hypervisors that shipped for a long time.
Do we need a flag for early config space access then?



> 
> Regarding the conditions I guess checking that driver_features has
> F_VERSION_1 already satisfies "only modern mode", or?

Right.

> For now
> I've deliberately omitted the has verify and the is big endian
> conditions so we have a better chance to see if something breaks
> (i.e. the approach does not work). I can add in those extra conditions
> later.

Or maybe if we will go down that road just the verify check (for
performance). I'm a bit unhappy we have the extra exit but consistency
seems more important.

> 
> --------------------------8<---------------------
> 
> From: Halil Pasic <pasic@linux.ibm.com>
> Date: Thu, 30 Sep 2021 02:38:47 +0200
> Subject: [PATCH] virtio: write back feature VERSION_1 before verify
> 
> This patch fixes a regression introduced by commit 82e89ea077b9
> ("virtio-blk: Add validation for block size in config space") and
> enables similar checks in verify() on big endian platforms.
> 
> The problem with checking multi-byte config fields in the verify
> callback, on big endian platforms, and with a possibly transitional
> device is the following. The verify() callback is called between
> config->get_features() and virtio_finalize_features(). That we have a
> device that offered F_VERSION_1 then we have the following options
> either the device is transitional, and then it has to present the legacy
> interface, i.e. a big endian config space until F_VERSION_1 is
> negotiated, or we have a non-transitional device, which makes
> F_VERSION_1 mandatory, and only implements the non-legacy interface and
> thus presents a little endian config space. Because at this point we
> can't know if the device is transitional or non-transitional, we can't
> know do we need to byte swap or not.

Well we established that we can know. Here's an alternative explanation:

	The virtio specification virtio-v1.1-cs01 states:

	Transitional devices MUST detect Legacy drivers by detecting that
	VIRTIO_F_VERSION_1 has not been acknowledged by the driver.
	This is exactly what QEMU as of 6.1 has done relying solely
	on VIRTIO_F_VERSION_1 for detecting that.

	However, the specification also says:
	driver MAY read (but MUST NOT write) the device-specific
	configuration fields to check that it can support the device before
	accepting it.

	In that case, any device relying solely on VIRTIO_F_VERSION_1
	for detecting legacy drivers will return data in legacy format.
	In particular, this implies that it is in big endian format
	for big endian guests. This naturally confuses the driver
	which expects little endian in the modern mode.

	It is probably a good idea to amend the spec to clarify that
	VIRTIO_F_VERSION_1 can only be relied on after the feature negotiation
	is complete. However, we already have regression so let's
	try to address it.


> 
> The virtio spec explicitly states that the driver MAY read config
> between reading and writing the features so saying that first accessing
> the config before feature negotiation is done is not an option. The
> specification ain't clear about setting the features multiple times
> before FEATURES_OK, so I guess that should be fine to set F_VERSION_1
> since at this point we already know that we are about to negotiate
> F_VERSION_1.
> 
> I don't consider this patch super clean, but frankly I don't think we
> have a ton of options. Another option that may or man not be cleaner,
> but is also IMHO much uglier is to figure out whether the device is
> transitional by rejecting _F_VERSION_1, then resetting it and proceeding
> according tho what we have figured out, hoping that the characteristics
> of the device didn't change.

An empty line before tags.

> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> Reported-by: markver@us.ibm.com

Let's add more commits that are affected. E.g. virtio-net with MTU
feature bit set is affected too.

So let's add Fixes tag for:
commit 14de9d114a82a564b94388c95af79a701dc93134
Author: Aaron Conole <aconole@redhat.com>
Date:   Fri Jun 3 16:57:12 2016 -0400

    virtio-net: Add initial MTU advice feature
    
I think that's all, but pls double check me.


> ---
>  drivers/virtio/virtio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 0a5b54034d4b..2b9358f2e22a 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -239,6 +239,12 @@ static int virtio_dev_probe(struct device *_d)
>  		driver_features_legacy = driver_features;
>  	}
>  
> +	/* Write F_VERSION_1 feature to pin down endianness */
> +	if (device_features & (1ULL << VIRTIO_F_VERSION_1) & driver_features) {
> +		dev->features = (1ULL << VIRTIO_F_VERSION_1);
> +		dev->config->finalize_features(dev);
> +	}
> +
>  	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
>  		dev->features = driver_features & device_features;
>  	else
> -- 
> 2.31.1
> 
> 
> 
> 
> 
>  

