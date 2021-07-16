Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CDF3CB0EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 04:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhGPDBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 23:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233119AbhGPDBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 23:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626404293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1rVaJ8XvOsDBWtaRQp3apo92CSiPixBvBUSI+5KjFdc=;
        b=KF+3SS/lAseT6Jrqoq6bE+ecfDcVb5AngV20KFdEldKxwqxrjJnKn5zE5jcCewELEA6yRi
        fTHHLSyHAkTBlElLKug7LONWja+Dp/CswFTk5mOlx2oAvY34zh8Yoy+WLMZDBTerbs2pe3
        AJSHsXwLMWXTXXBl2YOesiOtZRi+sA8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-nqcdgxOYPx6GShhcizEpEg-1; Thu, 15 Jul 2021 22:58:12 -0400
X-MC-Unique: nqcdgxOYPx6GShhcizEpEg-1
Received: by mail-pg1-f199.google.com with SMTP id k3-20020a6568c30000b029022887377adeso5864228pgt.15
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 19:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1rVaJ8XvOsDBWtaRQp3apo92CSiPixBvBUSI+5KjFdc=;
        b=G45OQae8J7l0PR2TFMsldq23MJpjxBre/tCaRLyNVlJn8lnhyxKpUam5vNhufQCWpg
         FbFGH4WWBgqOmMnJeLAmXg32zc3L6SbEfQPILa3NkvjL7puG/fOw2sZ6gM7DD/1ug7EL
         lhorIYTjhQFgEnDZ59iXIh8G7baeUVrgus+PTzvJWwvTiK3shDQqfBjMx25sagX+aJaT
         GLLaGvTZLoXrs/5IwQuq7Dv+CxuDuEtnUQl52Jw7hwqLMdrEqOVN2GSHnW96uUibkLgy
         BJgC3qejmdNYTBEqxjiWNdnFZnFULHMZHjexh0UhF4uahRu9hblv+vEoEpjdlzY5OADx
         4o/g==
X-Gm-Message-State: AOAM5307QpDG/Ba2DfA7i6fO2BMVzmDzMEUbehrCbszM4siUPAWfQjhr
        SFldED54y+FW7sPiw/NCMMh0eVuQLvkmPotTLmoDLCsVTgKhuo+mZ3Khl3Z+5aEzRnFRiUBE/Sx
        g5bCDmVG8qokwj7MkjNy2FmzLVQxF803IfIrE1lkmvGzvKJLRwyO2Emy967L0BcrQadt5QsxCbX
        wJ
X-Received: by 2002:a63:2ad7:: with SMTP id q206mr7719151pgq.293.1626404290489;
        Thu, 15 Jul 2021 19:58:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcVMtGVvo/4+WELLZqICmyEEq8fuHUEaK7zlWHRei1qwUHmSCRFN0Ja84LkdQNmIXFBviGIQ==
X-Received: by 2002:a63:2ad7:: with SMTP id q206mr7719128pgq.293.1626404290160;
        Thu, 15 Jul 2021 19:58:10 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w123sm8061175pfb.109.2021.07.15.19.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 19:58:09 -0700 (PDT)
Subject: Re: [PATCH 1/1] virtio: disable partitions scanning for no partitions
 block
To:     Yury Kamenev <damtev@yandex-team.ru>, mst@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com, axboe@kernel.dk,
        hch@lst.de, cand@gmx.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210715094707.19997-1-damtev@yandex-team.ru>
 <20210715094707.19997-2-damtev@yandex-team.ru>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <eada95b1-a1fb-3877-9b04-ac2bd16f5fe0@redhat.com>
Date:   Fri, 16 Jul 2021 10:57:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715094707.19997-2-damtev@yandex-team.ru>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/7/15 ÏÂÎç5:47, Yury Kamenev Ð´µÀ:
> Signed-off-by: Yury Kamenev <damtev@yandex-team.ru>


I think we need a better commit log here.

And why do we need a Kconfig for this? If there's a good reason, I guess 
the right approach is to invent something in the virtio core (via /sys)?

