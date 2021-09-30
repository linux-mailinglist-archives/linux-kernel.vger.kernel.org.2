Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F4F41D842
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 13:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350253AbhI3LB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 07:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38180 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350244AbhI3LB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 07:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632999585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b7LaHsUMLVR6EA21h5UrbLpMuCN6Sr+ds/6TKiPoY6M=;
        b=FoWmsJvsC6XSdx6XXPn2rHxwNNmAatuEGh6Xut40OEt8SWUGRM6sfGwBWtm5C+unLQjRoQ
        4hLa6zv7XxJNnPBgG1wPL/yCC8RjfrPfrP24+iBC2R9vgzElX5xZNZFDZfSpvKU6Fnjne3
        7qePn6hsf+Hz3pm6Hocw1zGti90ygLg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-oPww-ZYGOW2FyF-sqwFCJQ-1; Thu, 30 Sep 2021 06:59:43 -0400
X-MC-Unique: oPww-ZYGOW2FyF-sqwFCJQ-1
Received: by mail-ed1-f72.google.com with SMTP id b7-20020a50e787000000b003d59cb1a923so5858317edn.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 03:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b7LaHsUMLVR6EA21h5UrbLpMuCN6Sr+ds/6TKiPoY6M=;
        b=mR1siUfHgK/T52sReFV+PmkekyfTyGIJA7aK5kBLPXfOg3qE93TK8VDjptSv5wtupS
         t1q44T/dRP10Gj7SjtvrZ5ZRLYp40cYvM7MQMYwaxj+URHOjWpDnGJRP3IajHaLzLPPq
         W5E8s9bxT2qEKPB1cO8Tby5ic6bynh/C3Pex8S+oNtwiVhaf9+vWMT3cp0xt0OqF1mkz
         ufBz9tO65is/5peaomkrQUhoplDFjalT2izlkNWkeafZf0UQEXQgOp9iqfh1b6y2iI6C
         spAuSyx3EJVbGHVM3k0NC32Nah7ypYzguqI5DNCBmE2mCPosrY9MNSPNU9SFXAqZSmtK
         JsCw==
X-Gm-Message-State: AOAM533XF6N7W9G/WbwPHZ8uQd5j0rwG9R69Xg9zl2CII3k3HmDcRWT9
        VGJ9SRb2Mvb8XLPTdLfzUDBKll5ULMKtc+UTgqkjUbtQ1yLp4YWIwm+zjH/p0xaVPZJcq77NDJN
        MZvhpLUAu0yizL+jbWO3Gs7qJ
X-Received: by 2002:a17:906:3f95:: with SMTP id b21mr5678166ejj.368.1632999582386;
        Thu, 30 Sep 2021 03:59:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2i5HxRxp9m+CxrlD+fPbT58I6Y4N17yAXQUmiEQobb4UJZApVX/orNJjFHXXlnrsZIHnlVQ==
X-Received: by 2002:a17:906:3f95:: with SMTP id b21mr5678143ejj.368.1632999582132;
        Thu, 30 Sep 2021 03:59:42 -0700 (PDT)
Received: from redhat.com ([2.55.134.220])
        by smtp.gmail.com with ESMTPSA id w26sm1254203edu.59.2021.09.30.03.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 03:59:40 -0700 (PDT)
Date:   Thu, 30 Sep 2021 06:59:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <20210930065807-mutt-send-email-mst@kernel.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 06:05:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
> While the common case for device-authorization is to skip probe of
> unauthorized devices, some buses may still want to emit a message on
> probe failure (Thunderbolt), or base probe failures on the
> authorization status of a related device like a parent (USB). So add
> an option (has_probe_authorization) in struct bus_type for the bus
> driver to own probe authorization policy.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>



So what e.g. the PCI patch
https://lore.kernel.org/all/CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/
actually proposes is a list of
allowed drivers, not devices. Doing it at the device level
has disadvantages, for example some devices might have a legacy
unsafe driver, or an out of tree driver. It also does not
address drivers that poke at hardware during init.

Accordingly, I think the right thing to do is to skip
driver init for disallowed drivers, not skip probe
for specific devices.


> ---
>  drivers/base/dd.c            | 5 +++++
>  drivers/thunderbolt/domain.c | 1 +
>  drivers/usb/core/driver.c    | 1 +
>  include/linux/device/bus.h   | 4 ++++
>  4 files changed, 11 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 68ea1f949daa..0cd03ac7d3b1 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -544,6 +544,11 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  			   !drv->suppress_bind_attrs;
>  	int ret;
>  
> +	if (!dev->authorized && !dev->bus->has_probe_authorization) {
> +		dev_dbg(dev, "Device is not authorized\n");
> +		return -ENODEV;
> +	}
> +
>  	if (defer_all_probes) {
>  		/*
>  		 * Value of defer_all_probes can be set only by
> diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
> index 3e39686eff14..6de8a366b796 100644
> --- a/drivers/thunderbolt/domain.c
> +++ b/drivers/thunderbolt/domain.c
> @@ -321,6 +321,7 @@ struct bus_type tb_bus_type = {
>  	.probe = tb_service_probe,
>  	.remove = tb_service_remove,
>  	.shutdown = tb_service_shutdown,
> +	.has_probe_authorization = true,
>  };
>  
>  static void tb_domain_release(struct device *dev)
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index fb476665f52d..f57b5a7a90ca 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -2028,4 +2028,5 @@ struct bus_type usb_bus_type = {
>  	.match =	usb_device_match,
>  	.uevent =	usb_uevent,
>  	.need_parent_lock =	true,
> +	.has_probe_authorization = true,
>  };
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index 062777a45a74..571a2f6e7c1d 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -69,6 +69,9 @@ struct fwnode_handle;
>   * @lock_key:	Lock class key for use by the lock validator
>   * @need_parent_lock:	When probing or removing a device on this bus, the
>   *			device core should lock the device's parent.
> + * @has_probe_authorization: Set true to indicate to the driver-core to skip
> + *			     the authorization checks and let bus drivers
> + *			     handle it locally.
>   *
>   * A bus is a channel between the processor and one or more devices. For the
>   * purposes of the device model, all devices are connected via a bus, even if
> @@ -112,6 +115,7 @@ struct bus_type {
>  	struct lock_class_key lock_key;
>  
>  	bool need_parent_lock;
> +	bool has_probe_authorization;
>  };
>  
>  extern int __must_check bus_register(struct bus_type *bus);
> -- 
> 2.25.1

