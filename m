Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C788C32E6A4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCEKq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhCEKqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:46:14 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEB6C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 02:46:13 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id u187so1012663wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 02:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QYcloRQYqoQYeneB9TUL5LWRoYdegubdAgTSoIagbwI=;
        b=l1f+UOwIgVlt828ar7VR0vnkFXh4cRc5C417MtipeTaqlFL9hi+QxQf/kRpJECja4M
         b1VgvXtLOV2KpkBB58JtxLb1r7x39cua/HRZI9XXxtgnnfrWNKNfRFRTEas45fO773zY
         7mJT+4G1Sc+QLV2KsJ35V7xN27sbUzT0B7bZHtGhOQSugEZHgtKaZ8IjZJJY8KECnj/e
         NDxYvkkIxMp0CEG5YQG2rPAaxqFREGuonfLmWbqP9a2as8Ty/JDljoFuQmk5w49uAPkM
         S2mRfInX6LS/JeefCGRhe0mbClkNBjicwLmnvj5wLTXA7t3Uwhc3PfpgO3P27y1rnfyj
         Tanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QYcloRQYqoQYeneB9TUL5LWRoYdegubdAgTSoIagbwI=;
        b=rQBRRzgx1DUxD0lU+uG8wuEe41YFwRYqkXxh6r8zYx7Ew9yDuwNVV1p+lPjKM+rkZR
         X0PajiwC3Fqi9Pu7AJdioVeg01svQMI/5yF21VZKiuqETjtQPnLj90iaRTd1SIAXk9f6
         WfCK0l0nxE9zMkhQl8Udc7pxDN0UnMyOhNsjJYj7BeLbqQLc7iAoHnAUlA3kqr6GEOeX
         jP3qKVZejO55FiO+XizGpOYXBCffP6CGewdJATZPZ5rdYRIDCHaWcJklJHXRJCqCMZdb
         BCZ2FD+WlHB3NkIa9gLeQTopO4FiFJyr/nK2zWkZDlFLd+XJ9gsL5Cek4L7/H4acluQc
         Wa1w==
X-Gm-Message-State: AOAM530gQodbo7z1uki3Zx5OlNSFp0UtWyJJzwhfKCcKlUz8wW0fPyXy
        6HEZECuVswoRt2tFMb6vUkA4Xw==
X-Google-Smtp-Source: ABdhPJyPsHNdCZQ/LIRLnpXLb4jgGrGPiuq6+S8OtX5p5lHKSRBR7HyNChZTX5gDnxX/xPZN/4jXLA==
X-Received: by 2002:a1c:2049:: with SMTP id g70mr8213376wmg.7.1614941172536;
        Fri, 05 Mar 2021 02:46:12 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id o11sm4083278wrq.74.2021.03.05.02.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 02:46:12 -0800 (PST)
Date:   Fri, 5 Mar 2021 11:45:50 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, will@kernel.org, maz@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, alex.williamson@redhat.com,
        tn@semihalf.com, zhukeqian1@huawei.com,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        wangxingang5@huawei.com, jiangkunkun@huawei.com,
        zhangfei.gao@linaro.org, zhangfei.gao@gmail.com,
        vivek.gautam@arm.com, shameerali.kolothum.thodi@huawei.com,
        yuzenghui@huawei.com, nicoleotsuka@gmail.com,
        lushenming@huawei.com, vsethi@nvidia.com
Subject: Re: [PATCH v12 03/13] vfio: VFIO_IOMMU_SET_MSI_BINDING
Message-ID: <YEIL3qmcRfhUoRGt@myrica>
References: <20210223210625.604517-1-eric.auger@redhat.com>
 <20210223210625.604517-4-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223210625.604517-4-eric.auger@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 23, 2021 at 10:06:15PM +0100, Eric Auger wrote:
> This patch adds the VFIO_IOMMU_SET_MSI_BINDING ioctl which aim
> to (un)register the guest MSI binding to the host. This latter
> then can use those stage 1 bindings to build a nested stage
> binding targeting the physical MSIs.

Now that RMR is in the IORT spec, could it be used for the nested MSI
problem?  For virtio-iommu tables I was planning to do it like this:

MSI is mapped at stage-2 with an arbitrary IPA->doorbell PA. We report
this IPA to userspace through iommu_groups/X/reserved_regions. No change
there. Then to the guest we report a reserved identity mapping at IPA
(using RMR, an equivalent DT binding, or probed RESV_MEM for
virtio-iommu). The guest creates that mapping at stage-1, and that's it.
Unless I overlooked something we'd only reuse existing infrastructure and
avoid the SET_MSI_BINDING interface.

Thanks,
Jean
