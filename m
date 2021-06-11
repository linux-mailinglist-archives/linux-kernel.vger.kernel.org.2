Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4DF3A3905
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 02:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhFKAzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 20:55:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230230AbhFKAzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 20:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623372833;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PGrJyKtEWY/a46XGiMW3XrRqAIlmlmGIs4djfi8+oxY=;
        b=dXDMuj8CmtuxyX+jD/B9iJ5ieiP7gdHFi/GilF7zaG0i+UFy4/N9wf4zFYgulBpF+op2FN
        xPIl/ZOR6lOiIRH/9Qa9RaQZ9jrAJHaMzrVE+8GZfhWDpslWX526KXt47e7gsV1DZQZCxh
        gioRCYOe9d/HV5SRjCqPej69g+CSOvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121--BycJehLMie9POgt2WOjfQ-1; Thu, 10 Jun 2021 20:53:52 -0400
X-MC-Unique: -BycJehLMie9POgt2WOjfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15CEAA0CAD;
        Fri, 11 Jun 2021 00:53:51 +0000 (UTC)
Received: from [10.64.54.47] (vpn2-54-47.bne.redhat.com [10.64.54.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23EB760BF1;
        Fri, 11 Jun 2021 00:53:45 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [RFC PATCH] mm/page_reporting: Adjust threshold according to
 MAX_ORDER
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        alexander.h.duyck@linux.intel.com, david@redhat.com,
        shan.gavin@gmail.com
References: <20210601033319.100737-1-gshan@redhat.com>
 <20210601170347.d78ec4af51b1522305deef4a@linux-foundation.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <c1aba468-d309-2fe7-74c3-1f93860482d8@redhat.com>
Date:   Fri, 11 Jun 2021 12:54:51 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20210601170347.d78ec4af51b1522305deef4a@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/21 10:03 AM, Andrew Morton wrote:
> On Tue,  1 Jun 2021 11:33:19 +0800 Gavin Shan <gshan@redhat.com> wrote:
> 
>> The PAGE_REPORTING_MIN_ORDER is equal to @pageblock_order, taken as
>> minimal order (threshold) to trigger page reporting. The page reporting
>> is never triggered with the following configurations and settings on
>> aarch64. In the particular scenario, the page reporting won't be triggered
>> until the largest (2 ^ (MAX_ORDER-1)) free area is achieved from the
>> page freeing. The condition is very hard, or even impossible to be met.
>>
>>    CONFIG_ARM64_PAGE_SHIFT:              16
>>    CONFIG_HUGETLB_PAGE:                  Y
>>    CONFIG_HUGETLB_PAGE_SIZE_VARIABLE:    N
>>    pageblock_order:                      13
>>    CONFIG_FORCE_MAX_ZONEORDER:           14
>>    MAX_ORDER:                            14
>>
>> The issue can be reproduced in VM, running kernel with above configurations
>> and settings. The 'memhog' is used inside the VM to access 512MB anonymous
>> area. The QEMU's RSS doesn't drop accordingly after 'memhog' exits.
>>
>>    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64          \
>>    -accel kvm -machine virt,gic-version=host                        \
>>    -cpu host -smp 8,sockets=2,cores=4,threads=1 -m 4096M,maxmem=64G \
>>    -object memory-backend-ram,id=mem0,size=2048M                    \
>>    -object memory-backend-ram,id=mem1,size=2048M                    \
>>    -numa node,nodeid=0,cpus=0-3,memdev=mem0                         \
>>    -numa node,nodeid=1,cpus=4-7,memdev=mem1                         \
>>      :                                                              \
>>    -device virtio-balloon-pci,id=balloon0,free-page-reporting=yes
>>
>> This tries to fix the issue by adjusting the threshold to the smaller value
>> of @pageblock_order and (MAX_ORDER/2). With this applied, the QEMU's RSS
>> drops after 'memhog' exits.
>>
> 
> Sounds promising, but...
> 
>> --- a/mm/page_reporting.h
>> +++ b/mm/page_reporting.h
>> @@ -10,9 +10,10 @@
>>   #include <linux/pgtable.h>
>>   #include <linux/scatterlist.h>
>>   
>> -#define PAGE_REPORTING_MIN_ORDER	pageblock_order
>> -
>>   #ifdef CONFIG_PAGE_REPORTING
>> +#define PAGE_REPORTING_MIN_ORDER	\
>> +	min_t(unsigned int, pageblock_order, (MAX_ORDER / 2))
>> +
>>   DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
>>   void __page_reporting_notify(void);
> 
> Could you please redo this as a regular old static function in
> page_reporting.c?  Bonus points for commenting its design ;)
> 

Thanks for your time to review, Andrew. Sorry for the delay and late
reply. Yes, I will do if needed after the discussion with David is
finalized.

Thanks,
Gavin

