Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5C54158BB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 09:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbhIWHGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 03:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239358AbhIWHGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 03:06:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852AAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MKyCSBe17569FQKUN9uYPzsBrtR6yhh1quExeWYo6x0=; b=Gpo+PfTGtMC8bYFUnWTsGSG9j4
        s0FMMEqMgrIKFtOlEb1F7pdyyPMDdV/ByQsx8MU5bOf0DloJ2sUkVZzUHKyZmltUO7uj6Gvp16LFJ
        HzH1RQJch2GuXtgFu25vuzUer5+PypWZps9jjdO38l7Ts0bHfeFcfLuVmWBxvwGbyu/eexrndoLOm
        7Zdm0mQJizR2xX/uV+yvZWC6rVtg8r/VufBfqnFYKOVN//+5UnOyeVvQjC6pm9Og67M3R7tJ2Vbpm
        H21id5PPRfLhs+xu2hrA483NLoPQ0CeOjeb8Tdk/BW53H313pr55NgNPo8HpRQfHxdyjaNdUox+ki
        9A9HDhZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTImz-005AUz-Fy; Thu, 23 Sep 2021 07:05:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1631C300250;
        Thu, 23 Sep 2021 09:05:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F102F2C0D22ED; Thu, 23 Sep 2021 09:05:00 +0200 (CEST)
Date:   Thu, 23 Sep 2021 09:05:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YUwnHDUKfvNKQgPF@hirez.programming.kicks-ass.net>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <20210922210722.GV4323@worktop.programming.kicks-ass.net>
 <20210922211145.GF5106@worktop.programming.kicks-ass.net>
 <a5944e66-0552-d919-bd11-d9eced48bb45@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5944e66-0552-d919-bd11-d9eced48bb45@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 02:33:09PM -0700, Dave Hansen wrote:
> On 9/22/21 2:11 PM, Peter Zijlstra wrote:
> >>> +static bool fixup_pasid_exception(void)
> >>> +{
> >>> +	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> >>> +		return false;
> >>> +
> >>> +	return __fixup_pasid_exception();
> >>> +}
> > That is, shouldn't the above at the very least decode the instruction
> > causing the #GP and check it's this ENQCMD thing?
> 
> To reiterate: on systems with no X86_FEATURE_ENQCMD, there is basically
> no additional overhead.  It isn't worth doing decoding there.

Well, they won't get past the X86_FEATURE check anyway, so who cares.

> On systems with X86_FEATURE_ENQCMD, but where it is unused, the #GP
> handler gets some new overhead on every #GP.  Basically:
> 
> > +	pasid = current->mm->pasid;
> > +	if (pasid == PASID_DISABLED)
> > +		return false;
> 
> That's still pretty cheap.  Probably not worth doing decoding there either.
> 
> So, that leaves us with if you are:
> 1. On system with X86_FEATURE_ENQCMD
> 2. In a process/mm that has an allocated pasid
> 3. Your *task* does not have the MSR set
> 4. You get a #GP for some other reason
> 
> Then, you'll do this double-#GP dance.
> 
> So, instruction decoding could absolutely be added between steps 3 and
> 4.  It would absolutely save doing the double-#GP in cases where 1/2/3
> are met.  But, I wouldn't move it up above and of the 1/2/3 checks
> because they're way cheaper than instruction decoding.
> 
> In the end, it didn't seem worth it to me to be optimizing a relatively
> rare path which 99% of the time ends up in a crash.
> 
> If you want instruction decoding in here, though, just say the word. :)

Instruction deoding makes it obvious you only consume your own #GP, the
alternative is a comment that explains this reasoning. Having neither
gets you confusion as per this thread.
