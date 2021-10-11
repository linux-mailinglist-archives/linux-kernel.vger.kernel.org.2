Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6900428981
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 11:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhJKJTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbhJKJS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:18:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA3BC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 02:16:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m22so54030526wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 02:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0nkxjPYEpK6G/BSPxshK+If3Vx5Dign77+8NPOgdp5A=;
        b=o5bhT6O7zjOThtxY/SJmo4tsUFG2/zdzUm67PXqH2uM3Esme6jlzv21/ETV6z4c7RR
         wzk8ZM9TcGX+XY6xe2WX3EPIG5a8uot5ytWGlgBDE+cXGvtHArsho3kAovfIYHDvBBMT
         EmqoNKrLNr5HvSpSfSUoAD+YZa/+XjXLE7bIok+S+QqWx699qRA/778xoMcmdT8TNzQi
         9+Ed+xbGf0D/DcsbK7tM/jj8umMxvEla2ovIJULkjMPNVZ9uo1HYBO0KieMZguX13pfQ
         xNVC1AxlTATx4mu/mfVe6OYfPdJ3kiaOfm6cOUOakTMFchkCtVp7AKjIxMPCOlagfxXg
         7LWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0nkxjPYEpK6G/BSPxshK+If3Vx5Dign77+8NPOgdp5A=;
        b=Tvsubryrf1RQIF8JoQwKYi2Kx7LOXK7JsoBA/PtUgZmzte4VkfDluoE5LXeXpjcqK8
         u9njeLtbnNza9o2YyP8RD8HfN0EZxdoer0ouGNVTV0aquEReodrErm33NQyWZFqLIUjv
         +8049z6Tn+lXF0JyGUTxHp4eyuCC6lEf0NrVxi2r93qb+gC+SikviXcsfQtxqlBdTxdo
         kpkYw+SIoUEEACkjGUmUYmPJG4jgsYZxgTf3AF4yxujqP7ZGGhaFrmcxpdqbdtns4bVY
         sBYMKQj0l1FuV99mDQp9HGQR27gZG/VhK/p3o1EAMlnojIA+116gHHNZeuO7FL7YuB0T
         GVSQ==
X-Gm-Message-State: AOAM530pDqpJ5hPguNEBdAgHDOm8hDydzgm/vhFPpFduM3yx8W9uAxcp
        jY3ta9wgTfqK81gDrvIN7SyHiw==
X-Google-Smtp-Source: ABdhPJzmZPpxlzZgyZ5KgwS2WYv6prD2WVEkkWH0I0HXdlYIksxaPY0vrb+dREOxa4LLg5+rfZGlMQ==
X-Received: by 2002:adf:bb8d:: with SMTP id q13mr23299307wrg.327.1633943814314;
        Mon, 11 Oct 2021 02:16:54 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id v185sm15278013wme.35.2021.10.11.02.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 02:16:53 -0700 (PDT)
Date:   Mon, 11 Oct 2021 10:16:32 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Vivek Gautam <vivek.gautam@arm.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>, mst@redhat.com,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC v1 03/11] iommu/virtio: Handle incoming page faults
Message-ID: <YWQA8JLXfmQ4DMXv@myrica>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-4-vivek.gautam@arm.com>
 <YUoCTV6WYxxE10qj@myrica>
 <CAFp+6iEM7K8YOnQ4vSNoM+HuHQ-7pr=G3aui-77dGipyJ0+RjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFp+6iEM7K8YOnQ4vSNoM+HuHQ-7pr=G3aui-77dGipyJ0+RjQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On Mon, Oct 11, 2021 at 01:41:15PM +0530, Vivek Gautam wrote:
> > > +     list_for_each_entry(ep, &viommu->endpoints, list) {
> > > +             if (ep->eid == endpoint) {
> > > +                     vdev = ep->vdev;
> 
> I have a question here though -
> Is endpoint-ID unique across all the endpoints available per 'viommu_dev' or
> per 'viommu_domain'?
> If it is per 'viommu_domain' then the above list is also incorrect.
> As you pointed to in the patch [1] -
> [PATCH RFC v1 02/11] iommu/virtio: Maintain a list of endpoints served
> by viommu_dev
> I am planning to add endpoint ID into a static global xarray in
> viommu_probe_device() as below:
> 
>         vdev_for_each_id(i, eid, vdev) {
>                 ret = xa_insert(&viommu_ep_ids, eid, vdev, GFP_KERNEL);
>                 if (ret)
>                         goto err_free_dev;
>         }
> 
> and replace the above list traversal as below:
> 
>                 xa_lock_irqsave(&viommu_ep_ids, flags);
>                 xa_for_each(&viommu_ep_ids, eid, vdev) {
>                         if (eid == endpoint) {
>                                 ret =
> iommu_report_device_fault(vdev->dev, &fault_evt);
>                                 if (ret)
>                                         dev_err(vdev->dev, "Couldn't
> handle page request\n");
>                         }
>                 }
>                 xa_unlock_irqrestore(&viommu_ep_ids, flags);
> 
> But using a global xarray would also be incorrect if the endpointsID are global
> across 'viommu_domain'.
> 
> I need to find the correct 'viommu_endpoint' to call iommu_report_device_fault()
> with the correct device.

The endpoint IDs are only unique across viommu_dev, so a global xarray
wouldn't work but one in viommu_dev would. In vdomain it doesn't work
either because we can't get to the domain from the fault handler without
first finding the endpoint

Thanks,
Jean

