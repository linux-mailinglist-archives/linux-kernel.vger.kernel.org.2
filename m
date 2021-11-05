Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AFE446983
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 21:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbhKEUSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 16:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhKEUSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 16:18:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C74C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jcOfjw6XwonYpk3ilQHHDmFG7O1LJuGnONCWZY3GCR4=; b=nMhc7QiLyVX7yEJgANQd4IzhL/
        mr0S3ilYRjL6VIaGNxoN4UuU2meqeWNwqOWO8+woM4t0natBIJELUSHLr1tYNCspP0h1OpXrzrufl
        THoVVUNPqE0cPTbJ+l+INJE95jvQMR+1vATLkWEhgSyQFDA6eB7lPIbtEPw8uozfxCYxyk3W77vL9
        54hHli5+N1las0MX9oJNsS3uGfE/zNTYGyqi3oSHP7UeC5oGWZhku95dqJJ9KshCoEtNlRD64X3mr
        hHbVyXZM34PkSkxjB2+fq6Bq8zqynvmfusGqF1wpjtZtdiS/3OSgMyFUZBlKw7/q4PzDHuteDEBTX
        af0y2O3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj5d0-00EOWj-Dh; Fri, 05 Nov 2021 20:16:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 428A79862D2; Fri,  5 Nov 2021 21:15:57 +0100 (CET)
Date:   Fri, 5 Nov 2021 21:15:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 07/22] x86,extable: Extend extable functionality
Message-ID: <20211105201557.GQ174703@worktop.programming.kicks-ass.net>
References: <20211104164729.226550532@infradead.org>
 <20211104165524.925401847@infradead.org>
 <YYVqnr+gql9RpL4C@google.com>
 <20211105184556.GN174703@worktop.programming.kicks-ass.net>
 <YYWDQO3ugarMcKmH@google.com>
 <20211105193229.GP174703@worktop.programming.kicks-ass.net>
 <YYWKSmHkgdMA2euh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYWKSmHkgdMA2euh@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 07:47:22PM +0000, Sean Christopherson wrote:
> On Fri, Nov 05, 2021, Peter Zijlstra wrote:
> > On Fri, Nov 05, 2021 at 07:17:20PM +0000, Sean Christopherson wrote:

> > C99 is sodding daft wrt signed values. That's why we force -fwrapv and
> > say signed is 2s complement and expect sanity.
> 
> FWIW, -fwrapv was supplanted by -fno-strict-overflow back in 2009 by commit
> a137802ee839 ("Don't use '-fwrapv' compiler option: it's buggy in gcc-4.1.x").
> But I don't think that matters because AFAICT both apply only to "addition,
> subtraction and multiplication".

Right... I think i remember running into that before. I think I yelled
at people at the time for that not being very consistent. If we
explicitly state we want 2s complement, it had damn well be everywhere.

> > > gcc-10 generates a bare "shr", i.e. doesn't special case negative values, and "shr"
> > > is explicitly defined as an unsigned divide.
> > 
> > We hard rely on signed shift right to preserve sign all over the place,
> > how come it goes sideways here? Lemme go stare at asm...
> 
> Huh.  TIL there's actually a use case for this.

Yeah, the canonical pattern for sign extending an n-bit int is:

	(int)(x << (32-n)) >> (32-n)

I think we have macros for that somehwere, but I can never remember what
they're called.

> Anyways, I think the issue is that EX_IMM_MASK is being interpreted as an unsigned
> value by the compiler.  Which I think is legal for a 64-bit kernel?  Because bit 63
> is the MSB, not bit 31.  E.g. this
> 
> 	FIELD_GET((int)EX_IMM_MASK, e->type)
> 
> generates SAR instead of SHR.

Bah, you're right. The compiler is free to interpret a hex constant as
either. At the same time there's only an unsigned suffix, so while we
can force it unsigned, we can't explicitly construct a signed hex
constant.

That's really unfortunate that is... 6.4.4.1 item 5 of the C99 spec
covers this gem :-( I suppose I'll go stick that (int) cast in the
EX_IMM_MASK definition or something.
