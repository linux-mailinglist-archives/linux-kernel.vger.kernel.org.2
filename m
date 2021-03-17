Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6159433F394
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhCQOnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40860 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230397AbhCQOmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615992170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NkQsXi27NHSKlgwq+pAmF9EiJKw1cWeTWn81mhln8o4=;
        b=HJZuM6TEYPQ3TOxgxK+LbEAwzx23NG/8+hkrV38JvHLrVblhrbVX4d+HH475Hc5FO23wI9
        g8p64tZZ6CmUWiAANPVJW6Mxp/z/5lnWUKsWanjdy8BqTrroiwOYDcaPKj2K35y7IIjCac
        eCtWfy7L9FdP8D0Xds+VynfAeY5wGK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-w2KzdczhNtK16qHwlZsF-g-1; Wed, 17 Mar 2021 10:42:48 -0400
X-MC-Unique: w2KzdczhNtK16qHwlZsF-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F12A51927800;
        Wed, 17 Mar 2021 14:42:46 +0000 (UTC)
Received: from [10.36.112.124] (ovpn-112-124.ams2.redhat.com [10.36.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 032255D6AC;
        Wed, 17 Mar 2021 14:42:44 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] mm,page_alloc: Bail out earlier on -ENOMEM in
 alloc_contig_migrate_range
To:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-2-osalvador@suse.de> <YFIMtFu/g3jtGqA8@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <89830f41-b3f2-a158-a173-8c14101edcaa@redhat.com>
Date:   Wed, 17 Mar 2021 15:42:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFIMtFu/g3jtGqA8@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.21 15:05, Michal Hocko wrote:
> On Wed 17-03-21 12:12:47, Oscar Salvador wrote:
>> Currently, __alloc_contig_migrate_range can generate -EINTR, -ENOMEM or -EBUSY,
>> and report them down the chain.
>> The problem is that when migrate_pages() reports -ENOMEM, we keep going till we
>> exhaust all the try-attempts (5 at the moment) instead of bailing out.
>>
>> migrate_pages() bails out right away on -ENOMEM because it is considered a fatal
>> error. Do the same here instead of keep going and retrying.
> 
> I suspect this is not really a real life problem, right? The allocation
> would be more costly in the end but this is to be expected under a heavy
> memory pressure.
> 
> That being said, bailing out early makes sense to me. But now that
> you've made me look into the migrate_pages excellent error state reporting
> I suspect we have a bug here. Note the
> "Returns the number of pages that were not migrated, or an error code."
> 
> but I do not see putback_movable_pages for ret > 0 so it seems we might
> leak some pages.

At least in __alloc_contig_migrate_range() we seem to always leave the 
loop with ret <= 0 and do a putback_movable_pages() with ret < 0.

Which code are you referring to?

(I think the logic flow inside __alloc_contig_migrate_range() might be 
improved ...)

-- 
Thanks,

David / dhildenb

