Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5E5309054
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 23:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhA2Wvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 17:51:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50466 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231429AbhA2WvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 17:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611960582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=86e/Q91vEJwCNuCWODhKxinbSCcjEo7o3J9HsTUI3gE=;
        b=JyEQMe1sKse27iKsdWq8rcBML8s1yMzRXOw/7KcFxOewKg7012DaE6+8/mlnS4alU45W1t
        2Znbpl0r1MFCEx0O4BOoFmqWhLw4igronDIN1/9b2P6kALxFeq8Yd/jUBTTzXC3QaJnvOi
        D5yhNTPxwLQvWZ6JIAX/2aszfT4PKYU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-shmXkCNMNk-UHeUTGqjjxg-1; Fri, 29 Jan 2021 17:49:41 -0500
X-MC-Unique: shmXkCNMNk-UHeUTGqjjxg-1
Received: by mail-qt1-f200.google.com with SMTP id t5so7137902qti.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 14:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=86e/Q91vEJwCNuCWODhKxinbSCcjEo7o3J9HsTUI3gE=;
        b=PqVjnBxmOPEjtRvs/a8IPa6J6AMoaJPT649cKt7ocsGDjVZhHlsr3vcsYUPv4Q7+kN
         ywdcpeP4T7PkssX3tG9KHOhhNUPeonzd6p1zWe7pO1GNbqciJWZeJJPgsmXiLYiY5hxT
         wV5M8y8o0pBobJB0VZ0XAlPIQVqtxiQ6PF+Hkbowc7bjr2EaiQBhN0WNGGlPein2dr85
         EXcWHUSJNNNZjdaKmpERkVp6GNHHP86DUdBMO8v/r0TbHPJAIcJDez+Dt27DkLb2gu/S
         pdQogxx1ifN2d/zNBJp06Tbik8/VeNcpOsxI1urbYqA7T61aIg3u/0Zi3pFNjjtztOQh
         kyiA==
X-Gm-Message-State: AOAM5301jXjnafhkg2peuhQBKfGui5mxsiArvhQZgzQXYp4eCMKNaMX7
        86fNyL19QH3yHa04kHbg+R5DGb9pJDw08UJUoO7o8UYbFlshOBoS5cOuO88G4KPvjIP2h0wOrL1
        j3qgcO2i5NJnJOMlDQ8HBeAb5xsCE74jBMNrpF/7DpvRLBWPqSOGOybbHSCCTAE6x7ed26l3d/Q
        ==
X-Received: by 2002:ac8:bc4:: with SMTP id p4mr6356541qti.195.1611960580663;
        Fri, 29 Jan 2021 14:49:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynZsWldx+l8FXJGR6IflMlMsR+z6lMklRqeZ9afQwH+bW1mk/spRQWn8v6S0rRIXGypKuJcQ==
X-Received: by 2002:ac8:bc4:: with SMTP id p4mr6356518qti.195.1611960580378;
        Fri, 29 Jan 2021 14:49:40 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id u133sm1798784qka.116.2021.01.29.14.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 14:49:39 -0800 (PST)
Date:   Fri, 29 Jan 2021 17:49:38 -0500
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH RFC 00/30] userfaultfd-wp: Support shmem and hugetlbfs
Message-ID: <20210129224938.GC260413@xz-x1>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 12:08:37PM -0500, Peter Xu wrote:
> This is a RFC series to support userfaultfd upon shmem and hugetlbfs.
> 
> PS. Note that there's a known issue [0] with tlb against uffd-wp/soft-dirty in
> general and Nadav is working on it.  It may or may not directly affect
> shmem/hugetlbfs since there're no COW on shared mappings normally.  Private
> shmem could hit, but still that's another problem to solve in general, and this
> RFC is majorly to see whether there's any objection on the concept of the idea
> specific to uffd-wp on shmem/hugetlbfs.
> 
> The whole series can also be found online [1].
> 
> The major comment I'd like to get is on the new idea of swap special pte.  That
> comes from suggestions from both Hugh and Andrea and I appreciated a lot for
> those discussions.
> 
> In short, it's a new type of pte that doesn't exist in the past, while used in
> file-backed memories to persist information across ptes being erased (but the
> page cache could still exist, for example, so in the next page fault we can
> reload the page cache with that specific information when necessary).
> 
> I'm copy-pasting some commit message from the patch "mm/swap: Introduce the
> idea of special swap ptes", where uffd-wp becomes the first user of it:
> 
>     We used to have special swap entries, like migration entries, hw-poison
>     entries, device private entries, etc.
> 
>     Those "special swap entries" reside in the range that they need to be at least
>     swap entries first, and their types are decided by swp_type(entry).
> 
>     This patch introduces another idea called "special swap ptes".
> 
>     It's very easy to get confused against "special swap entries", but a speical
>     swap pte should never contain a swap entry at all.  It means, it's illegal to
>     call pte_to_swp_entry() upon a special swap pte.
> 
>     Make the uffd-wp special pte to be the first special swap pte.
> 
>     Before this patch, is_swap_pte()==true means one of the below:
> 
>        (a.1) The pte has a normal swap entry (non_swap_entry()==false).  For
>              example, when an anonymous page got swapped out.
> 
>        (a.2) The pte has a special swap entry (non_swap_entry()==true).  For
>              example, a migration entry, a hw-poison entry, etc.
> 
>     After this patch, is_swap_pte()==true means one of the below, where case (b) is
>     added:
> 
>      (a) The pte contains a swap entry.
> 
>        (a.1) The pte has a normal swap entry (non_swap_entry()==false).  For
>              example, when an anonymous page got swapped out.
> 
>        (a.2) The pte has a special swap entry (non_swap_entry()==true).  For
>              example, a migration entry, a hw-poison entry, etc.
> 
>      (b) The pte does not contain a swap entry at all (so it cannot be passed
>          into pte_to_swp_entry()).  For example, uffd-wp special swap pte.
> 
> Hugetlbfs needs similar thing because it's also file-backed.  I directly reused
> the same special pte there, though the shmem/hugetlb change on supporting this
> new pte is different since they don't share code path a lot.

Huge & Mike,

Would any of you have comment/concerns on the high-level design of this series?

It would be great to know it, especially major objection, before move on to an
non-rfc version.

Thanks,

-- 
Peter Xu

