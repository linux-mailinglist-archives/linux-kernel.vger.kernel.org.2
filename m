Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13532390D34
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 02:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhEZARb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 20:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229595AbhEZARa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 20:17:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E09E61028;
        Wed, 26 May 2021 00:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621988159;
        bh=P1mc1cqe6xqa0UqfbAJ+UR2ifYfKaOn6a7141BVg19c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DquXfRw5RI/pndSzZWTrvs3rihvaeTxONkNXRw9LAMhytg64gRDl/IQTuO2BtvViU
         /goY+9FLD0uPKYUnw0dxb/44e7HGAmFyO+bnIL33ikfX5jDuMJol1PwWzd7uZWfefQ
         +YfATwrZylk/7IHX0Lny/6s1PFNmFV6YGw1740GI=
Date:   Tue, 25 May 2021 17:15:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH 2/6] mm/userfaultfd: Fix uffd-wp special cases for
 fork()
Message-Id: <20210525171558.3b223a89c16bdf002f3e83cf@linux-foundation.org>
In-Reply-To: <20210428225030.9708-3-peterx@redhat.com>
References: <20210428225030.9708-1-peterx@redhat.com>
        <20210428225030.9708-3-peterx@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2021 18:50:26 -0400 Peter Xu <peterx@redhat.com> wrote:

> We tried to do something similar in b569a1760782 ("userfaultfd: wp: drop
> _PAGE_UFFD_WP properly when fork") previously, but it's not doing it all
> right..  A few fixes around the code path:
> 
>   1. We were referencing VM_UFFD_WP vm_flags on the _old_ vma rather than the
>      new vma.  That's overlooked in b569a1760782, so it won't work as expected.
>      Thanks to the recent rework on fork code (7a4830c380f3a8b3), we can easily
>      get the new vma now, so switch the checks to that.
> 
>   2. Dropping the uffd-wp bit in copy_huge_pmd() could be wrong if the huge pmd
>      is a migration huge pmd.  When it happens, instead of using pmd_uffd_wp(),
>      we should use pmd_swp_uffd_wp(). The fix is simply to handle them separately.
> 
>   3. Forget to carry over uffd-wp bit for a write migration huge pmd entry.
>      This also happens in copy_huge_pmd(), where we converted a write huge
>      migration entry into a read one.
> 
>   4. In copy_nonpresent_pte(), drop uffd-wp if necessary for swap ptes.
> 
>   5. In copy_present_page() when COW is enforced when fork(), we also need to
>      pass over the uffd-wp bit if VM_UFFD_WP is armed on the new vma, and when
>      the pte to be copied has uffd-wp bit set.
> 
> Remove the comment in copy_present_pte() about this.  It won't help a huge lot
> to only comment there, but comment everywhere would be an overkill.  Let's
> assume the commit messages would help.
> 

This run afoul of Alistair's "mm: Device exclusive memory access",
https://lkml.kernel.org/r/20210524132725.12697-8-apopple@nvidia.com

`vma' is now undeclared.  I think this?

--- a/mm/memory.c~mm-userfaultfd-fix-uffd-wp-special-cases-for-fork-fix
+++ a/mm/memory.c
@@ -850,8 +850,8 @@ copy_nonpresent_pte(struct mm_struct *ds
 		 * exclusive entries currently only support private writable
 		 * (ie. COW) mappings.
 		 */
-		VM_BUG_ON(!is_cow_mapping(vma->vm_flags));
-		if (try_restore_exclusive_pte(src_mm, src_pte, vma, addr))
+		VM_BUG_ON(!is_cow_mapping(dst_vma->vm_flags));
+		if (try_restore_exclusive_pte(src_mm, src_pte, dst_vma, addr))
 			return -EBUSY;
 		return -ENOENT;
 	}
_

