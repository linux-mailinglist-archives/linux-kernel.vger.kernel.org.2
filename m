Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39653348D85
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCYJ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46064 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230006AbhCYJ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616666217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8iDzS2rQihbEPN5F5Fal5LzoNiVnY/VTGnse7ANYFHg=;
        b=RskVjdRwfDQgPuma3ADt6P4Se4TNYWg4Vpby7i4eWrvB4KJe2sVmhtBZWmIRzIjUHRYfKo
        7cZ4rvWuP3ciK3XfIjFHhwLPJQw3I209SleDHTy6BiCiLFjcaRJg+V+IcmgG6DyXTKZBQT
        W3oRoYEeMQed9GmVcIPzEzg1PscVHRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-y8ji1gcZPz-bTiDFyxfDjw-1; Thu, 25 Mar 2021 05:56:54 -0400
X-MC-Unique: y8ji1gcZPz-bTiDFyxfDjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA4571013722;
        Thu, 25 Mar 2021 09:56:51 +0000 (UTC)
Received: from [10.36.115.72] (ovpn-115-72.ams2.redhat.com [10.36.115.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 949D66787C;
        Thu, 25 Mar 2021 09:56:39 +0000 (UTC)
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-2-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH 1/8] mm: cma: introduce cma_release_nowait()
Message-ID: <aba43427-0f51-7eb9-fa73-6e55237c8ddb@redhat.com>
Date:   Thu, 25 Mar 2021 10:56:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210325002835.216118-2-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.21 01:28, Mike Kravetz wrote:
> From: Roman Gushchin <guro@fb.com>
> 
> cma_release() has to lock the cma_lock mutex to clear the cma bitmap.
> It makes it a blocking function, which complicates its usage from
> non-blocking contexts. For instance, hugetlbfs code is temporarily
> dropping the hugetlb_lock spinlock to call cma_release().
> 
> This patch introduces a non-blocking cma_release_nowait(), which
> postpones the cma bitmap clearance. It's done later from a work
> context. The first page in the cma allocation is used to store
> the work struct. Because CMA allocations and de-allocations are
> usually not that frequent, a single global workqueue is used.
> 
> To make sure that subsequent cma_alloc() call will pass, cma_alloc()
> flushes the cma_release_wq workqueue. To avoid a performance
> regression in the case when only cma_release() is used, gate it
> by a per-cma area flag, which is set by the first call
> of cma_release_nowait().
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> [mike.kravetz@oracle.com: rebased to v5.12-rc3-mmotm-2021-03-17-22-24]
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---


1. Is there a real reason this is a mutex and not a spin lock? It seems 
to only protect the bitmap. Are bitmaps that huge that we spend a 
significant amount of time in there?

Because I also read "Because CMA allocations and de-allocations are
usually not that frequent".

With a spinlock, you would no longer be sleeping, but obviously you 
might end up waiting for the lock ;) Not sure if that would help.

2. IIUC, if we would do the clearing completely lockless and use atomic 
bitmap ops instead, only cma_debug_show_areas() would see slight 
inconsistencies. As long as the setting code (-> allocation code) holds 
the lock, I think this should be fine (-> no double allocations).

(sorry if that has already been discussed)

-- 
Thanks,

David / dhildenb

