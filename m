Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1EE34823C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbhCXTxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237980AbhCXTxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616615624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Auz9GU/nly2FsewQcEm0zC7+u8Knwn1/X/29MeBpMvo=;
        b=Ck6TeoNqlwv6nxvv9zDgJfoxGJGrPW2GnRgzkQOdZuYHsrdKtwmrZTnq9ULzUA/tV3nu+9
        B6tSmD2i8oW8iPUC1oOrbSc4PanypN7LcktUU5oUrj1c8uP9ErPJ70wIiZJ5z3H79yVA+s
        U9ciCwiyOKJDYowXCWjKYeaWzEOXu8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-yS6nuVE5MomZcMEBSoNjgg-1; Wed, 24 Mar 2021 15:53:40 -0400
X-MC-Unique: yS6nuVE5MomZcMEBSoNjgg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0485F1009456;
        Wed, 24 Mar 2021 19:53:39 +0000 (UTC)
Received: from [10.36.115.66] (ovpn-115-66.ams2.redhat.com [10.36.115.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE2B162677;
        Wed, 24 Mar 2021 19:53:28 +0000 (UTC)
Subject: Re: [PATCH] mm: cma: fix corruption cma_sysfs_alloc_pages_count
To:     John Hubbard <jhubbard@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        willy@infradead.org, digetx@gmail.com
References: <20210324192044.1505747-1-minchan@kernel.org>
 <01e09f8b-93f9-cd59-1f12-7ab4c86743e6@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <bf558f31-8044-954d-70a7-550cea6c08f1@redhat.com>
Date:   Wed, 24 Mar 2021 20:53:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <01e09f8b-93f9-cd59-1f12-7ab4c86743e6@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.03.21 20:45, John Hubbard wrote:
> On 3/24/21 12:20 PM, Minchan Kim wrote:
>> struct cma_stat's lifespan for cma_sysfs is different with
>> struct cma because kobject for sysfs requires dynamic object
>> while CMA is static object[1]. When CMA is initialized,
>> it couldn't use slab to allocate cma_stat since slab was not
>> initialized yet. Thus, it allocates the dynamic object
>> in subsys_initcall.
>>
>> However, the cma allocation can happens before subsys_initcall
>> then, it goes crash.
>>
>> Dmitry reported[2]:
>>
>> ..
>> [    1.226190] [<c027762f>] (cma_sysfs_alloc_pages_count) from [<c027706f>] (cma_alloc+0x153/0x274)
>> [    1.226720] [<c027706f>] (cma_alloc) from [<c01112ab>] (__alloc_from_contiguous+0x37/0x8c)
>> [    1.227272] [<c01112ab>] (__alloc_from_contiguous) from [<c1104af9>] (atomic_pool_init+0x7b/0x126)
>> [    1.233596] [<c1104af9>] (atomic_pool_init) from [<c0101d69>] (do_one_initcall+0x45/0x1e4)
>> [    1.234188] [<c0101d69>] (do_one_initcall) from [<c1101141>] (kernel_init_freeable+0x157/0x1a6)
>> [    1.234741] [<c1101141>] (kernel_init_freeable) from [<c0a27fd1>] (kernel_init+0xd/0xe0)
>> [    1.235289] [<c0a27fd1>] (kernel_init) from [<c0100155>] (ret_from_fork+0x11/0x1c)
>>
>> This patch moves those statistic fields of cma_stat into struct cma
>> and introduces cma_kobject wrapper to follow kobject's rule.
>>
>> At the same time, it fixes other routines based on suggestions[3][4].
>>
>> [1] https://lore.kernel.org/linux-mm/YCOAmXqt6dZkCQYs@kroah.com/
>> [2] https://lore.kernel.org/linux-mm/fead70a2-4330-79ff-e79a-d8511eab1256@gmail.com/
>> [3] https://lore.kernel.org/linux-mm/20210323195050.2577017-1-minchan@kernel.org/
>> [4] https://lore.kernel.org/linux-mm/20210324010547.4134370-1-minchan@kernel.org/
>>
>> Reported-by: Dmitry Osipenko <digetx@gmail.com>
>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>> Suggested-by: Dmitry Osipenko <digetx@gmail.com>
>> Suggested-by: John Hubbard <jhubbard@nvidia.com>
>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: Minchan Kim <minchan@kernel.org>
>> ---
>> I belive it's worth to have separate patch rather than replacing
>> original patch. It will also help to merge without conflict
>> since we already filed other patch based on it.
>> Strictly speaking, separating fix part and readbility part
>> in this patch would be better but it's gray to separate them
>> since most code in this patch was done while we were fixing
>> the bug. Since we don't release it yet, I hope it will work.
>> Otherwise, I can send a replacement patch inclucing all of
>> changes happend until now with gathering SoB.
> 
> If we still have a choice, we should not merge a patch that has a known
> serious problem, such as a crash. That's only done if the broken problematic
> patch has already been committed to a tree that doesn't allow rebasing,
> such as of course the main linux.git.
> 
> Here, I *think* it's just in linux-next and mmotm, so we still are allowed
> to fix the original patch.

Yes, that's what we should do in case it's not upstream yet. Clean 
resend + re-apply.


-- 
Thanks,

David / dhildenb

