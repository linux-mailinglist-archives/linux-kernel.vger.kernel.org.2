Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1FC349255
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhCYMpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31120 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230467AbhCYMpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616676324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nkPx4zf9Ni/bunuCjgiQUNXyvd5n76YoLZH5aZWMja4=;
        b=CIA/+zwiHZwM561L+gXOUKWntHLFDTfVXo6gturARjYne0xDxYQar+M1lehpoYOlxnsZst
        oSZbR1I9j4fwB7ovli4s2VaGZt268Y48eWNjBfur+jcVzVT122IakYD/Tjeb6R829ADVgV
        +UzPJZk6DZwrenAtyTCPD4Dm9nKO4Vw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-Lk-xWQidNiWyWuKCZR7yJQ-1; Thu, 25 Mar 2021 08:45:19 -0400
X-MC-Unique: Lk-xWQidNiWyWuKCZR7yJQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C1138018A1;
        Thu, 25 Mar 2021 12:45:18 +0000 (UTC)
Received: from [10.36.115.72] (ovpn-115-72.ams2.redhat.com [10.36.115.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04C1A5C3DF;
        Thu, 25 Mar 2021 12:45:14 +0000 (UTC)
Subject: Re: [PATCH] mm/sparse: Add the missing sparse_buffer_fini() in error
 branch
To:     Wang Wensheng <wangwensheng4@huawei.com>,
        akpm@linux-foundation.org, osalvador@suse.de,
        pasha.tatashin@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     rui.xiang@huawei.com
References: <20210325113155.118574-1-wangwensheng4@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <1f20f644-9f51-5f0b-a162-c340912b5212@redhat.com>
Date:   Thu, 25 Mar 2021 13:45:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210325113155.118574-1-wangwensheng4@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.21 12:31, Wang Wensheng wrote:
> sparse_buffer_init() and sparse_buffer_fini() should appear in pair, or
> a WARN issue would be through the next time sparse_buffer_init() runs.
> 
> Add the missing sparse_buffer_fini() in error branch.
> 
> Fixes: 85c77f791390 ("mm/sparse: add new sparse_init_nid() and sparse_init()")
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> ---
>   mm/sparse.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 7bd23f9..33406ea 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -547,6 +547,7 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
>   			pr_err("%s: node[%d] memory map backing failed. Some memory will not be available.",
>   			       __func__, nid);
>   			pnum_begin = pnum;
> +			sparse_buffer_fini();
>   			goto failed;
>   		}
>   		check_usemap_section_nr(nid, usage);
> 

Did you actually manage to reproduce this? I would have thought that 
__populate_section_memmap() barely fails during boot ...


Anyhow, looks like the right think to do to me

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

