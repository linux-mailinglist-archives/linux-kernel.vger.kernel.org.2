Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FBB36CFE1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 02:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbhD1AIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 20:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41588 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235653AbhD1AIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 20:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619568457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4HPRjF6IefTTXi7+TlIzyDGOJbUTZ8HmAi1R2WG08BM=;
        b=Hy4wASKAj25J6nbde5uGqcD6l4vFeeyehsxYVowmc/RQyT2AgmRt5IoYubAZM+oSQLuI6P
        S5xLyHzOruNfD73euz1nb2r7WX8mfoY94+6BvTlJcvE7z/6XzImIhDojqGEMTh0uPUD8fG
        9cussFzH7gHMXqyw9lHt/8O4xwF6UGM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-L_QezfB_PT6ceNQkur49JQ-1; Tue, 27 Apr 2021 20:07:36 -0400
X-MC-Unique: L_QezfB_PT6ceNQkur49JQ-1
Received: by mail-qk1-f198.google.com with SMTP id y9-20020ae9f4090000b02902e4caf24229so3642809qkl.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 17:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4HPRjF6IefTTXi7+TlIzyDGOJbUTZ8HmAi1R2WG08BM=;
        b=li4iYyA9pVWY7gWW6+NszBfdJPDZMa2z3iKbGynzgwSr3zYYl0Lz0y4RP2CeRcV5ps
         gATJTLwmn8PrRcM/WnTfauhWVxIlq4nbRv7i3ZyITZy6/c6beLnW06KL7YnfhFWyeh31
         1eTeeIWZDzd+/hzdMA/r4yvYWUtqMZzbtQ2Uqc9zMqfdVtBwCUTeri3apkuD9re0EP+l
         HgaB33BkCVkoK2yfWOi1UhwSzugMjIWudNCFcI74dKz08R0FtW2FYtiNmBGRI4fhj38x
         lYAP3W5ouhKz7SCY1khMdba32p/7L6qnt/qD6YHNpYPoA7+fY/7wyieKi8YOi67FiYrC
         jmrA==
X-Gm-Message-State: AOAM532M1xH+zKuThAtyopogyJ6d8ZQYg26T33lrW7VBN6jZUvmOUpcc
        qyKt0nD+IYIrmrEKwOmrDDvDq5+LKoojJoxN9pJZUdG+L3OQmLR+jLj7S4CQPDO4pKVPjUWFu9Q
        dKUNjkqXJXRLhGOD/a0bCoDYo
X-Received: by 2002:a37:e10b:: with SMTP id c11mr25020919qkm.152.1619568455502;
        Tue, 27 Apr 2021 17:07:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrU7unTybMnPl+jzN6o83Adzyp5LycZ9z6cmzVkA6kB5d8ANGZMGkCqfiCqW7EQQQzXgxILw==
X-Received: by 2002:a37:e10b:: with SMTP id c11mr25020899qkm.152.1619568455237;
        Tue, 27 Apr 2021 17:07:35 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id d3sm1052773qtm.56.2021.04.27.17.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 17:07:34 -0700 (PDT)
Date:   Tue, 27 Apr 2021 20:07:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 16/24] hugetlb/userfaultfd: Hook page faults for uffd
 write protection
Message-ID: <20210428000732.GA6584@xz-x1>
References: <20210427161317.50682-1-peterx@redhat.com>
 <20210427161317.50682-17-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210427161317.50682-17-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 12:13:09PM -0400, Peter Xu wrote:
> Hook up hugetlbfs_fault() with the capability to handle userfaultfd-wp faults.
> 
> We do this slightly earlier than hugetlb_cow() so that we can avoid taking some
> extra locks that we definitely don't need.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 629aa4c2259c8..8e234ee9a15e2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4802,6 +4802,25 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
>  		goto out_ptl;
>  
> +	/* Handle userfault-wp first, before trying to lock more pages */
> +	if (userfaultfd_pte_wp(vma, huge_ptep_get(ptep)) &&

I'm going to change this to:

-       if (userfaultfd_pte_wp(vma, huge_ptep_get(ptep)) &&
+       if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&

As strictly speaking it's not right to use userfaultfd_pte_wp() directly on a
huge pte...  Currently huge_pte_uffd_wp() is missing in this version (which is
still pte_uffd_wp() anyways), but I'll add a separate patch to introduce all
these helpers (also mention about what arch should do when the huge pte is not
handled the same way as small pte).  I'll try to keep Mike's R-b as this change
should be trivial, or please shoot.  Thanks,

> +	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
> +		struct vm_fault vmf = {
> +			.vma = vma,
> +			.address = haddr,
> +			.flags = flags,
> +		};
> +
> +		spin_unlock(ptl);
> +		if (pagecache_page) {
> +			unlock_page(pagecache_page);
> +			put_page(pagecache_page);
> +		}
> +		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> +		i_mmap_unlock_read(mapping);
> +		return handle_userfault(&vmf, VM_UFFD_WP);
> +	}
> +
>  	/*
>  	 * hugetlb_cow() requires page locks of pte_page(entry) and
>  	 * pagecache_page, so here we need take the former one
> -- 
> 2.26.2
> 

-- 
Peter Xu

