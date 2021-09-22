Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBEE4152B6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbhIVVZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237802AbhIVVZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632345853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5bSXV/WbyIuvflNI0O5gv8cTQJk2LfpQktDl+auRuYw=;
        b=L37TpUL4UUc5pDnzxM0hNyQd43uOGwTsDunt6IzmJjC1O8gluODtiEv9ThhHbgLvjFm+Cf
        mY7fyXc1+Jkrfoxr940MbgLSbH5Fm1n3jnLtPE1yVgzFk6pAsEtXrjVR139ZzuyPMLieZE
        EbS8E8PbVgTzwUGbSgRDREw2WLr8I5o=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-Xf-q7DGOPpeZiVq3m5MEFw-1; Wed, 22 Sep 2021 17:24:12 -0400
X-MC-Unique: Xf-q7DGOPpeZiVq3m5MEFw-1
Received: by mail-oi1-f198.google.com with SMTP id bh31-20020a056808181f00b0026d71fa022cso2577537oib.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=5bSXV/WbyIuvflNI0O5gv8cTQJk2LfpQktDl+auRuYw=;
        b=I93fz0cOP0Z2KGIB7kbNmphowD0ViWeLE06EftqKB4Q9JdUTxegeqUXxEtvfMNf34U
         LnW/NMv8if100i1mjTq+Ve5kVPqmEaq142lHqCwJR44SeB3atkXZq77j34d4fi1Sdfvv
         DyZuGVfUcB/qEB2kGEzhegydzETxUFpmJw8/BlPWqcuns66PfkfdxIDNay2wdYMFy3c7
         W+FhhW8A/lhw/cQe68EYcob2zemi1y5AlSy2w8HrnwyT5oFhgb3/AF/34GDZEOe8A4De
         2f87YPuYtpgi6SSKyWuwHzabQsLBKPlEKJiIx6BxMBmZSs8dGT1IoRXJitvtuhdIZDrE
         U0sg==
X-Gm-Message-State: AOAM533nr2Ha/nu1qqEpHHRughbEgZKCfdSvyhAszE9CxSTmdlE+RXnA
        vWBBTesQXhrMkcA2O4wXJZ/OGnzuAR2uXb6ZX0M9JfVaRD+6078pwPfBoiHyv4Vy8MLdvY7l+U2
        eS4OfWTu/jgOB9gJ6JuKuXJRy
X-Received: by 2002:a05:6808:2026:: with SMTP id q38mr1062567oiw.15.1632345849576;
        Wed, 22 Sep 2021 14:24:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdoCWR7q3blhAcNoLIpqhCzivqr2u9tYk00GR6mvZvaI93uSxrNhlQY0cnvU77gFLtK4G4DA==
X-Received: by 2002:a05:6808:2026:: with SMTP id q38mr1062549oiw.15.1632345849392;
        Wed, 22 Sep 2021 14:24:09 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id s24sm788936otp.36.2021.09.22.14.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 14:24:09 -0700 (PDT)
Date:   Wed, 22 Sep 2021 15:24:07 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     jgg@nvidia.com, hch@lst.de, jasowang@redhat.com, joro@8bytes.org,
        jean-philippe@linaro.org, kevin.tian@intel.com, parav@mellanox.com,
        lkml@metux.net, pbonzini@redhat.com, lushenming@huawei.com,
        eric.auger@redhat.com, corbet@lwn.net, ashok.raj@intel.com,
        yi.l.liu@linux.intel.com, jun.j.tian@intel.com, hao.wu@intel.com,
        dave.jiang@intel.com, jacob.jun.pan@linux.intel.com,
        kwankhede@nvidia.com, robin.murphy@arm.com, kvm@vger.kernel.org,
        iommu@lists.linux-foundation.org, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        david@gibson.dropbear.id.au, nicolinc@nvidia.com
Subject: Re: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Message-ID: <20210922152407.1bfa6ff7.alex.williamson@redhat.com>
In-Reply-To: <20210919063848.1476776-11-yi.l.liu@intel.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
        <20210919063848.1476776-11-yi.l.liu@intel.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2021 14:38:38 +0800
Liu Yi L <yi.l.liu@intel.com> wrote:

> +struct iommu_device_info {
> +	__u32	argsz;
> +	__u32	flags;
> +#define IOMMU_DEVICE_INFO_ENFORCE_SNOOP	(1 << 0) /* IOMMU enforced snoop */

Is this too PCI specific, or perhaps too much of the mechanism rather
than the result?  ie. should we just indicate if the IOMMU guarantees
coherent DMA?  Thanks,

Alex

> +#define IOMMU_DEVICE_INFO_PGSIZES	(1 << 1) /* supported page sizes */
> +#define IOMMU_DEVICE_INFO_ADDR_WIDTH	(1 << 2) /* addr_wdith field valid */
> +	__u64	dev_cookie;
> +	__u64   pgsize_bitmap;
> +	__u32	addr_width;
> +};
> +
> +#define IOMMU_DEVICE_GET_INFO	_IO(IOMMU_TYPE, IOMMU_BASE + 1)
>  
>  #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
>  #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */

