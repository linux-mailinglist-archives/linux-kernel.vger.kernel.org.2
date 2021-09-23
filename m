Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E924158B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 09:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbhIWHFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 03:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239358AbhIWHFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 03:05:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A4BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yBNicDjw8WK7MOJLUTRpaRMtfJjNW3VolUiGgcMY76E=; b=oaFb+XMbK85Xxum8z8ebeFAOZ2
        d5COXc8LI5sfH9MwypwQP5Catqv3zAu2Br/kxPWaVGeqpUkqqvgLr4/3f9QNydMeyOm2FqQfj8zx4
        e9K2Acx+dvXmmO85PVYoAIHx/kL3LRfUUNYMhlwtjrfG5KhQWC8A+GvvkiWrzEDfY8tzhAAkdHqcz
        ksgm7aauQUaUD1I6ze8m79+0+6Ze6FlQ/88pb1R8hfzKzqB/a1zhXXj/Q2+zSkNlima4yMDUaandF
        q3XfXBhPfC584OC8vRXSZGSeJrNvVvd5jkgyHbgHq223J7EribWdEiICEHozaROBGYT8jhhjL/3gf
        xkAUqz2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTIlB-005ATk-1G; Thu, 23 Sep 2021 07:03:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D806F30031A;
        Thu, 23 Sep 2021 09:03:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 75EB72133B1A7; Thu, 23 Sep 2021 09:03:07 +0200 (CEST)
Date:   Thu, 23 Sep 2021 09:03:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YUwmq1M0yIio5CZC@hirez.programming.kicks-ass.net>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <20210922210722.GV4323@worktop.programming.kicks-ass.net>
 <20210922211145.GF5106@worktop.programming.kicks-ass.net>
 <abfbdfbc9a68477f985eeb4192839fca@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abfbdfbc9a68477f985eeb4192839fca@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 09:26:10PM +0000, Luck, Tony wrote:
> >> > +static bool fixup_pasid_exception(void)
> >> > +{
> >> > +	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> >> > +		return false;
> >> > +
> >> > +	return __fixup_pasid_exception();
> >> > +}
> >
> > That is, shouldn't the above at the very least decode the instruction
> > causing the #GP and check it's this ENQCMD thing?
> 
> It can't reliably do that because some other thread in the process may
> have re-written the memory that regs->ip points at (bizarre case, but
> I think Dave Hansen brought it up).

I don't buy that argument, any cross modifying code gets to keep the
pieces in that case.

> So it would just add extra code, and still only be a hint.
> 
> Without the check this sequence is possible:
> 
> 1) Process binds an accelerator (so mm->pasid is set)
> 2) Task in the process executes something other than ENQCMD that gets a #GP
> 3) Kernel says "Oh, mm->pasid is set, I'll initialize the IA32_PASID MSR to see if that fixes it"
> 4) Nope. Re-executing the instruction at step #2 just gives another #GP
> 5) Kernel says "I already set IA32_PASID, so this must be something else ... do regular #GP actions"
> 
> Now if the task catches the signal that results from step #5 and avoids termination, it will have
> IA32_PASID set ... but to the right value should it go on to actually execute ENQCMD at some
> future point.
> 
> So the corner case from not knowing whether this #GP was from ENQCMD or not is harmless.

And all that *really* should be a in a comment near there, because I'm
100% sure I'll get confused and wonder about that very same thing the
next time I see that code.
