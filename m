Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60462371273
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 10:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhECI3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 04:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53495 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229817AbhECI3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 04:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620030522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oeOHRYo4V+sjXuBsEphc00viyXFIqMXEH0Oj0f+S1EU=;
        b=DIdLEnbZhoalaXITgWBkPli5FHjIdETclQL74/x9iNkG8ouWMDlyCACgTUUwPP/aYEVgnP
        L997FxEg424e5JqsAzqF1+UaMO24DklMIk+BTPnNoAvfhbFp/tbzAlD/8orlFt8GLb4kvr
        BjcADtsXGQRWmqaePruaq6Pie0RqgHQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-AcSN9Bm4NjS2wclxzuhKFg-1; Mon, 03 May 2021 04:28:38 -0400
X-MC-Unique: AcSN9Bm4NjS2wclxzuhKFg-1
Received: by mail-wr1-f70.google.com with SMTP id 67-20020adf81490000b029010756d109e6so3463920wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 01:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oeOHRYo4V+sjXuBsEphc00viyXFIqMXEH0Oj0f+S1EU=;
        b=MsZH3Y4uIw12NrlAb/RrfjlRIWvzQh63B/PYlyaomUFRFaUxjYFsb/FW8v2fT36qeD
         DiPaGn5+HQ1A1awB4/Ed7kA83Nat/rVnALvK5JjD6IDsn6K5od3yo2762jsNpl25CLad
         ooejSlLbm2c/er3IxuXZ7C7OBCEsBqtGjaWpLCHk0Vuk02nfZgQfRCUl3JWjORfH6RS+
         Pd7LS7FJjfzYpumhauZyzgvEwdSqqWkG+7NMzTHdT+gjSodmAYE7DfaTWTlxs6C5C+Hm
         JLR03H62H2RN58n07U61pM53TCtrLzKrgr7VsiW0uGelsXaOcuWmhhHEtkGddV1WdFri
         QWAg==
X-Gm-Message-State: AOAM533Tqnsf7MpLY7BAs26tQjT57iOVTmxpGvVliZCatfB2wbp/5qTC
        zohHdTtzrnALPo+3eGoEwzT1KanJqUBJA8m6qOxJfcMLG2hbQOwKU/uAErq3k1CUHupQ/T5Thbg
        iOhweOke4Zh55SgDlbaMCzIfo
X-Received: by 2002:a5d:6d85:: with SMTP id l5mr22979397wrs.22.1620030517791;
        Mon, 03 May 2021 01:28:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaIYYprmCHdbWEQG0UKlOnfr25C8JpbLNd+9kN/fx46K8mzScJzZQz2ZSZd2ki6w32eeO6Cw==
X-Received: by 2002:a5d:6d85:: with SMTP id l5mr22979345wrs.22.1620030517468;
        Mon, 03 May 2021 01:28:37 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c649f.dip0.t-ipconnect.de. [91.12.100.159])
        by smtp.gmail.com with ESMTPSA id r5sm12059190wmh.23.2021.05.03.01.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 01:28:37 -0700 (PDT)
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Price <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Aili Yao <yaoaili@kingsoft.com>, Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-8-david@redhat.com> <YI5H4yV/c6ReuIDt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 7/7] fs/proc/kcore: use page_offline_(freeze|unfreeze)
Message-ID: <5a5a7552-4f0a-75bc-582f-73d24afcf57b@redhat.com>
Date:   Mon, 3 May 2021 10:28:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YI5H4yV/c6ReuIDt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.05.21 08:34, Mike Rapoport wrote:
> On Thu, Apr 29, 2021 at 02:25:19PM +0200, David Hildenbrand wrote:
>> Let's properly synchronize with drivers that set PageOffline(). Unfreeze
>> every now and then, so drivers that want to set PageOffline() can make
>> progress.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   fs/proc/kcore.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
>> index 92ff1e4436cb..3d7531f47389 100644
>> --- a/fs/proc/kcore.c
>> +++ b/fs/proc/kcore.c
>> @@ -311,6 +311,7 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
>>   static ssize_t
>>   read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>>   {
>> +	size_t page_offline_frozen = 0;
>>   	char *buf = file->private_data;
>>   	size_t phdrs_offset, notes_offset, data_offset;
>>   	size_t phdrs_len, notes_len;
>> @@ -509,6 +510,18 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>>   			pfn = __pa(start) >> PAGE_SHIFT;
>>   			page = pfn_to_online_page(pfn);
> 
> Can't this race with page offlining for the first time we get here?


To clarify, we have three types of offline pages in the kernel ...

a) Pages part of an offline memory section; the memap is stale and not 
trustworthy. pfn_to_online_page() checks that. We *can* protect against 
memory offlining using get_online_mems()/put_online_mems(), but usually 
avoid doing so as the race window is very small (and a problem all over 
the kernel we basically never hit) and locking is rather expensive. In 
the future, we might switch to rcu to handle that more efficiently and 
avoiding these possible races.

b) PageOffline(): logically offline pages contained in an online memory 
section with a sane memmap. virtio-mem calls these pages "fake offline"; 
something like a "temporary" memory hole. The new mechanism I propose 
will be used to handle synchronization as races can be more severe, 
e.g., when reading actual page content here.

c) Soft offline pages: hwpoisoned pages that are not actually harmful 
yet, but could become harmful in the future. So we better try to remove 
the page from the page allcoator and try to migrate away existing users.


So page_offline_* handle "b) PageOffline()" only. There is a tiny race 
between pfn_to_online_page(pfn) and looking at the memmap as we have in 
many cases already throughout the kernel, to be tackled in the future.


(A better name for PageOffline() might make sense; PageSoftOffline() 
would be catchy but interferes with c). PageLogicallyOffline() is ugly; 
PageFakeOffline() might do)

>   
>> +			/*
>> +			 * Don't race against drivers that set PageOffline()
>> +			 * and expect no further page access.
>> +			 */
>> +			if (page_offline_frozen == MAX_ORDER_NR_PAGES) {
>> +				page_offline_unfreeze();
>> +				page_offline_frozen = 0;
>> +				cond_resched();
>> +			}
>> +			if (!page_offline_frozen++)
>> +				page_offline_freeze();
>> +
> 
> Don't we need to freeze before doing pfn_to_online_page()?

See my explanation above. Thanks!

-- 
Thanks,

David / dhildenb

