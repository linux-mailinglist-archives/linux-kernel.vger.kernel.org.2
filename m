Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1AB41A8EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 08:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238930AbhI1G1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 02:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57832 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234890AbhI1G1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 02:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632810339;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9wq1dVPtAXDMCZC9S+u92KoCxHpT0A4H8ulsqFHsRII=;
        b=UDRvPPH2Ztv/ykXHYg6Q/XQvcsd1qQmx4vD0ABeJBMaPCkhF2QJAeS9GTqG3m377s2iXFD
        HFFgsa4Xkh6j4TAisZS1qelygOF1BWjHMT4SettqUrj+11FTTEXVE+v9T3Rc6MbHm3UQ3p
        9Fh1BKSN+rObCnMVm7aji7p/N6QdS98=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-kLQN9vOWMjy8dKnKDjQ5jQ-1; Tue, 28 Sep 2021 02:25:37 -0400
X-MC-Unique: kLQN9vOWMjy8dKnKDjQ5jQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5-20020a1c00050000b02902e67111d9f0so1510508wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 23:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=9wq1dVPtAXDMCZC9S+u92KoCxHpT0A4H8ulsqFHsRII=;
        b=1Z/lIuvePn/8uqRoOkmPONamNEOgyZugy/Q2zejwOAU/zUAvnCwfUMrFQwSayY5q/d
         nqfixaT1Rk0cMx41rDIiFZzpU4Q4Xi7pmWxbfT0lcunwbhrSYKSoZ7WrIqQnaFfUq6LP
         xRKmoqdJPyBENsqncQjnnmQxRP0PfdDFHnz4lp1pB2QH49o2g4f0RKeLTaiYDcQOUoG/
         a4gLFbILHf5VUfIHVLw9X1A8oEvKw1WK00hmcUKhJm5uI4LI/K6noccPaSVU9mDknfUV
         D58gGVoSNR0r+HQcs2dKLdhBKOJLINKKiThFcQ9m8JwZQ8MwrkspeX3OT2Weaxnq2YdJ
         r69Q==
X-Gm-Message-State: AOAM5302msyy0+rYgNCPAC+nvMHkxe5Wbzzd9xgpkMBf7Cp1747tjQOG
        H6Bf/5dxikcRPrY3ZIDXGDxy40KQLxiB4Gxu3q/ZHx2ewKq+mRAm/AffhtGhT2V3q3yUxBlqM1d
        f7AkDWfMiyY8DGIl1MHhmiNUH
X-Received: by 2002:a5d:64cf:: with SMTP id f15mr4278527wri.284.1632810336267;
        Mon, 27 Sep 2021 23:25:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqSUu50iJ95OWE4UOFTINQsxuRK/ueiYpb9FlWfdG9FdcSiC/DUJ4GzrvCnuOU9QL4gLjBUA==
X-Received: by 2002:a5d:64cf:: with SMTP id f15mr4278495wri.284.1632810336011;
        Mon, 27 Sep 2021 23:25:36 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id l10sm1663709wmq.42.2021.09.27.23.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 23:25:35 -0700 (PDT)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v15 00/12] SMMUv3 Nested Stage Setup (IOMMU part)
To:     Krishna Reddy <vdumpa@nvidia.com>,
        "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "will@kernel.org" <will@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "zhukeqian1@huawei.com" <zhukeqian1@huawei.com>
Cc:     "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "wangxingang5@huawei.com" <wangxingang5@huawei.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
        "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>,
        "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "lushenming@huawei.com" <lushenming@huawei.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        "chenxiang66@hisilicon.com" <chenxiang66@hisilicon.com>,
        "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>
References: <20210411111228.14386-1-eric.auger@redhat.com>
 <BY5PR12MB37640C26FEBC8AC6E3EDF40BB3A79@BY5PR12MB3764.namprd12.prod.outlook.com>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <c3fcc2fb-3173-af83-2b30-423c2c1ab83d@redhat.com>
Date:   Tue, 28 Sep 2021 08:25:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB37640C26FEBC8AC6E3EDF40BB3A79@BY5PR12MB3764.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

On 9/27/21 11:17 PM, Krishna Reddy wrote:
> Hi Eric,
>> This is based on Jean-Philippe's
>> [PATCH v14 00/10] iommu: I/O page faults for SMMUv3
>> https://www.spinics.net/lists/arm-kernel/msg886518.html
>> (including the patches that were not pulled for 5.13)
>>
> Jean's patches have been merged to v5.14.
> Do you anticipate IOMMU/VFIO part patches getting into upstream kernel soon?

I am going to respin the smmu part rebased on v5.15. As for the VFIO
part, this needs to be totally redesigned based on /dev/iommu (see
[RFC 00/20] Introduce /dev/iommu for userspace I/O address space
management).

I will provide some updated kernel and qemu branches for testing purpose
only.

Thanks

Eric
>
> -KR
>

