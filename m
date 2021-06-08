Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C5239F746
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhFHNG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54047 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232651AbhFHNGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623157466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=63K+n8ra9EjWBL1NetjRp60dPBs6gFo+zF/xCw+Leec=;
        b=VupLRvgdI83sy0wpd3D6cgAknOwcLvyHWh5tkHo/bRpLuzwOOM+dbiT1NzvRPLg+gvKn3e
        FnU2QUFe4JLJcji0x0DHjMlxnnjyRqI6eNNGaoT59oTrYNfK5ETeqh4I8SoSZs+d0sOInj
        yFr1vEyPetW5hmjSEVFyIUIhUKXcvqw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-rKN5ZFhZPayVhwcp6Q1F5Q-1; Tue, 08 Jun 2021 09:04:25 -0400
X-MC-Unique: rKN5ZFhZPayVhwcp6Q1F5Q-1
Received: by mail-wr1-f72.google.com with SMTP id x9-20020adfffc90000b02901178add5f60so9437272wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 06:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=63K+n8ra9EjWBL1NetjRp60dPBs6gFo+zF/xCw+Leec=;
        b=OO50pZbWqB06ev/Ve4jlm2okxeXCjj9Wh2nf6/lNWV4GpIINjadNLEk9IYcCRAuCbN
         wu8Bkk5iyOtlcucu+h0NMeXq238FS4cxzI+JF3DpGacpnlBneWx01T44EnI8FWqxk3L7
         UvCgNFGtB05K0rert2QbGE0Ll6+NuOgEFypXimim9XypkjfKxc9gpBP3dVg8lnIjmwFS
         r3B2p4xbPVeSBGf6CXBTwrD+2x4CemirpKgqkQr56Gwfmvp337OYIX3C9hnpGAtMKJwR
         YMh/ca3N4oLrAbYWphWaU0P8CfQEPKya6M7q8rJel3td42pmTsQCGGtSC1z31zYLqdsh
         LRbA==
X-Gm-Message-State: AOAM533qr46EiFBumySsJlkIuDKpAYeI0z8Kjs/37o35EoWIBf9spPj1
        XHExgdoyXBXK6ejmc6Qa/90dHxD1sLkGxgfUALolT+Ya8DZSoLQiR/IOg4fNcp5uUdYgetllfmf
        6Svwx3mFzEp3EH/UhqccLZVnx
X-Received: by 2002:adf:f748:: with SMTP id z8mr23474722wrp.115.1623157463814;
        Tue, 08 Jun 2021 06:04:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKX+jixFhuThJLNsGu42jFOnM7fD2bzodnOrMQCqVuLLv2T84a1VIDJINmkFwrSXU0UYLhBg==
X-Received: by 2002:adf:f748:: with SMTP id z8mr23474659wrp.115.1623157463456;
        Tue, 08 Jun 2021 06:04:23 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c61cf.dip0.t-ipconnect.de. [91.12.97.207])
        by smtp.gmail.com with ESMTPSA id o5sm9828081wrw.65.2021.06.08.06.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 06:04:20 -0700 (PDT)
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-doc@vger.kernel.org
References: <20210525102604.8770-1-david@redhat.com>
 <YL4Ek6AqMUyiDrxY@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] memory-hotplug.rst: complete admin-guide overhaul
Message-ID: <5e01bd6f-4073-1ebb-489d-2e5c529909a2@redhat.com>
Date:   Tue, 8 Jun 2021 15:04:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YL4Ek6AqMUyiDrxY@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +ZONE_MOVABLE
>> +============
>> +
>> +ZONE_MOVABLE is an important mechanism for more reliable memory offlining.
>> +Further, having system RAM managed by ZONE_MOVABLE instead of one of the
>> +kernel zones can increase the number of possible transparent huge pages and
>> +dynamically allocated huge pages.
>> +
> 
> I'd move the first two paragraphs from "Zone Imbalances" here to provide
> some context what is movable and what is unmovable allocation.

Makes sense.

[...]

>> -How to offline memory
>> ----------------------
>> +Considerations
> 
> ZONE_MOVABLE Sizing Considerations ?
> 

Ack

