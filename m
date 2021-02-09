Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABBF315172
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhBIOWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:22:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229787AbhBIOWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612880446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=msdGZ/GSn00bg7qXqixtwijL96d2VWwgn9vqBSkBJdQ=;
        b=S473tGfjFNoIZMfUCWFySCGuMAGD8Pff9cpy79sGvJ9VNJs9ezbclazGBpoVND01OXDGcY
        QqP3E3tD+7q4QfOlDT7NL53gvK9hpE9U7ccf6STdCrrr6R5byL33MfZmD9edKlOIzkSSNU
        0KH1/6uVzUoSvzVJn3RDK4DwX50TsVM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-JObxMdZLPKuL2qVxm14jYA-1; Tue, 09 Feb 2021 09:20:44 -0500
X-MC-Unique: JObxMdZLPKuL2qVxm14jYA-1
Received: by mail-wm1-f71.google.com with SMTP id t128so2604623wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 06:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=msdGZ/GSn00bg7qXqixtwijL96d2VWwgn9vqBSkBJdQ=;
        b=cd1c3i6Z0xc2RDRri2bWPkLdA+vg74jrE520cKTQor2vk/dQ9FECSo6bI3UzUNyPN9
         faXCZXKxhcRdCvZJJJ6gseDZb8mFJFVbCzvTq52saNrBtlmdY+uV+fKTKV5sx1bO3IKl
         fkDgso2zAo+B8SwfrYUWu6j4gz3EjIC+hBQahAcsF8/EX/pr9KFyYqZZntaOMME1+ypT
         3P5s+lv20BRRGDlVSgDWsiNupB6AsMLDB2hh4ThI8mCU6jwPRTz0I/RU4f5iRbsiJQj+
         lJzT4oOFRUn9GaZY02TqJMkftVfKBcW/H1oRnTblc8nEtxnGRl2cZvlqTqM9vp+SOLOw
         c0Ag==
X-Gm-Message-State: AOAM530dcx98RkWTAiKA0wHQoEMFfBYn38KBxoYrHNLpo7rEpHPdAJYb
        Y9FA91WWx+BLfitL66E4O+GXyaWh/O5+Ur8FvB1uCQccOhu02W1z3nRsXsMoSWNjP8NQGY0cblx
        q7H1fGWeb22K9sQFl3CN2m2CO
X-Received: by 2002:a7b:c355:: with SMTP id l21mr3758437wmj.61.1612880443125;
        Tue, 09 Feb 2021 06:20:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyaCT+gLx+tOq8mMUWWrYDUDuZb44tkVMPE/QR2dkUVC06DHQp37dvlkoIz58MzQlsigTFJ7g==
X-Received: by 2002:a7b:c355:: with SMTP id l21mr3758427wmj.61.1612880442958;
        Tue, 09 Feb 2021 06:20:42 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id i7sm37506967wru.49.2021.02.09.06.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 06:20:41 -0800 (PST)
Date:   Tue, 9 Feb 2021 09:20:36 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        lulu@redhat.com, sgarzare@redhat.com, rdunlap@infradead.org
Subject: Re: [PATCH V3 16/19] virtio-pci: introduce modern device module
Message-ID: <20210209091916-mutt-send-email-mst@kernel.org>
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-17-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104065503.199631-17-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 02:55:00PM +0800, Jason Wang wrote:
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/Kconfig                 |  10 +-
>  drivers/virtio/Makefile                |   1 +
>  drivers/virtio/virtio_pci_common.h     |  27 +-
>  drivers/virtio/virtio_pci_modern.c     | 617 -------------------------
>  drivers/virtio/virtio_pci_modern_dev.c | 599 ++++++++++++++++++++++++
>  include/linux/virtio_pci_modern.h      | 111 +++++
>  6 files changed, 721 insertions(+), 644 deletions(-)
>  create mode 100644 drivers/virtio/virtio_pci_modern_dev.c
>  create mode 100644 include/linux/virtio_pci_modern.h
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 7b41130d3f35..6b9b81f4b8c2 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -12,6 +12,14 @@ config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>  	  This option is selected if the architecture may need to enforce
>  	  VIRTIO_F_ACCESS_PLATFORM
>  
> +config VIRTIO_PCI_MODERN
> +	tristate "Modern Virtio PCI Device"
> +	depends on PCI
> +	help
> +	  Modern PCI device implementation. This module implements the
> +	  basic probe and control for devices which are based on modern
> +	  PCI device with possible vendor specific extensions.
> +
>  menuconfig VIRTIO_MENU
>  	bool "Virtio drivers"
>  	default y
> @@ -20,7 +28,7 @@ if VIRTIO_MENU
>  
>  config VIRTIO_PCI
>  	tristate "PCI driver for virtio devices"
> -	depends on PCI
> +	depends on VIRTIO_PCI_MODERN
>  	select VIRTIO
>  	help
>  	  This driver provides support for virtio based paravirtual device

Looks like VIRTIO_PCI_MODERN is actually just a library that
virtio pci uses. Is that right? In that case just select it
automatically, let's not make users enable it manually.

-- 
MST

