Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B33E423D7D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238366AbhJFMPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:15:08 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:28448 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238105AbhJFMPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:15:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633522395; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=It/MRNqAXGNPyFh/a1DDiLRtR989/cjNw7hpzBembtQ=; b=VOCGO+FyylnuZe2HSgllvosLO8G+cS8rcmACsm3+lVsM56t9DohsTxsXVBXZl7URccrbFEWG
 vYUjeoPxCTxVZJOj/ysqmsW9EFWc2EyL0YxVRLS5M+KbJ+avsFP6jf3+sF5i77ulybj9mZzl
 CgwPob7K6BvyXeq5/ZD7+lRDG/o=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 615d92da30ce13d2b444b434 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 06 Oct 2021 12:13:14
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 225C3C4360D; Wed,  6 Oct 2021 12:13:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [192.168.0.109] (unknown [49.204.182.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C39DC4338F;
        Wed,  6 Oct 2021 12:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 4C39DC4338F
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
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <88df48af-901b-5765-d92c-6d14c2b1f73e@codeaurora.org>
Date:   Wed, 6 Oct 2021 17:43:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d5a2e107-70e2-30b5-6723-9eea6650517a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for delayed response.

On 9/29/2021 10:33 PM, David Hildenbrand wrote:
> On 29.09.21 10:58, Faiyaz Mohammed wrote:
>>
>>
>> On 9/28/2021 4:46 PM, David Hildenbrand wrote:
>>> On 28.09.21 12:53, Faiyaz Mohammed wrote:
>>>>
>>>>
>>>> On 9/28/2021 4:09 PM, David Hildenbrand wrote:
>>>>> On 28.09.21 11:04, Faiyaz Mohammed wrote:
>>>>>> For INITRD and initmem memory is reserved through "memblock_reserve"
>>>>>> during boot up but it is free via "free_reserved_area" instead
>>>>>> of "memblock_free".
>>>>>> For example:
>>>>>> [    0.294848] Freeing initrd memory: 12K.
>>>>>> [    0.696688] Freeing unused kernel memory: 4096K.
>>>>>>
>>>>>> To get the start and end address of the above freed memory and to
>>>>>> account
>>>>>> proper memblock added memblock_dbg log in "free_reserved_area".
>>>>>> After adding log:
>>>>>> [    0.294837] memblock_free: [0x00000083600000-0x00000083603000]
>>>>>> free_initrd_mem+0x20/0x28
>>>>>> [    0.294848] Freeing initrd memory: 12K.
>>>>>> [    0.695246] memblock_free: [0x00000081600000-0x00000081a00000]
>>>>>> free_initmem+0x70/0xc8
>>>>>> [    0.696688] Freeing unused kernel memory: 4096K.
>>>>>>
>>>>>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
>>>>>> ---
>>>>>>     mm/page_alloc.c | 5 +++++
>>>>>>     1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>> index b37435c..f85c3b2 100644
>>>>>> --- a/mm/page_alloc.c
>>>>>> +++ b/mm/page_alloc.c
>>>>>> @@ -8129,6 +8129,11 @@ unsigned long free_reserved_area(void *start,
>>>>>> void *end, int poison, const char
>>>>>>             pr_info("Freeing %s memory: %ldK\n",
>>>>>>                 s, pages << (PAGE_SHIFT - 10));
>>>>>>     +#ifdef CONFIG_HAVE_MEMBLOCK
>>>>>> +        memblock_dbg("memblock_free: [%#016llx-%#016llx] %pS\n",
>>>>>> +            __pa(start), __pa(end), (void *)_RET_IP_);
>>>>>> +#endif
>>>>>
>>>>> IMHO, the "memblock_free" part is misleading. Something was allocated
>>>>> early via memblock, then we transitioned to the buddy, now we're
>>>>> freeing
>>>>> that early allocation via the buddy.
>>>>> Yes, we're freeing the early allocation via buddy, but for proper
>>>> memblock accounting we need this debug print.
>>>>
>>>
>>> What do you mean with "accounting" ? These are debug statements.
>>>
>>>
>> Yes, these are debug statements, which help to know the a-b address
>> belongs to x callsite. This info is required when memblock=debug is
>> passed through command line and CONFIG_HAVE_MEMBLOCK is enabled.
> 
> The issue I'm having is talking in the name of memblock "memblock_dbg,
> memblock_free", when memblock might no longer be around. We have other
> places where we free early memblock allocations back to the buddy.
I didn't find place where we free early memblock allocation back to the
buddy.

Why "memblock_dbg" print with "memblock_free" string?.
- After buddy took over, buddy will free memblock reserved memory
through free_reserved_area and it will print the freed memory size, but
the freed memory through buddy still be part of memblock.reserved.regions.
- To know the address ranges, added the "memblock_dbg" print along with
"membloc_free" string.
- If it is misleading or confusing, we can remove the "memblock_free"
string from the "memblock_dgb" print and we can just print the address
range when "memlock=debug" pass through command line.

Thanks and regards,
Mohammed Faiyaz
