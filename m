Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A691041FDA9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 20:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhJBSWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 14:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233814AbhJBSWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 14:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633198853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/BseWdc8UQJjK9a1ZYawAXysMdy6qiRjZCYAo+Mifu0=;
        b=X0wKNwv2NkPOKc1fy1BHH2jlGsqkzhYwBls4wqB9OCE2ZWkI3eQ27iOhwYVaANmPwJ08jH
        yIsv1+AGFDi/GuvQAwuXZJmc5tgYe5CY8nCepBStGSSnRGGEWrxzWWDEUMH5gJPSko9Eqp
        juWwlru2BTd2nXUiLizsWe+WFBUCMPM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-L7g04a14MaScfP3UjsD3AQ-1; Sat, 02 Oct 2021 14:20:52 -0400
X-MC-Unique: L7g04a14MaScfP3UjsD3AQ-1
Received: by mail-wm1-f70.google.com with SMTP id 200-20020a1c00d1000000b0030b3dce20e1so7719967wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 11:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/BseWdc8UQJjK9a1ZYawAXysMdy6qiRjZCYAo+Mifu0=;
        b=F6jgp0RpGFAaKk9ReLOyOm9hhl8voOQDNpfKo51yriWM5WziUdOnXN9l37cYqnHSqc
         6kVGh9iOew0oOr1qQPNjrtL/P+090aJE6bGnyvpCeNWOUpc19IEpome8tpi+IaLS22m1
         ynjizihfdXIspCqg3c2MRunnlMrXLugRqXtIw15J41vjwbdptM2M3cnGp9f0SA4QBoL1
         ah2GLi3nTPntTtTVVnjKf/XZhayF0CQE56vRA7lHLWqqPNVibRwczd1Oj7lXHXz5Hp+a
         Opo73IboljQE9T7Q+eYg80mp36Jg6DNWktXjVnDbje167JCOXeieukCYfxdRuD62+UFh
         D8LQ==
X-Gm-Message-State: AOAM531/U/H6P5SV6yadcHyPUbUGHcit+79aXd2W0WgXce9H+1yT5inN
        2hhPrkcCKTKZde6b3VBnUIUfk1BTZetkpATDUxJdYqJ8xQu0wGbxSAcDHwEDpFitXbdKgkjqJzV
        /Wr5CgnwKO7Ul4jIDFHfA2Emg
X-Received: by 2002:adf:dd49:: with SMTP id u9mr4550510wrm.341.1633198851276;
        Sat, 02 Oct 2021 11:20:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvZQk7jDjIn08h5VZz1gHIyPHtFcuVU64tR+3kyaT84IIZkayL+B4+uQQLa/omoliyoequsA==
X-Received: by 2002:adf:dd49:: with SMTP id u9mr4550499wrm.341.1633198851080;
        Sat, 02 Oct 2021 11:20:51 -0700 (PDT)
Received: from redhat.com ([2.55.22.213])
        by smtp.gmail.com with ESMTPSA id s3sm9210727wrm.40.2021.10.02.11.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 11:20:50 -0700 (PDT)
Date:   Sat, 2 Oct 2021 14:20:47 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211002141351-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <87fstm47no.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fstm47no.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 01:36:27PM +0200, Cornelia Huck wrote:
> On Thu, Sep 30 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Sep 30, 2021 at 03:20:49AM +0200, Halil Pasic wrote:
> >> This patch fixes a regression introduced by commit 82e89ea077b9
> >> ("virtio-blk: Add validation for block size in config space") and
> >> enables similar checks in verify() on big endian platforms.
> >> 
> >> The problem with checking multi-byte config fields in the verify
> >> callback, on big endian platforms, and with a possibly transitional
> >> device is the following. The verify() callback is called between
> >> config->get_features() and virtio_finalize_features(). That we have a
> >> device that offered F_VERSION_1 then we have the following options
> >> either the device is transitional, and then it has to present the legacy
> >> interface, i.e. a big endian config space until F_VERSION_1 is
> >> negotiated, or we have a non-transitional device, which makes
> >> F_VERSION_1 mandatory, and only implements the non-legacy interface and
> >> thus presents a little endian config space. Because at this point we
> >> can't know if the device is transitional or non-transitional, we can't
> >> know do we need to byte swap or not.
> >
> > Hmm which transport does this refer to?
> > Distinguishing between legacy and modern drivers is transport
> > specific.  PCI presents
> > legacy and modern at separate addresses so distinguishing
> > between these two should be no trouble.
> 
> Hm, what about transitional devices?

transitional devices can be accessed through a modern
or a legacy interface, not both. Device knows how
it's accessed. It should key endian-ness decisions on
this not on feature negotiation.

> > Channel i/o has versioning so same thing?
> 
> It can turn off VERSION_1, but not legacy. (I had hacked up a patchset
> to potentially disable legacy some time ago, but did not have any
> resources to follow up on this.)

That's ok, my point is that revision is negotiated before config
accesses, IIUC a legacy driver expecting BE will use revision 0, modern
one will use revision 1 and up.

> 
> >
> >> The virtio spec explicitly states that the driver MAY read config
> >> between reading and writing the features so saying that first accessing
> >> the config before feature negotiation is done is not an option. The
> >> specification ain't clear about setting the features multiple times
> >> before FEATURES_OK, so I guess that should be fine.
> >> 
> >> I don't consider this patch super clean, but frankly I don't think we
> >> have a ton of options. Another option that may or man not be cleaner,
> >> but is also IMHO much uglier is to figure out whether the device is
> >> transitional by rejecting _F_VERSION_1, then resetting it and proceeding
> >> according tho what we have figured out, hoping that the characteristics
> >> of the device didn't change.
> >
> > I am confused here. So is the problem at the device or at the driver level?
> > I suspect it's actually the host that has the issue, not
> > the guest?
> 
> >From my perspective the problem is that the version of the device
> remains in limbo as long as the features have not yet been finalized,
> which means that the endianness of the config space remains in limbo as
> well. Both device and driver might come to different conclusions.

Version === legacy versus modern?
It is true that feature negotiation can not be used by device to decide that
question simply because it happens too late.
So let's not use it for that then ;)

Yes we have VERSION_1 which looks like it should allow this, but
unfortunately it only helps with that for the driver, not the device.

In practice legacy versus modern has to be determined by
transport specific versioning, luckily we have that for all
specified transports (can't say what happens with rproc).

> 
> >
> >
> >> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> >> Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> >> Reported-by: markver@us.ibm.com
> >> ---
> >>  drivers/virtio/virtio.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >> 
> >> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> >> index 0a5b54034d4b..9dc3cfa17b1c 100644
> >> --- a/drivers/virtio/virtio.c
> >> +++ b/drivers/virtio/virtio.c
> >> @@ -249,6 +249,10 @@ static int virtio_dev_probe(struct device *_d)
> >>  		if (device_features & (1ULL << i))
> >>  			__virtio_set_bit(dev, i);
> >>  
> >> +	/* Write back features before validate to know endianness */
> >> +	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
> >> +		dev->config->finalize_features(dev);
> >> +
> >>  	if (drv->validate) {
> >>  		err = drv->validate(dev);
> >>  		if (err)
> >> 
> >> base-commit: 02d5e016800d082058b3d3b7c3ede136cdc6ddcb
> >> -- 
> >> 2.25.1

