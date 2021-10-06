Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E66423B1E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 11:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbhJFJ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 05:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhJFJ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 05:57:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3206C06174E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 02:55:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t2so7025497wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 02:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=53P0MWqxHQf69YIQTg7++jhQaclFdr/J2LBfnT7Jxag=;
        b=SyqmL0KIwaYYoAnvxjN3cUgFEI9q0HKr8Ar/pWsMkn9kMDGzeCkwbxNr5N5Kc/UWS7
         qniK5NqdpFiEqx+FSrnniWhRiB36WlBCYKNtzy05dCMjzUyTW9QFNaEZ/f4z9YXH30MO
         IEn+GlPNPbZiWY/3MJ/uJXvLCXC/DyO5mBNQTIQJy/+FRS6AC8YCO7GzAia1tIaS52In
         ZmFzmtuOnaCJYRjB58b+zDAHwub8BWctoYeAeSgPq+1yuZ1lQzB34HrNc4dGrF/+kr4F
         r46OH/pMw/2AQQASBIOLJueH5xJxURZBBbE0SHmAeD1lDV/X9+qdhjVkuRQXODpRNfTK
         jVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=53P0MWqxHQf69YIQTg7++jhQaclFdr/J2LBfnT7Jxag=;
        b=nHyvIhHWNvtH5nyzSd6E1j4wIghg6Q4kcedtQ5CVJIE+cZ50RhzBICNPAa2TFo2l66
         yuca45WrqDa9IXqBc9Gsre5qSaVRjIaU/+o8wV2n0uWzNWDZsof2W1WF889eU60BhgvP
         +0XCNekh5S0mPNgQB1sAWzm6+FvD3171+oyn/zwz55gi8CXh5Pxbesvf7W8A7k6ubdiV
         h83Ykl0ABj5gwb8uq9SI0LxQi7oXsrckD2HcSjs/P/1e7LkXpWfywL32z63/wzSLHZ7/
         /jdWY34lRSappJ4aPJn1qkgQ3b1yZUpqwF3XQnBFZ2XMYmr4eh8Q188IBmAoFoIPQEGw
         49Mw==
X-Gm-Message-State: AOAM531h0XMvkfhUCY5/q0tsxUByOPQgAVEVkKnDdw1AMdcu6cYZlYdJ
        LyiXvSH+MtNxV5jvpruKW9eKUw==
X-Google-Smtp-Source: ABdhPJzxdeXU89q22gyHmthoWcnGdg9zFvCS0EtqufEuzVaX6IYosj6/AmW+M3t0tXGZdbu/vTLWjg==
X-Received: by 2002:a1c:f402:: with SMTP id z2mr8775367wma.53.1633514137346;
        Wed, 06 Oct 2021 02:55:37 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id o6sm378418wri.49.2021.10.06.02.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:55:36 -0700 (PDT)
Date:   Wed, 6 Oct 2021 10:55:14 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Vivek Kumar Gautam <vivek.gautam@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        Lorenzo.Pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFC v1 10/11] uapi/virtio-iommu: Add a new request type
 to send page response
Message-ID: <YV1ygu5URvuHB4qb@myrica>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-11-vivek.gautam@arm.com>
 <YUoFSrAK2gi3GWp/@myrica>
 <d40ea85b-3612-10b3-0add-40d07e6d9ca5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d40ea85b-3612-10b3-0add-40d07e6d9ca5@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 02:54:05PM +0530, Vivek Kumar Gautam wrote:
> > > +struct virtio_iommu_req_page_resp {
> > > +	struct virtio_iommu_req_head		head;
> > > +	__le32					domain;
> > 
> > I don't think we need this field, since the fault report doesn't come with
> > a domain.
> 
> But here we are sending the response which would be consumed by the vfio
> ultimately. In kvmtool, I am consuming this "virtio_iommu_req_page_resp"
> request in the virtio/iommu driver, extracting the domain from it, and using
> that to call the respective "page_response" ops from "vfio_iommu_ops" in the
> vfio/core driver.
> 
> Is this incorrect way of passing on the page-response back to the host
> kernel?

That works for the host userspace-kernel interface because the device is
always attached to a VFIO container.

For virtio-iommu the domain info is redundant. The endpoint information
needs to be kept through the whole response path in order to target the
right endpoint in the end. In addition the guest could enable PRI without
attaching the endpoint to a domain, or fail to disable PRI before
detaching the endpoint. Sure it's weird, but the host can still inject the
recoverable page fault in this case, and the guest answers with "invalid"
status but no domain. We could mandate domains for recoverable faults but
that forces a synchronization against attach/detach and I think it
needlessly deviates from other IOMMUs.

Thanks,
Jean
