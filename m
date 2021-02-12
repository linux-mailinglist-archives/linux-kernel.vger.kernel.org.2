Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BA7319C21
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhBLJwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:52:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230023AbhBLJv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613123431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NLn/4/rOA5xb9flMxCQVXqwcmKnjIyeK9Sd83umgNVA=;
        b=PFccEYJ3zXuIOJ8t3l4Sy9s1LrWpedBnsWbAJ+jTNqWWEoTWUFw4yhkDzypqlPk0inDn9q
        n9OlY8UkLLJISscetatnjPAW5xcYNuaCaiZHsTpZApMbD3MRvOu/qNqttH+kMCm1nkqQBB
        GKRYHAt2Zkqbf7YxmeFDKRYJI4xe3NA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-Z8u7bSY7O9y16m2jZttrzQ-1; Fri, 12 Feb 2021 04:50:27 -0500
X-MC-Unique: Z8u7bSY7O9y16m2jZttrzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFDD0100CC88;
        Fri, 12 Feb 2021 09:50:25 +0000 (UTC)
Received: from [10.36.114.178] (ovpn-114-178.ams2.redhat.com [10.36.114.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B18585DEFB;
        Fri, 12 Feb 2021 09:50:24 +0000 (UTC)
Subject: Re: [PATCH] hugetlbfs: Remove unneeded return value of
 hugetlb_vmtruncate()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210208084637.47789-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <379efeaf-a96b-d55d-b542-8fb6fad5ee9a@redhat.com>
Date:   Fri, 12 Feb 2021 10:50:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210208084637.47789-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.02.21 09:46, Miaohe Lin wrote:
> The function hugetlb_vmtruncate() is guaranteed to always success since
> commit 7aa91e104028 ("hugetlb: allow extending ftruncate on hugetlbfs").
> So we should remove the unneeded return value which is always 0.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   fs/hugetlbfs/inode.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 394da2ab08ad..701c82c36138 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -567,7 +567,7 @@ static void hugetlbfs_evict_inode(struct inode *inode)
>   	clear_inode(inode);
>   }
>   
> -static int hugetlb_vmtruncate(struct inode *inode, loff_t offset)
> +static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
>   {
>   	pgoff_t pgoff;
>   	struct address_space *mapping = inode->i_mapping;
> @@ -582,7 +582,6 @@ static int hugetlb_vmtruncate(struct inode *inode, loff_t offset)
>   		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
>   	i_mmap_unlock_write(mapping);
>   	remove_inode_hugepages(inode, offset, LLONG_MAX);
> -	return 0;
>   }
>   
>   static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> @@ -781,9 +780,7 @@ static int hugetlbfs_setattr(struct user_namespace *mnt_userns,
>   		if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
>   		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
>   			return -EPERM;
> -		error = hugetlb_vmtruncate(inode, newsize);
> -		if (error)
> -			return error;
> +		hugetlb_vmtruncate(inode, newsize);
>   	}
>   
>   	setattr_copy(&init_user_ns, inode, attr);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

