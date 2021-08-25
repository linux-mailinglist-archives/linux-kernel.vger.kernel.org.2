Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDF03F72CB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239832AbhHYKSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbhHYKSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:18:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536B0C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EhRIH/0qX5VzThjt44q0kraCg2KffpE06A8rCuJykTE=; b=uvMG+pDNNI6VW9nC9Zfzy6i620
        2NC7YPqK+pVvFhM6yFntpvobnb8oDt8Lb7QXU1+00QOygBq8V3zbI4d2EtW1niLL3mF+dn+fbdFhy
        zuHcNOGIK3ejUAEdGNJKqrzNQsMNlPdswdWfXsDRc2NmNHneJ3t4oz4ZNT+xn9yGSxeTOD4PihhEV
        ZZ31Dm7FxvjcqWSXr35Q8PxwhogirYIYhzPDht3Z+APqzPRsde4kCItyoXii4i0ATJplwLRFROP0W
        hVzw3/1Xtb6UUeOJT4w5aaJA/yugsZ6a8HK0lH0WvcyqkpXEwdTK8sDsccnyMWtU6q7bw3m4NS6Ru
        4s5czBSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIpw2-00CBb3-4E; Wed, 25 Aug 2021 10:15:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B10AE3005AD;
        Wed, 25 Aug 2021 12:15:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FEF3200E4A2F; Wed, 25 Aug 2021 12:15:05 +0200 (CEST)
Date:   Wed, 25 Aug 2021 12:15:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com,
        elver@google.com, Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v2 02/24] objtool: Introduce CFI hash
Message-ID: <YSYYKUHHK+dRa7g7@hirez.programming.kicks-ass.net>
References: <20210624094059.886075998@infradead.org>
 <20210624095147.756759107@infradead.org>
 <20210820222755.sqtlzframoz7k5cb@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820222755.sqtlzframoz7k5cb@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 03:27:55PM -0700, Josh Poimboeuf wrote:

> > @@ -2725,15 +2820,24 @@ static int validate_branch(struct objtoo
> >  
> >  			if (insn->visited & visited)
> >  				return 0;
> > -		}
> > +		} else
> > +			nr_visited++;
> >  
> >  		if (state.noinstr)
> >  			state.instr += insn->instr;
> >  
> > -		if (insn->hint)
> > -			state.cfi = insn->cfi;
> > -		else
> > -			insn->cfi = state.cfi;
> > +		if (insn->hint) {
> > +			state.cfi = *insn->cfip;
> > +		} else {
> > +			/* XXX track if we actually changed state.cfi */
> 
> Why would we do that?

Saves on the memcmp()..

> > +++ b/tools/objtool/include/objtool/check.h
> > @@ -60,9 +60,11 @@ struct instruction {
> >  	struct list_head alts;
> >  	struct symbol *func;
> >  	struct list_head stack_ops;
> > -	struct cfi_state cfi;
> > +	struct cfi_state *cfip;
> 
> Not sure about this rename.  Pointers generally don't need a 'p' postfix.

It was a dev thing, meant I typically rename a member when I change
type; easy for compiler and grep.

I can s/cfip/cfi/ on the patch, no biggie.