Thanks


> ---
>   .../admin-guide/kernel-parameters.txt         |  3 +++
>   drivers/block/Kconfig                         |  7 +++++
>   drivers/block/virtio_blk.c                    | 26 +++++++++++++++++++
>   include/uapi/linux/virtio_blk.h               |  2 ++
>   4 files changed, 38 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bdb22006f713..941bdaf5c167 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6076,6 +6076,9 @@
>   			brightness level.
>   			default: 1
>
> +	virtiopartscan
> +		Enable virtio block device partition scanning omission based on VIRTIO_BLK_F_NO_PART_SCAN feature flag.
> +
>   	virtio_mmio.device=
>   			[VMMIO] Memory mapped virtio (platform) device.
>
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 63056cfd4b62..69ecd3fd7037 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -399,6 +399,13 @@ config VIRTIO_BLK
>   	  This is the virtual block driver for virtio.  It can be used with
>             QEMU based VMMs (like KVM or Xen).  Say Y or M.
>
> +config VIRTIO_BLK_NO_PART_SCAN
> +	bool "Disable partition scanning for devices with no partitions"
> +	depends on VIRTIO_BLK
> +	help
> +	  Disable partition scanning for devices with no partitions.
> +	  Can reduce the kernel start time for tiny systems like squashfs images.
> +
>   config BLK_DEV_RBD
>   	tristate "Rados block device (RBD)"
>   	depends on INET && BLOCK
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 4b49df2dfd23..479711d3791c 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -692,6 +692,19 @@ static const struct blk_mq_ops virtio_mq_ops = {
>   static unsigned int virtblk_queue_depth;
>   module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
>
> +#ifndef MODULE
> +#ifdef CONFIG_VIRTIO_BLK_NO_PART_SCAN
> +static int partitions_scanning_disable __read_mostly;
> +
> +static int __init partitions_scanning_setup(char *__unused)
> +{
> +	partitions_scanning_disable = 1;
> +	return 1;
> +}
> +__setup("nopartscan", partitions_scanning_setup);
> +#endif
> +#endif
> +
>   static int virtblk_probe(struct virtio_device *vdev)
>   {
>   	struct virtio_blk *vblk;
> @@ -790,6 +803,13 @@ static int virtblk_probe(struct virtio_device *vdev)
>   	vblk->disk->flags |= GENHD_FL_EXT_DEVT;
>   	vblk->index = index;
>
> +#ifdef CONFIG_VIRTIO_BLK_NO_PART_SCAN
> +	if (unlikely(partitions_scanning_disable))
> +		/* disable partitions scanning if it was stated in virtio features*/
> +		if (virtio_has_feature(vdev, VIRTIO_BLK_F_NO_PART_SCAN))
> +			vblk->disk->flags |= GENHD_FL_NO_PART_SCAN;
> +#endif
> +
>   	/* configure queue flush support */
>   	virtblk_update_cache_mode(vdev);
>
> @@ -966,6 +986,9 @@ static unsigned int features_legacy[] = {
>   	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>   	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>   	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> +#ifdef CONFIG_VIRTIO_BLK_NO_PART_SCAN
> +	VIRTIO_BLK_F_NO_PART_SCAN,
> +#endif
>   }
>   ;
>   static unsigned int features[] = {
> @@ -973,6 +996,9 @@ static unsigned int features[] = {
>   	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>   	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>   	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> +#ifdef CONFIG_VIRTIO_BLK_NO_PART_SCAN
> +	VIRTIO_BLK_F_NO_PART_SCAN,
> +#endif
>   };
>
>   static struct virtio_driver virtio_blk = {
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index d888f013d9ff..9b381675342a 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -40,6 +40,7 @@
>   #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
>   #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
>   #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
> +#define VIRTIO_BLK_F_NO_PART_SCAN	16	/* Disable partition scanning */
>
>   /* Legacy feature bits */
>   #ifndef VIRTIO_BLK_NO_LEGACY
> --
> 2.24.3 (Apple Git-128)
>

