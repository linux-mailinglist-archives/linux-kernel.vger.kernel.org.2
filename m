Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6531B447BBA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 09:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbhKHI0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 03:26:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237927AbhKHI0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 03:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636359800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X09/Wf7+2r8y3w0MNY/PV0bQTpv1cgLMiBeLAHQWWQ0=;
        b=XFKJLwIx/SGxsLGGVnF5UohWoJcQUEWW+tRXLR02r/oPv4b6/xf1AC4fjg+XeFNB1RSrxt
        J5eglIgc74y5kg9a59krkJnoUCSUzsr5SA7IWhGaLK6uFs+WHyl/feaWC4xqVWQMzxam9N
        twGuSbCuNCnGDOsInOLWbUvnIt9OFF4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-ehe82XK2OBSuG4m6egkLbg-1; Mon, 08 Nov 2021 03:23:19 -0500
X-MC-Unique: ehe82XK2OBSuG4m6egkLbg-1
Received: by mail-wr1-f71.google.com with SMTP id v18-20020a5d5912000000b001815910d2c0so3779746wrd.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 00:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=X09/Wf7+2r8y3w0MNY/PV0bQTpv1cgLMiBeLAHQWWQ0=;
        b=tlo4UNahIom2Cp/QUgnhw/kI/Q7oqXBtmApQ4l4rWhNZJBSJMrQBDwFmkVz3MlAP7A
         7UkUlevmNTcSGaIDiamkhBtMGZxJa1xx6HA9ftw0zAsazARgzY0NRCeoDEd6DEpBcG25
         EM64EVnANm8gBetfTAIUwOZiCpSUwhn5GDKxzX6BC9TjAkBh1OW9B4yqvq0U5AwR7HU1
         zgZCB/xOYncvmZ642y0M+HmvW8Qjdzy3GFdfH0EaJXTTZBRGCMnS7sxo6jWP6y/IVyIe
         Yx80MO2E0p51ZYKMOz8oOjYc8K4+0ztUZqmAkvDGXppurHkQf9b2onYJJyEGLvgW/dXo
         PiTA==
X-Gm-Message-State: AOAM5327d3FhrkkYevYPOxDecktovu4C53OiQWdxPQKZcE5zdUdLPUJR
        gK1x5k8NT0PYGdGRqFu7j3n0smVW+T4EF9qzh8SnzPA+QgoVv39G4ulc3iNfINOnVm41twqGRbh
        cMOpF4ec258tdLGLsaCXYjjZ4
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr31031032wrz.286.1636359798759;
        Mon, 08 Nov 2021 00:23:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXPUypB/w4+MfLIgKakWtF8xsXW0dqm7QdItXyKpO2KOl7Hi4ZaHDUW312TnrLnZYKTxjv2g==
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr31031014wrz.286.1636359798548;
        Mon, 08 Nov 2021 00:23:18 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6108.dip0.t-ipconnect.de. [91.12.97.8])
        by smtp.gmail.com with ESMTPSA id j40sm16090857wms.16.2021.11.08.00.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 00:23:17 -0800 (PST)
Message-ID: <52d4711c-8034-d81f-865f-ff45e4359cad@redhat.com>
Date:   Mon, 8 Nov 2021 09:23:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mm/kmemleak: Avoid scanning potential huge holes
Content-Language: en-US
To:     Lang Yu <Lang.Yu@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
References: <20211105035241.1239751-1-lang.yu@amd.com>
 <db19fb83-7a96-605e-65ba-10e01391530d@redhat.com>
 <YYjRcGEW+snSyppV@lang-desktop>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YYjRcGEW+snSyppV@lang-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.11.21 08:27, Lang Yu wrote:
