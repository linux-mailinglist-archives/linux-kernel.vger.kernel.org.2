Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D5A313DB8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhBHSje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBHQd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:33:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E453C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 08:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hGiWVAMkh3J18K54lFBdPSUwqfZTeBYTlisCRNS4agk=; b=rHXX9igingjzDgZbeeQUVzMZB0
        aTGuIE7EmHevBvAPn6Ztim0rfZtLYcrAYU0awFeim99wVDKdwjNZ7Ku0PEowwMXhki+BnMa+d7k1J
        GVp5CSVzMCXrXu/dXIqhPT57/N0PVJqdN0E0WhRa5gpFYCZq2TVid7TezaFD7utwk/cEhcJztIwVX
        2RUYXjrFI4n3A7azGVynM4Yd06WVasf6W02BXHNN3UCP/w+38qDVmR+joyVJXcOQz5a77ascYc5J2
        Fz5qiXGSAW4y3y6NZLV4wzoYiH3NrMWOwtApd6XlrUs09UVUrkhkWqMx4QJZrBnclJ8HPixRIX2P2
        5t6nRA2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l99TJ-0000RD-1A; Mon, 08 Feb 2021 16:33:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 22F16301324;
        Mon,  8 Feb 2021 17:33:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 072512018B25B; Mon,  8 Feb 2021 17:33:07 +0100 (CET)
Date:   Mon, 8 Feb 2021 17:33:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC v1 05/26] x86/traps: Add #VE support for TDX guest
Message-ID: <YCFnwnzgHXNGKW+M@hirez.programming.kicks-ass.net>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <48a702f536ccf953eee5778023ed6d1a452f6dcf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YCEQiDNSHTGBXBcj@hirez.programming.kicks-ass.net>
 <20210208162301.GA365765@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208162301.GA365765@tassilo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 08:23:01AM -0800, Andi Kleen wrote:
> > Which is supposedly then set up to avoid #VE during the syscall gap,
> > yes? Which then results in #VE not having to be IST.
> 
> Yes that is currently true because all memory is pre-accepted.
> 
> If we ever do lazy accept we would need to make sure the memory accessed in
> the syscall gap is already accepted, or move over to an IST.

I think we're going to mandate the entry text/data will have to be
pre-accepted to avoid IST. ISTs really are crap.

> > > +#ifdef CONFIG_INTEL_TDX_GUEST
> > > +DEFINE_IDTENTRY(exc_virtualization_exception)
> > > +{
> > > +	struct ve_info ve;
> > > +	int ret;
> > > +
> > > +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> > > +
> > > +	/* Consume #VE info before re-enabling interrupts */
> > 
> > So what happens if NMI happens here, and triggers a nested #VE ?
> 
> Yes that's a gap. We should probably bail out and reexecute the original
> instruction. The VE handler would need to set a flag for that.
> 
> Or alternatively the NMI always gets the VE information and puts
> it on some internal stack, but that would seem clunkier.

The same is possible with MCE and #DB I imagine.
