Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1175C3502B2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 16:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbhCaOtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:49:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:46594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236140AbhCaOt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:49:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617202168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tfJA+TZ9qD+uLNeSPxgFvSUB6YHzcDNmhesxVbtiM78=;
        b=rjVi1+kLoItHEcYK0qZA68TaaHcXVmKEVe3A4lvDfumVUvd5U2wi9hVHA8aiPXu2a78wO3
        KJEjJzHcFeMO3sOm3NUDoY1fBXqVpICxBxs7gBHFM3mwwfDZvkdjY2AebTMwG3A0hT8Kbr
        WbgAfk51AZm0qEpp7uPaeVeG4fT6yjo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 74C1FB315;
        Wed, 31 Mar 2021 14:49:28 +0000 (UTC)
Date:   Wed, 31 Mar 2021 16:49:27 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     akpm@linux-foundation.org
Cc:     Mike Rapoport <rppt@kernel.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] userfaultfd: Write protect when virtual memory range has
 no page table entry
Message-ID: <YGSL91uL1K2RwOWY@dhcp22.suse.cz>
References: <20210319152428.52683-1-minhquangbui99@gmail.com>
 <YFhuDf6L7nkUoT7q@dhcp22.suse.cz>
 <YFiU9YWbYpLnlnde@kernel.org>
 <YFigbjaTT+YEEAO6@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFigbjaTT+YEEAO6@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-03-21 14:49:35, Michal Hocko wrote:
> On Mon 22-03-21 15:00:37, Mike Rapoport wrote:
> > On Mon, Mar 22, 2021 at 11:14:37AM +0100, Michal Hocko wrote:
> > > Le'ts Andrea and Mike
> > > 
> > > On Fri 19-03-21 22:24:28, Bui Quang Minh wrote:
> > > > userfaultfd_writeprotect() use change_protection() to clear write bit in
> > > > page table entries (pte/pmd). So, later write to this virtual address
> > > > range causes a page fault, which is then handled by userspace program.
> > > > However, change_protection() has no effect when there is no page table
> > > > entries associated with that virtual memory range (a newly mapped memory
> > > > range). As a result, later access to that memory range causes allocating a
> > > > page table entry with write bit still set (due to VM_WRITE flag in
> > > > vma->vm_flags).
> > > > 
> > > > Add checks for VM_UFFD_WP in vma->vm_flags when allocating new page table
> > > > entry in missing page table entry page fault path.
> > > 
> > > From the above it is not really clear whether this is a usability
> > > problem or a bug of the interface.
> > 
> > I'd say it's usability/documentation clarity issue. 
> > Userspace can register an area with
> > 
> > 	UFFDIO_REGISTER_MODE_MISSING | UFFDIO_REGISTER_MODE_WP
> > 
> > and then it will be notified either when page table has no entry for a
> > virtual address or when there is a write to a write protected address.
> 
> Thanks for the clarification! I have suspected this to be the case but
> I am not really familiar with the interface to have any strong statement
> here. Maybe we want to document this explicitly.

Btw. Andrew the patch still seems to be in mmotm. Do you plan to keep it
there?

-- 
Michal Hocko
SUSE Labs
