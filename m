Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E60B4212E4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbhJDPnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235375AbhJDPnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633362080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qU1FtB2Eld4jQppv2Kg9J4SKZoBotXi+g3+/KDP2nB0=;
        b=fVde5l54c7HD2vswDHRXZTw0yftZqFF4mcDPHQs1ZpGMqa/Wajp1NXjtuYmV4Nssr8pOfr
        rJUG2rrjk/2ikjwQnm3AC20VhjgPppOhA7MUHMWidEY83Qyh1Syb2X9S5DVcFNBUY60rGC
        5rf4z2Ct6Y/CYz6rc3U/eaCY4PK0vtY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-1GhoZGeuNI6W-cbc8GQcxg-1; Mon, 04 Oct 2021 11:39:38 -0400
X-MC-Unique: 1GhoZGeuNI6W-cbc8GQcxg-1
Received: by mail-ed1-f72.google.com with SMTP id ec14-20020a0564020d4e00b003cf5630c190so17688798edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 08:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qU1FtB2Eld4jQppv2Kg9J4SKZoBotXi+g3+/KDP2nB0=;
        b=YN0vZx7588y5bSnajAD0iIMB5KN7VtDLaCGfJRZPIkr6/NyIPaW9fxYiF+LpJy5zvR
         dfz9fQH1eNcaYxgOe5El3tuzzMd2pLV4wsr0xUs7q8LVYkKo/eC0KyBmLdXaYzo1iZuq
         EqqpDhCvWwxjdg/bOc7dOAEWqlDoJMgDYvYytJ/wbz1qTJJ8WXGsR4hk5J+1XlZf0Ag5
         kxzdLt+LR0gxE04UeMqBV67wZLauVOCqbSFyMgxpQcZUfxy7zZ9RUUOnTzKemyiUEKr6
         iyC7l0Qyp2mJQhc5bpFX/iIkuYYOLnUJu+kMcDAgg4pMIByqOMI0Xn5m6bnkGlWv7q7V
         oytA==
X-Gm-Message-State: AOAM533t05WmpqEd2ntPjFlPGRXGDVVPNgttEMJmd8V/qy21ppQXoksn
        AA19ESIdA39fskfiaEDpWRWsCte+AtXGC9tqTrrbMJZmBFaSvlhMFNjZ4WFr2XrShUC4RO1v0MF
        BSKhMX3Pvq+61O1FyelKYvlB6
X-Received: by 2002:a17:906:a2c9:: with SMTP id by9mr13462725ejb.305.1633361977035;
        Mon, 04 Oct 2021 08:39:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymXaxS/ytfZ06+7jKPOhRySBzCqaPSUjBwPFfvyPHjd3iZN7oI5pN28PgDrC2yAGlapCwmMA==
X-Received: by 2002:a17:906:a2c9:: with SMTP id by9mr13462700ejb.305.1633361976806;
        Mon, 04 Oct 2021 08:39:36 -0700 (PDT)
Received: from redhat.com (93-172-224-64.bb.netvision.net.il. [93.172.224.64])
        by smtp.gmail.com with ESMTPSA id o5sm7374753eds.26.2021.10.04.08.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 08:39:36 -0700 (PDT)
Date:   Mon, 4 Oct 2021 11:39:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
Message-ID: <20211004113722-mutt-send-email-mst@kernel.org>
References: <20210809101609.148-1-xieyongji@bytedance.com>
 <20211004112623-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004112623-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 11:27:29AM -0400, Michael S. Tsirkin wrote:
> On Mon, Aug 09, 2021 at 06:16:09PM +0800, Xie Yongji wrote:
> > An untrusted device might presents an invalid block size
> > in configuration space. This tries to add validation for it
> > in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
> > feature bit if the value is out of the supported range.
> > 
> > And we also double check the value in virtblk_probe() in
> > case that it's changed after the validation.
> > 
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> 
> So I had to revert this due basically bugs in QEMU.
> 
> My suggestion at this point is to try and update
> blk_queue_logical_block_size to BUG_ON when the size
> is out of a reasonable range.
> 
> This has the advantage of fixing more hardware, not just virtio.
> 
> 
> 
> > ---
> >  drivers/block/virtio_blk.c | 39 +++++++++++++++++++++++++++++++++------
> >  1 file changed, 33 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 4b49df2dfd23..afb37aac09e8 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -692,6 +692,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
> >  static unsigned int virtblk_queue_depth;
> >  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
> >  
> > +static int virtblk_validate(struct virtio_device *vdev)
> > +{
> > +	u32 blk_size;
> > +
> > +	if (!vdev->config->get) {
> > +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > +			__func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
> > +		return 0;
> > +
> > +	blk_size = virtio_cread32(vdev,
> > +			offsetof(struct virtio_blk_config, blk_size));
> > +
> > +	if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
> > +		__virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
> > +
> > +	return 0;
> > +}
> > +
> >  static int virtblk_probe(struct virtio_device *vdev)
> >  {
> >  	struct virtio_blk *vblk;

I started wondering about this. So let's assume is
PAGE_SIZE < blk_size (after all it's up to guest at many platforms).

Will using the device even work given blk size is less than what
is can support?

And what exactly happens today if blk_size is out of this range?





> > @@ -703,12 +725,6 @@ static int virtblk_probe(struct virtio_device *vdev)
> >  	u8 physical_block_exp, alignment_offset;
> >  	unsigned int queue_depth;
> >  
> > -	if (!vdev->config->get) {
> > -		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > -			__func__);
> > -		return -EINVAL;
> > -	}
> > -
> >  	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
> >  			     GFP_KERNEL);
> >  	if (err < 0)
> > @@ -823,6 +839,14 @@ static int virtblk_probe(struct virtio_device *vdev)
> >  	else
> >  		blk_size = queue_logical_block_size(q);
> >  
> > +	if (unlikely(blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)) {
> > +		dev_err(&vdev->dev,
> > +			"block size is changed unexpectedly, now is %u\n",
> > +			blk_size);
> > +		err = -EINVAL;
> > +		goto err_cleanup_disk;
> > +	}
> > +
> >  	/* Use topology information if available */
> >  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
> >  				   struct virtio_blk_config, physical_block_exp,
> > @@ -881,6 +905,8 @@ static int virtblk_probe(struct virtio_device *vdev)
> >  	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
> >  	return 0;
> >  
> > +err_cleanup_disk:
> > +	blk_cleanup_disk(vblk->disk);
> >  out_free_tags:
> >  	blk_mq_free_tag_set(&vblk->tag_set);
> >  out_free_vq:
> > @@ -983,6 +1009,7 @@ static struct virtio_driver virtio_blk = {
> >  	.driver.name			= KBUILD_MODNAME,
> >  	.driver.owner			= THIS_MODULE,
> >  	.id_table			= id_table,
> > +	.validate			= virtblk_validate,
> >  	.probe				= virtblk_probe,
> >  	.remove				= virtblk_remove,
> >  	.config_changed			= virtblk_config_changed,
> > -- 
> > 2.11.0

