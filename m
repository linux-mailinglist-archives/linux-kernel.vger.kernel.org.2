Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78792344631
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCVNtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:49:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:37004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhCVNtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:49:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616420975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5aJOCSImLqPAApaY0++1sOTv38yGygKLihUtVg+NGj4=;
        b=Bfh0Z3YBO7L1DsnYWYefFxQ2lRzNUaof7O/l1GcCBrtxGvepR9goz2264zEC041xAnVSEb
        /mSE2m9DY8gAwvZE2R3QVFfC8afoAt17iVWFkzQ81+emRnTkCI/C1Np2q21SfyCfj43ic8
        7K68RPMoN+7Xvy31vpojeJb5tOH18aA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 55447AC1F;
        Mon, 22 Mar 2021 13:49:35 +0000 (UTC)
Date:   Mon, 22 Mar 2021 14:49:34 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Bui Quang Minh <minhquangbui99@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] userfaultfd: Write protect when virtual memory range has
 no page table entry
Message-ID: <YFigbjaTT+YEEAO6@dhcp22.suse.cz>
References: <20210319152428.52683-1-minhquangbui99@gmail.com>
 <YFhuDf6L7nkUoT7q@dhcp22.suse.cz>
 <YFiU9YWbYpLnlnde@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFiU9YWbYpLnlnde@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-03-21 15:00:37, Mike Rapoport wrote:
> On Mon, Mar 22, 2021 at 11:14:37AM +0100, Michal Hocko wrote:
> > Le'ts Andrea and Mike
> > 
> > On Fri 19-03-21 22:24:28, Bui Quang Minh wrote:
> > > userfaultfd_writeprotect() use change_protection() to clear write bit in
> > > page table entries (pte/pmd). So, later write to this virtual address
> > > range causes a page fault, which is then handled by userspace program.
> > > However, change_protection() has no effect when there is no page table
> > > entries associated with that virtual memory range (a newly mapped memory
> > > range). As a result, later access to that memory range causes allocating a
> > > page table entry with write bit still set (due to VM_WRITE flag in
> > > vma->vm_flags).
> > > 
> > > Add checks for VM_UFFD_WP in vma->vm_flags when allocating new page table
> > > entry in missing page table entry page fault path.
> > 
> > From the above it is not really clear whether this is a usability
> > problem or a bug of the interface.
> 
> I'd say it's usability/documentation clarity issue. 
> Userspace can register an area with
> 
> 	UFFDIO_REGISTER_MODE_MISSING | UFFDIO_REGISTER_MODE_WP
> 
> and then it will be notified either when page table has no entry for a
> virtual address or when there is a write to a write protected address.

Thanks for the clarification! I have suspected this to be the case but
I am not really familiar with the interface to have any strong statement
here. Maybe we want to document this explicitly.
-- 
Michal Hocko
SUSE Labs
