Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36646323A51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 11:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbhBXKP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 05:15:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44566 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234880AbhBXKPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 05:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614161626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4FcXEpP0vdnzaUAUO/Bvo8vNurL9pwZLa9AyjXBoRb0=;
        b=hhmxXQtoRJaP/c+1GHs2fKw7+f37G47EiNYXGE9WSadYVCAosnjufYXTp9erXr1luzhTZi
        ZMdBRfvJ3O4PK0xtB3c4GQ+X95lC+aR9Ql4K2bWU5xCuf9nKhflWL/1lDB5avTR8Jv8mY8
        QMdm9MNv3890ObbEn5LNh5GfjOG/KfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-ntzSqvNBNKmBgedvhNEKjQ-1; Wed, 24 Feb 2021 05:13:44 -0500
X-MC-Unique: ntzSqvNBNKmBgedvhNEKjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A5D9801977;
        Wed, 24 Feb 2021 10:13:42 +0000 (UTC)
Received: from [10.36.114.83] (ovpn-114-83.ams2.redhat.com [10.36.114.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7ECF3828;
        Wed, 24 Feb 2021 10:13:40 +0000 (UTC)
Subject: Re: [PATCH v3] mm/mmap: Don't unlock VMAs in remap_file_pages()
To:     Liam Howlett <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
References: <20210223235010.2296915-1-Liam.Howlett@Oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8eb2255e-b526-1d5f-c224-6af3bec1270d@redhat.com>
Date:   Wed, 24 Feb 2021 11:13:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210223235010.2296915-1-Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.02.21 00:50, Liam Howlett wrote:
> Since this call uses MAP_FIXED, do_mmap() will munlock the necessary
> range.  There is also an error in the loop test expression which will
> evaluate as false and the loop body has never execute.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> ---
>   mm/mmap.c | 18 +-----------------
>   1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dc7206032387c..e22b048733269 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3025,25 +3025,9 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>   
>   	flags &= MAP_NONBLOCK;
>   	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
> -	if (vma->vm_flags & VM_LOCKED) {
> -		struct vm_area_struct *tmp;
> +	if (vma->vm_flags & VM_LOCKED)
>   		flags |= MAP_LOCKED;
>   
> -		/* drop PG_Mlocked flag for over-mapped range */
> -		for (tmp = vma; tmp->vm_start >= start + size;
> -				tmp = tmp->vm_next) {
> -			/*
> -			 * Split pmd and munlock page on the border
> -			 * of the range.
> -			 */
> -			vma_adjust_trans_huge(tmp, start, start + size, 0);
> -
> -			munlock_vma_pages_range(tmp,
> -					max(tmp->vm_start, start),
> -					min(tmp->vm_end, start + size));
> -		}
> -	}
> -
>   	file = get_file(vma->vm_file);
>   	ret = do_mmap(vma->vm_file, start, size,
>   			prot, flags, pgoff, &populate, NULL);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

