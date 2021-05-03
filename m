Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E081A37125A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 10:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhECIRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 04:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232831AbhECIRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 04:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620029769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uB/EYYvRDIWzIKd9NUtpds132sJrn5ZaXZy/6UA0sM=;
        b=agNuSzL4sB4nJM4a3ImhqRPGf9dsq2uqox2rNh5P5drlhWCmH6CUsJFghV9LtZzg8p0cWD
        caMOtNW6dnCs5s/fF1f9y9yCsh/+DTo8XbP8psjPgtHzq3GkY6ilJ/68nNSfd3gxAKGXsj
        W2/xoGK9LsmNfoen7UyuhUj7L2C2XV8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-6wZj9jtVNx-6AhASptlVWg-1; Mon, 03 May 2021 04:16:06 -0400
X-MC-Unique: 6wZj9jtVNx-6AhASptlVWg-1
Received: by mail-ed1-f71.google.com with SMTP id s20-20020a0564025214b029038752a2d8f3so4105533edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 01:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3uB/EYYvRDIWzIKd9NUtpds132sJrn5ZaXZy/6UA0sM=;
        b=Md4yJMhhuaWerBR/loIrt+HmjRwg/jAp4MbFJwglPjA1kVDwGYJ8x7EizkyBkuInMP
         GUIbJ5oXPW/eRwaFQLtGH7TvYR5t7VlTTPR9Mdk1xs1cRqKGwop1mXuxKZd3qppN6hDN
         oLIdAsxuvmqpXOTsDehAuIeXUCQlazoex1ueE01oo15aQWbAIv5WsuyhrBZaym3uyatE
         Nalft9me1OD74v2BhaeYNKZv4QmtWUMmE1q+uVffXeygx8kBQQUMyAlfAOOKhMbdFfWf
         dT4/249o94805XDcM3ya+xBPUV9he/OksZyyIEzz9n98KsGs0raP5ZTPS4V3Scom//iN
         3Osg==
X-Gm-Message-State: AOAM530odgnSCG0zRljg+AGAHUH+p45jlciAJGWkgcVTdK6x/V9IpXcg
        /6mK6x4OEKUgx3SNQ4XeX2zfwgruOWhfO+OozfVKPMPUja7LtikUTdEjEsomeSijPrnazxv6tzr
        IIegUeVU12nUV2YolH0qjBajy
X-Received: by 2002:a17:906:8147:: with SMTP id z7mr11677881ejw.496.1620029764846;
        Mon, 03 May 2021 01:16:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5t6QJnu76x0vRJx5wjyCiN1MvkzdCqG/1DMVBAPOiuRhGpdYa0HWbVhYZGZKhNk34vPvb6A==
X-Received: by 2002:a17:906:8147:: with SMTP id z7mr11677854ejw.496.1620029764611;
        Mon, 03 May 2021 01:16:04 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c649f.dip0.t-ipconnect.de. [91.12.100.159])
        by smtp.gmail.com with ESMTPSA id lr15sm4554094ejb.107.2021.05.03.01.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 01:16:04 -0700 (PDT)
Subject: Re: [PATCH v1 6/7] virtio-mem: use page_offline_(start|end) when
 setting PageOffline()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Price <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Aili Yao <yaoaili@kingsoft.com>, Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-7-david@redhat.com> <YI5HzXN7+ZTNXtcI@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <98f22a46-da8b-2891-fade-09937c0ccf69@redhat.com>
Date:   Mon, 3 May 2021 10:16:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YI5HzXN7+ZTNXtcI@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.05.21 08:33, Mike Rapoport wrote:
> On Thu, Apr 29, 2021 at 02:25:18PM +0200, David Hildenbrand wrote:
>> Let's properly use page_offline_(start|end) to synchronize setting
>> PageOffline(), so we won't have valid page access to unplugged memory
>> regions from /proc/kcore.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   drivers/virtio/virtio_mem.c | 2 ++
>>   mm/util.c                   | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>> index 10ec60d81e84..dc2a2e2b2ff8 100644
>> --- a/drivers/virtio/virtio_mem.c
>> +++ b/drivers/virtio/virtio_mem.c
>> @@ -1065,6 +1065,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
>>   static void virtio_mem_set_fake_offline(unsigned long pfn,
>>   					unsigned long nr_pages, bool onlined)
>>   {
>> +	page_offline_begin();
>>   	for (; nr_pages--; pfn++) {
>>   		struct page *page = pfn_to_page(pfn);
>>   
>> @@ -1075,6 +1076,7 @@ static void virtio_mem_set_fake_offline(unsigned long pfn,
>>   			ClearPageReserved(page);
>>   		}
>>   	}
>> +	page_offline_end();
> 
> I'm not really familiar with ballooning and memory hotplug, but is it the
> only place that needs page_offline_{begin,end} ?

Existing balloon implementations that I am aware of (Hyper-V, XEN, 
virtio-balloon, vmware-balloon) usually allow reading inflated memory; 
doing so might result in unnecessary overhead in the hypervisor, so we 
really want to avoid it -- but it's strictly not forbidden and has been 
working forever. So we barely care about races: if there would be a rare 
race, we'd still be able to read that memory.

For virtio-mem, it'll be different in the future when using shmem, huge 
pages, !anonymous private mappings, ... as backing storage for a VM; 
there will be a virtio spec extension to document that virtio-mem 
changes that indicate the new behavior won't allow reading unplugged 
memory and doing so will result in undefined behavior.

-- 
Thanks,

David / dhildenb

