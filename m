Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A4741AD54
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbhI1KzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:55:18 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:20470 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239895AbhI1KzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:55:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632826418; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=NZcnDpRDCvHoGo8Uu7Z28aE4Y4k3OjuuF5aRxTueu0Q=; b=rh0v3aSI04Mk9MoU1vRT4UQ7Ta+AxUCUEi7oY07ZqlQi/uMc0tadrbyt5Cwqb8xI9wlTfEUy
 ihMvgsjpsxW+FGp72KmuJHq7InWIlY+Tpe4YdHtsFu8aOYZiCKlawIOLi5KdvLDoxdHLUI/0
 xJiWw5sEVbkZsAdFurGVTcjpH44=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6152f430519bd8dcf01afd39 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 10:53:36
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 11A96C43616; Tue, 28 Sep 2021 10:53:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.0.109] (unknown [49.204.180.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B807DC4338F;
        Tue, 28 Sep 2021 10:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B807DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v1] mm: page_alloc: Add debug log in free_reserved_area
 for static memory
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     guptap@codeaurora.org
References: <1632819849-511-1-git-send-email-faiyazm@codeaurora.org>
 <248ec931-7c16-3e2d-cc8f-8ce0dd4e923b@redhat.com>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <0149edd5-fe7f-2786-413c-6de2eab3e30c@codeaurora.org>
Date:   Tue, 28 Sep 2021 16:23:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <248ec931-7c16-3e2d-cc8f-8ce0dd4e923b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/2021 4:09 PM, David Hildenbrand wrote:
> On 28.09.21 11:04, Faiyaz Mohammed wrote:
>> For INITRD and initmem memory is reserved through "memblock_reserve"
>> during boot up but it is free via "free_reserved_area" instead
>> of "memblock_free".
>> For example:
>> [    0.294848] Freeing initrd memory: 12K.
>> [    0.696688] Freeing unused kernel memory: 4096K.
>>
>> To get the start and end address of the above freed memory and to account
>> proper memblock added memblock_dbg log in "free_reserved_area".
>> After adding log:
>> [    0.294837] memblock_free: [0x00000083600000-0x00000083603000]
>> free_initrd_mem+0x20/0x28
>> [    0.294848] Freeing initrd memory: 12K.
>> [    0.695246] memblock_free: [0x00000081600000-0x00000081a00000]
>> free_initmem+0x70/0xc8
>> [    0.696688] Freeing unused kernel memory: 4096K.
>>
>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
>> ---
>>   mm/page_alloc.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index b37435c..f85c3b2 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8129,6 +8129,11 @@ unsigned long free_reserved_area(void *start,
>> void *end, int poison, const char
>>           pr_info("Freeing %s memory: %ldK\n",
>>               s, pages << (PAGE_SHIFT - 10));
>>   +#ifdef CONFIG_HAVE_MEMBLOCK
>> +        memblock_dbg("memblock_free: [%#016llx-%#016llx] %pS\n",
>> +            __pa(start), __pa(end), (void *)_RET_IP_);
>> +#endif
> 
> IMHO, the "memblock_free" part is misleading. Something was allocated
> early via memblock, then we transitioned to the buddy, now we're freeing
> that early allocation via the buddy.
> Yes, we're freeing the early allocation via buddy, but for proper
memblock accounting we need this debug print.

> I would not expect memblock_dbg once memblock might not actually be
> alive anymore.
> 
Here we can add pr_info as well, but the intention is to get callsite
and address info when the memblock=debug is pass through command line
and it is for debugging purpose.

Thanks and regards,
Mohammed Faiyaz
