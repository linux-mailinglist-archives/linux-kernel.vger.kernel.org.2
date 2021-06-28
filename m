Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1833B68C1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 20:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbhF1S6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 14:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235662AbhF1S6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 14:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624906580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ECyZepa63nlv7FQfDjXLVtw4C+haeQFo0Jc6XzQeZsE=;
        b=BBpbfYkxxDm8vXqRkY6GtztJnJIZTCUsxurOdgpF94SRq3EHHJv0OC9TevvQpmKsn0Miff
        HPth/gF8YDpGjiRvcptN3GFz+sF5W+gdjNLF2vgG2JQuG4j4AnbFal+3u9E74UjqFKPQsd
        qyk7G9Dgrb8SWcwYqWsm0zmyqtxsltU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-iI1jAftSOn6UxlWEGxeEhQ-1; Mon, 28 Jun 2021 14:56:05 -0400
X-MC-Unique: iI1jAftSOn6UxlWEGxeEhQ-1
Received: by mail-oi1-f199.google.com with SMTP id 7-20020aca0f070000b029023d769dcb9bso5897369oip.14
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 11:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECyZepa63nlv7FQfDjXLVtw4C+haeQFo0Jc6XzQeZsE=;
        b=n+xuR+BjzbaE/LBUfvqCOiDte/NyPx2PpJG7GQbVH2LdvGbiMi0gumBBwHyEwT2h0P
         Y9dCjHWOkawD6nXKBQh/F5ufjwgOgVRt1OrMvMzj9akGpI+egyIc6qhlJGRfN9RUf3BY
         5YUuc6PVctBhn2qnak2T0cLnNxSvNTuKcVso4S/wZZflOFlFlt36eb4tbmGYB93kByvi
         VznIdQFS8PIAtzX6fzdB7FAuva7RKvaKCw3JEmQJLvgqyGlaWrDVT2MXzp38NP11TzX7
         /FOtX8iFkCZ9B+TX9sitUbACjEzykISdMPpZYabMXWc9WRDOSTn6jcrcYNv1EZLqnnfh
         342A==
X-Gm-Message-State: AOAM531ymZeyOhSNGu32NCOWk4ni7Rp2GdB2UURqsr6tCL3wV7UQRpY4
        STQAlC1vptQPDmEZna89d5zfGW8L0ZFFYOjvsY6kyc0nasVpdVs71kMpIr8at+znHtz6oWf2rY2
        E9O5n5vbVCCJADAojDsNuXuek
X-Received: by 2002:a4a:9644:: with SMTP id r4mr745810ooi.52.1624906564642;
        Mon, 28 Jun 2021 11:56:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+tWMyISY1yeEpZ9LNbIsGyIkCItlWIyGFb4Yoh05L8iUj6egVfko/ubXmKIYKG3lf81/DXQ==
X-Received: by 2002:a4a:9644:: with SMTP id r4mr745775ooi.52.1624906564120;
        Mon, 28 Jun 2021 11:56:04 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id u10sm3756394otj.75.2021.06.28.11.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 11:56:03 -0700 (PDT)
Date:   Mon, 28 Jun 2021 12:56:02 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>
Cc:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cohuck@redhat.com>, <jgg@nvidia.com>
Subject: Re: [PATCH] vfio/mtty: Enforce available_instances
Message-ID: <20210628125602.5b07388e.alex.williamson@redhat.com>
In-Reply-To: <ee949a98-6998-2032-eb17-00ef8b8d911c@nvidia.com>
References: <162465624894.3338367.12935940647049917981.stgit@omen>
        <ee949a98-6998-2032-eb17-00ef8b8d911c@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 23:19:54 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 6/26/2021 2:56 AM, Alex Williamson wrote:
> > The sample mtty mdev driver doesn't actually enforce the number of
> > device instances it claims are available.  Implement this properly.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> > 
> > Applies to vfio next branch + Jason's atomic conversion
> >   
> 
> 
> Does this need to be on top of Jason's patch?

Yes, see immediately above.

> Patch to use mdev_used_ports is reverted here, can it be changed from 
> mdev_devices_list to mdev_avail_ports atomic variable?

It doesn't revert Jason's change, it builds on it.  The patches could
we squashed, but there's no bug in Jason's patch that we're trying to
avoid exposing, so I don't see why we'd do that.

> Change here to use atomic variable looks good to me.
> 
> Reviewed by: Kirti Wankhede <kwankhede@nvidia.com>

