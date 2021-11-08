Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9A0447CB5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 10:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbhKHJ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 04:27:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236043AbhKHJ1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 04:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636363486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybeFSdtAZ4EwMpS3+3Y/SQeUtl6qQqpL/8+hRad1ie0=;
        b=WRjtmB0KKrngFXzTOXN8YaEjvffePEhi7b9kLdiGjiiKvgxrkf5pxYT6Eq1ldo5Nz9+PIe
        dfP8k/IzkXQlGMB1MIJhiGI8gaxN8lgPn8rEWraTX9b8mE+6i29Pd3lVOdNASaLu66EOdK
        hlPbSxknPwh2WWv5vJ3TxreDNW4EE+o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-GPBY1mOaNiuV1viQGFDUWQ-1; Mon, 08 Nov 2021 04:24:45 -0500
X-MC-Unique: GPBY1mOaNiuV1viQGFDUWQ-1
Received: by mail-wm1-f70.google.com with SMTP id 128-20020a1c0486000000b0030dcd45476aso5975319wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 01:24:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=ybeFSdtAZ4EwMpS3+3Y/SQeUtl6qQqpL/8+hRad1ie0=;
        b=FV0onxZBHJ+mTx0iVR3N6jAsoWAnsw2K0tiyU6Mbt//hxUEFQYs5NlqDW4migsaJ+J
         ga+IZxt1U75rD5JuCZetC8/UKY7xj8z8Z5EpSVfg3vcQw9HQcnsPLgNjj2zLynYWnN3P
         bjCNKrfMa3kwFYQBWFVTxBLn9ZTi9Bdv7jM0cQk1+uOjfu02JQFBjy3ynwBatUYvZnrr
         0HO2qgjFqQmmSeGOqfyxYBwsU6k6CANZI24HhGiKYWtlyKNajjI5/ZFCYl8M4dvizeFV
         A36rqyDtljjiQHx5dCn9cE9DcXiENEEq3M6C4lKa5tar4p6VXEjdr7Z0EEJgH/rxy29O
         HQiw==
X-Gm-Message-State: AOAM533cICFvFkQIMkq/OHh6lArz7k5hGi9Txx17+zfuRRksfcRIqwvb
        tvu7jlh1FEBMTA9SVAx8J4LwNMhSz3RA1z3qPRZ50NLPZTBDPSWOQIUB5odOLw9V3Lo1jwm9Sl+
        BPTyTPiEkZsuy7uUUyRxmT0DH
X-Received: by 2002:adf:e84d:: with SMTP id d13mr79210297wrn.72.1636363484627;
        Mon, 08 Nov 2021 01:24:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOnpR/fEzwYG5rDmzJ34LZtESJyB3uTFiClm2vRx6xAbVq0FmYn3J2SxRUbUrYlk9JsU3qhA==
X-Received: by 2002:adf:e84d:: with SMTP id d13mr79210266wrn.72.1636363484362;
        Mon, 08 Nov 2021 01:24:44 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6108.dip0.t-ipconnect.de. [91.12.97.8])
        by smtp.gmail.com with ESMTPSA id w1sm18504690wmc.19.2021.11.08.01.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 01:24:44 -0800 (PST)
Message-ID: <a82d57cc-c99a-406c-15b7-3e92975dc452@redhat.com>
Date:   Mon, 8 Nov 2021 10:24:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Lang Yu <Lang.Yu@amd.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
References: <20211105035241.1239751-1-lang.yu@amd.com>
 <db19fb83-7a96-605e-65ba-10e01391530d@redhat.com>
 <YYjRcGEW+snSyppV@lang-desktop>
 <52d4711c-8034-d81f-865f-ff45e4359cad@redhat.com>
 <YYjomTdnLg4L6ppm@lang-desktop>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/kmemleak: Avoid scanning potential huge holes
