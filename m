Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D18D3B3C72
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 08:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhFYGHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 02:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231923AbhFYGHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 02:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624601093;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N1pzwVD62x/6KZDBAhY2ZWGnUYF4mbkQPcI7uLK8T28=;
        b=ftGMY7xrPaRrp6QW5tcKkfeMe8Q7/qvEgwCOOPejuREA8sM97ZpM3Ah1C4g18m/a2oULcC
        ggE3jrVevj0fKiH/n23jehGvxYYHMdOBbYFYQjspjwC3XpV3Y7V7iSoBpLzK4YQI5TVTZ6
        v4AiUSxK3pRMfBPKWC7IpHUqxvMU8uk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-8y7uJH48NPiSN0NkmBP_tQ-1; Fri, 25 Jun 2021 02:04:52 -0400
X-MC-Unique: 8y7uJH48NPiSN0NkmBP_tQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7998802C87;
        Fri, 25 Jun 2021 06:04:50 +0000 (UTC)
Received: from [10.64.54.233] (vpn2-54-233.bne.redhat.com [10.64.54.233])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C800D19C44;
        Fri, 25 Jun 2021 06:04:40 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 3/4] mm/page_reporting: Allow driver to specify
 reporting order
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        alexander.duyck@gmail.com, david@redhat.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
References: <20210625014710.42954-1-gshan@redhat.com>
 <20210625014710.42954-4-gshan@redhat.com>
 <20210625014653-mutt-send-email-mst@kernel.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <c1710727-36c5-37e3-2075-fcdf63cd9eed@redhat.com>
Date:   Fri, 25 Jun 2021 16:04:38 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20210625014653-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/21 3:48 PM, Michael S. Tsirkin wrote:
> On Fri, Jun 25, 2021 at 09:47:09AM +0800, Gavin Shan wrote:
>> The page reporting order (threshold) is sticky to @pageblock_order
>> by default. The page reporting can never be triggered because the
>> freeing page can't come up with a free area like that huge. The
>> situation becomes worse when the system memory becomes heavily
>> fragmented.
>>
>> For example, the following configurations are used on ARM64 when 64KB
>> base page size is enabled. In this specific case, the page reporting
>> won't be triggered until the freeing page comes up with a 512MB free
>> area. That's hard to be met, especially when the system memory becomes
>> heavily fragmented.
>>
>>     PAGE_SIZE:          64KB
>>     HPAGE_SIZE:         512MB
>>     pageblock_order:    13       (512MB)
>>     MAX_ORDER:          14
>>
>> This allows the drivers to specify the page reporting order when the
>> page reporting device is registered. It falls back to @pageblock_order
>> if it's not specified by the driver. The existing users (hv_balloon
>> and virtio_balloon) don't specify it and @pageblock_order is still
>> taken as their page reporting order. So this shouldn't introduce any
>> functional changes.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
>> ---
>>   include/linux/page_reporting.h | 3 +++
>>   mm/page_reporting.c            | 6 ++++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
>> index 3b99e0ec24f2..fe648dfa3a7c 100644
>> --- a/include/linux/page_reporting.h
>> +++ b/include/linux/page_reporting.h
>> @@ -18,6 +18,9 @@ struct page_reporting_dev_info {
>>   
>>   	/* Current state of page reporting */
>>   	atomic_t state;
>> +
>> +	/* Minimal order of page reporting */
>> +	unsigned int order;
>>   };
>>   
>>   /* Tear-down and bring-up for page reporting devices */
>> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
>> index 34bf4d26c2c4..382958eef8a9 100644
>> --- a/mm/page_reporting.c
>> +++ b/mm/page_reporting.c
>> @@ -329,6 +329,12 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
>>   		goto err_out;
>>   	}
>>   
>> +	/*
>> +	 * Update the page reporting order if it's specified by driver.
>> +	 * Otherwise, it falls back to @pageblock_order.
>> +	 */
>> +	page_reporting_order = prdev->order ? : pageblock_order;
>> +
> 
> Hmm. So on ARM achitectures with 64K pages, the command line parameter
> is silently ignored?
> 
> Isn't this a problem?
> 

It's fine as the command line parameter is used as debugging purpose.
Besides, it can be changed by writing to the following file:

    /sys/module/page_reporting/parameters/page_reporting_order


>>   	/* initialize state and work structures */
>>   	atomic_set(&prdev->state, PAGE_REPORTING_IDLE);
>>   	INIT_DELAYED_WORK(&prdev->work, &page_reporting_process);
>> -- 
>> 2.23.0

Thanks,
Gavin

