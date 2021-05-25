Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5E738FD43
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhEYI64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:58:56 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:28115 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhEYI6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:58:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621933046; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=gufDQkZS0H4qGMiURI+0yvsJ49ZYpANcr23Ed3Ewtro=; b=TPGfptKOgiQPULsV5wgh3FENh4vd82ExFg6AvX+uhsfdwo6WqnacpxUnlVIPUom7o0ZyU+ZS
 cMped/2XqrPZXO2fCmA5dD/FX1bCrc8SrZUUPFKPzAyE7zO2SCZNJDyumhBseBCGciDlJOk4
 wcmPGlw3i5YAe2rgX3/PKEEVB3E=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60acbbf25f788b52a50e3c07 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 25 May 2021 08:57:22
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C0C89C4338A; Tue, 25 May 2021 08:57:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.105] (unknown [49.204.181.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 41CC4C433F1;
        Tue, 25 May 2021 08:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41CC4C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH v7] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        glittao@gmail.com, vinmenon@codeaurora.org
References: <1621928285-751-1-git-send-email-faiyazm@codeaurora.org>
 <YKys873HUNp/ZMqV@kroah.com>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <7324d56f-c5fe-05fa-55f2-7dd2dbf9bce0@codeaurora.org>
Date:   Tue, 25 May 2021 14:27:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKys873HUNp/ZMqV@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/2021 1:23 PM, Greg KH wrote:
> On Tue, May 25, 2021 at 01:08:05PM +0530, Faiyaz Mohammed wrote:
>> alloc_calls and free_calls implementation in sysfs have two issues,
>> one is PAGE_SIZE limitiation of sysfs and other is it does not adhere
>> to "one value per file" rule.
>>
>> To overcome this issues, move the alloc_calls and free_calls implemeation
>> to debugfs.
>>
>> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
>> to be inline with what it does.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
>> ---
>> changes in V7:
>>         - Drop the older alloc_calls and free_calls interface.
>> changes in v6:
>>         - https://lore.kernel.org/linux-mm/1621341949-26762-1-git-send-email-faiyazm@codeaurora.org/
>>
>> changes in v5:
>>         - https://lore.kernel.org/linux-mm/1620296523-21922-1-git-send-email-faiyazm@codeaurora.org/
>>
>> changes in v4:
>>         - https://lore.kernel.org/linux-mm/1618583239-18124-1-git-send-email-faiyazm@codeaurora.org/
>>
>> changes in v3:
>>         - https://lore.kernel.org/linux-mm/1617712064-12264-1-git-send-email-faiyazm@codeaurora.org/
>>
>> changes in v2:
>>         - https://lore.kernel.org/linux-mm/3ac1d3e6-6207-96ad-16a1-0f5139d8b2b5@codeaurora.org/
>>
>> changes in v1:
>>         - https://lore.kernel.org/linux-mm/1610443287-23933-1-git-send-email-faiyazm@codeaurora.org/
>>
>>  include/linux/slub_def.h |   8 ++
>>  mm/slab_common.c         |   9 ++
>>  mm/slub.c                | 353 ++++++++++++++++++++++++++++++++++-------------
>>  3 files changed, 276 insertions(+), 94 deletions(-)
>>
>> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
>> index dcde82a..b413ebe 100644
>> --- a/include/linux/slub_def.h
>> +++ b/include/linux/slub_def.h
>> @@ -159,6 +159,14 @@ static inline void sysfs_slab_release(struct kmem_cache *s)
>>  }
>>  #endif
>>  
>> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
>> +#define SLAB_SUPPORTS_DEBUGFS
>> +void debugfs_slab_release(struct kmem_cache *);
>> +#else
>> +static inline void debugfs_slab_release(struct kmem_cache *s)
>> +{
>> +}
>> +#endif
>>  void object_err(struct kmem_cache *s, struct page *page,
>>  		u8 *object, char *reason);
>>  
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index a4a5714..873dd79 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -455,6 +455,9 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>>  #else
>>  		slab_kmem_cache_release(s);
>>  #endif
>> +#ifdef SLAB_SUPPORTS_DEBUGFS
>> +		debugfs_slab_release(s);
>> +#endif
> 
> Why do you need these #ifdef if your slub_dev.h file already provides an
> "empty" function for this?
> 
We are not including slub_def.h directly. mm/slab.h includes the
slub_def.h if CONFIG_SLUB enable,

from mm/slab.h
#ifdef CONFIG_SLAB
#include <linux/slab_def.h>
#endif

#ifdef CONFIG_SLUB
#include <linux/slub_def.h>
#endif

so if CONFIG_SLAB is enable then mm/slab.h includes slab_def.h, to avoid
undefined reference error added SLAB_SUPPORTS_DEBUGFS like
SLAB_SUPPORTS_SYSFS.
>>  	}
>>  }
>>  
>> @@ -472,6 +475,9 @@ static int shutdown_cache(struct kmem_cache *s)
>>  #ifdef SLAB_SUPPORTS_SYSFS
>>  		sysfs_slab_unlink(s);
>>  #endif
>> +#ifdef SLAB_SUPPORTS_DEBUGFS
>> +		debugfs_slab_release(s);
>> +#endif
> 
> Same here.
> 
>>  		list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
>>  		schedule_work(&slab_caches_to_rcu_destroy_work);
>>  	} else {
>> @@ -482,6 +488,9 @@ static int shutdown_cache(struct kmem_cache *s)
>>  #else
>>  		slab_kmem_cache_release(s);
>>  #endif
>> +#ifdef SLAB_SUPPORTS_DEBUGFS
>> +		debugfs_slab_release(s);
>> +#endif
> 
> And here.
> 
> What is wrong with your .h file that keeps the need for #ifdef in the .c
> file?
> 
> I thought I've asked about this a number of times in the past, what am I
> missing?
> 
> thanks,
> 
> greg k-h
> 
