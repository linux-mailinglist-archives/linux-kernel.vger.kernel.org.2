Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEF6390EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 05:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhEZDGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 23:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhEZDGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 23:06:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 323BE61059;
        Wed, 26 May 2021 03:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621998272;
        bh=V4OpdXOQ49FmWgr/xUUxYOmoUsWXjcuopfW08hMrjv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kSfWwaZ/I/MUjqP8ClC5NFBBhtbtwTtUV5fuaH+f597H5ZPRBtKz5JzjREaFInqZN
         FF4Kp0lT5LeFOBHGqlx8A6hjo0/JRkSpISjVFlOo2PsY5bfR57DXmbJt/Ngf/fyA/H
         YBq8GQ0THZbtXlJib70TNVVst5pdpdbC8jp65eTQ=
Date:   Tue, 25 May 2021 20:04:31 -0700
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
Message-Id: <20210525200431.41eb48106ba681151f320afb@linux-foundation.org>
In-Reply-To: <YK2YArvcaabj8GHi@t490s>
References: <20210428225030.9708-1-peterx@redhat.com>
        <20210428225030.9708-3-peterx@redhat.com>
        <20210525171558.3b223a89c16bdf002f3e83cf@linux-foundation.org>
        <YK2YArvcaabj8GHi@t490s>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021 20:36:18 -0400 Peter Xu <peterx@redhat.com> wrote:

> On Tue, May 25, 2021 at 05:15:58PM -0700, Andrew Morton wrote:
> > This run afoul of Alistair's "mm: Device exclusive memory access",
> > https://lkml.kernel.org/r/20210524132725.12697-8-apopple@nvidia.com
> > 
> > `vma' is now undeclared.  I think this?
> > 
> > --- a/mm/memory.c~mm-userfaultfd-fix-uffd-wp-special-cases-for-fork-fix
> > +++ a/mm/memory.c
> > @@ -850,8 +850,8 @@ copy_nonpresent_pte(struct mm_struct *ds
> >  		 * exclusive entries currently only support private writable
> >  		 * (ie. COW) mappings.
> >  		 */
> > -		VM_BUG_ON(!is_cow_mapping(vma->vm_flags));
> > -		if (try_restore_exclusive_pte(src_mm, src_pte, vma, addr))
> > +		VM_BUG_ON(!is_cow_mapping(dst_vma->vm_flags));
> 
> This one looks good, as both src_vma/dst_vma should have the same flags related
> to is_cow.
> 
> > +		if (try_restore_exclusive_pte(src_mm, src_pte, dst_vma, addr))
> 
> Should this be s/dst_vma/src_vma/ perhaps?  Alistairs please correct me
> otherwise, as it tries to restore the pte for src mm not dst (the child).
> 
> I haven't yet got time to look at the new series, planning to do it tomorrow
> maybe.. but I see that it's already queued in -mm.  Andrew, we do have chance
> to go back if necessary, right?

Sure.

> I haven't looked at the rest, but I think try_restore_exclusive_pte() can at
> least drop the *mm pointer as it's never used (even if we need, we've got
> vma->vm_mm too)..

OK, thanks.  I just released a tree into linux-next (hopefully this
blooper won't cause too much damage).  Please send a suitable fixup.

