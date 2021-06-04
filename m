Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482B139AFB1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 03:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhFDBce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 21:32:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229697AbhFDBcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622770248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jD0SrrifrVAIWI7R1gZoaTn69EV68xZixLKv5uzjFb0=;
        b=LMBoFqc44DOArA0RxhZDRCpNYIRKtOjHtRTf9+0oDj5qumjjiYyTznNL0O+1WtmWe3JPUi
        OQa4ICPKWYN8rQ4UzTXu9woMyBx6ItojTaXMr/GveL/Ngtl6vMY8iTrNiCulIAoTy5N7wL
        JQuQ5WP1FwCq9DJkS1WfBLTVKpgdSVA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-YqgCkUpuPYSYgUb2kOBEdw-1; Thu, 03 Jun 2021 21:30:46 -0400
X-MC-Unique: YqgCkUpuPYSYgUb2kOBEdw-1
Received: by mail-pj1-f72.google.com with SMTP id w12-20020a17090a528cb029015d7f990752so6599709pjh.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 18:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jD0SrrifrVAIWI7R1gZoaTn69EV68xZixLKv5uzjFb0=;
        b=pIxWGVAPsQvk2tO2kmPSmT8DuNCyVjsAwt5lnS2fpk/8JwVfi9AnnScRpRwzsfUbWb
         I+huzNyuqf+OesvsAu2QgbE6D9173F3+YkT1J8/Xrk89P9e3xbgHta9wK9WoRqyFUZ3c
         GOJjmsed9sHpblwp223IJkPIjtZmCc+X6mMmZLEO4sgXtAo4nfxA9WnjbyEk9WRS2ZIG
         PPdeAjasyBiQwUFdCByrahJQEojRGcZzg8ZAI1DCsPTEhX0j5TgJ2FRCUUbCL/7nYh7c
         xbcf1xLpyeB9pvbaSKQBFEJ5Anjd9drAYf6bVIjgcodFPzWAGGZonVvAzwAAkTKxJUnx
         neuw==
X-Gm-Message-State: AOAM532Ez+Qq3XXEZiwK+l2y2lsc5AozMH7PpMD27hE1NBow5PLZVRg0
        wYUa9EzTG//U4eH6kZlMb9g9q6019MwawZ7y52PHk+LUuwQEIXIwi3Dfmxj154N6HE9XqWbwxC0
        9EWK4USHqMUpVlpYZknbtOZ7/
X-Received: by 2002:a63:6e87:: with SMTP id j129mr2331150pgc.45.1622770245926;
        Thu, 03 Jun 2021 18:30:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPvvTcrHVuEjSyMsuOtnGOtgpMffrms7oNztTWuUcXduMPhSu1xCuPg2j+GGQkXnPef6d2rw==
X-Received: by 2002:a63:6e87:: with SMTP id j129mr2331134pgc.45.1622770245745;
        Thu, 03 Jun 2021 18:30:45 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d3sm3177937pjk.16.2021.06.03.18.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 18:30:45 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Shenming Lu <lushenming@huawei.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Alex Williamson (alex.williamson@redhat.com)" 
        <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <c9c066ae-2a25-0799-51a7-0ca47fff41a1@huawei.com>
 <aa1624bf-e472-2b66-1d20-54ca23c19fd2@linux.intel.com>
 <ed4f6e57-4847-3ed2-75de-cea80b2fbdb8@huawei.com>
 <01fe5034-42c8-6923-32f1-e287cc36bccc@linux.intel.com>
 <20210601173323.GN1002214@nvidia.com>
 <23a482f9-b88a-da98-3800-f3fd9ea85fbd@huawei.com>
 <20210603111914.653c4f61@jacob-builder>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <1175ebd5-9d8e-2000-6d05-baa93e960915@redhat.com>
Date:   Fri, 4 Jun 2021 09:30:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603111914.653c4f61@jacob-builder>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/4 ÉÏÎç2:19, Jacob Pan Ð´µÀ:
> Hi Shenming,
>
> On Wed, 2 Jun 2021 12:50:26 +0800, Shenming Lu <lushenming@huawei.com>
> wrote:
>
>> On 2021/6/2 1:33, Jason Gunthorpe wrote:
>>> On Tue, Jun 01, 2021 at 08:30:35PM +0800, Lu Baolu wrote:
>>>    
>>>> The drivers register per page table fault handlers to /dev/ioasid which
>>>> will then register itself to iommu core to listen and route the per-
>>>> device I/O page faults.
>>> I'm still confused why drivers need fault handlers at all?
>> Essentially it is the userspace that needs the fault handlers,
>> one case is to deliver the faults to the vIOMMU, and another
>> case is to enable IOPF on the GPA address space for on-demand
>> paging, it seems that both could be specified in/through the
>> IOASID_ALLOC ioctl?
>>
> I would think IOASID_BIND_PGTABLE is where fault handler should be
> registered. There wouldn't be any IO page fault without the binding anyway.
>
> I also don't understand why device drivers should register the fault
> handler, the fault is detected by the pIOMMU and injected to the vIOMMU. So
> I think it should be the IOASID itself register the handler.


As discussed in another thread.

I think the reason is that ATS doesn't forbid the #PF to be reported via 
a device specific way.

Thanks


>
>> Thanks,
>> Shenming
>>
>
> Thanks,
>
> Jacob
>

