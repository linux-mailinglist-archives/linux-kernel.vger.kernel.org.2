Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9BC42BABE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 10:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhJMIrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 04:47:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:35713 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232692AbhJMIrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 04:47:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634114717; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=l6omNya1/EkI04DuKbuDKH4HzjeEIZgIwC7p3ibuEy4=; b=fr/U51LT32ZtLaybRhJhwFlvIuwVq8Vl8xoMCoqh83SQ1V4TYrhr0hkjSfGJR2UnuIkPuXWT
 NhOFghgBR5EwuAtrK7CN6xshJQ7lacIPa9LD/yRbGdWAVoScMmIFnkGYtpdE+d1RpwO2C6ff
 FBgukQ+wdvFvr9M1Mc22VA0rViQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 61669c9bab9da96e6430b8c1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 13 Oct 2021 08:45:15
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2BD80C43616; Wed, 13 Oct 2021 08:45:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.109] (unknown [49.204.183.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 68031C4338F;
        Wed, 13 Oct 2021 08:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 68031C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v2] mm: page_alloc: Add debug log in free_reserved_area
 for static memory
To:     David Hildenbrand <david@redhat.com>,
        Faiyaz Mohammed <quic_faiyazm@codeaurora.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     guptap@codeaurora.org
References: <1633936279-26856-1-git-send-email-quic_faiyazm@codeaurora.org>
 <7027fa91-296f-01cb-6c5d-d25c81c835d5@redhat.com>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <0504c1eb-7c46-7def-5d08-8f7aa027784a@codeaurora.org>
Date:   Wed, 13 Oct 2021 14:15:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7027fa91-296f-01cb-6c5d-d25c81c835d5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2021 2:04 PM, David Hildenbrand wrote:
> On 11.10.21 09:11, Faiyaz Mohammed wrote:
>> From: Faiyaz Mohammed <faiyazm@codeaurora.org>
>>
>> For INITRD and initmem memory is reserved through "memblock_reserve"
>> during boot up but it is free via "free_reserved_area" instead
>> of "memblock_free".
>> For example:
>> [    0.294848] Freeing initrd memory: 12K.
>> [    0.696688] Freeing unused kernel memory: 4096K.
>>
>> To get the start and end address of the above freed memory and to account
>> proper memblock added pr_debug log in "free_reserved_area".
>> After adding log:
>> [    0.294837] 0x00000083600000-0x00000083603000
>> free_initrd_mem+0x20/0x28
>> [    0.294848] Freeing initrd memory: 12K.
>> [    0.695246] 0x00000081600000-0x00000081a00000 free_initmem+0x70/0xc8
>> [    0.696688] Freeing unused kernel memory: 4096K.
>>
>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
>> ---
>> changes in v2:
>>     - To avoid confusion, remove the memblock_dbg print and drop the
>>     memblock_free string, now using pr_debug to print the address ranges.
>>
>>   mm/page_alloc.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 668edb1..395df3f 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8153,6 +8153,11 @@ unsigned long free_reserved_area(void *start,
>> void *end, int poison, const char
>>       if (pages && s)
>>           pr_info("Freeing %s memory: %ldK\n", s, K(pages));
>>   +#ifdef CONFIG_HAVE_MEMBLOCK
>> +        pr_debug("%#016llx-%#016llx %pS\n",
>> +            __pa(start), __pa(end), (void *)_RET_IP_);
>> +#endif
>> +
> 
> Are we missing parentheses that the code indentation implies?
> Further, I think we want to use "%pa" instead of "%llx" and
> eventually drop the CONFIG_HAVE_MEMBLOCK dependency. Maybe
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b37435c274cf..e7946e5ca094 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8097,6 +8097,8 @@ EXPORT_SYMBOL(adjust_managed_page_count);
>  
>  unsigned long free_reserved_area(void *start, void *end, int poison,
> const char *s)
>  {
> +       const phys_addr_t pstart = __pa(start);
> +       const phys_addr_t pend = __pa(end);
>         void *pos;
>         unsigned long pages = 0;
>  
> @@ -8125,9 +8127,11 @@ unsigned long free_reserved_area(void *start,
> void *end, int poison, const char
>                 free_reserved_page(page);
>         }
>  
> -       if (pages && s)
> +       if (pages && s) {
>                 pr_info("Freeing %s memory: %ldK\n",
>                         s, pages << (PAGE_SHIFT - 10));
> +               pr_debug("[%pa-%pa] %pS\n", &pstart, &pend, (void
> *)_RET_IP_);
> +       }
>  
>         return pages;
>  }
> Sure, I will update it and push again.

Thanks and regards,
Mohammed Faiyaz
