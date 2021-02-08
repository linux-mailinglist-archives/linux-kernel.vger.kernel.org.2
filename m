Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B59313E15
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbhBHSwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhBHRAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:00:41 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C9AC06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 09:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vmozN1g5LQmAFpPJNsn4DIDXXJw2IeO1GJ7wsREQXLU=; b=RH6Q4qHbanMcy6idw/w/seE7Ux
        hHHYX8g5cdR6doD79r2sxwaw/pcsH+5PaOTyIYiT0SdIqM3lUapfBYi/Unxe0H+/wukrjx7lH63Mk
        iwX9DcfT4GzYmq19g7Z4LPjfG6mlSwf21FT7jmKFGvV4MsHiNcbbgaiPs9WHw6tbfFRMLox2Plggo
        3CGp5lLp8rS/jIO93k1HGDwQIGWRyf26PbkRm0ku2bvWo5MkElB1DbQcYP72Q/5+T23K1PM9/oTeW
        3XYATudwfHSO5/EB6NIXFcALvoWz9nKuhhH5kXdUwyYMa8oHYjEcgEegYeMxwRwObPvzGsethqRSl
        jWD1tZvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l99tA-0006Lq-Sp; Mon, 08 Feb 2021 16:59:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 88B7F306099;
        Mon,  8 Feb 2021 17:59:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 74C0B2846AE56; Mon,  8 Feb 2021 17:59:50 +0100 (CET)
Date:   Mon, 8 Feb 2021 17:59:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC v1 05/26] x86/traps: Add #VE support for TDX guest
Message-ID: <YCFuBu3O/U6pP0yr@hirez.programming.kicks-ass.net>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <48a702f536ccf953eee5778023ed6d1a452f6dcf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YCEQiDNSHTGBXBcj@hirez.programming.kicks-ass.net>
 <20210208162301.GA365765@tassilo.jf.intel.com>
 <YCFnwnzgHXNGKW+M@hirez.programming.kicks-ass.net>
 <YCFq3y5b62NsmBhO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCFq3y5b62NsmBhO@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 08:46:23AM -0800, Sean Christopherson wrote:
> On Mon, Feb 08, 2021, Peter Zijlstra wrote:
> > On Mon, Feb 08, 2021 at 08:23:01AM -0800, Andi Kleen wrote:
> > > > > +#ifdef CONFIG_INTEL_TDX_GUEST
> > > > > +DEFINE_IDTENTRY(exc_virtualization_exception)
> > > > > +{
> > > > > +	struct ve_info ve;
> > > > > +	int ret;
> > > > > +
> > > > > +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> > > > > +
> > > > > +	/* Consume #VE info before re-enabling interrupts */
> > > > 
> > > > So what happens if NMI happens here, and triggers a nested #VE ?
> > > 
> > > Yes that's a gap. We should probably bail out and reexecute the original
> > > instruction. The VE handler would need to set a flag for that.
> 
> No, NMI cannot happen here.  The TDX-Module "blocks" NMIs until the #VE info is
> consumed by the guest.

'cute', might be useful to have that mentioned somewhere.

> > > Or alternatively the NMI always gets the VE information and puts
> > > it on some internal stack, but that would seem clunkier.
> > 
> > The same is possible with MCE and #DB I imagine.
> 
> The MCE "architecture" for a TDX guest is rather stupid.  The guest is required
> to keep CR4.MCE=1, but at least for TDX 1.0 the VMM is not allowed to inject #MC.
> So, for better or worse, #MC is a non-issue.
> 
> #VE->#DB->#VE would be an issue, presumably this needs to be noinstr (or whatever
> it is that prevents #DBs on functions).

Ah, it is that already ofcourse, so yeah #DB can't happen here.
