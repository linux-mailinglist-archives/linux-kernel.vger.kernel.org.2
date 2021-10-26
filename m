Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1257D43B072
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbhJZKsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhJZKs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:48:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B87C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 03:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=79uDAhKkdgC1LO3hXXD2cl32wcIP7RXhvSvVaoiulL4=; b=OgC5++Q8ShbPv4yb8XShbxCmU0
        XEmK3Xes1qJj10SMnF4HtfdgQIiU2fZjeOxmrdluoDlPXDJWiaFQNWPuByxp+OGh3gnn4aKL3FR6T
        mLCYJdIxYKvKqKbm6b60WumMpgf8Py0iGmB/eH3+QWXMjFTEBkPG++tGDUMhz6BQpDy16p96NUpei
        Vg+OgBKZht9SdLQniIgaYOKKgZsHe/YW6Fu+gE2QDN2TTzVD3thDqzf1QQ347P7fW7aAOtOG1z3hw
        d0+xJnj4pGM/TmXupkWb70bkuYyobvEzWQtoEOfI2OyC/Ft1QvKvgeicbLuHi2AaPLxS0d9owpR2p
        xTb4gr6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfJxt-00CLIR-CM; Tue, 26 Oct 2021 10:45:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 105AA300288;
        Tue, 26 Oct 2021 12:45:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0F342024464C; Tue, 26 Oct 2021 12:45:55 +0200 (CEST)
Date:   Tue, 26 Oct 2021 12:45:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/4] arm64: implement support for static call trampolines
Message-ID: <YXfcY7PPAvOK9E+8@hirez.programming.kicks-ass.net>
References: <20211025122102.46089-1-frederic@kernel.org>
 <20211025122102.46089-3-frederic@kernel.org>
 <YXa3q2AOH0T+smFy@hirez.programming.kicks-ass.net>
 <CAMj1kXELqoVp5zBcQ8g+0O56sBq9qAEDO-7OTenDkpRcb7oeQQ@mail.gmail.com>
 <YXa85OTw7i3Bg9yj@hirez.programming.kicks-ass.net>
 <YXbC3NRWDDfsW6DG@hirez.programming.kicks-ass.net>
 <CAMj1kXEKASsYJMHHNA=uNGTnLMoXO_4BP0--1k7cEfZZupdsog@mail.gmail.com>
 <YXbHJCtkBdMP/bF6@hirez.programming.kicks-ass.net>
 <CAMj1kXHYXzU=pW6tUJB61QW5VBL7WKBhT7BkNJ970FQdHz1VVw@mail.gmail.com>
 <20211026103655.GB30152@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026103655.GB30152@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 11:36:55AM +0100, Mark Rutland wrote:

> My preference overall is to keep the trampoline self-contained, and I'd
> prefer to keep the RET inline in the trampoline rather than trying to
> factor it out so that all the control-flow is clearly in one place.
> 
> So I'd prefer that we have the sequence as-is:
> 
> | 0:	.quad 0x0
> | 	bti	c
> | 	< insn >
> | 	ldr	x16, 0b
> | 	cbz	x16, 1f
> | 	br	x16
> | 1:	ret

OK, fair enough. In that case:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Although I do think that function can use a comment to explain the magic
involved.

> If we knew these were only called with IRQs enabled (and so we can take
> an IPI to generate a context synchronization event), we could patch
> <insn> to a RET and point the literal back at the BTI, e.g.

Given the static_call() usage on x86 I'm pretty sure you'll want them
with IRQs disabled.
