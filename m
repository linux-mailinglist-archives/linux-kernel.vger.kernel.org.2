Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2A63B103A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 00:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhFVWyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 18:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229800AbhFVWym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624402345;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZAToiYSoBX48PZwkBHA5eLSjXvs8urxlIWQJRJqGGyU=;
        b=D+YhuLVLe+RyW/h1Zwutqai0Zw37rTl309d68dr/UiDWI6SavoEOTlbfJloCT6A/9VF90f
        1jUVZsRa0tJzgUukVtvEsnvWRJwR0sNCRWqpNKpcq2v7lVNvCwxZoq+Cuq6myOP28VdDqu
        GOaAJjk+gJIIjBI1NYRO3ywsGYtkX0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-T05E8pI-NBK_8d_Mp3dRug-1; Tue, 22 Jun 2021 18:52:21 -0400
X-MC-Unique: T05E8pI-NBK_8d_Mp3dRug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B9A7108A78D;
        Tue, 22 Jun 2021 22:46:39 +0000 (UTC)
Received: from [10.64.54.84] (vpn2-54-84.bne.redhat.com [10.64.54.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F20B19C66;
        Tue, 22 Jun 2021 22:46:28 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2 3/3] virtio_balloon: Specify page reporting order if
 needed
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shan.gavin@gmail.com
References: <20210622074926.333223-1-gshan@redhat.com>
 <20210622074926.333223-4-gshan@redhat.com>
 <CAKgT0Ue461-yYEYSsSpLo-7xjK8aa3__2aAwJZ+CLy7_waC8Pg@mail.gmail.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <3e449606-e02f-7c09-45e3-8d2401b53086@redhat.com>
Date:   Wed, 23 Jun 2021 10:47:30 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ue461-yYEYSsSpLo-7xjK8aa3__2aAwJZ+CLy7_waC8Pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/21 3:44 AM, Alexander Duyck wrote:
> On Mon, Jun 21, 2021 at 10:49 PM Gavin Shan <gshan@redhat.com> wrote:
>>
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
>> ---
>>   drivers/virtio/virtio_balloon.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index 510e9318854d..fd419780cc23 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -993,6 +993,23 @@ static int virtballoon_probe(struct virtio_device *vdev)
>>                          goto out_unregister_oom;
>>                  }
>>
>> +               /*
>> +                * The default page reporting order is @pageblock_order, which
>> +                * corresponds to 512MB in size on ARM64 when 64KB base page
>> +                * size is used. The page reporting won't be triggered if the
>> +                * freeing page can't come up with a free area like that huge.
>> +                * So we specify the page reporting order to 5, corresponding
>> +                * to 2MB. It helps to avoid THP splitting if 4KB base page
>> +                * size is used by host.
>> +                *
>> +                * Ideallh, the page reporting order is selected based on the
> 
> "Ideally"
> 

Yeah, I noticed it right after the patch was posted. Will be fixed
in v3.

>> +                * host's base page size. However, it needs more work to report
>> +                * that value. The hardcoded order would be fine currently.
>> +                */
>> +#if defined(CONFIG_ARM64) && defined(CONFIG_ARM64_64K_PAGES)
>> +               vb->pr_dev_info.order = 5;
>> +#endif
>> +
>>                  err = page_reporting_register(&vb->pr_dev_info);
>>                  if (err)
>>                          goto out_unregister_oom;
> 
> This works for now. However my preference would be to look into seeing
> if we can add a value that the host can report that would override the
> value you selected here. Then in situations where the host has a
> smaller THP page size then the guest it can report the preferred
> reporting order via the virtio_balloon interface and have greater
> flexibility.
> 
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> 

Yes, It's something for later. Lets fix the particular case
(ARM64 and 64KB page size) for now.

Thanks,
Gavin