> I'd also move the contents of "Boot Memory and ZONE_MOVABLE" here (with
> some adjustments):
> 
>    By default, all the memory configured at boot time is managed by the kernel
>    zones and ZONE_MOVABLE is not used.
> 
>    To enable ZONE_MOVABLE to include the memory present at boot and to
>    control the ratio between movable and kernel zones there are two command
>    line options: ``kernelcore=`` and ``movablecore=``. See
>    Documentation/admin-guide/kernel-parameters.rst for their description.
> 

Makes sense. I'll move it to the end of the "ZONE_MOVABLE Sizing 
Considerations" section.

>> +--------------
>>   
>> -You can offline a memory block by using the same sysfs interface that was used
>> -in memory onlining::
>> +We usually expect that a large portion of available system RAM will actually
>> +be consumed by user space, either directly or indirectly via the page cache. In
>> +the normal case, ZONE_MOVABLE can be used when allocating such pages just fine.
>>   
>> -	% echo offline > /sys/devices/system/memory/memoryXXX/state
>> +With that in mind, it makes sense that we can have a big portion of system RAM
>> +managed by ZONE_MOVABLE. However, there are some things to consider when
>> +using ZONE_MOVABLE, especially when fine-tuning zone ratios:
>>   
>> -If offline succeeds, the state of the memory block is changed to be "offline".
>> -If it fails, some error core (like -EBUSY) will be returned by the kernel.
>> -Even if a memory block does not belong to ZONE_MOVABLE, you can try to offline
>> -it.  If it doesn't contain 'unmovable' memory, you'll get success.
>> +- Having a lot of offline memory blocks. Even offline memory blocks consume
>> +  memory for metadata and page tables in the direct map; having a lot of
>> +  offline memory blocks is not a typical case, though.
>> +
>> +- Memory ballooning. Some memory ballooning implementations, such as
>> +  the Hyper-V balloon, the XEN balloon, the vbox balloon and the VMWare
> 
> So, everyone except virtio-mem? ;-)

Well, virtio-mem does not classify as memory balloon in that sense, as 
it only operates on own device memory ;)

virtio-balloon and pseries CMM support balloon compaction.

> I'd drop the names because if some of those will implement balloon
> compaction they surely will forget to update the docs.

I can do the opposite and mention the ones that already do. Some most 
probably will never support it.

"Memory ballooning without balloon compaction is incompatible with 
ZONE_MOVABLE. Only some implementations, such as virtio-balloon and 
pseries CMM, fully support balloon compaction."


> 
>> +  balloon with huge pages don't support balloon compaction and, thereby
>> +  ZONE_MOVABLE.
>> +
>> +  Further, CONFIG_BALLOON_COMPACTION might be disabled. In that case, balloon
>> +  inflation will only perform unmovable allocations and silently create a
>> +  zone imbalance, usually triggered by inflation requests from the
>> +  hypervisor.
>> +
>> +- Gigantic pages are unmovable, resulting in user space consuming a
>> +  lot of unmovable memory.
>> +
>> +- Huge pages are unmovable when an architectures does not support huge
>> +  page migration, resulting in a similar issue as with gigantic pages.
>> +
>> +- Page tables are unmovable. Excessive swapping, mapping extremely large
>> +  files or ZONE_DEVICE memory can be problematic, although only
>> +  really relevant in corner cases. When we manage a lot of user space memory
>> +  that has been swapped out or is served from a file/pmem/... we still need
> 
>                                                       ^ persistent memory

Agreed.

> 
>> +  a lot of page tables to manage that memory once user space accessed that
>> +  memory once.
>> +
>> +- DAX: when we have a lot of ZONE_DEVICE memory added to the system as DAX
>> +  and we are not using an altmap to allocate the memmap from device memory
>> +  directly, we will have to allocate the memmap for this memory from the
>> +  kernel zones.
> 
> I'm not sure admin-guide reader will know when we use altmap when we don't.
> Maybe
> 
>    DAX: in certain DAX configurations the memory map for the device memory will
>    be allocated from the kernel zones.

Indeed, simpler and communicates the same message.

I'll also add

"KASAN can have a significant memory overhead, for example, consuming 
1/8th of the total system memory size as (unmovable) tracking metadata."


Thanks Mike!

-- 
Thanks,

David / dhildenb

