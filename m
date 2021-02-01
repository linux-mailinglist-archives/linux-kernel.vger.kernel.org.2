Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3FD30AF7C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhBASft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:35:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232999AbhBASdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612204324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eGnMVrjYoL74O1671GF2bpk9Mg2hYvXBiXlmuuE5Fo4=;
        b=jIwvncTvqton9+fvjufPpBQgYUvljB8lTYpbZHoO/X2He0N7ZDz6YLuurKQ+QIeFaqMHE3
        B6IvGKSbZPReN8YDLz6LlJwdmKNxipqUdzD/DWEsHsZuzFSvksrYwKFeWhCs6HGYZVk0MV
        CTk0Ex6VXwNSgkFX0OZ/OIdWNiXVTX0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-q6uz6CwNOLq3R9dfUrfoag-1; Mon, 01 Feb 2021 13:32:03 -0500
X-MC-Unique: q6uz6CwNOLq3R9dfUrfoag-1
Received: by mail-qk1-f199.google.com with SMTP id e5so13966533qkn.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eGnMVrjYoL74O1671GF2bpk9Mg2hYvXBiXlmuuE5Fo4=;
        b=qUTVKrcykhwf+B39l+bOFqBVPW5nCTFsofjBCiBwSoFMBPpC7LhtLEU1bNi6iymEoa
         ZjvgM2o5MYelV5GsKK7WQ8RuTGAEKWh//JeG3d/f3qQbvLDYzBNvc8VX7OQ/iw3Hv7N7
         T80GpgY2+hIR9TGJo58xDoYVkgWAqWv0Zj40+2xhR0H5a4o8zWhtImzEb01+sE37HizZ
         pqzQl92Bprg3FjvVZD/fcRQmOpWbAhYabYYewyMbOddnrd5R//BhH8vJlqJ8IXhgmVWv
         LTyREQg6fhHAnB6rXF0qiGGYGtZThnaasO28EC5WH0E2NfqMdf3qd1p5b7THfH5++YQW
         7hFg==
X-Gm-Message-State: AOAM531ij8qJd8e+lLiPo4QAmRdv/KlJ96/aqYR4U5TppHo0VX3A2HdX
        vMW2g2M5OaKJ2oJhyv91xJ6bs7MuMR2IgO1/QyZ3C2rsPahEMuO9Sz6LRV6b3e7Lx4gIuf9/FUb
        m+8BI+DwP7P6GWnvaSnlSIK67
X-Received: by 2002:a05:622a:28d:: with SMTP id z13mr16655646qtw.87.1612204322668;
        Mon, 01 Feb 2021 10:32:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJK+spTGER3hyW35kxmeQAWfZPyW2Gmvh9OEvQWvWgtG63iuN5ASuXAcAlEgsKAZT0riy1Tw==
X-Received: by 2002:a05:622a:28d:: with SMTP id z13mr16655618qtw.87.1612204322354;
        Mon, 01 Feb 2021 10:32:02 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id m21sm14447098qtq.52.2021.02.01.10.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:32:01 -0800 (PST)
Date:   Mon, 1 Feb 2021 13:31:59 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v3 5/9] userfaultfd: add minor fault registration mode
Message-ID: <20210201183159.GF260413@xz-x1>
References: <20210128224819.2651899-1-axelrasmussen@google.com>
 <20210128224819.2651899-6-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128224819.2651899-6-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 02:48:15PM -0800, Axel Rasmussen wrote:
> This feature allows userspace to intercept "minor" faults. By "minor"
> faults, I mean the following situation:
> 
> Let there exist two mappings (i.e., VMAs) to the same page(s) (shared
> memory). One of the mappings is registered with userfaultfd (in minor
> mode), and the other is not. Via the non-UFFD mapping, the underlying
> pages have already been allocated & filled with some contents. The UFFD
> mapping has not yet been faulted in; when it is touched for the first
> time, this results in what I'm calling a "minor" fault. As a concrete
> example, when working with hugetlbfs, we have huge_pte_none(), but
> find_lock_page() finds an existing page.
> 
> This commit adds the new registration mode, and sets the relevant flag
> on the VMAs being registered. In the hugetlb fault path, if we find
> that we have huge_pte_none(), but find_lock_page() does indeed find an
> existing page, then we have a "minor" fault, and if the VMA has the
> userfaultfd registration flag, we call into userfaultfd to handle it.

When re-read, now I'm thinking whether we should restrict the minor fault
scenario with shared mappings always, assuming there's one mapping with uffd
and the other one without, while the non-uffd can modify the data before an
UFFDIO_CONTINUE kicking the uffd process.

To me, it's really more about page cache and that's all..

So I'm wondering whether below would be simpler and actually clearer on
defining minor faults, comparing to the above whole two paragraphs.  For
example, the scemantics do not actually need two mappings:

    For shared memory, userfaultfd missing fault used to only report the event
    if the page cache does not exist for the current fault process.  Here we
    define userfaultfd minor fault as the case where the missing page fault
    does have a backing page cache (so only the pgtable entry is missing).

It should not affect most of your code, but only one below [1].

[...]

> @@ -1302,9 +1301,26 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
>  				     unsigned long vm_flags)
>  {
>  	/* FIXME: add WP support to hugetlbfs and shmem */
> -	return vma_is_anonymous(vma) ||
> -		((is_vm_hugetlb_page(vma) || vma_is_shmem(vma)) &&
> -		 !(vm_flags & VM_UFFD_WP));
> +	if (vm_flags & VM_UFFD_WP) {
> +		if (is_vm_hugetlb_page(vma) || vma_is_shmem(vma))
> +			return false;
> +	}
> +
> +	if (vm_flags & VM_UFFD_MINOR) {
> +		/*
> +		 * The use case for minor registration (intercepting minor
> +		 * faults) is to handle the case where a page is present, but
> +		 * needs to be modified before it can be used. This requires
> +		 * two mappings: one with UFFD registration, and one without.
> +		 * So, it only makes sense to do this with shared memory.
> +		 */
> +		/* FIXME: Add minor fault interception for shmem. */
> +		if (!(is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SHARED)))
> +			return false;

[1]

So here we also restrict the mapping be shared.  My above comment on the commit
message is also another way to ask whether we could also allow it to happen
with non-shared mappings as long as there's a page cache.  If so, we could drop
the VM_SHARED check here.  It won't affect your existing use case for sure, it
just gives more possibility that maybe it could also be used on non-shared
mappings due to some reason in the future.

What do you think?

The rest looks good to me.

Thanks,

-- 
Peter Xu

