Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C35E396F52
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhFAItK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233295AbhFAItI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622537247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYTowN5h1GdgeSz4pVIaEJ+JP4FgfgDASAC8d+STYRY=;
        b=dFpAPDvpcuzrxyjTwWDQFRqNi1rCszT5WsS4YuaEmIqi3c7gEhDIU4OmowfsJk5bgfV4Tw
        5duBKfxUlLbSP2H8yr7+Oy3DCnfkxqHLAZCBxVI2Z3BgP5SZsai3eQny2CXv/vD4u+12UW
        f+IEBFHvBjOX8vzK2NOSQHxu30Inhkg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-mnei0VyWMZSpTKcDDyQMlA-1; Tue, 01 Jun 2021 04:47:26 -0400
X-MC-Unique: mnei0VyWMZSpTKcDDyQMlA-1
Received: by mail-pg1-f200.google.com with SMTP id 28-20020a63135c0000b029021b78388f01so8450901pgt.23
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PYTowN5h1GdgeSz4pVIaEJ+JP4FgfgDASAC8d+STYRY=;
        b=fQGhnc6UuseKiFiHve5GNDIjkTfpnd5V639+V18OhoS4jCJ7lOCHiXjQoxYSLmH5iw
         yj9pJXIeKhTCeYPWfzYnmhMqmZswpw0xv+eC7dDJU0X+I+VJxREaLx+Kx7o/ztBsu3X8
         zTJThh2XsuWhTK1q/6dtJp1ZwnLPqychodv0RCAt/l98VKl66nt2il8m5KJ2T2mE9BkZ
         ML9eCNhSezb7Hk/roaB1O33avoXxq6UdpopH0VWud7GV3Dx37OjSSzRSA3VQfqL0uSkP
         LMr6ok5bjQ65akjwTguNnveKxy69tnzgdq7kUIElWgRFulyQ8ioJGOurv7PBROjnoe8I
         HXzg==
X-Gm-Message-State: AOAM533Ag1Fi7DfUpCILKqshuPdvT3zj9Eid8OUfI693ZOmC6X3bBS9Y
        +0MkJjdhWF2VFdsc+2n3mDgtZp3Xx/W1t6+OIXZ54tB+SzhUoxN1IIly7cAZICDzB1nhozea+88
        e73QDMmR5qlICJqrJDldxPGHm
X-Received: by 2002:a17:90a:28a6:: with SMTP id f35mr3817356pjd.1.1622537244923;
        Tue, 01 Jun 2021 01:47:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzscRLjTOrJzV1p867VwF0SvDWPDq+DR2OEkGDg2XAVKt86UYa+sx9GG+cra3Z9boNIhyiUZg==
X-Received: by 2002:a17:90a:28a6:: with SMTP id f35mr3817332pjd.1.1622537244626;
        Tue, 01 Jun 2021 01:47:24 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f5sm1553146pjp.37.2021.06.01.01.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 01:47:24 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Liu Yi L <yi.l.liu@linux.intel.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Alex Williamson (alex.williamson@redhat.com)\"\"" 
        <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <f510f916-e91c-236d-e938-513a5992d3b5@redhat.com>
 <20210531164118.265789ee@yiliu-dev>
 <78ee2638-1a03-fcc8-50a5-81040f677e69@redhat.com>
 <20210601113152.6d09e47b@yiliu-dev>
 <164ee532-17b0-e180-81d3-12d49b82ac9f@redhat.com>
 <64898584-a482-e6ac-fd71-23549368c508@linux.intel.com>
 <429d9c2f-3597-eb29-7764-fad3ec9a934f@redhat.com>
 <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
 <MWHPR11MB1886269E2B3DE471F1A9A7618C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <42a71462-1abc-0404-156c-60a7ee1ad333@redhat.com>
Date:   Tue, 1 Jun 2021 16:47:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1886269E2B3DE471F1A9A7618C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/1 下午2:16, Tian, Kevin 写道:
>> From: Jason Wang
>> Sent: Tuesday, June 1, 2021 2:07 PM
>>
>> 在 2021/6/1 下午1:42, Tian, Kevin 写道:
>>>> From: Jason Wang
>>>> Sent: Tuesday, June 1, 2021 1:30 PM
>>>>
>>>> 在 2021/6/1 下午1:23, Lu Baolu 写道:
>>>>> Hi Jason W,
>>>>>
>>>>> On 6/1/21 1:08 PM, Jason Wang wrote:
>>>>>>>> 2) If yes, what's the reason for not simply use the fd opened from
>>>>>>>> /dev/ioas. (This is the question that is not answered) and what
>>>>>>>> happens
>>>>>>>> if we call GET_INFO for the ioasid_fd?
>>>>>>>> 3) If not, how GET_INFO work?
>>>>>>> oh, missed this question in prior reply. Personally, no special reason
>>>>>>> yet. But using ID may give us opportunity to customize the
>> management
>>>>>>> of the handle. For one, better lookup efficiency by using xarray to
>>>>>>> store the allocated IDs. For two, could categorize the allocated IDs
>>>>>>> (parent or nested). GET_INFO just works with an input FD and an ID.
>>>>>> I'm not sure I get this, for nesting cases you can still make the
>>>>>> child an fd.
>>>>>>
>>>>>> And a question still, under what case we need to create multiple
>>>>>> ioasids on a single ioasid fd?
>>>>> One possible situation where multiple IOASIDs per FD could be used is
>>>>> that devices with different underlying IOMMU capabilities are sharing a
>>>>> single FD. In this case, only devices with consistent underlying IOMMU
>>>>> capabilities could be put in an IOASID and multiple IOASIDs per FD could
>>>>> be applied.
>>>>>
>>>>> Though, I still not sure about "multiple IOASID per-FD" vs "multiple
>>>>> IOASID FDs" for such case.
>>>> Right, that's exactly my question. The latter seems much more easier to
>>>> be understood and implemented.
>>>>
>>> A simple reason discussed in previous thread - there could be 1M's
>>> I/O address spaces per device while #FD's are precious resource.
>>
>> Is the concern for ulimit or performance? Note that we had
>>
>> #define NR_OPEN_MAX ~0U
>>
>> And with the fd semantic, you can do a lot of other stuffs: close on
>> exec, passing via SCM_RIGHTS.
> yes, fd has its merits.
>
>> For the case of 1M, I would like to know what's the use case for a
>> single process to handle 1M+ address spaces?
> This single process is Qemu with an assigned device. Within the guest
> there could be many guest processes. Though in reality I didn't see
> such 1M processes on a single device, better not restrict it in uAPI?


Sorry I don't get here.

We can open up to ~0U file descriptors, I don't see why we need to 
restrict it in uAPI.

Thanks


>
>>
>>> So this RFC treats fd as a container of address spaces which is each
>>> tagged by an IOASID.
>>
>> If the container and address space is 1:1 then the container seems useless.
>>
> yes, 1:1 then container is useless. But here it's assumed 1:M then
> even a single fd is sufficient for all intended usages.
>
> Thanks
> Kevin

