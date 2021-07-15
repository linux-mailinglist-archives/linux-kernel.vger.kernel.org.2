Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126953C95D9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 04:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhGOCXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 22:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231863AbhGOCXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 22:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626315653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qIMPem89MDX9CyRymEODASuBwQsPbelIeY3DhbvC9/k=;
        b=DcXIrls6kUOSzah4+A5t5FUO7Cdsj42KYlPmndz+pIQ1IfGKcKkStoNGmQbkiY94DIUGOi
        okL6e1sRJNyvHkBUPm5kKK1VP3zEC5d1VwJcXZVdCnkQdQ0pphvmvZR29cHWYdnz06Bsi3
        0tcdpk9eIz3NhYQJvpME/Vg0W10lrN4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-cZI7if-fNl2JtOg_5eNmLg-1; Wed, 14 Jul 2021 22:20:52 -0400
X-MC-Unique: cZI7if-fNl2JtOg_5eNmLg-1
Received: by mail-pf1-f199.google.com with SMTP id h6-20020a62b4060000b02903131bc4a1acso3129168pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 19:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qIMPem89MDX9CyRymEODASuBwQsPbelIeY3DhbvC9/k=;
        b=XmZP9vv5WmBdPvj9/oErrLIFO1RG13w4SQhA0Buy1mo18vKl0clw5UiSjvPqVXqn8u
         jdfXMLK89ZvUSBwQySCinqTdiHKqFwg1176YjwVoFzKUuTu5rRToIAav/2ZQK9rivgpr
         9Mixu0OxMwOyrhlk51KlPDNwxyvZGAwzo9N1plsolM8xAVZeGuoA5Ov6sN0jlgxoDL/8
         l+aMUdBSveEKDW+dk0AjtwTSqhWmuwgYfywCN4yafrJDdvUmGeEUbGLHbESPCP37lrEU
         bbIgJPEF9C/z/N7Ti2iLJIhbQcHhJf/Ii1TbS/2Y50xdKscZm6FxwNsU/56jHcJm2E3f
         /bTQ==
X-Gm-Message-State: AOAM530ZUrWTQ2q/7qy4ISg53WdeNIXxm+uCj0ZTiWxX/d2T+YWn1cm/
        9Asj2CFLsvXzCoFMjdgXgiEp8CoVSpO6+BrVpXhpMiUOoYI3nyC8/sEUXajZ5L/PHj+hOeDgLRs
        EUtkjaHolCF6RStUUxTG9B1vQz1qAMxgF+s0FqAOiv8zuWBe2LKt9NE/dWk2TJIm4Yi9HECRzeM
        fs
X-Received: by 2002:a17:90a:1941:: with SMTP id 1mr7021912pjh.217.1626315651062;
        Wed, 14 Jul 2021 19:20:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybOsI3CmBYlnZZGHyBp8j1KVybpeIfAQjdQVC6tPCV/HtNWu2hK14gevvyKrFs/xFGbLJ7PQ==
X-Received: by 2002:a17:90a:1941:: with SMTP id 1mr7021834pjh.217.1626315650579;
        Wed, 14 Jul 2021 19:20:50 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p3sm7097812pjt.0.2021.07.14.19.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 19:20:50 -0700 (PDT)
Subject: Re: [PATCH v9 13/17] vdpa: factor out vhost_vdpa_pa_map() and
 vhost_vdpa_pa_unmap()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
        hch@infradead.org, christian.brauner@canonical.com,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net, mika.penttila@nextfour.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-14-xieyongji@bytedance.com> <20210713113114.GL1954@kadam>
 <20e75b53-0dce-2f2d-b717-f78553bddcd8@redhat.com>
 <20210714080512.GW1954@kadam>
 <db02315d-0ffe-f4a2-da67-5a014060fa4a@redhat.com>
 <20210714095722.GC25548@kadam>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <96f66296-2071-c321-96d7-882070261eb6@redhat.com>
Date:   Thu, 15 Jul 2021 10:20:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714095722.GC25548@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/14 下午5:57, Dan Carpenter 写道:
> On Wed, Jul 14, 2021 at 05:41:54PM +0800, Jason Wang wrote:
>> 在 2021/7/14 下午4:05, Dan Carpenter 写道:
>>> On Wed, Jul 14, 2021 at 10:14:32AM +0800, Jason Wang wrote:
>>>> 在 2021/7/13 下午7:31, Dan Carpenter 写道:
>>>>> On Tue, Jul 13, 2021 at 04:46:52PM +0800, Xie Yongji wrote:
>>>>>> @@ -613,37 +618,28 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v, u64 iova, u64 size)
>>>>>>     	}
>>>>>>     }
>>>>>> -static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>>>>> -					   struct vhost_iotlb_msg *msg)
>>>>>> +static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>>>>>> +			     u64 iova, u64 size, u64 uaddr, u32 perm)
>>>>>>     {
>>>>>>     	struct vhost_dev *dev = &v->vdev;
>>>>>> -	struct vhost_iotlb *iotlb = dev->iotlb;
>>>>>>     	struct page **page_list;
>>>>>>     	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
>>>>>>     	unsigned int gup_flags = FOLL_LONGTERM;
>>>>>>     	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
>>>>>>     	unsigned long lock_limit, sz2pin, nchunks, i;
>>>>>> -	u64 iova = msg->iova;
>>>>>> +	u64 start = iova;
>>>>>>     	long pinned;
>>>>>>     	int ret = 0;
>>>>>> -	if (msg->iova < v->range.first ||
>>>>>> -	    msg->iova + msg->size - 1 > v->range.last)
>>>>>> -		return -EINVAL;
>>>>> This is not related to your patch, but can the "msg->iova + msg->size"
>>>>> addition can have an integer overflow.  From looking at the callers it
>>>>> seems like it can.  msg comes from:
>>>>>      vhost_chr_write_iter()
>>>>>      --> dev->msg_handler(dev, &msg);
>>>>>          --> vhost_vdpa_process_iotlb_msg()
>>>>>             --> vhost_vdpa_process_iotlb_update()
>>>> Yes.
>>>>
>>>>
>>>>> If I'm thinking of the right thing then these are allowed to overflow to
>>>>> 0 because of the " - 1" but not further than that.  I believe the check
>>>>> needs to be something like:
>>>>>
>>>>> 	if (msg->iova < v->range.first ||
>>>>> 	    msg->iova - 1 > U64_MAX - msg->size ||
>>>> I guess we don't need - 1 here?
>>> The - 1 is important.  The highest address is 0xffffffff.  So it goes
>>> start + size = 0 and then start + size - 1 == 0xffffffff.
>>
>> Right, so actually
>>
>> msg->iova = 0xfffffffe, msg->size=2 is valid.
> I believe so, yes.  It's inclusive of 0xfffffffe and 0xffffffff.
> (Not an expert).


I think so, and we probably need to fix vhost_overflow() as well which did:

static bool vhost_overflow(u64 uaddr, u64 size)
{
         /* Make sure 64 bit math will not overflow. */
         return uaddr > ULONG_MAX || size > ULONG_MAX || uaddr > 
ULONG_MAX - size;
}

Thanks


>
> regards,
> dan carpenter
>

