Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5324212A4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhJDP3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233469AbhJDP3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633361251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=auNZYLZiQYvet1N/rTWrc/v8jISoRi7qtdbe/2SoG5w=;
        b=Jd7fANc+Ym6GNcmOcw8fl+AZRqpOAxObyOtRs/3tcrIA1iZmuhybkIOH0KKsqrPTlC2eyw
        XbfDSsTBD7SC8Tw4V6bPrR+lpEfEp1V0EnBHxVoWxnmeJ1/6zzQgG317XoM0/42gXt0Dis
        8bjZ3ITsNv6aFEMBqZ/buifJONubPAg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-40o3AFPVMhmbhGUlqTsf4w-1; Mon, 04 Oct 2021 11:27:30 -0400
X-MC-Unique: 40o3AFPVMhmbhGUlqTsf4w-1
Received: by mail-ed1-f70.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so17524359edy.14
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 08:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=auNZYLZiQYvet1N/rTWrc/v8jISoRi7qtdbe/2SoG5w=;
        b=kX4vjNduTO0bTTN/VVTO4B6VahT8nmb54luABZYcuienSVoVzrlLG+6wMStpF4TBqZ
         qfHkW4ZlNdLJtikSf5tP2d6sK+SyYRs8SEdP7QKgn1SWPrVC/shuw2yVePBOiPa4xBPW
         2Sz21Z+29u8b/iZDCAy5QVukkJg69rjp67teajxaFvbNaR4zrZ1C9O4uEGvzKO02q38h
         N5QHBcUE47OVFbsG7TYBKYptq5Pv2CL1Fx1sG4dbgFkIgO1EAVEUIo8myFvR81aaR8c8
         iHq46jODocd1phALZGQkNsKPvvV12m7o/Mo3rkhpli9XWvCNSWrFKlCQqpSxpVyIFZeZ
         GUBQ==
X-Gm-Message-State: AOAM530mnV+2oVq72qillfCC9bdzymvlbjgBN/90GgG9NhYUGp4cW3PH
        FBs1dawZiCthEgHvG6SV68PwieVl/7G09BvFZFrWddEijobmq4gy5uCX/Kwe1umnqnM7S15zReg
        14ugaqQpcWDXtrnNiGU84UoyQ
X-Received: by 2002:a50:e043:: with SMTP id g3mr18999651edl.196.1633361249582;
        Mon, 04 Oct 2021 08:27:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMJ7M+trs4RD8gzRpJQ6aRNNiNOKTOmXRorts5UQDjiCJa96uVKFhOKPZwNVjzIT+MTyscBg==
X-Received: by 2002:a50:e043:: with SMTP id g3mr18999630edl.196.1633361249409;
        Mon, 04 Oct 2021 08:27:29 -0700 (PDT)
Received: from redhat.com (93-172-224-64.bb.netvision.net.il. [93.172.224.64])
        by smtp.gmail.com with ESMTPSA id d30sm1918863edn.49.2021.10.04.08.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 08:27:28 -0700 (PDT)
Date:   Mon, 4 Oct 2021 11:27:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
Message-ID: <20211004112623-mutt-send-email-mst@kernel.org>
References: <20210809101609.148-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809101609.148-1-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 06:16:09PM +0800, Xie Yongji wrote:
> An untrusted device might presents an invalid block size
> in configuration space. This tries to add validation for it
> in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
> feature bit if the value is out of the supported range.
> 
> And we also double check the value in virtblk_probe() in
> case that it's changed after the validation.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

So I had to revert this due basically bugs in QEMU.

My suggestion at this point is to try and update
blk_queue_logical_block_size to BUG_ON when the size
is out of a reasonable range.

This has the advantage of fixing more hardware, not just virtio.



> ---
>  drivers/block/virtio_blk.c | 39 +++++++++++++++++++++++++++++++++------
>  1 file changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 4b49df2dfd23..afb37aac09e8 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -692,6 +692,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
>  static unsigned int virtblk_queue_depth;
>  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
>  
> +static int virtblk_validate(struct virtio_device *vdev)
> +{
> +	u32 blk_size;
> +
> +	if (!vdev->config->get) {
> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
> +		return 0;
> +
> +	blk_size = virtio_cread32(vdev,
> +			offsetof(struct virtio_blk_config, blk_size));
> +
> +	if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
> +		__virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
> +
> +	return 0;
> +}
> +
>  static int virtblk_probe(struct virtio_device *vdev)
>  {
>  	struct virtio_blk *vblk;
> @@ -703,12 +725,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	u8 physical_block_exp, alignment_offset;
>  	unsigned int queue_depth;
>  
> -	if (!vdev->config->get) {
> -		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> -			__func__);
> -		return -EINVAL;
> -	}
> -
>  	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
>  			     GFP_KERNEL);
>  	if (err < 0)
> @@ -823,6 +839,14 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	else
>  		blk_size = queue_logical_block_size(q);
>  
> +	if (unlikely(blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)) {
> +		dev_err(&vdev->dev,
> +			"block size is changed unexpectedly, now is %u\n",
> +			blk_size);
> +		err = -EINVAL;
> +		goto err_cleanup_disk;
> +	}
> +
>  	/* Use topology information if available */
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
>  				   struct virtio_blk_config, physical_block_exp,
> @@ -881,6 +905,8 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
>  	return 0;
>  
> +err_cleanup_disk:
> +	blk_cleanup_disk(vblk->disk);
>  out_free_tags:
>  	blk_mq_free_tag_set(&vblk->tag_set);
>  out_free_vq:
> @@ -983,6 +1009,7 @@ static struct virtio_driver virtio_blk = {
>  	.driver.name			= KBUILD_MODNAME,
>  	.driver.owner			= THIS_MODULE,
>  	.id_table			= id_table,
> +	.validate			= virtblk_validate,
>  	.probe				= virtblk_probe,
>  	.remove				= virtblk_remove,
>  	.config_changed			= virtblk_config_changed,
> -- 
> 2.11.0

