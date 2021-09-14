Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D7140ACE1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhINL6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:58:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232289AbhINL6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631620651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kjBNsUJZhb+CoTbkZeanK9icxsVOilejMTC0HAi65SM=;
        b=TvaQ0yLoOUu4da3W6v0KkTXSfeuALwDf/wx9dyqGIcB/K4v8PgJ8pyhcYa1klnlybuSR37
        pIJnfoxxPXr8VmbFPSnsOuIbFffHGkz3IMCUXYRjSHKzxquX3SFslUotXwtnmPefdo+DVk
        Oqf+4GRXTV0qQkI3uPgUjW0xTMdnqy4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-rrBKklPMOyukN_BfXln_Lw-1; Tue, 14 Sep 2021 07:57:28 -0400
X-MC-Unique: rrBKklPMOyukN_BfXln_Lw-1
Received: by mail-wm1-f70.google.com with SMTP id z18-20020a1c7e120000b02902e69f6fa2e0so6340529wmc.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 04:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kjBNsUJZhb+CoTbkZeanK9icxsVOilejMTC0HAi65SM=;
        b=qmID5Q143HuJA+eKtUlnRB4W7woGF4v9RccB0GWLhs7/Uo5AyQ4fm8Pm6Gp9Bj2GMC
         FyUXTMB2ElxtZ0WbOGIIFJmMWERnVe9toUG0F8bQZ/hN8W6wDNiIiXFcxHIdSO96W8Pd
         IYrJkaZd63kgx50Dd08rhH2iy35xe8OiIrn3/66YL98N+V3gBLTA7DoCyrhAxkepYNNl
         p/p+fAFgxAQUVivIrTf1auYRitGH2PfnQdlK+6VSwfBZxL0ryyRrpa0qBj7Hxbl9/+va
         RNqOgxdUvFwvFuc2GXNFWSHpP+g/41f2wHF8ooIKh1Dew6wzTXZj/ooOMy7MrYqKJXlQ
         6mDg==
X-Gm-Message-State: AOAM533lSVTnqubUZE09uaNv1StD77+sKcMfgY165ZeR1DZPqBK26ZUu
        6iN2g2fjkBBLccGwf02+Na1XCZjm0BEcfvVoa+cttjKlvaTQaIxtQn+qEehv0UFTN6RC2myriW8
        3D1HQuitd90UE/ZnZ+AuF1Bvk
X-Received: by 2002:adf:b785:: with SMTP id s5mr18234000wre.30.1631620647014;
        Tue, 14 Sep 2021 04:57:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+Cp51cW71Hx/HXa3ft0tf4MRVU/E3ocxIO1LloVlrNFZuxeHhOo+RIIhwRu78LdbPvR4dbQ==
X-Received: by 2002:adf:b785:: with SMTP id s5mr18233980wre.30.1631620646792;
        Tue, 14 Sep 2021 04:57:26 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6041.dip0.t-ipconnect.de. [91.12.96.65])
        by smtp.gmail.com with ESMTPSA id i5sm10058563wrc.86.2021.09.14.04.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 04:57:26 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] virtio-mem: disallow mapping virtio-mem memory via
 /dev/mem
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Wang <jasowang@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
References: <20210902160919.25683-1-david@redhat.com>
 <20210902160919.25683-4-david@redhat.com>
 <20210903025630-mutt-send-email-mst@kernel.org>
 <e5344ed1-6aaf-9e0a-a32d-f7cf69fe5a34@redhat.com>
 <20210914075046-mutt-send-email-mst@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <cec01643-b6e4-0ba9-9c93-5c9c95939491@redhat.com>
Date:   Tue, 14 Sep 2021 13:57:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914075046-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.09.21 13:52, Michael S. Tsirkin wrote:
> On Tue, Sep 14, 2021 at 11:45:25AM +0200, David Hildenbrand wrote:
>> On 03.09.21 09:02, Michael S. Tsirkin wrote:
>>> On Thu, Sep 02, 2021 at 06:09:19PM +0200, David Hildenbrand wrote:
>>>> We don't want user space to be able to map virtio-mem device memory
>>>> directly (e.g., via /dev/mem) in order to have guarantees that in a sane
>>>> setup we'll never accidentially access unplugged memory within the
>>>> device-managed region of a virtio-mem device, just as required by the
>>>> virtio-spec.
>>>>
>>>> As soon as the virtio-mem driver is loaded, the device region is visible
>>>> in /proc/iomem via the parent device region. From that point on user space
>>>> is aware of the device region and we want to disallow mapping anything
>>>> inside that region (where we will dynamically (un)plug memory) until
>>>> the driver has been unloaded cleanly and e.g., another driver might take
>>>> over.
>>>>
>>>> By creating our parent IORESOURCE_SYSTEM_RAM resource with
>>>> IORESOURCE_EXCLUSIVE, we will disallow any /dev/mem access to our
>>>> device region until the driver was unloaded cleanly and removed the
>>>> parent region. This will work even though only some memory blocks are
>>>> actually currently added to Linux and appear as busy in the resource tree.
>>>>
>>>> So access to the region from user space is only possible
>>>> a) if we don't load the virtio-mem driver.
>>>> b) after unloading the virtio-mem driver cleanly.
>>>>
>>>> Don't build virtio-mem if access to /dev/mem cannot be restricticted --
>>>> if we have CONFIG_DEVMEM=y but CONFIG_STRICT_DEVMEM is not set.
>>>>
>>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>
>>>
>>>> ---
>>>>    drivers/virtio/Kconfig      | 1 +
>>>>    drivers/virtio/virtio_mem.c | 4 +++-
>>>>    2 files changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>>>> index ce1b3f6ec325..ff80cd03f1d1 100644
>>>> --- a/drivers/virtio/Kconfig
>>>> +++ b/drivers/virtio/Kconfig
>>>> @@ -101,6 +101,7 @@ config VIRTIO_MEM
>>>>    	depends on MEMORY_HOTPLUG_SPARSE
>>>>    	depends on MEMORY_HOTREMOVE
>>>>    	depends on CONTIG_ALLOC
>>>> +	depends on !DEVMEM || STRICT_DEVMEM
>>>>    	help
>>>>    	 This driver provides access to virtio-mem paravirtualized memory
>>>>    	 devices, allowing to hotplug and hotunplug memory.
>>>
>>> It would be nicer if there was a symbol in the MEMORY_ namespace
>>> we can depend on exported by mm and depending on !DEVMEM ||
>>> STRICT_DEVMEM.
>>>
>>> E.g.
>>>
>>> config MEMORY_EXCLUSIVE
>>>           def_bool y
>>>           depends on !DEVMEM || STRICT_DEVMEM
>>>
>>> and then in virtio
>>> 	depends on MEMORY_EXCLUSIVE
>>>
>>>
>>
>> Yes, but I'm not able to come up with an expressive name. MEMORY_EXCLUSIVE
>> can be highly misleading ...
> 
> 
> I mean ... it enables IORESOURCE_EXCLUSIVE ... but ok ...
> MEMORY_EXCLUSIVE_KERNEL_MAP ?

It enables IORESOURCE_EXCLUSIVE for IORESOURCE_SYSTEM_RAM ... and 
notably not for IORESOURCE_MEM.

MEMORY_EXCLUSIVE_SYSTEM_RAM ?

> 
>>
>>> the virtio change itself is ok though:
>>>
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> Thanks!
>>
>>
>> -- 
>> Thanks,
>>
>> David / dhildenb
> 


-- 
Thanks,

David / dhildenb

