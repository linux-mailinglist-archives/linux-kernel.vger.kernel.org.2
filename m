Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380473FFACF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 09:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347524AbhICHDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 03:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347087AbhICHDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 03:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630652533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=07FgH7wT67po2w8bQGIw93/1x6mvSaBB2yNe5PGszL8=;
        b=KfzTMChXoFsHlKFnQ3QLnB0Z15byHWp29rk0HWfCkQtgDev6rd355pPGfguT9/V4CHN2Kf
        /dJJKbXgvbB6gNA7glbJwbRRBLOsg3zc1l2dgw06z2/Hb9ExUs+r9RZP36J4kzooe+Uxjm
        jmckaga8qT+E/upbjRNLA8hzvnwYpt4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-5IwTppg8MqCdmhQrBaTU7A-1; Fri, 03 Sep 2021 03:02:11 -0400
X-MC-Unique: 5IwTppg8MqCdmhQrBaTU7A-1
Received: by mail-wr1-f69.google.com with SMTP id 102-20020adf82ef000000b001576e345169so1258182wrc.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 00:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=07FgH7wT67po2w8bQGIw93/1x6mvSaBB2yNe5PGszL8=;
        b=KfU+2yuhPjwkPpgs53BmlzUno1T2WIiw9SF2qz7hwWEZ5ji4I44BM/EuGsijlhyqjy
         9o0kHbQK+OTF9HIgVSypGcgScGdO/3K2ndSxzoHFEEvMSqhkz8qlkQ6kSvv8XSE9RDA2
         yqzjPJEtIfE1dMNCXWtJIbrchKHyZ/NKKZZvpmSreOe4lUJdfEXIfvb997JYvLG39zqe
         fQDOiWumwcdYx7Ug+f+3yO9HX7vLnWhU1sbPb+hrGWZpFAw63unhABk7dcElqAHTiYkV
         rjnW5JO4p7JpAnYmDwrlkBq4hlmNnQj79smp3oY0huimDnLap3wH7GOqzO+9G7/8Ru8q
         jbsw==
X-Gm-Message-State: AOAM532UzRSb3CqJfJXpcxoFQPwWNosSVqG9HR9so1/Z3kftxpj7/rku
        UHUY5D8Fe3sBjLpKDRMMGDXovAYJzmWr8qkLvjS/0F81ki1LlyLeD4D08gyIXmt9v1RH+Y4Wy0X
        gO0gY0F5k441ux/OvOdZ/5VOS
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr2223510wrv.402.1630652530706;
        Fri, 03 Sep 2021 00:02:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydsWfnmMs9uEFqCpYm22oyb0W/h3tDknscsNUxRfbHoKaj/53aSdqrSr8X//PvyYQLUFL9pw==
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr2223485wrv.402.1630652530498;
        Fri, 03 Sep 2021 00:02:10 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207f:7f47:ccd3:7600:6a2d:c5a])
        by smtp.gmail.com with ESMTPSA id x9sm3336534wmi.30.2021.09.03.00.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 00:02:08 -0700 (PDT)
Date:   Fri, 3 Sep 2021 03:02:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Wang <jasowang@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 3/3] virtio-mem: disallow mapping virtio-mem memory
 via /dev/mem
Message-ID: <20210903025630-mutt-send-email-mst@kernel.org>
References: <20210902160919.25683-1-david@redhat.com>
 <20210902160919.25683-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902160919.25683-4-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 06:09:19PM +0200, David Hildenbrand wrote:
> We don't want user space to be able to map virtio-mem device memory
> directly (e.g., via /dev/mem) in order to have guarantees that in a sane
> setup we'll never accidentially access unplugged memory within the
> device-managed region of a virtio-mem device, just as required by the
> virtio-spec.
> 
> As soon as the virtio-mem driver is loaded, the device region is visible
> in /proc/iomem via the parent device region. From that point on user space
> is aware of the device region and we want to disallow mapping anything
> inside that region (where we will dynamically (un)plug memory) until
> the driver has been unloaded cleanly and e.g., another driver might take
> over.
> 
> By creating our parent IORESOURCE_SYSTEM_RAM resource with
> IORESOURCE_EXCLUSIVE, we will disallow any /dev/mem access to our
> device region until the driver was unloaded cleanly and removed the
> parent region. This will work even though only some memory blocks are
> actually currently added to Linux and appear as busy in the resource tree.
> 
> So access to the region from user space is only possible
> a) if we don't load the virtio-mem driver.
> b) after unloading the virtio-mem driver cleanly.
> 
> Don't build virtio-mem if access to /dev/mem cannot be restricticted --
> if we have CONFIG_DEVMEM=y but CONFIG_STRICT_DEVMEM is not set.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>


> ---
>  drivers/virtio/Kconfig      | 1 +
>  drivers/virtio/virtio_mem.c | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index ce1b3f6ec325..ff80cd03f1d1 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -101,6 +101,7 @@ config VIRTIO_MEM
>  	depends on MEMORY_HOTPLUG_SPARSE
>  	depends on MEMORY_HOTREMOVE
>  	depends on CONTIG_ALLOC
> +	depends on !DEVMEM || STRICT_DEVMEM
>  	help
>  	 This driver provides access to virtio-mem paravirtualized memory
>  	 devices, allowing to hotplug and hotunplug memory.

It would be nicer if there was a symbol in the MEMORY_ namespace
we can depend on exported by mm and depending on !DEVMEM ||
STRICT_DEVMEM.

E.g.

config MEMORY_EXCLUSIVE
        def_bool y
        depends on !DEVMEM || STRICT_DEVMEM

and then in virtio
	depends on MEMORY_EXCLUSIVE


the virtio change itself is ok though:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

for merging through -mm.

> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index b91bc810a87e..c2d93492cf0f 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2523,8 +2523,10 @@ static int virtio_mem_create_resource(struct virtio_mem *vm)
>  	if (!name)
>  		return -ENOMEM;
>  
> +	/* Disallow mapping device memory via /dev/mem completely. */
>  	vm->parent_resource = __request_mem_region(vm->addr, vm->region_size,
> -						   name, IORESOURCE_SYSTEM_RAM);
> +						   name, IORESOURCE_SYSTEM_RAM |
> +						   IORESOURCE_EXCLUSIVE);
>  	if (!vm->parent_resource) {
>  		kfree(name);
>  		dev_warn(&vm->vdev->dev, "could not reserve device region\n");
> -- 
> 2.31.1

