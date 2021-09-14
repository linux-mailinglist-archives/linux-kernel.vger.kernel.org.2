Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D8E40AB13
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhINJqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229706AbhINJqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631612729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E5LbE6tJqoUXws78/lpKd/8E8fVAHtF02Bi+7E0E5fs=;
        b=VfAU49d5BGQE41zBt+oMgrVKmS9tGl9Hje9XRIizSfXNGeanpmkLRdpvB+g+1y1OCVXEmM
        LHaKZwB6v/OmBDyr0OfwJiZha6c4IbR3YRogOel613Zks3Sj+hKxsY/UW83AJuUxsmcoKq
        /YyPoaGJOsizp5srZO9qx1isjJTplMk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-THp-K7pcPoeWmZy1j8_PeA-1; Tue, 14 Sep 2021 05:45:28 -0400
X-MC-Unique: THp-K7pcPoeWmZy1j8_PeA-1
Received: by mail-wm1-f72.google.com with SMTP id h1-20020a05600c350100b002e751bf6733so487086wmq.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 02:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=E5LbE6tJqoUXws78/lpKd/8E8fVAHtF02Bi+7E0E5fs=;
        b=0KOJl7Hiudx5Q3AgaBG33bSr+SYnRu9nwtm9RxcGOuhe/eCkvPMh5HLpR0q4Jnwnhg
         5/jBBjISfCRlRtyHAaCPJOR6ZJ98KPzLVkCMW3suKlEmPe5eq7edZMzgSEGHYS6py2vE
         lXVZ7STvVWs9KzvsWWJpVQpucyAUuy+Yg8sGikqjkJ9glvxpcj5OO5Mh/VhA0ycxol9m
         19njg/y2wdbNxE2P0yaX7w+Ud4xuVUX40Eo0lm0DrXHOJo3JsFpn23rNpaW5glWKLGSv
         LVhkQSChQXRXNPObBUED50wJzPGZGzFHBZ6raApAZ9SIug5PdaCyHIB/xNaIxP2xrIYD
         yvsg==
X-Gm-Message-State: AOAM533XZPjnsKpUAxXsarDNFKiNC/c1FwOOPpm83zJtrVZQ7MtYSzrt
        m3Cj0mEQGyV3EXHVT5NuyICnG0Xc16N7k+mwDj/B+pM0Vg0J/m+kz5fkjXaAOw8v14XXVwqhIc2
        5nCdaYGPjULQiPvxGj+ekzvMq
X-Received: by 2002:adf:9bdb:: with SMTP id e27mr17402900wrc.162.1631612727181;
        Tue, 14 Sep 2021 02:45:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8IcKWrpo+CJ7yCXWiJlrYgqbtEzRpSOIG2NkaYA3QbTjmbDrA7ukm1vPG4+wVUH0DoQ1dzw==
X-Received: by 2002:adf:9bdb:: with SMTP id e27mr17402881wrc.162.1631612726956;
        Tue, 14 Sep 2021 02:45:26 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6041.dip0.t-ipconnect.de. [91.12.96.65])
        by smtp.gmail.com with ESMTPSA id f5sm591405wmb.47.2021.09.14.02.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 02:45:26 -0700 (PDT)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <e5344ed1-6aaf-9e0a-a32d-f7cf69fe5a34@redhat.com>
Date:   Tue, 14 Sep 2021 11:45:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210903025630-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.09.21 09:02, Michael S. Tsirkin wrote:
> On Thu, Sep 02, 2021 at 06:09:19PM +0200, David Hildenbrand wrote:
>> We don't want user space to be able to map virtio-mem device memory
>> directly (e.g., via /dev/mem) in order to have guarantees that in a sane
>> setup we'll never accidentially access unplugged memory within the
>> device-managed region of a virtio-mem device, just as required by the
>> virtio-spec.
>>
>> As soon as the virtio-mem driver is loaded, the device region is visible
>> in /proc/iomem via the parent device region. From that point on user space
>> is aware of the device region and we want to disallow mapping anything
>> inside that region (where we will dynamically (un)plug memory) until
>> the driver has been unloaded cleanly and e.g., another driver might take
>> over.
>>
>> By creating our parent IORESOURCE_SYSTEM_RAM resource with
>> IORESOURCE_EXCLUSIVE, we will disallow any /dev/mem access to our
>> device region until the driver was unloaded cleanly and removed the
>> parent region. This will work even though only some memory blocks are
>> actually currently added to Linux and appear as busy in the resource tree.
>>
>> So access to the region from user space is only possible
>> a) if we don't load the virtio-mem driver.
>> b) after unloading the virtio-mem driver cleanly.
>>
>> Don't build virtio-mem if access to /dev/mem cannot be restricticted --
>> if we have CONFIG_DEVMEM=y but CONFIG_STRICT_DEVMEM is not set.
>>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> 
>> ---
>>   drivers/virtio/Kconfig      | 1 +
>>   drivers/virtio/virtio_mem.c | 4 +++-
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>> index ce1b3f6ec325..ff80cd03f1d1 100644
>> --- a/drivers/virtio/Kconfig
>> +++ b/drivers/virtio/Kconfig
>> @@ -101,6 +101,7 @@ config VIRTIO_MEM
>>   	depends on MEMORY_HOTPLUG_SPARSE
>>   	depends on MEMORY_HOTREMOVE
>>   	depends on CONTIG_ALLOC
>> +	depends on !DEVMEM || STRICT_DEVMEM
>>   	help
>>   	 This driver provides access to virtio-mem paravirtualized memory
>>   	 devices, allowing to hotplug and hotunplug memory.
> 
> It would be nicer if there was a symbol in the MEMORY_ namespace
> we can depend on exported by mm and depending on !DEVMEM ||
> STRICT_DEVMEM.
> 
> E.g.
> 
> config MEMORY_EXCLUSIVE
>          def_bool y
>          depends on !DEVMEM || STRICT_DEVMEM
> 
> and then in virtio
> 	depends on MEMORY_EXCLUSIVE
> 
> 

Yes, but I'm not able to come up with an expressive name. 
MEMORY_EXCLUSIVE can be highly misleading ...


> the virtio change itself is ok though:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks!


-- 
Thanks,

David / dhildenb

