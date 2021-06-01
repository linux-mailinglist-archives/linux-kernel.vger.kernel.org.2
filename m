Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D69396CAB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 07:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhFAFM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 01:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229477AbhFAFMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 01:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622524244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/e5q/5xjzsRkEDNz5ZxlpC3JGa3sYqjV3MHMYvl155U=;
        b=Y4nvsKtcf4MBWjXFMbUfn7QLGmZuWJxzckl0n4ef+oxtWWTZGyAQpcjbfdWWEhj4nTfVQl
        Cr2wpzMgGNeP+RROXScd2jKxBQeRPT9osQGSdkVkcTp5jB9CROXSj+xnRENvFwAofnoW30
        xgDeSkVwStyqYpu5nogq8o9VIQ+50Ac=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-GfnkxVjNOiCsxChQtgEmkA-1; Tue, 01 Jun 2021 01:10:42 -0400
X-MC-Unique: GfnkxVjNOiCsxChQtgEmkA-1
Received: by mail-pl1-f200.google.com with SMTP id o12-20020a170902778cb02900ff01bc1ddbso379406pll.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 22:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/e5q/5xjzsRkEDNz5ZxlpC3JGa3sYqjV3MHMYvl155U=;
        b=qoDU/HmreqZxJmeex8K3ahTht/8KDCrZdNp5JtMTUSPppjlYHu+f+ykFVPMkffWYrh
         JKjly8OKyDi0WoyoHPksTpOkTH7nHX7yQBMCW8T+Ve9WrKHbmmXgmtCdWuujJr4l0IB1
         QvPYwgJ2wKED4QtBsfL/i1szPQkoRisGoVSMghHphItruOqCxLBO3uwIxC4+QVyN/vrR
         LqOC8tuO0ki/Kh8uXiRkXMSYDf3WIrBqE/Kaw8RjYZHEmPGVwNBgSmOu4L6Z5Z2cGDCB
         u4etrKl27uyRHT5aG6ThzPhBynphs3hYpEzzN7jqQqYkNkC22BRsve8yhhgM5w0YFvfp
         WNfA==
X-Gm-Message-State: AOAM5306b35oNIHgPR6FjWdQ0gIwH0wwni//adjIVdWmt/tFarQMKxg0
        gt2cI1Cza21Js2nioTj3VOhlO8FUbw8GpNgvnlcfGTG2WNNf60ehWoCjj9JChiJrC0tPgQ/eupS
        JJoryyESqkINs3B3et4zQ0kjQ
X-Received: by 2002:a62:e705:0:b029:2e0:3497:32d3 with SMTP id s5-20020a62e7050000b02902e0349732d3mr20356166pfh.8.1622524241700;
        Mon, 31 May 2021 22:10:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytHxyR4BWmCRVtKpv5IYBYhq4d+/sKgZ9pMx4Js9IFNC7XvBhu73uGhDC20WcBEh8d9BaQzw==
X-Received: by 2002:a62:e705:0:b029:2e0:3497:32d3 with SMTP id s5-20020a62e7050000b02902e0349732d3mr20356134pfh.8.1622524241480;
        Mon, 31 May 2021 22:10:41 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j20sm11866560pfj.40.2021.05.31.22.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 22:10:41 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To:     Shenming Lu <lushenming@huawei.com>,
        Liu Yi L <yi.l.liu@linux.intel.com>
Cc:     yi.l.liu@intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Alex Williamson (alex.williamson@redhat.com)\"" 
        <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Zenghui Yu <yuzenghui@huawei.com>,
        "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <f510f916-e91c-236d-e938-513a5992d3b5@redhat.com>
 <20210531164118.265789ee@yiliu-dev>
 <78ee2638-1a03-fcc8-50a5-81040f677e69@redhat.com>
 <1fedcd93-1a8a-884f-d0c8-3e2c21ed7654@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e95add68-7556-f8a3-695b-40389742a682@redhat.com>
Date:   Tue, 1 Jun 2021 13:10:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1fedcd93-1a8a-884f-d0c8-3e2c21ed7654@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/1 下午12:27, Shenming Lu 写道:
> On 2021/6/1 10:36, Jason Wang wrote:
>> åœ¨ 2021/5/31 ä¸‹å�ˆ4:41, Liu Yi L å†™é�“:
>>>> I guess VFIO_ATTACH_IOASID will fail if the underlayer doesn't support
>>>> hardware nesting. Or is there way to detect the capability before?
>>> I think it could fail in the IOASID_CREATE_NESTING. If the gpa_ioasid
>>> is not able to support nesting, then should fail it.
>>>
>>>> I think GET_INFO only works after the ATTACH.
>>> yes. After attaching to gpa_ioasid, userspace could GET_INFO on the
>>> gpa_ioasid and check if nesting is supported or not. right?
>>
>> Some more questions:
>>
>> 1) Is the handle returned by IOASID_ALLOC an fd?
>> 2) If yes, what's the reason for not simply use the fd opened from /dev/ioas. (This is the question that is not answered) and what happens if we call GET_INFO for the ioasid_fd?
>> 3) If not, how GET_INFO work?
> It seems that the return value from IOASID_ALLOC is an IOASID number in the
> ioasid_data struct, then when calling GET_INFO, we should convey this IOASID
> number to get the associated I/O address space attributes (depend on the
> physical IOMMU, which could be discovered when attaching a device to the
> IOASID fd or number), right?


Right, but the question is why need such indirection? Unless there's a 
case that you need to create multiple IOASIDs per ioasid fd. It's more 
simpler to attach the metadata into the ioasid fd itself.

Thanks


>
> Thanks,
> Shenming
>

