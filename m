Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763DF3F760A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbhHYNlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241334AbhHYNln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:41:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26805C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u7FLS4tamcLSqFAxWKbUp61JSeXYax+Olzwhlq2yfAU=; b=tBcorG9KOTysppkUny/CAV3q0r
        eBNg+E2ksiS51rhX3LW2wG/bqwTp+OicvPgYE+IgGPpZms5pYAQ4gxK5myNkTH27TnK4LNWF1KskD
        e2JkWq+sNMSzNp/Xx//jqqgxH1QUA9Pfliuzkxp9pZq6nKCFOsjO8E4EA37PdipcXydBxrsyZpLNM
        LeCE/oeQ6Sji0f9vdlrqejmWswsKbN+dEB9Ho9pXLnI4F9ESMv8+5vh0jm9EA5A1Rc7r2OVktTcWA
        0BidW0GiPZ1aey9qkKQWFYgW+RORc3Q4xuTg4oAtXFQMCbo2lQAtczUqUyQdZ7XOsktRjYSaVc/Pe
        jbSxEMZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIt6m-00CKzT-QB; Wed, 25 Aug 2021 13:38:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DFA093005AD;
        Wed, 25 Aug 2021 15:38:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C3A51200E4A2F; Wed, 25 Aug 2021 15:38:23 +0200 (CEST)
Date:   Wed, 25 Aug 2021 15:38:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com,
        elver@google.com
Subject: Re: [PATCH v2 06/24] x86: Always inline
 context_tracking_guest_enter()
Message-ID: <YSZHz9FFoSKL4dem@hirez.programming.kicks-ass.net>
References: <20210624094059.886075998@infradead.org>
 <20210624095148.003928226@infradead.org>
 <20210820232203.nmuc3gelzsazyewk@treble>
 <20210820233440.jjzdw6qjnytonlmv@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820233440.jjzdw6qjnytonlmv@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 04:34:40PM -0700, Josh Poimboeuf wrote:
> On Fri, Aug 20, 2021 at 04:22:07PM -0700, Josh Poimboeuf wrote:
> > On Thu, Jun 24, 2021 at 11:41:05AM +0200, Peter Zijlstra wrote:
> > > Yes, it really did out-of-line this....
> > > 
> > > vmlinux.o: warning: objtool: vmx_vcpu_enter_exit()+0x31: call to context_tracking_guest_enter() leaves .noinstr.text section
> > > 
> > > 000000000019f660 <context_tracking_guest_enter>:
> > >   19f660:	e8 00 00 00 00       	callq  19f665 <context_tracking_guest_enter+0x5>	19f661: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
> > >   19f665:	31 c0                	xor    %eax,%eax
> > >   19f667:	c3                   	retq   
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > Ha.  I'm guessing this was from CONFIG_DEBUG_SECTION_MISMATCH, which is
> > only good for triggering a lot of these useless __always_inline patches.
> > 
> > I have a patch somewhere to get rid of it.
> 
> Found it.

Even with your patch applied, x86_64-allyesconfig still gives me the
above. In fact, I had to re-instate 4 of the 6 __always_inline patches,
so I've kept them all for now.
