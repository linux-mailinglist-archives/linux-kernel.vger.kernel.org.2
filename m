Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294EB34A3D0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhCZJLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50423 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230113AbhCZJLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616749875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYIdGHSbq+nHpKryU5K53cj3fb6qJx+fwdvk+fL0gws=;
        b=Cg3LeY/3KG194YGYcsM6qk2IWjAf1UuEPrUxAofWYHM33xUP8nqkuwC/gBFX748Xjy6z8B
        0zNBGi960rXL3pT9UtC5SXqT53Os/Lq9Ly6rmvjmSGfOkOt+mqOGY1vLtdaZjx6xO9K8ag
        c+avyh1M4PyiocFzWHh6l5n38/IFsbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-siUoXzJuPeetuU1R6PeB_A-1; Fri, 26 Mar 2021 05:11:11 -0400
X-MC-Unique: siUoXzJuPeetuU1R6PeB_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C380E835B63;
        Fri, 26 Mar 2021 09:11:09 +0000 (UTC)
Received: from [10.36.114.167] (ovpn-114-167.ams2.redhat.com [10.36.114.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D47210016F4;
        Fri, 26 Mar 2021 09:11:08 +0000 (UTC)
Subject: Re: [PATCH] mm/sparse: Add the missing sparse_buffer_fini() in error
 branch
To:     Wang Wensheng <wangwensheng4@huawei.com>,
        akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     rui.xiang@huawei.com
References: <20210326022325.3181-1-wangwensheng4@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <85e0d0f0-e6c7-e287-c6b2-ab5d37b718e2@redhat.com>
Date:   Fri, 26 Mar 2021 10:11:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210326022325.3181-1-wangwensheng4@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.21 03:23, Wang Wensheng wrote:
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

I am confused, why the resend, and why without RBs?

https://lkml.kernel.org/r/20210325113155.118574-1-wangwensheng4@huawei.com

-- 
Thanks,

David / dhildenb

