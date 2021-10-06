Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526C9423952
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbhJFIEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50390 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237665AbhJFIDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633507304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c35aybOfo9pBjuNizm0LjauEBD0q9opIWAMl2tyAep0=;
        b=LdrdiA+2xxFC59rAs2/qm2JXf1/wUBotuHiI+5uVmNi1J5E9/QkoK3qz+zslMFgOKfR3yd
        QaGbqpS/YcgwAbtRXMk2UNRG+rm8cj6aVmsRB0FDyci8jna6VTdGak9yw/qpSW2Tdg4WMg
        JDNSzyol2C2d0sbJ4EAJHWuGwu/DlK0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-A8aMZPn9Nu2mpVp5AXU5Vw-1; Wed, 06 Oct 2021 04:01:41 -0400
X-MC-Unique: A8aMZPn9Nu2mpVp5AXU5Vw-1
Received: by mail-wr1-f72.google.com with SMTP id 75-20020adf82d1000000b00160cbb0f800so550999wrc.22
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 01:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=c35aybOfo9pBjuNizm0LjauEBD0q9opIWAMl2tyAep0=;
        b=qaLEnzPdBHS3fKVjevmhiJZgJbON78u/5fffYTkvyQpjuMyun2mMTcAv3rlo3YP+yx
         bK8kO4pf193KgVJu9LIY70JYloqfQPgcpLt6Z+zwWWhZshr+H7FOcSl36yKeHM3bVYrb
         N0S+7a3NT0xXXs0UCbZC9YbH0z65IOYN4rSaGT2bRt80DjUcJ1qJwRqMBx7ruqnNe8bP
         nkqOhNuxRIeJdvGY1e7pHX5dOMOPOl2ffYW22cFophM02oa1KdBkX6mPE/YTjE7HSzhG
         +2EiJ85bz7DZqCYDebC1f9QeHvcoJB0zKiATYGhIeIg2gEx+pnQ4zQXye9t8Bya+A0I6
         MP7A==
X-Gm-Message-State: AOAM5307UZR3/YjVdtQVe4ywxJtxI3oN5l6vQKYTEBYkDLGk6n09AkTt
        +eegYBOziLQAedMEr4Uq7FdqmFJCXqcCzFs0s/xidMpwIrWlNXjGvQqhGSDCjr+6WmkeJFGnVrv
        yjVn/DSMqU41d6VhCwD85PpY0
X-Received: by 2002:a05:600c:1992:: with SMTP id t18mr2699806wmq.48.1633507300619;
        Wed, 06 Oct 2021 01:01:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyJvYkKNT0PnZsl8y/R4yENzonm/o0NU+J2mMwAgmnH5NfAQA3pCU7qmNSg1WRzAjBTWX+Xg==
X-Received: by 2002:a05:600c:1992:: with SMTP id t18mr2699788wmq.48.1633507300300;
        Wed, 06 Oct 2021 01:01:40 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6529.dip0.t-ipconnect.de. [91.12.101.41])
        by smtp.gmail.com with ESMTPSA id a2sm6465397wru.82.2021.10.06.01.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 01:01:39 -0700 (PDT)
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
References: <20210930144117.23641-1-david@redhat.com>
 <20210930144117.23641-4-david@redhat.com> <YVzvYmf4xWC1DORO@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 3/3] memory-hotplug.rst: document the "auto-movable"
 online policy
