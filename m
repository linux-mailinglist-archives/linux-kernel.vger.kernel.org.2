Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7C8356181
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 04:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243614AbhDGCxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 22:53:40 -0400
Received: from server.lespinasse.org ([63.205.204.226]:38929 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhDGCxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 22:53:38 -0400
X-Greylist: delayed 2802 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Apr 2021 22:53:36 EDT
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617764000; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=AEkIgafzi7RpGn936tjGd8ecfLF4DBUsLsBZWtHC3mE=;
 b=jwq0GYnuqbluhacKNV+IS34m5Cy5apitjOcbiVWuIY1KAUeIpQE+zTHyBQwnrXTGYG83z
 jiPcnTahJuUp9RxDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617764000; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=AEkIgafzi7RpGn936tjGd8ecfLF4DBUsLsBZWtHC3mE=;
 b=QdC9Mh3eVoNrOVHPdwYVAcJtLFrR5Jq0+IwQluDDulUsFoXYdPJrnyFMRAXvuS4ofjZA6
 i2QwKfDRfimkZuZTlqa9QmdRj3Ms3nlCMYEQ5rUaV99lmznXgVraoSXWxonpEu04vCoX3z9
 na95oCqP/WOF1TdAVLBLx4W8qh83sYlWD4pEPrTqsVyp5jediQ7Zo2wTmEV3zQdpE2VnaUB
 6jEht/ob8DyfXLM2DPgNAf5vQCGqNLs0otVdJknn0Bj0XR8UTGt3IkkviCvIIWzKJbgn4u4
 cqYdg0Li7gDpd30NYcc/nK+ZztHMaRGAxuf43hOsNaLhtMxeN6SdPctvIhsw==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 489D81601D1; Tue,  6 Apr 2021 19:53:20 -0700 (PDT)
Date:   Tue, 6 Apr 2021 19:53:20 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 24/37] mm: implement speculative handling in
 __do_fault()
Message-ID: <20210407025320.GA19997@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-25-michel@lespinasse.org>
 <20210407023527.GX2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407023527.GX2531743@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 03:35:27AM +0100, Matthew Wilcox wrote:
> On Tue, Apr 06, 2021 at 06:44:49PM -0700, Michel Lespinasse wrote:
> > In the speculative case, call the vm_ops->fault() method from within
> > an rcu read locked section, and verify the mmap sequence lock at the
> > start of the section. A match guarantees that the original vma is still
> > valid at that time, and that the associated vma->vm_file stays valid
> > while the vm_ops->fault() method is running.
> > 
> > Note that this implies that speculative faults can not sleep within
> > the vm_ops->fault method. We will only attempt to fetch existing pages
> > from the page cache during speculative faults; any miss (or prefetch)
> > will be handled by falling back to non-speculative fault handling.
> > 
> > The speculative handling case also does not preallocate page tables,
> > as it is always called with a pre-existing page table.
> 
> I still don't understand why you want to do this.  The speculative
> fault that doesn't do I/O is already here, and it's called ->map_pages
> (which I see you also do later).  So what's the point of this patch?

I have to admit I did not give much tought about which path would be
generally most common here.

The speculative vm_ops->fault path would be used:
- for private mapping write faults,
- when fault-around is disabled (probably an uncommon case in general,
  but actually common at Google).

That said, I do think your point makes sense in general, espicially if
this could help avoid the per-filesystem enable bit.
