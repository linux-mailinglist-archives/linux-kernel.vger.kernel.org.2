Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA82C359E2F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhDIMER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhDIMEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:04:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF9AC061760;
        Fri,  9 Apr 2021 05:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g2GtkY2xyVbfP4oncgBQ7PLvMs7xcQF1ze4EUV6e/8Y=; b=Qieuquf7P91tQQwsSThvYUsod8
        5PccWzw+284JyKvO414g0rn6cPXUMmUJs93UxzrVtJNnWbBDAiVsOfRkOVxT5VzuSQBol67qnR2df
        9KVJCVv9C+jJIFjb1ntEhTJX8oKitk5rjtB8bSPYV5X6GldrorN0UoazNLTx7KFd1+nqmt5ZzvntG
        bAqSBJQmGAQjjxB69uiGvvsGihUVre8QshxywElka04dG1lGRvwsg+rMQxyd6uWK7pgQE3jZEMHIK
        KDyDfCPm0nW/rlh1uGcepfzy8Yxn4PDDtimH5XzkrjjnI+EzxIkXSS++HMmzGL8YCIWkLC2Fe8MrT
        FO1Plxig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUprX-000gi0-5M; Fri, 09 Apr 2021 12:03:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68AD1300084;
        Fri,  9 Apr 2021 14:03:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2EB542BDB13FE; Fri,  9 Apr 2021 14:03:46 +0200 (CEST)
Date:   Fri, 9 Apr 2021 14:03:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Malcolm <dmalcolm@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: Re: static_branch/jump_label vs branch merging
Message-ID: <YHBCoijoopbsDn29@hirez.programming.kicks-ass.net>
References: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net>
 <CAMj1kXGngxH0VCHyREKeLau=159sRkWYKVZwOV84r6dvCqXcig@mail.gmail.com>
 <YHA2jPIaj0p23mv8@hirez.programming.kicks-ass.net>
 <5f78b7e2f9ae937271ef52ee9e999a91c2719da9.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f78b7e2f9ae937271ef52ee9e999a91c2719da9.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 07:55:42AM -0400, David Malcolm wrote:
> On Fri, 2021-04-09 at 13:12 +0200, Peter Zijlstra wrote:
> > On Fri, Apr 09, 2021 at 11:57:22AM +0200, Ard Biesheuvel wrote:
> > > On Thu, 8 Apr 2021 at 18:53, Peter Zijlstra <peterz@infradead.org>
> > > wrote:
> > 
> > > > Is there *any* way in which we can have the compiler recognise
> > > > that the
> > > > asm_goto only depends on its arguments and have it merge the
> > > > branches
> > > > itself?
> > > > 
> > > > I do realize that asm-goto being volatile this is a fairly huge
> > > > ask, but
> > > > I figured I should at least raise the issue, if only to raise
> > > > awareness.
> > > > 
> > > 
> > > Wouldn't that require the compiler to interpret the contents of the
> > > asm() block?
> > 
> > Yeah, this is more or less asking for ponies :-) One option would be
> > some annotation that conveys the desired semantics without it having
> > to
> > untangle the mess in the asm block.
> > 
> > The thing the compiler needs to know is that the branch is constant
> > for
> > any @key, and hence allow the obvious optimizations. I'm not sure if
> > this is something compiler folks would be even willing to consider,
> > but
> > I figured asking never hurts.
> > 
> 
> Sorry if this is a dumb question, but does the function attribute:
>   __attribute__ ((pure)) 
> help here?  It's meant to allow multiple calls to a predicate to be
> merged - though I'd be nervous of using it here, the predicate isn't
> 100% pure, since AIUI the whole point of what you've built is for
> predicates that very rarely change - but can change occasionally.

I actually tried that, but it doesn't seem to work. Given the function
arguments are all compile time constants it should DTRT AFAICT, but
alas.
