Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388D431169E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhBEXH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:07:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232027AbhBEOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612541552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3TsJGd0+8Rr5FyrVFN0YQ1LVOoJ9uc/e+iMpGoDsN6c=;
        b=EAdzdZqAMZOP8xdDPHP5YEiKva4TlKW0xFgjcsgAkjGx/UifIOi6CH019ex8TYKwaiAAcG
        b56xob6BH31UEpYc718x0C1Pbdnst2kCK/2plyIdV3NtfNx9+sXzlPgzBHMC8SrfyiOeLx
        RAeC/3kiSDSwGXjK3UI07U4ybBazk2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-h5tM4UstNoKPRL5aLC_cUg-1; Fri, 05 Feb 2021 11:12:30 -0500
X-MC-Unique: h5tM4UstNoKPRL5aLC_cUg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 888EF80402C;
        Fri,  5 Feb 2021 16:12:29 +0000 (UTC)
Received: from [10.36.113.156] (ovpn-113-156.ams2.redhat.com [10.36.113.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D86919C47;
        Fri,  5 Feb 2021 16:12:28 +0000 (UTC)
Subject: Re: [PATCH] mm/hugetlb: use helper huge_page_size() to simplify the
 hugetlb_vm_op_pagesize()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210205092209.16024-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2743477c-a256-0295-884d-5354c634508d@redhat.com>
Date:   Fri, 5 Feb 2021 17:12:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210205092209.16024-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.02.21 10:22, Miaohe Lin wrote:
> We can use helper huge_page_size() to get the size of the pages allocated
> when backing a VMA directly to make the code more simplified.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/hugetlb.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 18628f8dbfb0..3eea2a34d9f5 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3647,9 +3647,7 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
>   
>   static unsigned long hugetlb_vm_op_pagesize(struct vm_area_struct *vma)
>   {
> -	struct hstate *hstate = hstate_vma(vma);
> -
> -	return 1UL << huge_page_shift(hstate);
> +	return huge_page_size(hstate_vma(vma));
>   }

Maybe it makes sense to squash all of these individual patches you send 
that do the same things/perform the same cleanups. Shouldn't be to hard 
to identify all these cases using simple "git grep".

Makes life of reviewers and maintainers easier ...


-- 
Thanks,

David / dhildenb

