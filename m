Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919AD3A05FE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhFHV3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:29:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233064AbhFHV24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623187622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANhdFVJMgOPlVeqKKH+dsmD0siNPfDTKlYNgvOQ5R3o=;
        b=iNtVZs9FUpi1ae3CShJl5CKLiHXeRv1KyAPR8p3JMcnbptJUdGMjsC0h/l6BUHFBuL5G93
        xqVIASxrxcyAs5l1zdZFn+thli19pxBhJx708HhcRah4m07Y+jh885/GVOxO7lYGIt4NVj
        bZd6UJjNvkODVgz45ScA6ViI2whRIVo=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-7IQscKItOImenEfGia_w3A-1; Tue, 08 Jun 2021 17:26:58 -0400
X-MC-Unique: 7IQscKItOImenEfGia_w3A-1
Received: by mail-ot1-f71.google.com with SMTP id e28-20020a9d491c0000b02903daf90867beso10227770otf.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 14:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ANhdFVJMgOPlVeqKKH+dsmD0siNPfDTKlYNgvOQ5R3o=;
        b=B34p7xR5nhvJE8QbShPNF1ucPldb8yAdWJUcIMifYv/HG2szYGPFud63AgOcf7n700
         ZQqMO8K3MwQpGKsvXtHDhm3O9TGYoqBZAYMzX+C56vawYlXQ081HJkesJK6JqT6Qr1DI
         hTepWlIAZ76oBVm2iag1j2/tTSpf10ex3xE5ULbOGe+sMVYj5JoCdx/Or4XLHb2fHB75
         UN/eRGI+fAqU9L31OHJAgEA7Db0aM0uHiMr8LrhwEhgHLeTadLIf7xU1IYLjfQC7NdAX
         r4rFHNoRkpFiKIZKiFusgzDwAore275JhtcwAMz4PGkXmtMx7TXi56kci0c1frjZXoM5
         MiEA==
X-Gm-Message-State: AOAM5316nCOgjT3J0lOgfSXCGAu6zpBhhPj1HhJhWapuf+QEu6zaC/aH
        ivMiITcAlQTje7YpoUV7VqnbzO0OkYgarkuePVFVLxbFRan3Zhvs7cX8usCmP1s6Y/tiKaici/t
        KFdb3f2HY8jpV7LYbGAEPZTsA
X-Received: by 2002:a05:6808:13cb:: with SMTP id d11mr4168936oiw.138.1623187618240;
        Tue, 08 Jun 2021 14:26:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRvvGc6tdMNzZeUwij7tWuvUu215rQbuWwhep+IMzXG4f8s5RDIMcZh3VVPI9xldH1Y0wBIw==
X-Received: by 2002:a05:6808:13cb:: with SMTP id d11mr4168914oiw.138.1623187618064;
        Tue, 08 Jun 2021 14:26:58 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id w8sm2086647otk.16.2021.06.08.14.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 14:26:57 -0700 (PDT)
Date:   Tue, 8 Jun 2021 15:26:56 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     <cohuck@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jgg@nvidia.com>,
        <aviadye@nvidia.com>, <oren@nvidia.com>, <shahafs@nvidia.com>,
        <parav@nvidia.com>, <artemp@nvidia.com>, <kwankhede@nvidia.com>,
        <ACurrid@nvidia.com>, <cjia@nvidia.com>, <yishaih@nvidia.com>,
        <kevin.tian@intel.com>, <hch@infradead.org>, <targupta@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <liulongfang@huawei.com>,
        <yan.y.zhao@intel.com>
Subject: Re: [PATCH 10/11] vfio-pci: introduce vfio_pci_core subsystem
 driver
Message-ID: <20210608152656.5aa4cfa3.alex.williamson@redhat.com>
In-Reply-To: <20210603160809.15845-11-mgurtovoy@nvidia.com>
References: <20210603160809.15845-1-mgurtovoy@nvidia.com>
        <20210603160809.15845-11-mgurtovoy@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 19:08:08 +0300
Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 5e2e1b9a9fd3..384d06661f30 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -config VFIO_PCI
> -	tristate "VFIO support for PCI devices"
> +config VFIO_PCI_CORE
> +	tristate "VFIO core support for PCI devices"
>  	depends on VFIO && PCI && EVENTFD
>  	depends on MMU
>  	select VFIO_VIRQFD
> @@ -11,9 +11,17 @@ config VFIO_PCI
>  
>  	  If you don't know what to do here, say N.
>  
> +config VFIO_PCI
> +	tristate "VFIO support for PCI devices"
> +	depends on VFIO_PCI_CORE
> +	help
> +	  This provides a generic PCI support using the VFIO framework.
> +
> +	  If you don't know what to do here, say N.
> +

I think it's going to generate a lot of user and distro frustration to
hide VFIO_PCI behind a new VFIO_PCI_CORE option.  The core should be a
dependency *selected* by the drivers, not a prerequisite for the
driver.  Thanks,

Alex

