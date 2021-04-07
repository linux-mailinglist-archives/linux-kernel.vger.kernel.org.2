Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C3135761D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhDGUc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:32:58 -0400
Received: from server.lespinasse.org ([63.205.204.226]:49973 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbhDGUcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:32:47 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617827557; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=8+RTC5y9SGjFpBKmqkWwVCk46oblpz7Iw5ZFtmiCre0=;
 b=myxGJZUXe+NiYa8jTF68T5sVHAIRuWKBJvTubjYWMRny6i72+hPXGNFbHPi3+JlOU+oiY
 BQFEjQBOVFDoWeXCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617827557; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=8+RTC5y9SGjFpBKmqkWwVCk46oblpz7Iw5ZFtmiCre0=;
 b=gwXSR8jeWr+MhP6KenwdNG70wDvW4+sfC9vBokubO0p4UlXmonHUXgbDdO0FnkP1/Hzov
 XZSJ4JByG9DRSY0LP4wyG/ZQAcm1VKObfYyaYa+W9/LAlHYVOyxtO00BgwRyV5xhTSjeLnj
 2xxDXdIrnsG5ukGblOqdduOQLd1Bvifgk16B7n7HNxWo6CX4NXypTx5ZytOhf4cQSDTLAsL
 +VMuLcKhTnmNCTtI+eKQ2iFFHymjKYUgJW0BVhc4OHAx383laypPoNozJRCMlZ21bw79YyI
 oKuH1N3QuEm6vSzud/CmlBmYiOcfuBydbvPXkeffIOy13qTmiCqdjCRrAb7g==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id B0D91160244; Wed,  7 Apr 2021 13:32:37 -0700 (PDT)
Date:   Wed, 7 Apr 2021 13:32:37 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 11/37] x86/mm: attempt speculative mm faults first
Message-ID: <20210407203237.GC25738@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-12-michel@lespinasse.org>
 <YG3GTI8j1ohk4NhS@hirez.programming.kicks-ass.net>
 <20210407153528.GF2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407153528.GF2531743@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 04:35:28PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 07, 2021 at 04:48:44PM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 06, 2021 at 06:44:36PM -0700, Michel Lespinasse wrote:
> > > --- a/arch/x86/mm/fault.c
> > > +++ b/arch/x86/mm/fault.c
> > > @@ -1219,6 +1219,8 @@ void do_user_addr_fault(struct pt_regs *regs,
> > >  	struct mm_struct *mm;
> > >  	vm_fault_t fault;
> > >  	unsigned int flags = FAULT_FLAG_DEFAULT;
> > > +	struct vm_area_struct pvma;
> > 
> > That's 200 bytes on-stack... I suppose that's just about acceptible, but
> > perhaps we need a comment in struct vm_area_struct to make people aware
> > this things lives on-stack and size really is an issue now.
> 
> Michel's gone off and done his own thing here.

I don't think that is an entirely fair representation. First we are
both aware of each other's work, there is no working in dark caves here.
But also, I don't even consider this patchset to be entirely my thing;
most of the main building blocks come from prior proposals before mine.

> The rest of us (Laurent, Liam & I) are working on top of the maple tree
> which shrinks vm_area_struct by five pointers, so just 160 bytes.

The idea of evaluating maple tree and speculative faults as a bundle
is actually worrying to me. I think both ideas are interesting and
worth looking into on their own, but I'm not convinced that they have
much to do with each other.

> Also, our approach doesn't involve copying VMAs in order to handle a fault.

See my other reply to Peter's message - copying VMAs is a convenient
way to reduce the size of the patchset, but it's not fundamental to
the approach at all.
