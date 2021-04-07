Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FE63575AB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355990AbhDGUPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:15:04 -0400
Received: from server.lespinasse.org ([63.205.204.226]:37655 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345885AbhDGUPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:15:04 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617826493; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=1amBocSDkmECZ2mX+Wc/8c6p3WkPnn/9Znd0jYHQysk=;
 b=1utFFPbwYH/kug0197KEJXeIgLIxpJOV5kRZk+THEpmPkR5sjuxevNPszZCRqfhs8ZgzX
 VbSfwENbkDiOdRyAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617826493; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=1amBocSDkmECZ2mX+Wc/8c6p3WkPnn/9Znd0jYHQysk=;
 b=DEKz1SQnJU+nbSR645NCzeOO9THxWML8a9p6boPQGis3vFpMhPs8PQr3QbgvxAvvHslCn
 TnhKABdkSqoraINfdiXolIpbGsG0/HyHkthR8o2pYO/JWkunCg/m+y7RM8Zy7J6URdLpNVk
 SrbcSf7rpUqx7pTecUuEMzu0BVnmRyLXVoag4y3hJaYEnTgKyhq4TUp5vp8CZfhv7OKuQEv
 nojZ9+GLYUKT9Jo6X5fdvc4cKeHtGjf44xHYzXfE2zJzFiAzThgkuA2Un8/FxNJnZA3uyGK
 j35FL2gSm+wkUNjp7p6Z21ee5TkA7Co3CZTRDEaUUtXUEZgLRMfz1QljNXhQ==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id B8916160244; Wed,  7 Apr 2021 13:14:53 -0700 (PDT)
Date:   Wed, 7 Apr 2021 13:14:53 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 11/37] x86/mm: attempt speculative mm faults first
Message-ID: <20210407201453.GA25738@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-12-michel@lespinasse.org>
 <YG3GTI8j1ohk4NhS@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG3GTI8j1ohk4NhS@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 04:48:44PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 06, 2021 at 06:44:36PM -0700, Michel Lespinasse wrote:
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1219,6 +1219,8 @@ void do_user_addr_fault(struct pt_regs *regs,
> >  	struct mm_struct *mm;
> >  	vm_fault_t fault;
> >  	unsigned int flags = FAULT_FLAG_DEFAULT;
> > +	struct vm_area_struct pvma;
> 
> That's 200 bytes on-stack... I suppose that's just about acceptible, but
> perhaps we need a comment in struct vm_area_struct to make people aware
> this things lives on-stack and size really is an issue now.

Right, I agree that having the vma copy on-stack is not ideal.

I think what really should be done, is to copy just the attributes of
the vma that will be needed during the page fault. Things like vm_mm,
vm_page_prot, vm_flags, vm_ops, vm_pgoff, vm_file, vm_private_data,
vm_policy. We definitely do not need rbtree and rmap fields such as
vm_prev, vm_next, vm_rb, rb_subtree_gap, shared, anon_vma_chain etc...

The reason I did things this way, is because changing the entire fault
handler to use attributes stored in struct vm_fault, rather than in
the original vma, would be quite intrusive. I think it would be a
reasonable step to consider once there is agreement on the rest of the
speculative fault patch set, but it's practical doing it before then.
