Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9ED42870D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 08:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhJKGwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 02:52:21 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59287 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234300AbhJKGwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 02:52:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633935019; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=TXk71XK/vEYfwGU4P+f/iw8Xd38iVJG3pkx2rxci/YE=; b=O6pagYHDBssvjPsaPx8FIu28EH1E//PWyxaknHjShpq48eOc4lS/Z26iJtm7IKPY3aoIfIyb
 wRlhFO37mewvuRbZb/cfayY8yuiRRkutc/V/lKbxiu5UopzoAlcNdzhQ8fsD0zaPncag1GC/
 +ngXl8ZUoRxxDyQ5i4JEn7qiROQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6163de9cab9da96e644ca561 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 06:50:04
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EC710C4360C; Mon, 11 Oct 2021 06:50:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.109] (unknown [49.204.182.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70D17C4338F;
        Mon, 11 Oct 2021 06:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 70D17C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v1] mm: page_alloc: Add debug log in free_reserved_area
 for static memory
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     guptap@codeaurora.org
References: <1632819849-511-1-git-send-email-faiyazm@codeaurora.org>
 <248ec931-7c16-3e2d-cc8f-8ce0dd4e923b@redhat.com>
 <0149edd5-fe7f-2786-413c-6de2eab3e30c@codeaurora.org>
 <ab7a9fb0-a3e7-0cb8-6dbd-40a68e6fd299@redhat.com>
 <1f6708d2-1ca8-6d1f-d9f0-855f2df755ed@codeaurora.org>
 <d5a2e107-70e2-30b5-6723-9eea6650517a@redhat.com>
 <88df48af-901b-5765-d92c-6d14c2b1f73e@codeaurora.org>
 <aee9523c-4930-7980-e498-00f671b7d336@redhat.com>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <c2f9cbf5-ff81-f36e-68f9-ba3110b1ddd3@codeaurora.org>
Date:   Mon, 11 Oct 2021 12:19:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <aee9523c-4930-7980-e498-00f671b7d336@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/2021 5:48 PM, David Hildenbrand wrote:
> On 06.10.21 14:13, Faiyaz Mohammed wrote:
>> Hi,
>>
>> Sorry for delayed response.
>>
>> On 9/29/2021 10:33 PM, David Hildenbrand wrote:
>>> On 29.09.21 10:58, Faiyaz Mohammed wrote:
>>>>
>>>>
>>>> On 9/28/2021 4:46 PM, David Hildenbrand wrote:
>>>>> On 28.09.21 12:53, Faiyaz Mohammed wrote:
>>>>>>
>>>>>>
>>>>>> On 9/28/2021 4:09 PM, David Hildenbrand wrote:
>>>>>>> On 28.09.21 11:04, Faiyaz Mohammed wrote:
>>>>>>>> For INITRD and initmem memory is reserved through
>>>>>>>> "memblock_reserve"
>>>>>>>> during boot up but it is free via "free_reserved_area" instead
>>>>>>>> of "memblock_free".
>>>>>>>> For example:
>>>>>>>> [    0.294848] Freeing initrd memory: 12K.
>>>>>>>> [    0.696688] Freeing unused kernel memory: 4096K.
>>>>>>>>
>>>>>>>> To get the start and end address of the above freed memory and to
>>>>>>>> account
>>>>>>>> proper memblock added memblock_dbg log in "free_reserved_area".
>>>>>>>> After adding log:
>>>>>>>> [    0.294837] memblock_free: [0x00000083600000-0x00000083603000]
>>>>>>>> free_initrd_mem+0x20/0x28
>>>>>>>> [    0.294848] Freeing initrd memory: 12K.
>>>>>>>> [    0.695246] memblock_free: [0x00000081600000-0x00000081a00000]
>>>>>>>> free_initmem+0x70/0xc8
>>>>>>>> [    0.696688] Freeing unused kernel memory: 4096K.
>>>>>>>>
>>>>>>>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
>>>>>>>> ---
>>>>>>>>      mm/page_alloc.c | 5 +++++
>>>>>>>>      1 file changed, 5 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>>>> index b37435c..f85c3b2 100644
>>>>>>>> --- a/mm/page_alloc.c
>>>>>>>> +++ b/mm/page_alloc.c
>>>>>>>> @@ -8129,6 +8129,11 @@ unsigned long free_reserved_area(void
>>>>>>>> *start,
>>>>>>>> void *end, int poison, const char
>>>>>>>>              pr_info("Freeing %s memory: %ldK\n",
>>>>>>>>                  s, pages << (PAGE_SHIFT - 10));
>>>>>>>>      +#ifdef CONFIG_HAVE_MEMBLOCK
>>>>>>>> +        memblock_dbg("memblock_free: [%#016llx-%#016llx] %pS\n",
>>>>>>>> +            __pa(start), __pa(end), (void *)_RET_IP_);
>>>>>>>> +#endif
>>>>>>>
>>>>>>> IMHO, the "memblock_free" part is misleading. Something was
>>>>>>> allocated
>>>>>>> early via memblock, then we transitioned to the buddy, now we're
>>>>>>> freeing
>>>>>>> that early allocation via the buddy.
>>>>>>> Yes, we're freeing the early allocation via buddy, but for proper
>>>>>> memblock accounting we need this debug print.
>>>>>>
>>>>>
>>>>> What do you mean with "accounting" ? These are debug statements.
>>>>>
>>>>>
>>>> Yes, these are debug statements, which help to know the a-b address
>>>> belongs to x callsite. This info is required when memblock=debug is
>>>> passed through command line and CONFIG_HAVE_MEMBLOCK is enabled.
>>>
>>> The issue I'm having is talking in the name of memblock "memblock_dbg,
>>> memblock_free", when memblock might no longer be around. We have other
>>> places where we free early memblock allocations back to the buddy.
>> I didn't find place where we free early memblock allocation back to the
>> buddy.
> 
> One example I know is
> 
> section_deactivate()->free_map_bootmem()->vmemmap_free()-> ...
> free_pagetable()->free_reserved_page().
> 
> when we free the vmemmap allocated via memblock back to the buddy.
> 
>>
>> Why "memblock_dbg" print with "memblock_free" string?.
>> - After buddy took over, buddy will free memblock reserved memory
>> through free_reserved_area and it will print the freed memory size, but
>> the freed memory through buddy still be part of
>> memblock.reserved.regions.
>> - To know the address ranges, added the "memblock_dbg" print along with
>> "membloc_free" string.
>> - If it is misleading or confusing, we can remove the "memblock_free"
>> string from the "memblock_dgb" print and we can just print the address
>> range when "memlock=debug" pass through command line.
> 
> That would be better, but do we really have to depend on
> "memlock=debug"? Can't we do pr_debug() ?
> 
Yes, I think we can do pr_debug. I will update the patch and push again.

Thanks and regards,
Mohammed Faiyaz