Thanks!  It was Jason's patch[1] that converted to use an atomic
though, so I'm slightly confused if this R-b is for the patch below,
Jason's patch, or both.  Thanks,

Alex

[1]https://lore.kernel.org/kvm/0-v1-0bc56b362ca7+62-mtty_used_ports_jgg@nvidia.com/

> >   samples/vfio-mdev/mtty.c |   22 ++++++++++++++++------
> >   1 file changed, 16 insertions(+), 6 deletions(-)
> > 
> > diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
> > index ffbaf07a17ea..8b26fecc4afe 100644
> > --- a/samples/vfio-mdev/mtty.c
> > +++ b/samples/vfio-mdev/mtty.c
> > @@ -144,7 +144,7 @@ struct mdev_state {
> >   	int nr_ports;
> >   };
> >   
> > -static atomic_t mdev_used_ports;
> > +static atomic_t mdev_avail_ports = ATOMIC_INIT(MAX_MTTYS);
> >   
> >   static const struct file_operations vd_fops = {
> >   	.owner          = THIS_MODULE,
> > @@ -707,11 +707,20 @@ static int mtty_probe(struct mdev_device *mdev)
> >   {
> >   	struct mdev_state *mdev_state;
> >   	int nr_ports = mdev_get_type_group_id(mdev) + 1;
> > +	int avail_ports = atomic_read(&mdev_avail_ports);
> >   	int ret;
> >   
> > +	do {
> > +		if (avail_ports < nr_ports)
> > +			return -ENOSPC;
> > +	} while (!atomic_try_cmpxchg(&mdev_avail_ports,
> > +				     &avail_ports, avail_ports - nr_ports));
> > +
> >   	mdev_state = kzalloc(sizeof(struct mdev_state), GFP_KERNEL);
> > -	if (mdev_state == NULL)
> > +	if (mdev_state == NULL) {
> > +		atomic_add(nr_ports, &mdev_avail_ports);
> >   		return -ENOMEM;
> > +	}
> >   
> >   	vfio_init_group_dev(&mdev_state->vdev, &mdev->dev, &mtty_dev_ops);
> >   
> > @@ -724,6 +733,7 @@ static int mtty_probe(struct mdev_device *mdev)
> >   
> >   	if (mdev_state->vconfig == NULL) {
> >   		kfree(mdev_state);
> > +		atomic_add(nr_ports, &mdev_avail_ports);
> >   		return -ENOMEM;
> >   	}
> >   
> > @@ -735,9 +745,9 @@ static int mtty_probe(struct mdev_device *mdev)
> >   	ret = vfio_register_group_dev(&mdev_state->vdev);
> >   	if (ret) {
> >   		kfree(mdev_state);
> > +		atomic_add(nr_ports, &mdev_avail_ports);
> >   		return ret;
> >   	}
> > -	atomic_add(mdev_state->nr_ports, &mdev_used_ports);
> >   
> >   	dev_set_drvdata(&mdev->dev, mdev_state);
> >   	return 0;
> > @@ -746,12 +756,13 @@ static int mtty_probe(struct mdev_device *mdev)
> >   static void mtty_remove(struct mdev_device *mdev)
> >   {
> >   	struct mdev_state *mdev_state = dev_get_drvdata(&mdev->dev);
> > +	int nr_ports = mdev_state->nr_ports;
> >   
> > -	atomic_sub(mdev_state->nr_ports, &mdev_used_ports);
> >   	vfio_unregister_group_dev(&mdev_state->vdev);
> >   
> >   	kfree(mdev_state->vconfig);
> >   	kfree(mdev_state);
> > +	atomic_add(nr_ports, &mdev_avail_ports);
> >   }
> >   
> >   static int mtty_reset(struct mdev_state *mdev_state)
> > @@ -1271,8 +1282,7 @@ static ssize_t available_instances_show(struct mdev_type *mtype,
> >   {
> >   	unsigned int ports = mtype_get_type_group_id(mtype) + 1;
> >   
> > -	return sprintf(buf, "%d\n",
> > -		       (MAX_MTTYS - atomic_read(&mdev_used_ports)) / ports);
> > +	return sprintf(buf, "%d\n", atomic_read(&mdev_avail_ports) / ports);
> >   }
> >   
> >   static MDEV_TYPE_ATTR_RO(available_instances);
> > 
> >   
> 

