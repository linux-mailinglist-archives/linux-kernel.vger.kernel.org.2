Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D539933B0AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCOLKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53365 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229813AbhCOLKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615806613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8yuhBec4/2fTpsvveERpk7/R/kPqBZv9NR7tFdHJ5s=;
        b=O2S7+mpTdathAM7oVQLb13wI8uSAX+l0VXmlDyoT0OtqK1crl9XJCRWdypGB1dnK56xQfR
        Gm61RkE3VXDAqdAFVghqDNVZOGwvhLjQ/ZeZX2Eox+8EOqluHOUCDV/XS1SgNNIUiBMT2b
        xGgZ4+d1bI0VwwXFRazKXzmI5DcdKhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-eOGXBqH5N3WE6lUyP2O3xQ-1; Mon, 15 Mar 2021 07:10:09 -0400
X-MC-Unique: eOGXBqH5N3WE6lUyP2O3xQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F1301074659;
        Mon, 15 Mar 2021 11:10:07 +0000 (UTC)
Received: from [10.36.112.200] (ovpn-112-200.ams2.redhat.com [10.36.112.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56F9A6C43A;
        Mon, 15 Mar 2021 11:10:05 +0000 (UTC)
Subject: Re: [PATCH v4 1/4] mm,page_alloc: Bail out earlier on -ENOMEM in
 alloc_contig_migrate_range
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210310150853.13541-1-osalvador@suse.de>
 <20210310150853.13541-2-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c9f50be7-8a34-d455-e960-0b079ac6609f@redhat.com>
Date:   Mon, 15 Mar 2021 12:10:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210310150853.13541-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.21 16:08, Oscar Salvador wrote:
> Currently, __alloc_contig_migrate_range can generate -EINTR, -ENOMEM or -EBUSY,
> and report them down the chain.
> The problem is that when migrate_pages() reports -ENOMEM, we keep going till we
> exhaust all the try-attempts (5 at the moment) instead of bailing out.
> 
> migrate_pages bails out right away on -ENOMEM because it is considered a fatal
> error. Do the same here instead of keep going and retrying.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   mm/page_alloc.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3e4b29ee2b1e..94467f1b85ff 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8484,7 +8484,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>   			}
>   			tries = 0;
>   		} else if (++tries == 5) {
> -			ret = ret < 0 ? ret : -EBUSY;
> +			ret = -EBUSY;
>   			break;
>   		}
>   
> @@ -8494,6 +8494,12 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>   
>   		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
>   				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
> +		/*
> +		 * On -ENOMEM, migrate_pages() bails out right away. It is pointless
> +		 * to retry again over this error, so do the same here.
> +		 */
> +		if (ret == -ENOMEM)
> +			break;

I would have thought we could also be able to get other fatal errors 
from migrate_pages(), but doesn't seem like it

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