In-Reply-To: <YYjomTdnLg4L6ppm@lang-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.11.21 10:06, Lang Yu wrote:
> On Mon, Nov 08, 2021 at 09:23:16AM +0100, David Hildenbrand wrote:
>> On 08.11.21 08:27, Lang Yu wrote:
>>> On Fri, Nov 05, 2021 at 02:14:50PM +0100, David Hildenbrand wrote:
>>>> On 05.11.21 04:52, Lang Yu wrote:
>>>>> When using devm_request_free_mem_region() and
>>>>> devm_memremap_pages() to add ZONE_DEVICE memory, if requested
>>>>> free mem region pfn were huge(e.g., 0x400000000 ,we found
>>>>> on some amd apus, amdkfd svm will request a such free mem region),
>>>>> the node_end_pfn() will be also huge(see move_pfn_range_to_zone()).
>>>>> It creates a huge hole between node_start_pfn() and node_end_pfn().
>>>>>
>>>>> In such a case, following code snippet acctually was
>>>>> just doing busy test_bit() looping on the huge hole.
>>>>>
>>>>> for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>>>>> 	struct page *page = pfn_to_online_page(pfn);
>>>>> 		if (!page)
>>>>> 			continue;
>>>>> 	...
>>>>> }
>>>>>
>>>>> So we got a soft lockup:
>>>>>
>>>>>  watchdog: BUG: soft lockup - CPU#6 stuck for 26s! [bash:1221]
>>>>>  CPU: 6 PID: 1221 Comm: bash Not tainted 5.15.0-custom #1
>>>>>  RIP: 0010:pfn_to_online_page+0x5/0xd0
>>>>>  Call Trace:
>>>>>   ? kmemleak_scan+0x16a/0x440
>>>>>   kmemleak_write+0x306/0x3a0
>>>>>   ? common_file_perm+0x72/0x170
>>>>>   full_proxy_write+0x5c/0x90
>>>>>   vfs_write+0xb9/0x260
>>>>>   ksys_write+0x67/0xe0
>>>>>   __x64_sys_write+0x1a/0x20
>>>>>   do_syscall_64+0x3b/0xc0
>>>>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>>
>>>>> I did some tests with the patch.
>>>>>
>>>>> (1) amdgpu module unloaded
>>>>>
>>>>> before the patch:
>>>>>
>>>>> real    0m0.976s
>>>>> user    0m0.000s
>>>>> sys     0m0.968s
>>>>>
>>>>> after the patch:
>>>>>
>>>>> real    0m0.981s
>>>>> user    0m0.000s
>>>>> sys     0m0.973s
>>>>>
>>>>> (2) amdgpu module loaded
>>>>>
>>>>> before the patch:
>>>>>
>>>>> real    0m35.365s
>>>>> user    0m0.000s
>>>>> sys     0m35.354s
>>>>>
>>>>> after the patch:
>>>>>
>>>>> real    0m1.049s
>>>>> user    0m0.000s
>>>>> sys     0m1.042s
>>>>>
>>>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>>>> ---
>>>>>  mm/kmemleak.c | 9 +++++----
>>>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>>>>> index b57383c17cf6..d07444613a84 100644
>>>>> --- a/mm/kmemleak.c
>>>>> +++ b/mm/kmemleak.c
>>>>> @@ -1403,6 +1403,7 @@ static void kmemleak_scan(void)
>>>>>  {
>>>>>  	unsigned long flags;
>>>>>  	struct kmemleak_object *object;
>>>>> +	struct zone *zone;
>>>>>  	int i;
>>>>>  	int new_leaks = 0;
>>>>>  
>>>>> @@ -1443,9 +1444,9 @@ static void kmemleak_scan(void)
>>>>>  	 * Struct page scanning for each node.
>>>>>  	 */
>>>>>  	get_online_mems();
>>>>> -	for_each_online_node(i) {
>>>>> -		unsigned long start_pfn = node_start_pfn(i);
>>>>> -		unsigned long end_pfn = node_end_pfn(i);
>>>>> +	for_each_populated_zone(zone) {
>>>>> +		unsigned long start_pfn = zone->zone_start_pfn;
>>>>> +		unsigned long end_pfn = zone_end_pfn(zone);
>>>>>  		unsigned long pfn;
>>>>>  
>>>>>  		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>>>>> @@ -1455,7 +1456,7 @@ static void kmemleak_scan(void)
>>>>>  				continue;
>>>>>  
>>>>>  			/* only scan pages belonging to this node */
>>>>> -			if (page_to_nid(page) != i)
>>>>> +			if (page_to_nid(page) != zone_to_nid(zone))
>>>>
>>>> With overlapping zones you might rescan ranges ... instead we should do:
>>>>
>>>> /* only scan pages belonging to this zone */
>>>> if (zone != page_zone(page))
>>>> 	...
>>>>
>>>> Or alternatively:
>>>>
>>>> /* only scan pages belonging to this node */
>>>> if (page_to_nid(page) != zone_to_nid(zone))
>>>> 	continue;
>>>> /* only scan pages belonging to this zone */
>>>> if (page_zonenum(page) != zone_idx(zone))
>>>> 	continue;
>>>
>>> The original code has covered that, i.e., 
>>> only scan pages belonging to this node.
>>> I didn't change that behavior.
>>
>> Again, you can easily have overlapping zones -- ZONE_NORMAL and
>> ZONE_MOVABLE -- in which case, a PFN is spanned by multiple zones, but
>> only belongs to a single zone.
>>
>> The original code would scan each PFN exactly once, as it was iterating
>> the node PFNs. Your changed code might scan a single PFN multiple times,
>> if it's spanned by multiple zones.
>>
> 
> Did you mean a single PFN is shared by multiple zones belonging to the 
> same node here? Thanks!

Not shared, spanned. A PFN always belongs to exactly one ZONE+NODE, but
might be "spanned" by multiple nodes or multiple zones, because nodes
and zones can overlap We can get the actual zone of a PFN via
page_zone(page) in my example above. Note that checking for the zone
structure (not the zone number/idx) implicitly checks for the node.


Let's take a look at an example:

...
[root@vm-0 ~]# cat /sys/devices/system/memory/memory32/valid_zones
Normal
[root@vm-0 ~]# cat /sys/devices/system/memory/memory33/valid_zones
Normal
[root@vm-0 ~]# cat /sys/devices/system/memory/memory34/valid_zones
Normal
[root@vm-0 ~]# cat /sys/devices/system/memory/memory35/valid_zones
Normal
[root@vm-0 ~]# cat /sys/devices/system/memory/memory36/valid_zones
Normal
[root@vm-0 ~]# cat /sys/devices/system/memory/memory37/valid_zones
Normal
[root@vm-0 ~]# cat /sys/devices/system/memory/memory38/valid_zones
Normal
[root@vm-0 ~]# cat /sys/devices/system/memory/memory39/valid_zones
Normal
[root@vm-0 ~]# cat /sys/devices/system/memory/memory40/valid_zones
Movable
[root@vm-0 ~]# cat /sys/devices/system/memory/memory41/valid_zones
Normal
[root@vm-0 ~]# cat /sys/devices/system/memory/memory42/valid_zones
Movable
[root@vm-0 ~]# cat /sys/devices/system/memory/memory43/valid_zones
Normal
[root@vm-0 ~]# cat /sys/devices/system/memory/memory44/valid_zones
Movable
[root@vm-0 ~]# cat /sys/devices/system/memory/memory45/valid_zones
Normal
[root@vm-0 ~]# cat /sys/devices/system/memory/memory46/valid_zones
Movable
[root@vm-0 ~]# cat /sys/devices/system/memory/memory47/valid_zones
Normal
[root@vm-0 ~]# cat /sys/devices/system/memory/memory48/valid_zones


# cat /proc/zoneinfo
Node 0, zone      DMA
	...
        spanned  4095
        present  3998
        managed  3977
	...
  start_pfn:           1
Node 0, zone    DMA32
	...
        spanned  1044480
        present  782304
        managed  765920
	...
  start_pfn:           4096
Node 0, zone   Normal
	...
        spanned  524288
        present  393216
        managed  365736
	...
  start_pfn:           1048576
Node 0, zone  Movable
	...
        spanned  229376
        present  131072
        managed  131072
  start_pfn:           1310720


So Normal spans:

1048576 -> 1572863

And Movable spans:

1310720 -> 1540095

Both zones overlap.

-- 
Thanks,

David / dhildenb

