Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B083FEC86
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 12:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242421AbhIBK4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 06:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbhIBK4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 06:56:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CFAC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 03:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xRZI+EF7Bb02HlmhwHew/8U98K28CzYAN65inQkPbLA=; b=qgwUZG/cFtFFmCiMx1IAFICojh
        7f+SYg96TVtEcKoLz294qVnFHbDWbjrJd2j+kqW133UQ+BxcHU2Au9HHWps9azq2TRqXcezFZ7Y5/
        08FUDzdXgjuyfo+hnflXXnTPqJfmqjxjJLo0SyuIuyhRsKkxdqtlZGiFJD/DTGrTQYNjgj0qTCUaK
        pHq3Vv9yJxKZAT147cfr5AFOtbjWgQ6HkB9UeGlsW0BprwWDk1WlyrQQSFkbZsuJkscbbTIPodzXA
        PXO7c2bR9km4keuJe333Kh3qIyfyojkCSiz1r6WuiDnf74Vf313kNBUfBO8aTfryLvkrKzwx4bwJ3
        DpsGReSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLkIG-003OPI-OB; Thu, 02 Sep 2021 10:50:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 20D6B30029F;
        Thu,  2 Sep 2021 12:50:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 054722B1DE8E8; Thu,  2 Sep 2021 12:50:02 +0200 (CEST)
Date:   Thu, 2 Sep 2021 12:50:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chester Lin <clin@suse.com>, Juergen Gross <jgross@suse.com>,
        andrew.cooper3@citrix.com
Subject: Re: [PATCH 02/24] x86/traps: Move arch/x86/kernel/traps.c to
 arch/x86/entry/
Message-ID: <YTCsWpSmPYvXa1xz@hirez.programming.kicks-ass.net>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-3-jiangshanlai@gmail.com>
 <YTCGov+vvAMvso7q@suse.de>
 <1f327579-e62a-df65-0763-e88243829db3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f327579-e62a-df65-0763-e88243829db3@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 05:21:51PM +0800, Lai Jiangshan wrote:
> 
> 
> On 2021/9/2 16:09, Joerg Roedel wrote:
> > On Wed, Sep 01, 2021 at 01:50:03AM +0800, Lai Jiangshan wrote:
> > >   arch/x86/entry/Makefile            | 5 ++++-
> > >   arch/x86/{kernel => entry}/traps.c | 0
> > >   arch/x86/kernel/Makefile           | 5 +----
> > >   3 files changed, 5 insertions(+), 5 deletions(-)
> > >   rename arch/x86/{kernel => entry}/traps.c (100%)
> > 
> >  From looking over the patch-set I didn't spot the reason for putting the
> > entry C code into traps.c. Can you explain that please? Otherwise I'd
> > prefer to create a new file, like arch/x86/entry/entry64.c.
> 
> 
> I agree, and I think Peter is handling it.

I don't think I said that. I said I like the patches but there's a lot
of scary code and details to review, which takes time.

I've now done a second reading of the patches and provided some more
feedback, but I'm very sure I didn't get to the scary details yet.

One thing that got pointed out (by Andrew Cooper) is that by moving the
whole SWAPGS trainwreck to C it becomes entirely 'trivial' to sneak in
an 'accidental' per-cpu reference before having done the SWAPGS dance.

I'm myself not (yet) convinced that's a good enough reason to leave it
in ASM, but it does certainly need consideration.
