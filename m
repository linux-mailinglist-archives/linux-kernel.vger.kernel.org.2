Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C087633C4FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhCOR5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbhCOR5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:57:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB16C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UgsM3r+A3uAyD4XpoD3sbbhR2BV/6Oau6PrSoEqaNEQ=; b=cNfLZ0fEVbH0E28I81+5yz+dEQ
        MhKxNY4RAGV7KxxF3p4DckLwmLFXiT6JxJEYhAs6DXp+sZSDt+zwdZMuBuZEpIUtN4anCCgdXJ9rd
        OJhqLPQ1V16JWH+2Gs7udQD+pM/bc6LdmzmAOcyt1Y39aFgAG2rQGoJS7x6fW+FXiCwGllRxOqXX1
        W0kMHw8yEwFhX2mc3W+cCD5evaK9jfjtbLr7TQsV6aXvs6QvVBKYyqnfMI5LeI4tIpyE4FF/Urj2k
        8GRJcsEDHg1TfIM3TtwZDtSZSvfZC3V6bKEhcrTTnEC0v5UUO8m618G1D/4wtvyZ8wTWM9K9h/eWD
        eNUxT90w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLrFA-00GZPt-GK; Mon, 15 Mar 2021 17:43:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6E493003D8;
        Mon, 15 Mar 2021 18:43:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D1282D1CBC15; Mon, 15 Mar 2021 18:43:03 +0100 (CET)
Date:   Mon, 15 Mar 2021 18:43:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [GIT pull] locking/urgent for v5.12-rc3
Message-ID: <YE+cp6mPfcOmJMsa@hirez.programming.kicks-ass.net>
References: <161573639668.27979.17827928369874291298.tglx@nanos>
 <CAHk-=wjuD2cCptSJmmHBp2c9chTPnZcSi+0vA+QJ8JNjYTJKCw@mail.gmail.com>
 <YE8b6dgsEG4OU0ay@hirez.programming.kicks-ass.net>
 <YE9AkgbqL+eVO6p1@hirez.programming.kicks-ass.net>
 <YE9EVNG4/5UMJvFp@hirez.programming.kicks-ass.net>
 <YE9OOx0za7ZH3AXe@hirez.programming.kicks-ass.net>
 <20210315170321.ndeqgjzdfupvuiak@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315170321.ndeqgjzdfupvuiak@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 12:03:21PM -0500, Josh Poimboeuf wrote:
> On Mon, Mar 15, 2021 at 01:08:27PM +0100, Peter Zijlstra wrote:
> > On Mon, Mar 15, 2021 at 12:26:12PM +0100, Peter Zijlstra wrote:
> > > Ooooh, modules don't have this. They still have regular
> > > .static_call_sites sections, and *those* are unaligned.
> > > 
> > > Section Headers:
> > > [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
> > > 
> > > [16] .static_call_sites PROGBITS        0000000000000000 008aa1 0006f0 00  WA  0   0  1
> > > 
> > > And that goes *BOOM*.. Let me ses if I can figure out how to make
> > > objtool align those sections.
> > 
> > The below seems to have cured it:
> > 
> > [16] .static_call_sites PROGBITS        0000000000000000 008aa8 0006f0 00  WA  0   0  8
> > 
> > 
> > So, anybody any opinion on if we ought to do this?
> 
> I'd say yes to alignment, for the sake of consistency with vmlinux.
> 
> Though instead of using objtool, it can be done in the module linker
> script:

Pfff, I should've looked for one.. Yes, that's much nicer.

> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index 168cd27e6122..73345cbfe100 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -17,6 +17,7 @@ SECTIONS {
>  	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
>  
>  	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
> +	.static_call_sites	0 : ALIGN(8) { KEEP(*(.static_call_sites)) }
>  
>  	__patchable_function_entries : { *(__patchable_function_entries) }
>  
> 
