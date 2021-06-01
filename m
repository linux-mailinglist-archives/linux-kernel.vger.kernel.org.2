Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9DE396D20
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 08:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhFAGJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 02:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231139AbhFAGI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 02:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622527637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WBtT6QfhiDgonj2vvLPkT9r7vtcFNwuVXyhZCxDQcFk=;
        b=g3QgaCw5HTnjmQFssW/gZqX/BdxT0PiPrInkzqb5sDFCrlZW/UeDGH6QYMkAJzZSfUbhHC
        56mj8tPmO1GnMd1xQ9AIwflyXoIKdg18G7XVDGza8kx41G5M1pjk7cDnA+OMq+o+ccdix9
        np7eeJfiaqV8rO/jl/rZd7wDFV8JtuI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-gX3GaGayO7yGyzcSxsrVaw-1; Tue, 01 Jun 2021 02:07:16 -0400
X-MC-Unique: gX3GaGayO7yGyzcSxsrVaw-1
Received: by mail-pg1-f200.google.com with SMTP id q64-20020a6343430000b02902164088f2f0so8277683pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 23:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WBtT6QfhiDgonj2vvLPkT9r7vtcFNwuVXyhZCxDQcFk=;
        b=nzAG3RquW5cA49vx57KoCEhy80kpMa8kcvmfbkaX3OEM+XsrxPtvUpjVvhLjqXiDRq
         f6Da0eHTUrrEw5GR6q0zYzJg8mH4Gw9zVwO4xzFBhShSIYsWOKR/IhIhaDNspqEY8zYi
         D3gNHY0d/PjF0lOS6evnoU17arJd2jhnt8pt++/jXYONJzvOSAN5VS3urcKWS21HXPln
         +ugVWo0vr65NNAXBR1ZyDXNrm2kWRCllFkGg1dvfR5RysHFaM35bGNhBEhXHJBs8ciLx
         hZ8QNRbJBuzRViaS3mhBlgn8LrwQc/SSqjf8oq/FqG8VMTBJjcP8tORfZ+VJxaxkEg56
         Zd9g==
X-Gm-Message-State: AOAM531s/G3b/+KzakGQufbamLCI6dXkMQxu4PkcfUVkUNYA/TQ6PD+h
        XQJ4Uqv6scvdfJUQtoWtJtB6KhoIeeI6+wBIl3rBBO5dgbhjzXJGL9G/sgsDZRzmHyKLGsWoKsy
        4WNQFiBdfgnJH/1unSkvButXj
X-Received: by 2002:a62:1856:0:b029:2e9:c6ef:3b34 with SMTP id 83-20020a6218560000b02902e9c6ef3b34mr10235747pfy.65.1622527635283;
        Mon, 31 May 2021 23:07:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy061Dy19iHLayhC8IX/sic1Xj79JCDr5oreU6IxvFEXjUpr+lVQ790JMBSTMUZPvKcvJ5VZQ==
X-Received: by 2002:a62:1856:0:b029:2e9:c6ef:3b34 with SMTP id 83-20020a6218560000b02902e9c6ef3b34mr10235727pfy.65.1622527635026;
        Mon, 31 May 2021 23:07:15 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 25sm12058529pfh.39.2021.05.31.23.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 23:07:14 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Liu Yi L <yi.l.liu@linux.intel.com>
Cc:     "Alex Williamson (alex.williamson@redhat.com)\"\"" 
        <alex.williamson@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
Date:   Tue, 1 Jun 2021 14:07:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/1 下午1:42, Tian, Kevin 写道:
>> From: Jason Wang
>> Sent: Tuesday, June 1, 2021 1:30 PM
>>
>> 在 2021/6/1 下午1:23, Lu Baolu 写道:
>>> Hi Jason W,
>>>
>>> On 6/1/21 1:08 PM, Jason Wang wrote:
>>>>>> 2) If yes, what's the reason for not simply use the fd opened from
>>>>>> /dev/ioas. (This is the question that is not answered) and what
>>>>>> happens
>>>>>> if we call GET_INFO for the ioasid_fd?
>>>>>> 3) If not, how GET_INFO work?
>>>>> oh, missed this question in prior reply. Personally, no special reason
>>>>> yet. But using ID may give us opportunity to customize the management
>>>>> of the handle. For one, better lookup efficiency by using xarray to
>>>>> store the allocated IDs. For two, could categorize the allocated IDs
>>>>> (parent or nested). GET_INFO just works with an input FD and an ID.
>>>>
>>>> I'm not sure I get this, for nesting cases you can still make the
>>>> child an fd.
>>>>
>>>> And a question still, under what case we need to create multiple
>>>> ioasids on a single ioasid fd?
>>> One possible situation where multiple IOASIDs per FD could be used is
>>> that devices with different underlying IOMMU capabilities are sharing a
>>> single FD. In this case, only devices with consistent underlying IOMMU
>>> capabilities could be put in an IOASID and multiple IOASIDs per FD could
>>> be applied.
>>>
>>> Though, I still not sure about "multiple IOASID per-FD" vs "multiple
>>> IOASID FDs" for such case.
>>
>> Right, that's exactly my question. The latter seems much more easier to
>> be understood and implemented.
>>
> A simple reason discussed in previous thread - there could be 1M's
> I/O address spaces per device while #FD's are precious resource.


Is the concern for ulimit or performance? Note that we had

#define NR_OPEN_MAX ~0U

And with the fd semantic, you can do a lot of other stuffs: close on 
exec, passing via SCM_RIGHTS.

For the case of 1M, I would like to know what's the use case for a 
single process to handle 1M+ address spaces?


> So this RFC treats fd as a container of address spaces which is each
> tagged by an IOASID.


If the container and address space is 1:1 then the container seems useless.

Thanks


>
> Thanks
> Kevin

