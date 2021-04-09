Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9048D359CC3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbhDILNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbhDILND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:13:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ABBC061760;
        Fri,  9 Apr 2021 04:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hm8v2BngVc54Q1o/cHItYp3tUBFPm1as5OTivyD8ADc=; b=Qc7p+hZVeE4RTBofF7GNthlGbM
        FGUQORuzdf6qyYPPtQJLKfZRHAB+Q/whVYuMWKyFC3FXSjvcxgk6HwXon6ACrguTOIYCPsR3qx87+
        4xi+khX9wBokaE1Qp3zs9rx9TNrsl1Q96UeXjtjyJchN2i5iFus3hLVmcr7M0mx/QCATcbyN2LClt
        qdCePxreCijLlV0Iugr6NdrtkC2q7hz3i1hn7zou2ehAh/vgRJKI0v/vJauV4NLUhRJL7NwZg9Cgf
        vRtRC+Ck0Vt2Q/8msY+JgbBLfjfyL/q4vKS/peY0ybZKq6gQu5PesI958kkla8tKOnmUW/rupg9Jq
        gOX65sfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUp3c-000GIR-SY; Fri, 09 Apr 2021 11:12:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 427923001E3;
        Fri,  9 Apr 2021 13:12:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2BE8723CDCDDC; Fri,  9 Apr 2021 13:12:12 +0200 (CEST)
Date:   Fri, 9 Apr 2021 13:12:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: Re: static_branch/jump_label vs branch merging
Message-ID: <YHA2jPIaj0p23mv8@hirez.programming.kicks-ass.net>
References: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net>
 <CAMj1kXGngxH0VCHyREKeLau=159sRkWYKVZwOV84r6dvCqXcig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGngxH0VCHyREKeLau=159sRkWYKVZwOV84r6dvCqXcig@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 11:57:22AM +0200, Ard Biesheuvel wrote:
> On Thu, 8 Apr 2021 at 18:53, Peter Zijlstra <peterz@infradead.org> wrote:

> > Is there *any* way in which we can have the compiler recognise that the
> > asm_goto only depends on its arguments and have it merge the branches
> > itself?
> >
> > I do realize that asm-goto being volatile this is a fairly huge ask, but
> > I figured I should at least raise the issue, if only to raise awareness.
> >
> 
> Wouldn't that require the compiler to interpret the contents of the asm() block?

Yeah, this is more or less asking for ponies :-) One option would be
some annotation that conveys the desired semantics without it having to
untangle the mess in the asm block.

The thing the compiler needs to know is that the branch is constant for
any @key, and hence allow the obvious optimizations. I'm not sure if
this is something compiler folks would be even willing to consider, but
I figured asking never hurts.
