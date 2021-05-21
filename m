Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B206D38C5D7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbhEULle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:41:34 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:59368 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbhEULlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:41:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621597197; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=1RUBO5gobty3p8p9uWkHS44TdwUBkEs0GqFUhu2ijkw=; b=bOizWZe67WHViNLheZWWJjPmPolLwzL2dKj7M8wSEqBa01UbZ68GiZtKrVOw24abIb2saQEo
 uH+jif9KglpNyUmH/lxq3eang211xjYRyl/T7ZxPesGZjvLO94e1UAbmXQ55kwg2XN9HVHSU
 xqdp8N9Cc7gu/QjgzRZpj/vELCs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60a79c0b7b5af81b5c2a9950 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 May 2021 11:39:55
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B2543C433F1; Fri, 21 May 2021 11:39:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.105] (unknown [49.204.180.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8790C433D3;
        Fri, 21 May 2021 11:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8790C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH v6] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, glittao@gmail.com, greg@kroah.com
Cc:     vinmenon@codeaurora.org
References: <1621341949-26762-1-git-send-email-faiyazm@codeaurora.org>
 <a8247d42-01d3-6d9c-678f-382ea1e02945@suse.cz>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <a86f72b3-76ff-b767-71bd-044d70fab064@codeaurora.org>
Date:   Fri, 21 May 2021 17:09:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a8247d42-01d3-6d9c-678f-382ea1e02945@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/2021 4:43 PM, Vlastimil Babka wrote:
> On 5/18/21 2:45 PM, Faiyaz Mohammed wrote:
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
> 
> 
>> @@ -5817,6 +5769,249 @@ static int __init slab_sysfs_init(void)
>>  __initcall(slab_sysfs_init);
>>  #endif /* CONFIG_SYSFS */
>>  
>> +#if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
>> +static int debugfs_slab_alias(struct kmem_cache *s, const char *name)
>> +{
>> +	struct saved_alias *al;
>> +	struct dentry *slab_cache_dir;
>> +
>> +	if (slab_state == FULL) {
>> +		/*
>> +		 * If we have a leftover link then remove it.
>> +		 */
>> +		slab_cache_dir = debugfs_lookup(s->name, slab_debugfs_root);
>> +		debugfs_remove(slab_cache_dir);
>> +		debugfs_create_symlink(name, slab_debugfs_root, NULL);
> 
> v6 got stuck on boot for me, unlike v5, seems like here you should return 0?
> That helped
> 
oh, it worked me without return, but I think yes, have to return from
here once the symlink is created like sysfs_slab_alias do. I will update
in next patch version.

>> +	}
>> +
>> +	al = kmalloc(sizeof(struct saved_alias), GFP_KERNEL);
>> +	if (!al)
>> +		return -ENOMEM;
>> +
>> +	al->s = s;
>> +	al->name = name;
>> +	al->next = alias_list;
>> +	alias_list = al;
>> +	return 0;
>> +}
>> +

Thanks and regards,
Mohammed Faiyaz
