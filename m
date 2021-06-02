Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0592739849C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhFBIy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230153AbhFBIyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622623954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ArZvpLSAQuv5CBVhrYmEmSDRDRVYj1zP8TVHlpX3nA=;
        b=AbiYxKSJVy2rX3sCP1zR7d4fZXnZ0W4NQ0UnmNlOkCgz+tarWfL2scG9ZGCMQ7Mgsik+er
        AGx3ZdxXqdJ6XwdQnVA1o/0GkTp+zUI9WvppP3L2iqg10yziUobNcANNCAdrYYOtqzuU30
        sAlPECiEQ3+eqZu85C13wJAL3RJ0FNw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-GoasKwmFPoWZRQcRHkNakg-1; Wed, 02 Jun 2021 04:52:30 -0400
X-MC-Unique: GoasKwmFPoWZRQcRHkNakg-1
Received: by mail-pg1-f197.google.com with SMTP id s7-20020a6352470000b029021b9013c124so1247440pgl.19
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 01:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9ArZvpLSAQuv5CBVhrYmEmSDRDRVYj1zP8TVHlpX3nA=;
        b=UgUf9E9571eW8J9+vuUaUhC2Qz223tCVrLX++5MGryTrGooCGURHlyh4GEsTz5VpBU
         A7TYB4Jta1QP+j30x26VpyhV6g93sokeAtRaOX1dRAWtOUxE4vFLN/g8iB54RN7FVu09
         I6Z1ro9Q3+GlKk7+JuhtVXb3JB44RIyPBBXyz5CPCcM7K2cIJuKi9UPjw5JGjHiT8/cC
         VeUBSixZTD5viTsidRrjZQkl6q1CVe9hoOgCnG1vdHEpSZN+k3L61fq1z+XoBIdkdixH
         M491D0i3ldnWqqBnbYvyVHe6FauNrLFTvil5l+qZU+CWz6NuK0oS/BP42Ekr4NpX+eaJ
         oSfw==
X-Gm-Message-State: AOAM533X/fXEz2jCvdszT1hD/6o2eJRHvHFwQJY3qCMj081uAqTdZOZe
        GWJ876XTY/nL460I7JQXqp+QTwNkNwydkZoCrvTQqVdmkJSM21NVPTh4qW08vzZi49NyzVzRub3
        6E8ATl58hfXHOACamPnC8w8BC
X-Received: by 2002:a05:6a00:856:b029:28e:e5d2:9a62 with SMTP id q22-20020a056a000856b029028ee5d29a62mr25918428pfk.17.1622623949417;
        Wed, 02 Jun 2021 01:52:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6352chW2w8JBVfW8qE6tyLLdIANPog+tIL9JC4Kxa2bdk25eLDpPcxihKlfwVlgGmyGjSHg==
X-Received: by 2002:a05:6a00:856:b029:28e:e5d2:9a62 with SMTP id q22-20020a056a000856b029028ee5d29a62mr25918402pfk.17.1622623949178;
        Wed, 02 Jun 2021 01:52:29 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a20sm6829660pfk.145.2021.06.02.01.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 01:52:28 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Alex Williamson (alex.williamson@redhat.com)" 
        <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528200311.GP1002214@nvidia.com>
 <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601202834.GR1002214@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <1a3b4cf2-f511-640b-6c8c-a85f94a9536d@redhat.com>
Date:   Wed, 2 Jun 2021 16:52:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601202834.GR1002214@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/2 ÉÏÎç4:28, Jason Gunthorpe Ð´µÀ:
>> I summarized five opens here, about:
>>
>> 1)  Finalizing the name to replace /dev/ioasid;
>> 2)  Whether one device is allowed to bind to multiple IOASID fd's;
>> 3)  Carry device information in invalidation/fault reporting uAPI;
>> 4)  What should/could be specified when allocating an IOASID;
>> 5)  The protocol between vfio group and kvm;
>>
>> For 1), two alternative names are mentioned: /dev/iommu and
>> /dev/ioas. I don't have a strong preference and would like to hear
>> votes from all stakeholders. /dev/iommu is slightly better imho for
>> two reasons. First, per AMD's presentation in last KVM forum they
>> implement vIOMMU in hardware thus need to support user-managed
>> domains. An iommu uAPI notation might make more sense moving
>> forward. Second, it makes later uAPI naming easier as 'IOASID' can
>> be always put as an object, e.g. IOMMU_ALLOC_IOASID instead of
>> IOASID_ALLOC_IOASID.:)
> I think two years ago I suggested /dev/iommu and it didn't go very far
> at the time.


It looks to me using "/dev/iommu" excludes the possibility of 
implementing IOASID in a device specific way (e.g through the 
co-operation with device MMU + platform IOMMU)?

What's more, ATS spec doesn't forbid the device #PF to be reported via a 
device specific way.

Thanks


> We've also talked about this as /dev/sva for a while and
> now /dev/ioasid
>
> I think /dev/iommu is fine, and call the things inside them IOAS
> objects.
>
> Then we don't have naming aliasing with kernel constructs.
>   

