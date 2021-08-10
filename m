Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5243E514B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 05:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbhHJDGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 23:06:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232897AbhHJDF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 23:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628564736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNAD9HvPLL20RnA7Fm9EynMKwbGxKPvS4YW5JmvO4X8=;
        b=aTQKRcVlu3h39rfRnxSo4jghn3CBn34dqIhm7nWrTAGhY77OTE0TjVmyfPIlsXA2Y8qWIt
        p2dQMA1nfrYbeJXq4ivrfBEsX9vHiBg0op/bXQkfWniclK2RKh+y/V3PZ7GS0Hkj163X7k
        gJjMn2X91iJ9Go+wnQLjd1ZgVdG0vxc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-5MdIuSl-NO-mn3w94-XYvA-1; Mon, 09 Aug 2021 23:05:35 -0400
X-MC-Unique: 5MdIuSl-NO-mn3w94-XYvA-1
Received: by mail-pj1-f71.google.com with SMTP id d35-20020a17090a6f26b0290178ab46154dso3496257pjk.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 20:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FNAD9HvPLL20RnA7Fm9EynMKwbGxKPvS4YW5JmvO4X8=;
        b=p46BzSB4eKYx1a+EGl1wXClTh+iiUNlXo+c33K5oO4nK6uUrNU6PPfwajQ8IxBUwP0
         wGOOCaHkPmhKbIecgqJpimfOSgqp1U1D8yxIVGNWc9OSdib5yH1/iPiZS8cYBsfKEfEn
         S2wqxALFMmYbSfjfQWVXdnP41dxPu52mh5ltXGnwSkLwPx6JubZAuqrWlZFF2CL2meEc
         HP6M+8ne83iz3CQH3yLV0vQrgjroDrLQunLAiepgzINJNwVr786xWzOrZVmR+nlHe4PU
         1XbHb+NXWQPnBX9Y/Y4dvr1T+FyoGx6XYM2XfOqed/BBw7ZLsbQzEUyMDM/mOgWYzy7U
         xM3w==
X-Gm-Message-State: AOAM530tLNIDPERoCLmtJuh7tFcHCkOI5pkqZx5AfPSWWpGx86l0jHMh
        JrphryOjfq6Aao+Cs9Istqcxwux21GBdmq/kSbPHSvP9l72lATV743PLd2WbjeZj5ZCbm6ch+G1
        6TIOlQjCN48egHT4qifyrtLpFR7gStSlBBej8pmHEGKJGNVVMlPNepnn5lyzRDgpwuU219+oNnt
        XC
X-Received: by 2002:a63:2585:: with SMTP id l127mr303535pgl.318.1628564734500;
        Mon, 09 Aug 2021 20:05:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXfNDEqGz8UY7V4AUjb+V6s581Q/QII16jDbubwX4LuBoC0RVi6HBrqCF4aijatpedgi9vtg==
X-Received: by 2002:a63:2585:: with SMTP id l127mr303496pgl.318.1628564734150;
        Mon, 09 Aug 2021 20:05:34 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s5sm16264880pji.56.2021.08.09.20.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 20:05:33 -0700 (PDT)
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        stefanha@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210809101609.148-1-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <08366773-76b5-be73-7e32-d9ce6f6799bf@redhat.com>
Date:   Tue, 10 Aug 2021 11:05:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809101609.148-1-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/8/9 ÏÂÎç6:16, Xie Yongji Ð´µÀ:
> An untrusted device might presents an invalid block size
> in configuration space. This tries to add validation for it
> in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
> feature bit if the value is out of the supported range.
>
> And we also double check the value in virtblk_probe() in
> case that it's changed after the validation.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   drivers/block/virtio_blk.c | 39 +++++++++++++++++++++++++++++++++------
>   1 file changed, 33 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 4b49df2dfd23..afb37aac09e8 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -692,6 +692,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
>   static unsigned int virtblk_queue_depth;
>   module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
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


I wonder if it's better to just fail here as what we did for probe().

Thanks


> +
> +	return 0;
> +}
> +
>   static int virtblk_probe(struct virtio_device *vdev)
>   {
>   	struct virtio_blk *vblk;
> @@ -703,12 +725,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>   	u8 physical_block_exp, alignment_offset;
>   	unsigned int queue_depth;
>   
> -	if (!vdev->config->get) {
> -		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> -			__func__);
> -		return -EINVAL;
> -	}
> -
>   	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
>   			     GFP_KERNEL);
>   	if (err < 0)
> @@ -823,6 +839,14 @@ static int virtblk_probe(struct virtio_device *vdev)
>   	else
>   		blk_size = queue_logical_block_size(q);
>   
> +	if (unlikely(blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)) {
> +		dev_err(&vdev->dev,
> +			"block size is changed unexpectedly, now is %u\n",
> +			blk_size);
> +		err = -EINVAL;
> +		goto err_cleanup_disk;
> +	}
> +
>   	/* Use topology information if available */
>   	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
>   				   struct virtio_blk_config, physical_block_exp,
> @@ -881,6 +905,8 @@ static int virtblk_probe(struct virtio_device *vdev)
>   	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
>   	return 0;
>   
> +err_cleanup_disk:
> +	blk_cleanup_disk(vblk->disk);
>   out_free_tags:
>   	blk_mq_free_tag_set(&vblk->tag_set);
>   out_free_vq:
> @@ -983,6 +1009,7 @@ static struct virtio_driver virtio_blk = {
>   	.driver.name			= KBUILD_MODNAME,
>   	.driver.owner			= THIS_MODULE,
>   	.id_table			= id_table,
> +	.validate			= virtblk_validate,
>   	.probe				= virtblk_probe,
>   	.remove				= virtblk_remove,
>   	.config_changed			= virtblk_config_changed,

