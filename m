Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF85740ACD0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhINLxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232093AbhINLxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631620340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qBY2XNwXX1MA9VLSXKiCQE1n4LcmSBqUdBbPiBpddUA=;
        b=HfZ/XgMhjIa8+zSl/oevZasKQs1OcW4rpNysMpLGvT39tT5hpJfvV5pYUvfdND0W9DA229
        BUi8ZkkDynu4IVCUMpM6VCpOXPor6SpGk6cOCNXazL3qwmDSqgAnKZaQYdCziMkDXZDkWn
        rm8Car2i2ISfbwfeOe90uhUTnfKJR6Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-hL_SWEGjPtyZjSt1kC0QQQ-1; Tue, 14 Sep 2021 07:52:19 -0400
X-MC-Unique: hL_SWEGjPtyZjSt1kC0QQQ-1
Received: by mail-wr1-f70.google.com with SMTP id h5-20020a5d6885000000b0015e21e37523so416594wru.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 04:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qBY2XNwXX1MA9VLSXKiCQE1n4LcmSBqUdBbPiBpddUA=;
        b=53God0hU7OVcXSLNcBZae9e0ZlEukB2O3EKz36Kh3blfklgn8WQFjQvbcQM2AOfl7Y
         4Z6JuBjroGO+nhAadNKGob0SlMN4tAyONXL0TJ/K90fb5cS70+M36np+TsJJ+zhWYoPH
         QmLb/leo7VzMu6614Py6fgh3QSZPjyNvlMSvqRqPIYibvOR2kCo/2dXa2i3a35/B4ugs
         uZZoW1Ziz5ScQ7C0syTx2atDmW+dqKBX+K+HSq7fYI8j0ezJlPyW9/ZSnqLMlJ7hwgIm
         Nee9PijAgn4sl9QRIydobnBR2u3H9dwcdcvGugC0WXThfJZAqkIVhp+FLQeDP5ojreyE
         GUsA==
X-Gm-Message-State: AOAM531yajsKfNJ++BxGuXPmhcdcyYXjiNM1DmhkFPBSKXE2/8nQuP+A
        yDu0Q/1TrCrzLbLw2YLD2LY7djta9Qykt08JRXx0tGX3hSCOG//toknyWVwtdh8niRMsxzpyrN8
        4oIv+7wvthA0kmBpJ11/tbrO2
X-Received: by 2002:a05:600c:a05:: with SMTP id z5mr1723611wmp.73.1631620338108;
        Tue, 14 Sep 2021 04:52:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiYlZHtMLRjzoVegHvs1Jq46SZ36SDV0xzz4EafT+Ga/oyoJS+AncArM4zwCppyvnbWFnkYg==
X-Received: by 2002:a05:600c:a05:: with SMTP id z5mr1723592wmp.73.1631620337926;
        Tue, 14 Sep 2021 04:52:17 -0700 (PDT)
Received: from redhat.com ([2.55.151.134])
        by smtp.gmail.com with ESMTPSA id l21sm922488wmh.31.2021.09.14.04.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 04:52:17 -0700 (PDT)
Date:   Tue, 14 Sep 2021 07:52:13 -0400
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
Message-ID: <20210914075046-mutt-send-email-mst@kernel.org>
References: <20210902160919.25683-1-david@redhat.com>
 <20210902160919.25683-4-david@redhat.com>
 <20210903025630-mutt-send-email-mst@kernel.org>
 <e5344ed1-6aaf-9e0a-a32d-f7cf69fe5a34@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5344ed1-6aaf-9e0a-a32d-f7cf69fe5a34@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 11:45:25AM +0200, David Hildenbrand wrote:
> On 03.09.21 09:02, Michael S. Tsirkin wrote:
> > On Thu, Sep 02, 2021 at 06:09:19PM +0200, David Hildenbrand wrote:
> > > We don't want user space to be able to map virtio-mem device memory
> > > directly (e.g., via /dev/mem) in order to have guarantees that in a sane
> > > setup we'll never accidentially access unplugged memory within the
> > > device-managed region of a virtio-mem device, just as required by the
> > > virtio-spec.
> > > 
> > > As soon as the virtio-mem driver is loaded, the device region is visible
> > > in /proc/iomem via the parent device region. From that point on user space
> > > is aware of the device region and we want to disallow mapping anything
> > > inside that region (where we will dynamically (un)plug memory) until
> > > the driver has been unloaded cleanly and e.g., another driver might take
> > > over.
> > > 
> > > By creating our parent IORESOURCE_SYSTEM_RAM resource with
> > > IORESOURCE_EXCLUSIVE, we will disallow any /dev/mem access to our
> > > device region until the driver was unloaded cleanly and removed the
> > > parent region. This will work even though only some memory blocks are
> > > actually currently added to Linux and appear as busy in the resource tree.
> > > 
> > > So access to the region from user space is only possible
> > > a) if we don't load the virtio-mem driver.
> > > b) after unloading the virtio-mem driver cleanly.
> > > 
> > > Don't build virtio-mem if access to /dev/mem cannot be restricticted --
> > > if we have CONFIG_DEVMEM=y but CONFIG_STRICT_DEVMEM is not set.
> > > 
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > 
> > 
> > > ---
> > >   drivers/virtio/Kconfig      | 1 +
> > >   drivers/virtio/virtio_mem.c | 4 +++-
> > >   2 files changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > > index ce1b3f6ec325..ff80cd03f1d1 100644
> > > --- a/drivers/virtio/Kconfig
> > > +++ b/drivers/virtio/Kconfig
> > > @@ -101,6 +101,7 @@ config VIRTIO_MEM
> > >   	depends on MEMORY_HOTPLUG_SPARSE
> > >   	depends on MEMORY_HOTREMOVE
> > >   	depends on CONTIG_ALLOC
> > > +	depends on !DEVMEM || STRICT_DEVMEM
> > >   	help
> > >   	 This driver provides access to virtio-mem paravirtualized memory
> > >   	 devices, allowing to hotplug and hotunplug memory.
> > 
> > It would be nicer if there was a symbol in the MEMORY_ namespace
> > we can depend on exported by mm and depending on !DEVMEM ||
> > STRICT_DEVMEM.
> > 
> > E.g.
> > 
> > config MEMORY_EXCLUSIVE
> >          def_bool y
> >          depends on !DEVMEM || STRICT_DEVMEM
> > 
> > and then in virtio
> > 	depends on MEMORY_EXCLUSIVE
> > 
> > 
> 
> Yes, but I'm not able to come up with an expressive name. MEMORY_EXCLUSIVE
> can be highly misleading ...


I mean ... it enables IORESOURCE_EXCLUSIVE ... but ok ...
MEMORY_EXCLUSIVE_KERNEL_MAP ?

> 
> > the virtio change itself is ok though:
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Thanks!
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb

