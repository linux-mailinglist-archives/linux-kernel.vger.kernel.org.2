Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED403955A6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 08:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhEaG5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 02:57:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:44466 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhEaG5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 02:57:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622444134; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=mr/UQhEDVHVlbjHaYkilt71pM3p94jqivYSMdvW31M8=; b=VZOquo7vRFLPzZEkyk5O75RCxKrf2AeRv36o6YEA6LFn9JLulWdKTlKTrWL58O3j2zTLvMDX
 OlsCpuiXSX2YtucEqYO3qOe95wWx0FMJbi06Q7NGpy7yox69GGrTE8Yp5rwhqnljBBKBcA/r
 Jeo9a+Nn/ByyT/xFDZH317whXVA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60b48855e27c0cc77f4d5868 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 May 2021 06:55:17
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ECF7AC4360C; Mon, 31 May 2021 06:55:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.105] (unknown [49.204.182.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1DC93C433F1;
        Mon, 31 May 2021 06:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1DC93C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH v7] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, greg@kroah.com, glittao@gmail.com
Cc:     vinmenon@codeaurora.org
References: <1621928285-751-1-git-send-email-faiyazm@codeaurora.org>
 <86d843f0-bbef-7c3b-6b6a-5d6b32434bee@suse.cz>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <b43fad97-5f40-c94a-7cb4-9a31edd6668f@codeaurora.org>
Date:   Mon, 31 May 2021 12:25:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <86d843f0-bbef-7c3b-6b6a-5d6b32434bee@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/2021 5:08 PM, Vlastimil Babka wrote:
> On 5/25/21 9:38 AM, Faiyaz Mohammed wrote:
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
> 
> These were IIRC bot reports for some bugs in the previous versions, so keeping
> the Reported-by: for the whole patch is misleading - these were not reports for
> the sysfs issues this patch fixes by moving the files to debugfs.
> 
Yes, I will update in next patch version.
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
> 
> I don't see any of the symlinks under /sys/kernel/debug/slab/, so I think the
> aliases handling code is wrong, and I can see at least two reasons why it could be:
> 

I think I missed one thing, when CONFIG_SLUB_DEBUG_ON enable or
slub_debug is pass through command line __kmem_cache_alias() will return
null, so no symlinks will be created even if CONFIG_SLAB_MERGE_DEFAULT
is enable and to store user data we need to enable CONFIG_SLUB_DEBUG_ON
or pass slub_debug through command line.

>> @@ -4525,6 +4535,8 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
>>  			s->refcount--;
>>  			s = NULL;
>>  		}
>> +
>> +		debugfs_slab_alias(s, name);
> 
> Here you might be calling debugfs_slab_alias() with NULL if the
> sysfs_slab_alias() above returned true.
> 
I think we can drop debugfs_slab_alias implementation.
>>  	}
>>  
>>  	return s;
> 
> ...
> 
>> +static int __init slab_debugfs_init(void)
>> +{
>> +	struct kmem_cache *s;
>> +
>> +	slab_debugfs_root = debugfs_create_dir("slab", NULL);
>> +
>> +	slab_state = FULL;
>> +
>> +	list_for_each_entry(s, &slab_caches, list)
>> +		debugfs_slab_add(s);
>> +
>> +	while (alias_list) {
>> +		struct saved_alias *al = alias_list;
> 
> alias_list a single list and both slab_sysfs_init() and slab_debugfs_init()
> flush it. So only the init call that happens to be called first, does actually
> find an unflushed list. I think you
> need to use a separate list for debugfs (simpler) or a shared list with both
> sysfs and debugfs processing (probably more complicated).
> 
same here, I think we can drop the debugfs alias change.

> And finally a question, perhaps also for Greg. With sysfs, we hand out the
> lifecycle of struct kmem_cache to sysfs, to ensure we are not reading sysfs
> files of a cache that has been removed.
> 
> But with debugfs, what are the guarantees that things won't blow up when a
> debugfs file is being read while somebody calls kmem_cache_destroy() on the cache?
> 
>> +
>> +		alias_list = alias_list->next;
>> +
>> +		debugfs_slab_alias(al->s, al->name);
>> +
>> +		kfree(al);
>> +	}
>> +
>> +	return 0;
>> +
>> +}
>> +__initcall(slab_debugfs_init);
>> +#endif
>>  /*
>>   * The /proc/slabinfo ABI
>>   */
>>
> 
