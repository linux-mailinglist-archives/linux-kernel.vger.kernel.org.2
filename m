Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818593B3C86
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 08:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbhFYGO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 02:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230192AbhFYGOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 02:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624601524;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sf9gA/UAd48g44nPnsDESq35tNMyRoqbYl4+jRnecw4=;
        b=UeSpx0aX/XR0OZkjENS3iknaqZqFIqOqMMcbhtXIqPZlrn0vIkR0+0rh34AF2dQgXKN5NV
        dXu7vhbbhb8MRk30zTBZH8aNunjNQHHO7mLLnAYwE9pYk5baYwG4RGsb6WDgIoLmr6LTld
        bVzy/wnPksXVmbqwdh8O5h/30EKqEmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-sNORG0X0Pcqy7GIDaFFgIg-1; Fri, 25 Jun 2021 02:12:00 -0400
X-MC-Unique: sNORG0X0Pcqy7GIDaFFgIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0518D1084F53;
        Fri, 25 Jun 2021 06:11:59 +0000 (UTC)
Received: from [10.64.54.233] (vpn2-54-233.bne.redhat.com [10.64.54.233])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3872A6E0B6;
        Fri, 25 Jun 2021 06:11:48 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 4/4] virtio_balloon: Specify page reporting order if
 needed
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        alexander.duyck@gmail.com, david@redhat.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
References: <20210625014710.42954-1-gshan@redhat.com>
 <20210625014710.42954-5-gshan@redhat.com>
 <20210625015629-mutt-send-email-mst@kernel.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <c75e21fc-4054-9f2b-3cb4-677be4f5d2f7@redhat.com>
Date:   Fri, 25 Jun 2021 16:11:46 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20210625015629-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/21 3:57 PM, Michael S. Tsirkin wrote:
> On Fri, Jun 25, 2021 at 09:47:10AM +0800, Gavin Shan wrote:
>> The page reporting won't be triggered if the freeing page can't come
>> up with a free area, whose size is equal or bigger than the threshold
>> (page reporting order). The default page reporting order, equal to
>> @pageblock_order, is too huge on some architectures to trigger page
>> reporting. One example is ARM64 when 64KB base page size is used.
>>
>>        PAGE_SIZE:          64KB
>>        pageblock_order:    13       (512MB)
>>        MAX_ORDER:          14
>>
>> This specifies the page reporting order to 5 (2MB) for this specific
>> case so that page reporting can be triggered.
>>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: virtualization@lists.linux-foundation.org
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
>> ---
>>   drivers/virtio/virtio_balloon.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index 510e9318854d..47dce91f788c 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -993,6 +993,23 @@ static int virtballoon_probe(struct virtio_device *vdev)
>>   			goto out_unregister_oom;
>>   		}
>>   
>> +		/*
>> +		 * The default page reporting order is @pageblock_order, which
>> +		 * corresponds to 512MB in size on ARM64 when 64KB base page
>> +		 * size is used. The page reporting won't be triggered if the
>> +		 * freeing page can't come up with a free area like that huge.
>> +		 * So we specify the page reporting order to 5, corresponding
>> +		 * to 2MB. It helps to avoid THP splitting if 4KB base page
>> +		 * size is used by host.
>> +		 *
>> +		 * Ideally, the page reporting order is selected based on the
>> +		 * host's base page size. However, it needs more work to report
>> +		 * that value. The hard-coded order would be fine currently.
>> +		 */
>> +#if defined(CONFIG_ARM64) && defined(CONFIG_ARM64_64K_PAGES)
>> +		vb->pr_dev_info.order = 5;
>> +#endif
>> +
> 
> I was hoping we can get rid of the hacks in virtio with the new
> parameter and logic in mm core. Why not?
> 

Yes, it's something for future as the comments says. Ideally, The
page reporting order can be provided by VMM (QEMU). However, guest's
memory could be backed up by combinations like 4KB pages, 16KB huge
pages, ..., 1GB huge pages. So I need to sort it out before the hack
can be removed from virtio-balloon.

>>   		err = page_reporting_register(&vb->pr_dev_info);
>>   		if (err)
>>   			goto out_unregister_oom;

Thanks,
Gavin

