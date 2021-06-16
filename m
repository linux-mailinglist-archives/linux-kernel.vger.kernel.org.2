Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAE93A940F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhFPHeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhFPHeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:34:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282E3C061767
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fl3DdxiotfbJW41rurXe7Q6sPhCdtUvqest464jkbyM=; b=LioT44BF3C0/SbJehA4uhP8re5
        MEo6fFLHkkm4X31U4PVvUfSYs4blO2O12qyoUM3Nj8gI+qefFa7+nITyI/jYUB0kaUkhkFL7sAbfr
        4X0RYrXr/+tG15PhxAMPGDD5Wo3X3EM7dWjbSdJbNlVIqThpc0jqauiihreMahb2Gm0IE56O8uJDh
        y38LBkt3mICzcR8DIx/3m1trnqf8R/3Lhj+7Tvbqj1rg7rPVB644Ky5QfjbiXxw5vIn0009JFpv8y
        wlrCxInNx72/O9AmmASyRmIFFz6yD87dpgQ5/7lFN/C6pEMOATLk+tRjr55neduNSAlRNj7vMbAef
        J6RfiQZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltQ0h-007kdA-M3; Wed, 16 Jun 2021 07:30:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B4471300252;
        Wed, 16 Jun 2021 09:30:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 601902C76DB8D; Wed, 16 Jun 2021 09:30:50 +0200 (CEST)
Date:   Wed, 16 Jun 2021 09:30:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/8] membarrier: Document why membarrier() works
Message-ID: <YMmoqgLdMNu7KAV5@hirez.programming.kicks-ass.net>
References: <cover.1623813516.git.luto@kernel.org>
 <b648efcb72feb257b9fe004bd132f581805ec0d6.1623813516.git.luto@kernel.org>
 <1623814509.xcl6pmt93d.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623814509.xcl6pmt93d.astroid@bobo.none>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 02:00:37PM +1000, Nicholas Piggin wrote:
> Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 pm:
> > We had a nice comment at the top of membarrier.c explaining why membarrier
> > worked in a handful of scenarios, but that consisted more of a list of
> > things not to forget than an actual description of the algorithm and why it
> > should be expected to work.
> > 
> > Add a comment explaining my understanding of the algorithm.  This exposes a
> > couple of implementation issues that I will hopefully fix up in subsequent
> > patches.
> > 
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > ---
> >  kernel/sched/membarrier.c | 55 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> > 
> > diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> > index b5add64d9698..3173b063d358 100644
> > --- a/kernel/sched/membarrier.c
> > +++ b/kernel/sched/membarrier.c
> > @@ -7,6 +7,61 @@
> >  #include "sched.h"
> >  
> 
> Precisely describing the orderings is great, not a fan of the style of the
> comment though.

I'm with Nick on that; I can't read it :/ It only makes things more
confusing. If you want precision, English (or any natural language) is
your enemy.

To describe ordering use the diagrams and/or litmus tests.
