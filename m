Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A8A46006B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 18:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355611AbhK0RPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 12:15:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234049AbhK0RNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 12:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638032990;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vRURtkQMrygkkpJa5/CnJXDZ5sDcZbWT4igezBUS9pQ=;
        b=FhlLh9TTl0kug+3h2TFFb6fVP/OmNCJtFmJjLeh/nX6/loPdfy/nFljhdfDf0dRDG8cMJ4
        UTVgHdKH3CWt43HV3ATRI/NnYQBIrhBt3U3NHAA8PAvh/popRGP3I92CQO5bjuhfUWigeY
        B80j7SF+QmsxzHoVeeIm+eaOjGZXElk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-sovdw4u-PXColLNWF8E-yg-1; Sat, 27 Nov 2021 12:09:49 -0500
X-MC-Unique: sovdw4u-PXColLNWF8E-yg-1
Received: by mail-wm1-f69.google.com with SMTP id r129-20020a1c4487000000b00333629ed22dso8950483wma.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 09:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=vRURtkQMrygkkpJa5/CnJXDZ5sDcZbWT4igezBUS9pQ=;
        b=CsLXUAvJOugANsEJfSNwhA9wupGqWCTWRPMBST6+DNwtQqIpz7PCN4f85vO2+lJDiw
         V2SlvnrTcL1gFYG0quwa9ImuzxPyN1yeOsXyXXfvv/ihfb7C0Jw5Uy7DprhwNpAqwNEY
         5UhpjmloKQKzL7F9hkFhP/XpICnZl1zC+EU9pJ22htkxvax4fsT2SR5geSvOWL23xFSu
         whjjEMXnQW412tTiKlSJmV7RWmjHtIRqJ4MybenTsCz685+GR2PrFpszNp49N7BefvdV
         32UwL96uyTAxQc/HcClQFd3ihGfrdSET/bniiFpVnXF/mQHpVJaDxT955RVrt3sfcO2H
         f5Cw==
X-Gm-Message-State: AOAM532pLlgn7mBUq9/8ON1umKz59wgYTetsBQpGSF4L63mnpmf143Hn
        DDpMdXD+wMQGoPiMz+QTnmwnIZfowklJOVkbKu2XUF9AawITKEcgH6j+L3QLGI86SsOCHIrCYpC
        j5WaKrzhWW1D8zO+GwsspRKN0
X-Received: by 2002:a5d:668c:: with SMTP id l12mr22379160wru.19.1638032987548;
        Sat, 27 Nov 2021 09:09:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5OwWLf9ZEjV2RgLp40TCTTOZhK1sLUiAq9n/cmFpfXGNuE0qdAugxQT46s7QMau7MCbU2rA==
X-Received: by 2002:a5d:668c:: with SMTP id l12mr22379138wru.19.1638032987388;
        Sat, 27 Nov 2021 09:09:47 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id f15sm12165030wmg.30.2021.11.27.09.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 09:09:46 -0800 (PST)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v2 3/5] iommu/virtio: Sort reserved regions
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
        will@kernel.org, mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        sebastien.boeuf@intel.com, kevin.tian@intel.com,
        pasic@linux.ibm.com
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-4-jean-philippe@linaro.org>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <96a911b2-abca-eee1-334b-52a5bb5a9b6e@redhat.com>
Date:   Sat, 27 Nov 2021 18:09:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211123155301.1047943-4-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 11/23/21 4:53 PM, Jean-Philippe Brucker wrote:
> To ease identity mapping support, keep the list of reserved regions
> sorted.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/iommu/virtio-iommu.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index ee8a7afd667b..d63ec4d11b00 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -423,7 +423,7 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
>  	size_t size;
>  	u64 start64, end64;
>  	phys_addr_t start, end;
> -	struct iommu_resv_region *region = NULL;
> +	struct iommu_resv_region *region = NULL, *next;
>  	unsigned long prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>  
>  	start = start64 = le64_to_cpu(mem->start);
> @@ -454,7 +454,12 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
>  	if (!region)
>  		return -ENOMEM;
>  
> -	list_add(&region->list, &vdev->resv_regions);
> +	/* Keep the list sorted */
> +	list_for_each_entry(next, &vdev->resv_regions, list) {
> +		if (next->start > region->start)
> +			break;
> +	}
> +	list_add_tail(&region->list, &next->list);
>  	return 0;
>  }
>  