> On Fri, Nov 05, 2021 at 02:14:50PM +0100, David Hildenbrand wrote:
>> On 05.11.21 04:52, Lang Yu wrote:
>>> When using devm_request_free_mem_region() and
>>> devm_memremap_pages() to add ZONE_DEVICE memory, if requested
>>> free mem region pfn were huge(e.g., 0x400000000 ,we found
>>> on some amd apus, amdkfd svm will request a such free mem region),
>>> the node_end_pfn() will be also huge(see move_pfn_range_to_zone()).
>>> It creates a huge hole between node_start_pfn() and node_end_pfn().
>>>
>>> In such a case, following code snippet acctually was
>>> just doing busy test_bit() looping on the huge hole.
>>>
>>> for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>>> 	struct page *page = pfn_to_online_page(pfn);
>>> 		if (!page)
>>> 			continue;
>>> 	...
>>> }
>>>
>>> So we got a soft lockup:
>>>
>>>  watchdog: BUG: soft lockup - CPU#6 stuck for 26s! [bash:1221]
>>>  CPU: 6 PID: 1221 Comm: bash Not tainted 5.15.0-custom #1
>>>  RIP: 0010:pfn_to_online_page+0x5/0xd0
>>>  Call Trace:
>>>   ? kmemleak_scan+0x16a/0x440
>>>   kmemleak_write+0x306/0x3a0
>>>   ? common_file_perm+0x72/0x170
>>>   full_proxy_write+0x5c/0x90
>>>   vfs_write+0xb9/0x260
>>>   ksys_write+0x67/0xe0
>>>   __x64_sys_write+0x1a/0x20
>>>   do_syscall_64+0x3b/0xc0
>>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>
>>> I did some tests with the patch.
>>>
>>> (1) amdgpu module unloaded
>>>
>>> before the patch:
>>>
>>> real    0m0.976s
>>> user    0m0.000s
>>> sys     0m0.968s
>>>
>>> after the patch:
>>>
>>> real    0m0.981s
>>> user    0m0.000s
>>> sys     0m0.973s
>>>
>>> (2) amdgpu module loaded
>>>
>>> before the patch:
>>>
>>> real    0m35.365s
>>> user    0m0.000s
>>> sys     0m35.354s
>>>
>>> after the patch:
>>>
>>> real    0m1.049s
>>> user    0m0.000s
>>> sys     0m1.042s
>>>
>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>> ---
>>>  mm/kmemleak.c | 9 +++++----
>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>>> index b57383c17cf6..d07444613a84 100644
>>> --- a/mm/kmemleak.c
>>> +++ b/mm/kmemleak.c
>>> @@ -1403,6 +1403,7 @@ static void kmemleak_scan(void)
>>>  {
>>>  	unsigned long flags;
>>>  	struct kmemleak_object *object;
>>> +	struct zone *zone;
>>>  	int i;
>>>  	int new_leaks = 0;
>>>  
>>> @@ -1443,9 +1444,9 @@ static void kmemleak_scan(void)
>>>  	 * Struct page scanning for each node.
>>>  	 */
>>>  	get_online_mems();
>>> -	for_each_online_node(i) {
>>> -		unsigned long start_pfn = node_start_pfn(i);
>>> -		unsigned long end_pfn = node_end_pfn(i);
>>> +	for_each_populated_zone(zone) {
>>> +		unsigned long start_pfn = zone->zone_start_pfn;
>>> +		unsigned long end_pfn = zone_end_pfn(zone);
>>>  		unsigned long pfn;
>>>  
>>>  		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>>> @@ -1455,7 +1456,7 @@ static void kmemleak_scan(void)
>>>  				continue;
>>>  
>>>  			/* only scan pages belonging to this node */
>>> -			if (page_to_nid(page) != i)
>>> +			if (page_to_nid(page) != zone_to_nid(zone))
>>
>> With overlapping zones you might rescan ranges ... instead we should do:
>>
>> /* only scan pages belonging to this zone */
>> if (zone != page_zone(page))
>> 	...
>>
>> Or alternatively:
>>
>> /* only scan pages belonging to this node */
>> if (page_to_nid(page) != zone_to_nid(zone))
>> 	continue;
>> /* only scan pages belonging to this zone */
>> if (page_zonenum(page) != zone_idx(zone))
>> 	continue;
> 
> The original code has covered that, i.e., 
> only scan pages belonging to this node.
> I didn't change that behavior.

Again, you can easily have overlapping zones -- ZONE_NORMAL and
ZONE_MOVABLE -- in which case, a PFN is spanned by multiple zones, but
only belongs to a single zone.

The original code would scan each PFN exactly once, as it was iterating
the node PFNs. Your changed code might scan a single PFN multiple times,
if it's spanned by multiple zones.

-- 
Thanks,

David / dhildenb

