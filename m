Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2231391B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhEZPIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:08:16 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:15251 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbhEZPIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:08:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622041605; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=b8BjlH9egfM8irtGeEu6Ssq225EyE56PX+b1TLfvFCQ=; b=NLZ8Y22NsUd2qbq3vUqDfBPc7k37L+Wxu79k5M57G68dhRd3j0Iqnvg+NXFdJ3YqUSDcBcLD
 870/um/RBO7LcxsaQUqJ92OQkcz2goqWivLLOkRuRgDMx9kx06fyCWxzGguwv+7NAR8PmyIx
 EVPXm2o6G690fgxUgNYotjuwkU0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60ae63f38dd30e785f8d0a68 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 26 May 2021 15:06:27
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7ED58C4338A; Wed, 26 May 2021 15:06:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.105] (unknown [49.204.183.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2BDD2C4338A;
        Wed, 26 May 2021 15:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BDD2C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH v7] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Vlastimil Babka <vbabka@suse.cz>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        glittao@gmail.com, vinmenon@codeaurora.org
References: <1621928285-751-1-git-send-email-faiyazm@codeaurora.org>
 <YKys873HUNp/ZMqV@kroah.com>
 <7324d56f-c5fe-05fa-55f2-7dd2dbf9bce0@codeaurora.org>
 <YKzlia5b/vaDaul9@kroah.com> <371e20a8-6b07-1eaa-d587-3b444d03ba2f@suse.cz>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <544e7eaf-ceaa-0ff0-15c3-b615db7e1b00@codeaurora.org>
Date:   Wed, 26 May 2021 20:36:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <371e20a8-6b07-1eaa-d587-3b444d03ba2f@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/2021 4:33 PM, Vlastimil Babka wrote:
> On 5/25/21 1:54 PM, Greg KH wrote:
>> On Tue, May 25, 2021 at 02:27:15PM +0530, Faiyaz Mohammed wrote:
>>>> --- a/mm/slab_common.c
>>>>> +++ b/mm/slab_common.c
>>>>> @@ -455,6 +455,9 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>>>>>  #else
>>>>>  		slab_kmem_cache_release(s);
>>>>>  #endif
>>>>> +#ifdef SLAB_SUPPORTS_DEBUGFS
>>>>> +		debugfs_slab_release(s);
>>>>> +#endif
>>>>
>>>> Why do you need these #ifdef if your slub_dev.h file already provides an
>>>> "empty" function for this?
>>>>
>>> We are not including slub_def.h directly. mm/slab.h includes the
>>> slub_def.h if CONFIG_SLUB enable,
>>>
>>> from mm/slab.h
>>> #ifdef CONFIG_SLAB
>>> #include <linux/slab_def.h>
>>> #endif
>>>
>>> #ifdef CONFIG_SLUB
>>> #include <linux/slub_def.h>
>>> #endif
>>>
>>> so if CONFIG_SLAB is enable then mm/slab.h includes slab_def.h, to avoid
>>> undefined reference error added SLAB_SUPPORTS_DEBUGFS like
>>> SLAB_SUPPORTS_SYSFS.
>>
>> Ick, ok, messy code, I'll stop complaining now if this really is the
>> only way to do it (still feels wrong to me...)
> 
> How about simply replicating the empty function in
> include/linux/slab_def.h
> 
Yes, we can add empty function in include/linux/slab_def.h.
I will add in next patch version.

> We could do the same with SYSFS, except the SLAB (and SLUB w/o SYSFS) versions
> of sysfs_slab_release() would not be empty, but just call
> slab_kmem_cache_release(s);
> Then we could get rid of the #ifdef's completely?
> 
Is it okay, if I raise separate patch for sysfs by adding empty function
in slab_def.h?

Thanks and regards,
Mohammed Faiyaz
>> greg k-h
>>
> 
