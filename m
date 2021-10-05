Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182444223BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbhJEKop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233490AbhJEKon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633430573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bnN0iAzDh/S8fsii9MloUrds9D80Vyvt+Eh8JOcls+c=;
        b=jAAGSj/1A9pe5/4ev1aSj2zdS6zPNf/13cTpMXeDaPa/wMUOiiIqVobXYAAEzfjh54W0Nb
        PUT/OEzxTFkYyyvY924F3A4W6uj0CVAGxMdFdWU+GGJVSwdQm6zRxaGFSOcMOJ/FCvz7aN
        UOE7/X39LkN4xlfs3B8G2gxA2MQiGcM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-ExL-mijlMlyTOGJjGw5cbQ-1; Tue, 05 Oct 2021 06:42:52 -0400
X-MC-Unique: ExL-mijlMlyTOGJjGw5cbQ-1
Received: by mail-ed1-f71.google.com with SMTP id y15-20020a50ce0f000000b003dab997cf7dso16705143edi.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 03:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bnN0iAzDh/S8fsii9MloUrds9D80Vyvt+Eh8JOcls+c=;
        b=Z0L7PKHxcFbjHJwfhABPDuhohmgpJUEaq0KCmPU9lrgxXm6pr+4x78TzWnRiXBym16
         CHzcstJN0Wkpk6f9aWi1p6jA0AnSPLJTBND7ZF551kfW9xdFAVh88iOl1eZtuKitSmy5
         3gz5Fwj79ZzvVCrjiD/+1hbaiz7xQZdV9vxt8iClLPui/I7TKFvyJJixyexJ+JD62gSe
         sqT3AlWClFoYOozdUEyEg38AG2HehQmopymd8EfgcTjjpr5jybOyUU0SKTNwkG0s8MZg
         pSPuTU7GI4BQi8TL0ets+FM8YEpEck/vtpdAYhLZJMCLQBB1kiTc5WtUd2Dib2+sl3oQ
         /TIA==
X-Gm-Message-State: AOAM532+ToNhoBJxZirgMC5MhtPisCy/yTNpmDAb+3vWpr2gYuWJhQ9p
        Yp/ZMpGME9CoX8LwgoRNgNqadGlEfF/ogCOYu1PyltFxgIwrTSbq5UqX3zHgU/ZOgqsZD4ZZi6r
        8w3q7IVV8ahgWrEOLIRJk7QKf
X-Received: by 2002:a17:906:608e:: with SMTP id t14mr23510388ejj.441.1633430570492;
        Tue, 05 Oct 2021 03:42:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwACM112IUCa3fOx7O5XRyDrZ+g5wNyCBCOWtDMMiRFBtNmFLZZKgE9j8Wc70F7xxIuqg+/cw==
X-Received: by 2002:a17:906:608e:: with SMTP id t14mr23510362ejj.441.1633430570315;
        Tue, 05 Oct 2021 03:42:50 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
        by smtp.gmail.com with ESMTPSA id a1sm8000402edu.43.2021.10.05.03.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 03:42:49 -0700 (PDT)
Date:   Tue, 5 Oct 2021 06:42:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Wolf <kwolf@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
Message-ID: <20211005062359-mutt-send-email-mst@kernel.org>
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

Stefan also pointed out this duplicates the logic from 

        if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
                return -EINVAL;


and a bunch of other places.


Would it be acceptable for blk layer to validate the input
instead of having each driver do it's own thing?
Maybe inside blk_queue_logical_block_size?



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

