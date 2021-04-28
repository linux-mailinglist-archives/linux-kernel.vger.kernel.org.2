Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C7F36DAC1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbhD1PBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:01:13 -0400
Received: from server.lespinasse.org ([63.205.204.226]:57569 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbhD1O7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 10:59:10 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-13-ed;
 t=1619621903; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=QydOVvpj2OAyZRQLFyThi3nH5+pcZsNgV/K3JPyDtNY=;
 b=v0pzT2ftLbgMGbGTh60i1QNqjD03znuBtiCVjyDA+AlHGKjxRg095hn5nSntHwdJwW5G2
 6ieNuTl11n2gIsIBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-13-rsa; t=1619621903; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=QydOVvpj2OAyZRQLFyThi3nH5+pcZsNgV/K3JPyDtNY=;
 b=x/TTWv4tQOnLutEIDbG9cc6Wu1R2lL73vSbCsE8Edvz0ZzakWl8TXCdqzHPoB4q7KtApc
 PS63BgYRDrK2I9sJbFt8w5Wb3W+YiKEv+O7IVJm/IPQEJcRmH4oiDN7wOBl8+KmMEdOzMEQ
 Bcqg/QcQ7qk+RP6dkeEYE8bVyfEwJQb/LLVgCmYr3sTVHLG47D8GgPAA+ceHeEVOMaND8ZV
 qyRoeiMdhcU7ZcbsIrXL3tRexMT8znCDwT/Zv+I8e3V07y3OlHEWb2uXB4NrwjqkimLqeku
 dwPEpKGb8yQQBd/CPngXo6zar+9JaHutiDx2DHNR1JpZkjMwl9RU4K4kL2ag==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id B1B4816026E; Wed, 28 Apr 2021 07:58:23 -0700 (PDT)
Date:   Wed, 28 Apr 2021 07:58:23 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Andy Lutomirski <luto@kernel.org>,
        Paul McKenney <paulmck@kernel.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 13/37] mm: implement speculative handling in
 __handle_mm_fault().
Message-ID: <20210428145823.GA856@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-14-michel@lespinasse.org>
 <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 08:36:01AM -0700, Andy Lutomirski wrote:
> On 4/6/21 6:44 PM, Michel Lespinasse wrote:
> > The page table tree is walked with local irqs disabled, which prevents
> > page table reclamation (similarly to what fast GUP does). The logic is
> > otherwise similar to the non-speculative path, but with additional
> > restrictions: in the speculative path, we do not handle huge pages or
> > wiring new pages tables.
> 
> Not on most architectures.  Quoting the actual comment in mm/gup.c:
> 
> >  * Before activating this code, please be aware that the following assumptions
> >  * are currently made:
> >  *
> >  *  *) Either MMU_GATHER_RCU_TABLE_FREE is enabled, and tlb_remove_table() is used to
> >  *  free pages containing page tables or TLB flushing requires IPI broadcast.
> 
> On MMU_GATHER_RCU_TABLE_FREE architectures, you cannot make the
> assumption that it is safe to dereference a pointer in a page table just
> because irqs are off.  You need RCU protection, too.
> 
> You have the same error in the cover letter.

Hi Andy,

Thanks for your comment. At first I thought did not matter, because we
only enable ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT on selected
architectures, and I thought MMU_GATHER_RCU_TABLE_FREE is not set on
these. But I was wrong - MMU_GATHER_RCU_TABLE_FREE is enabled on X86
with paravirt. So I took another look at fast GUP to make sure I
actually understand it.

This brings a question about lockless_pages_from_mm() - I see it
disabling interrupts, which it explains is necessary for disabling THP
splitting IPIs, but I do not see it taking an RCU read lock as would
be necessary for preventing paga table freeing on
MMU_GATHER_RCU_TABLE_FREE configs. I figure local_irq_save()
indirectly takes an rcu read lock somehow ? I think this is something
I should also mention in my explanation, and I have not seen a good
description of this on the fast GUP side...

Thanks,

--
Michel "walken" Lespinasse
