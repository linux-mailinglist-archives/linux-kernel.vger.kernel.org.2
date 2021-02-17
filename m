Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6306531D56F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 07:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhBQGmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 01:42:31 -0500
Received: from z11.mailgun.us ([104.130.96.11]:49459 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhBQGmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 01:42:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613544096; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=JaBAanv/WVmlzFcHuQSdzVG4S0qCVTgr4QFab9kYwPE=; b=HenYN/kY2IL9BHh2ocShVtO46tqWqK7Xe/DYzxlNETYWFYyvsxf94ICxvkoKvNwRo39FJJjR
 iB2pzjIZEawxUSxqUG1kuVsxkJXqms1qlahRjSQ+ZZwIgfvNO3+chdtpQ0hMkeIkGgiZeLVG
 RAujFbpER9dbmiPlUaxrVwrTON8=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 602cba7859e27801599f9122 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Feb 2021 06:40:56
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C4469C43466; Wed, 17 Feb 2021 06:40:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.147.187] (unknown [106.195.71.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DAFDFC433C6;
        Wed, 17 Feb 2021 06:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DAFDFC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH] mm: slub: Convert sys slab alloc_calls, free_calls to bin
 attribute
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     vinmenon@codeaurora.org
References: <1610443287-23933-1-git-send-email-faiyazm@codeaurora.org>
 <d35e37e8-9b70-6b04-b5b8-19030921a1b5@suse.cz>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <7c2e2e62-8589-f9ca-1933-7faccc87bccd@codeaurora.org>
Date:   Wed, 17 Feb 2021 12:10:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <d35e37e8-9b70-6b04-b5b8-19030921a1b5@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlastimil,

On 1/13/2021 9:35 PM, Vlastimil Babka wrote:
> On 1/12/21 10:21 AM, Faiyaz Mohammed wrote:
>> Reading the sys slab alloc_calls, free_calls returns the available object
>> owners, but the size of this file is limited to PAGE_SIZE
>> because of the limitation of sysfs attributes, it is returning the
>> partial owner info, which is not sufficient to debug/account the slab
>> memory and alloc_calls output is not matching with /proc/slabinfo.
>>
>> To remove the PAGE_SIZE limitation converted the sys slab
>> alloc_calls, free_calls to bin attribute.
>>
>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
>> ---
>>  mm/slub.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 47 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index b52384e..8744e5ec 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -4710,13 +4710,14 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
>>  }
>>  
>>  static int list_locations(struct kmem_cache *s, char *buf,
>> -					enum track_item alloc)
>> +			loff_t offset, enum track_item alloc)
>>  {
>>  	int len = 0;
>>  	unsigned long i;
>>  	struct loc_track t = { 0, 0, NULL };
>>  	int node;
>>  	struct kmem_cache_node *n;
>> +	static unsigned int previous_read_count;
> 
> Hmm static? What about parallel reads from different files? I guess you'll have
> to somehow employ the offset parameter here and it won't be pretty, because you
> are still printing free text and not some fixed-size binary chunks where seeking
> is simple.
To avoid static, I have used small logic by fixing track max length and
tracks per page. Please find patch v2.

> Also it's wasteful to to repeat the data gathering for each pritned page, you'd
> need a mechanism that allows holding private data between printing out the
> pages. If bin_attribute doesn't have that, you'd need e.g. seq_file which we use
> for /proc/pid/(s)maps etc.>I think seq_file implementation is not feasible with sysfs and I didn't
find any example in kernel. If we want to use seq_file than I guess we
have to move slab in debugfs.


>>  	unsigned long *map = bitmap_alloc(oo_objects(s->max), GFP_KERNEL);
> 
> This line doesn't exist since 90e9f6a66c78f in v5.6-rc1, is the patch based on
> an old kernel?
> 
Updated the patch v2.

>>  	if (!map || !alloc_loc_track(&t, PAGE_SIZE / sizeof(struct location),
>> @@ -4742,11 +4743,9 @@ static int list_locations(struct kmem_cache *s, char *buf,
>>  		spin_unlock_irqrestore(&n->list_lock, flags);
>>  	}
>>  
>> -	for (i = 0; i < t.count; i++) {
>> +	for (i = previous_read_count; i < t.count; i++) {
>>  		struct location *l = &t.loc[i];
>>  
>> -		if (len > PAGE_SIZE - KSYM_SYMBOL_LEN - 100)
>> -			break;
>>  		len += sprintf(buf + len, "%7ld ", l->count);
>>  
>>  		if (l->addr)
>> @@ -4784,12 +4783,20 @@ static int list_locations(struct kmem_cache *s, char *buf,
>>  					 nodemask_pr_args(&l->nodes));
>>  
>>  		len += sprintf(buf + len, "\n");
>> +
>> +		if (len > PAGE_SIZE - KSYM_SYMBOL_LEN - 100) {
>> +			previous_read_count = i + 1;
>> +			break;
>> +		}
>>  	}
>>  
>> +	if ((offset != 0) && ((i >= t.count) || (previous_read_count > t.count))) {
>> +		previous_read_count = 0;
>> +		len = 0;
>> +	} else if (!t.count)
>> +		len += sprintf(buf, "No data\n");
>>  	free_loc_track(&t);
>>  	bitmap_free(map);
>> -	if (!t.count)
>> -		len += sprintf(buf, "No data\n");
>>  	return len;
>>  }
>>  
>> @@ -5180,6 +5187,7 @@ static int any_slab_objects(struct kmem_cache *s)
>>  
>>  struct slab_attribute {
>>  	struct attribute attr;
>> +	struct bin_attribute bin_attr;
>>  	ssize_t (*show)(struct kmem_cache *s, char *buf);
>>  	ssize_t (*store)(struct kmem_cache *s, const char *x, size_t count);
>>  };
>> @@ -5192,6 +5200,12 @@ struct slab_attribute {
>>  	static struct slab_attribute _name##_attr =  \
>>  	__ATTR(_name, 0600, _name##_show, _name##_store)
>>  
>> +#define SLAB_BIN_ATTR_RO(_name) \
>> +	static struct slab_attribute _name##_attr = { \
>> +	.bin_attr = \
>> +	__BIN_ATTR_RO(_name, 0) \
>> +	} \
>> +
>>  static ssize_t slab_size_show(struct kmem_cache *s, char *buf)
>>  {
>>  	return sprintf(buf, "%u\n", s->size);
>> @@ -5535,21 +5549,33 @@ static ssize_t validate_store(struct kmem_cache *s,
>>  }
>>  SLAB_ATTR(validate);
>>  
>> -static ssize_t alloc_calls_show(struct kmem_cache *s, char *buf)
>> +static ssize_t alloc_calls_read(struct file *filp, struct kobject *kobj,
>> +				struct bin_attribute *bin_attr, char *buf,
>> +					loff_t offset, size_t count)
>>  {
>> +	struct kmem_cache *s;
>> +
>> +	s = to_slab(kobj);
>>  	if (!(s->flags & SLAB_STORE_USER))
>>  		return -ENOSYS;
>> -	return list_locations(s, buf, TRACK_ALLOC);
>> +
>> +	return list_locations(s, buf, offset, TRACK_ALLOC);
>>  }
>> -SLAB_ATTR_RO(alloc_calls);
>> +SLAB_BIN_ATTR_RO(alloc_calls);
>>  
>> -static ssize_t free_calls_show(struct kmem_cache *s, char *buf)
>> +static ssize_t free_calls_read(struct file *filp, struct kobject *kobj,
>> +				struct bin_attribute *bin_attr, char *buf,
>> +					loff_t offset, size_t count)
>>  {
>> +	struct kmem_cache *s;
>> +
>> +	s = to_slab(kobj);
>>  	if (!(s->flags & SLAB_STORE_USER))
>>  		return -ENOSYS;
>> -	return list_locations(s, buf, TRACK_FREE);
>> +
>> +	return list_locations(s, buf, offset, TRACK_FREE);
>>  }
>> -SLAB_ATTR_RO(free_calls);
>> +SLAB_BIN_ATTR_RO(free_calls);
>>  #endif /* CONFIG_SLUB_DEBUG */
>>  
>>  #ifdef CONFIG_FAILSLAB
>> @@ -5694,6 +5720,14 @@ STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
>>  STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
>>  #endif	/* CONFIG_SLUB_STATS */
>>  
>> +
>> +static struct bin_attribute *slab_bin_attrs[] = {
>> +#ifdef CONFIG_SLUB_DEBUG
>> +	&alloc_calls_attr.bin_attr,
>> +	&free_calls_attr.bin_attr,
>> +#endif
>> +};
>> +
>>  static struct attribute *slab_attrs[] = {
>>  	&slab_size_attr.attr,
>>  	&object_size_attr.attr,
>> @@ -5722,8 +5756,6 @@ static struct attribute *slab_attrs[] = {
>>  	&poison_attr.attr,
>>  	&store_user_attr.attr,
>>  	&validate_attr.attr,
>> -	&alloc_calls_attr.attr,
>> -	&free_calls_attr.attr,
>>  #endif
>>  #ifdef CONFIG_ZONE_DMA
>>  	&cache_dma_attr.attr,
>> @@ -5769,6 +5801,7 @@ static struct attribute *slab_attrs[] = {
>>  
>>  static const struct attribute_group slab_attr_group = {
>>  	.attrs = slab_attrs,
>> +	.bin_attrs = slab_bin_attrs,
>>  };
>>  
>>  static ssize_t slab_attr_show(struct kobject *kobj,
>>
> 
