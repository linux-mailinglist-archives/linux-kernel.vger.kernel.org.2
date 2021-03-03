Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5DE32C027
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbhCCSgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385485AbhCCRTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:19:54 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC52C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 09:19:13 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d11so24537080wrj.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i2EmiA2OI6AS1yv/kESZ25uJxCrsbJD4OPafUbCob7k=;
        b=G7Wv9nJ4rffonUPHi15xk4myESuF1veXlWxhT6o1EflZeRo7Es0NPuoJvoWKAMFaXn
         a8HSUzKKOdcBC11ggt5ntPm2ZHzRAlrEDwLk+uG+ahMNqGmhdUVm4eyJ9RqUvAM6vrEc
         t8RObshVlZWj7/nsMtM8Qkv0RWNXngpUPL0uTytGMVh8xDFblD332rtFAyE/vEmKLaG8
         ze3Sz1EVrorfCpgAOdVTAhxVf+fTaRyvBFJosrkBHZ/jgD0bOdmdRiIK6FwYGHrh5t/g
         rTr+S9l1vQbvmeZuk4GjEjOv+c6yYz4AYk91JxwmeTOjSHX56NTmPArkkazCvqQGAyH0
         7/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i2EmiA2OI6AS1yv/kESZ25uJxCrsbJD4OPafUbCob7k=;
        b=SJjwUKhYZHzzY3oeXbXPZnMHFDJ2N2g0nJAz04LfiJy4xf0gahGUHvoB6N9CLo7zSI
         lDxJWk82fUBxIO/HOnZLAoh3+drEvIk3GJDfRrfyiXFiOuPZQod8DX5+IsHKrei8AJqT
         EWDD2JeuI2cq3XZ++IBmM4xK5KdNUvzMvw3/97Dpu8W3B67BVUz+G6VMF9o3FKnSpLjM
         TszH/anG+VKrJei2JGz/zSbd117l5TAh6UHgb5k7qNM2+c4BXaON4UIvPAwqRSjOdvjO
         K4D58o6lRN+sB/v+1s1wK+k2So4hTBst6F/I3RF60ialg2oak5Z/5WJyFKj9vQfscfwk
         AAcQ==
X-Gm-Message-State: AOAM530MNwXd7iKKbmwZKN7DFlHMKadNcJVjuu+9ARvhBh0HjVDWKyfW
        oHgiuE+MiD4Ic3TbhQVIX0XFaw==
X-Google-Smtp-Source: ABdhPJxUR+nvbzEW9IaIRVudC5yUeyFpL97Hh5+SHssrit/Q6elP8Y7hyAVFMdldaV9xhDA9NaLjQg==
X-Received: by 2002:adf:f7cc:: with SMTP id a12mr28284530wrq.54.1614791951832;
        Wed, 03 Mar 2021 09:19:11 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id z7sm4968309wrt.70.2021.03.03.09.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:19:11 -0800 (PST)
Date:   Wed, 3 Mar 2021 18:18:49 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Vivek Gautam <vivek.gautam@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, alex.williamson@redhat.com,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, lorenzo.pieralisi@arm.com,
        shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFC v1 08/15] iommu: Add asid_bits to arm smmu-v3 stage1
 table info
Message-ID: <YD/E+XASgn9PL9HM@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-9-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115121342.15093-9-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 05:43:35PM +0530, Vivek Gautam wrote:
> aisd_bits data is required to prepare stage-1 tables for arm-smmu-v3.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> ---
>  include/uapi/linux/iommu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 082d758dd016..96abbfc7c643 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -357,7 +357,7 @@ struct iommu_pasid_smmuv3 {
>  	__u32	version;
>  	__u8	s1fmt;
>  	__u8	s1dss;
> -	__u8	padding[2];
> +	__u16	asid_bits;

Is this used anywhere?  This struct is passed from host userspace to host
kernel to attach the PASID table, so I don't think it needs an asid_bits
field.

Thanks,
Jean