Message-ID: <4bab9000-0b49-a852-d574-1c8b2fe10de1@redhat.com>
Date:   Wed, 6 Oct 2021 10:01:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVzvYmf4xWC1DORO@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.21 02:35, Mike Rapoport wrote:
> On Thu, Sep 30, 2021 at 04:41:17PM +0200, David Hildenbrand wrote:
>> In commit e83a437faa62 ("mm/memory_hotplug: introduce "auto-movable" online
>> policy") we introduced a new memory online policy to automatically
>> select a zone for memory blocks to be onlined. We added a way to
>> set the active online policy and tunables for the auto-movable online
>> policy. In follow-up commits we tweaked the "auto-movable" policy to also
>> consider memory device details when selecting zones for memory blocks to
>> be onlined.
>>
>> Let's document the new toggles and how the two online policies we have
>> work.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   .../admin-guide/mm/memory-hotplug.rst         | 128 +++++++++++++++---
>>   1 file changed, 108 insertions(+), 20 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
>> index ee00b70dedde..c20a2c0031cf 100644
>> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
>> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
>> @@ -165,9 +165,8 @@ Or alternatively::
>>   
>>   	% echo 1 > /sys/devices/system/memory/memoryXXX/online
>>   
>> -The kernel will select the target zone automatically, usually defaulting to
>> -``ZONE_NORMAL`` unless ``movable_node`` has been specified on the kernel
>> -command line or if the memory block would intersect the ZONE_MOVABLE already.
>> +The kernel will select the target zone automatically, depending on the
>> +configured ``online_policy``.
>>   
>>   One can explicitly request to associate an offline memory block with
>>   ZONE_MOVABLE by::
>> @@ -198,6 +197,9 @@ Auto-onlining can be enabled by writing ``online``, ``online_kernel`` or
>>   
>>   	% echo online > /sys/devices/system/memory/auto_online_blocks
>>   
>> +Similarly to manual onlining, with ``online`` the kernel will select the
>> +target zone automatically, depending on the configured ``online_policy``.
>> +
>>   Modifying the auto-online behavior will only affect all subsequently added
>>   memory blocks only.
>>   
>> @@ -393,9 +395,11 @@ command line parameters are relevant:
>>   ======================== =======================================================
>>   ``memhp_default_state``	 configure auto-onlining by essentially setting
>>                            ``/sys/devices/system/memory/auto_online_blocks``.
>> -``movable_node``	 configure automatic zone selection in the kernel. When
>> -			 set, the kernel will default to ZONE_MOVABLE, unless
>> -			 other zones can be kept contiguous.
>> +``movable_node``	 configure automatic zone selection in the kernel when
>> +			 using the ``contig-zones`` online policy. When
>> +			 set, the kernel will default to ZONE_MOVABLE when
>> +			 onlining a memory block, unless other zones can be kept
>> +			 contiguous.
> 
> The movable_node main purpose is to allow unplugging an entire node. Zone
> selection is a consequence of this. You may want to cite the description of
> movable_node in kernel-paramenters.txt here.

Right, I only document the effects of these parameters on memory 
hot(un)plug.

What about:

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst 
b/Documentation/admin-guide/mm/memory-hotplug.rst
index c20a2c0031cf..f8976ded0863 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -402,6 +402,9 @@ command line parameters are relevant:
                          contiguous.
  ======================== 
=======================================================

+See Documentation/admin-guide/kernel-parameters.txt for a more generic
+description of these command line parameters.
+
  Module Parameters
  ------------------


> 
> And, pardon my ignorance, how movable_node will play with auto-movable
> policy?

It's essentially ignored with the auto-movable policy for memory 
hotplugged after boot (!MEMBLOCK_HOTPLUG). That's why only the 
description of "contig-zones" below describes how it interacts with the 
``movable_node``, and we make it clear here that it's restricted to the 
"contig-zones" policy as well.

<details>
Bare metal, where we care about reliably unplugging hotplugged memory 
usually configures auto-onlining to "online_movable": for example, 
that's the case on RHEL. auto-movable doesn't make too much sense for 
bare metal: the nature of "movable_node" is to essentially online 
anything that might get hotunplugged MOVABLE, especially after 
hotplugging memory and rebooting: that is highly dangerous especially in 
virtualized environments.

"auto-movable" is valuable in virtualized environments, where we add 
memory via:
* add_memory_driver_managed() like virtio-mem, whereby such memory is
   never part of the firmware provided memory-map, so the policy is
   always in control even after a reboot.
* Hotplugged virtual DIMMs, such as provided by x86-64/arm64, whereby we
   don't include these DIMMs in the firmware-provided memory map, but
   ACPI code adds them after early boot, making it behave similar to
   add_memory_driver_managed() -- the policy is always in control even
   after a reboot.
</details>


Thanks!

-- 
Thanks,

David / dhildenb

