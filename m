Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153733B3C65
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 07:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhFYF76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 01:59:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60720 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230097AbhFYF74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 01:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624600655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=job0R158zZW24Fu1rVr8pekZniCKjXlCIztMZWCfYjM=;
        b=ZZc5Oq/iDXPEepOptrfoSZjW5HkYt+den5JiB51LZlmXOEajWTw8OmZ/794PffPUovtCGA
        pC9sK9MlzASgKNQuTXvILvXdY8oUzF/F4e78t8y70fxgq41v0zNtPAT15o31KuBHG4MD0Q
        a0q/biXlcCKz1bvyZlX3NLY4c2w4VPw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-PJnZtdq-OKiK8bCaegX--A-1; Fri, 25 Jun 2021 01:57:25 -0400
X-MC-Unique: PJnZtdq-OKiK8bCaegX--A-1
Received: by mail-wr1-f69.google.com with SMTP id w10-20020a5d608a0000b0290124b2be1b59so1447862wrt.20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 22:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=job0R158zZW24Fu1rVr8pekZniCKjXlCIztMZWCfYjM=;
        b=c96/z3D2L/4zpS2H02OUuICvRf4i9UJv4KTP3PTJ4f1O+pjW2cQoP6ZHQh1Le2fTte
         ZQsxn/1lII0MGt6sqDTRZUHcW4wRz/THhJJNIZsXlx+/EVVeFbZjYJ8KOcGtz2RGvUDV
         mmvs9N4T/txoxQN4/g2RlcK/u/WgKg7qfXYxzmHwaW2vqTvesNyfdkyy+at1SobC1G98
         Cy300yWj0m1wWjrvF5hMGng0y9257P1UmS7Cp+jxyynctDSZLESEVkuIw3QouzktEb9c
         EhP6iv8Yj8mGEeSfLeO/QRC8MinNua4lQngx/fATR4vX7bWrHZlDeADxVn5YV5hrRM9i
         VCrA==
X-Gm-Message-State: AOAM5300VYmvVnDLQZ6BvDB0VKKkYdZQ71S/UggfjqHfBjLJnX4mLX30
        4V0Xlv1jHjVlUMFPSgmIkSUSTfN/R6a4pbbdXXRTQIz0OZ0L6lU2K5QUFdDgo39Ds6C+Dics0Yx
        nyTNlR+vBiGZgJAYk3nZljt+i
X-Received: by 2002:a05:600c:4642:: with SMTP id n2mr8435423wmo.101.1624600643796;
        Thu, 24 Jun 2021 22:57:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgmXsAR3ZiLjKLe3+/RBI5YxbHAUyt8t4V7/i8IJY9rFS8hM9ANROdRfY9lXYdfkVtNI8qDg==
X-Received: by 2002:a05:600c:4642:: with SMTP id n2mr8435396wmo.101.1624600643470;
        Thu, 24 Jun 2021 22:57:23 -0700 (PDT)
Received: from redhat.com ([77.124.79.210])
        by smtp.gmail.com with ESMTPSA id u9sm3474653wmq.41.2021.06.24.22.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 22:57:22 -0700 (PDT)
Date:   Fri, 25 Jun 2021 01:57:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        alexander.duyck@gmail.com, david@redhat.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH v4 4/4] virtio_balloon: Specify page reporting order if
 needed
Message-ID: <20210625015629-mutt-send-email-mst@kernel.org>
References: <20210625014710.42954-1-gshan@redhat.com>
 <20210625014710.42954-5-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625014710.42954-5-gshan@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 09:47:10AM +0800, Gavin Shan wrote:
> The page reporting won't be triggered if the freeing page can't come
> up with a free area, whose size is equal or bigger than the threshold
> (page reporting order). The default page reporting order, equal to
> @pageblock_order, is too huge on some architectures to trigger page
> reporting. One example is ARM64 when 64KB base page size is used.
> 
>       PAGE_SIZE:          64KB
>       pageblock_order:    13       (512MB)
>       MAX_ORDER:          14
> 
> This specifies the page reporting order to 5 (2MB) for this specific
> case so that page reporting can be triggered.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> ---
>  drivers/virtio/virtio_balloon.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 510e9318854d..47dce91f788c 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -993,6 +993,23 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  			goto out_unregister_oom;
>  		}
>  
> +		/*
> +		 * The default page reporting order is @pageblock_order, which
> +		 * corresponds to 512MB in size on ARM64 when 64KB base page
> +		 * size is used. The page reporting won't be triggered if the
> +		 * freeing page can't come up with a free area like that huge.
> +		 * So we specify the page reporting order to 5, corresponding
> +		 * to 2MB. It helps to avoid THP splitting if 4KB base page
> +		 * size is used by host.
> +		 *
> +		 * Ideally, the page reporting order is selected based on the
> +		 * host's base page size. However, it needs more work to report
> +		 * that value. The hard-coded order would be fine currently.
> +		 */
> +#if defined(CONFIG_ARM64) && defined(CONFIG_ARM64_64K_PAGES)
> +		vb->pr_dev_info.order = 5;
> +#endif
> +

I was hoping we can get rid of the hacks in virtio with the new
parameter and logic in mm core. Why not?

>  		err = page_reporting_register(&vb->pr_dev_info);
>  		if (err)
>  			goto out_unregister_oom;
> -- 
> 2.23.0

