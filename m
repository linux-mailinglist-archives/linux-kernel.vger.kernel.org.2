Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9E8417613
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345686AbhIXNmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344804AbhIXNmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:42:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21EBC06161E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=66iruQyw4wjAu1lDqnvGKU6vRWu6JERcPGI2qJLde+U=; b=q2HwTNPmMxKrZbOf3MOv42gDBK
        8Bve+tNf0Z/zni3CLHBmX9ix/2RjmcP8uXbGwFJlGKA005f0spq6CnmA2lWI6Ywir1VEYqz+Iwrdy
        SpsSBktQrWYdfkfsrPEnbUB0OZ+08LQSIu/PNnIuR6kDFd1ISHb8cRgrSue/sAJGwkMKxJgE/Jq7K
        7IL0wQtmfCWkPHaSGV8WeWp/taPAHWPd3dKrr5iyxFsIxGRDgyFb3wOsgy0EwMNqqiDvdCYM/3MTu
        iJnGmcWzx14oypzEtPs8WFWvLIgFwN5fvpC4IJdS7PGnHnnSVUpEZjdYHg1gZZJrIxsaURvykUGqx
        OU1gNCKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTlOF-007FCG-ON; Fri, 24 Sep 2021 13:38:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 144ED30026F;
        Fri, 24 Sep 2021 15:37:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C38B52C5DFD94; Fri, 24 Sep 2021 15:37:22 +0200 (CEST)
Date:   Fri, 24 Sep 2021 15:37:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
Message-ID: <YU3UkvNdzCqAANSY@hirez.programming.kicks-ass.net>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <20210922210722.GV4323@worktop.programming.kicks-ass.net>
 <YUy2AmabA4ODOgAC@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUy2AmabA4ODOgAC@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 10:14:42AM -0700, Luck, Tony wrote:
> On Wed, Sep 22, 2021 at 11:07:22PM +0200, Peter Zijlstra wrote:
> > On Mon, Sep 20, 2021 at 07:23:45PM +0000, Fenghua Yu wrote:
> > > @@ -538,6 +547,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
> > >  
> > >  	cond_local_irq_enable(regs);
> > >  
> > > +	if (user_mode(regs) && fixup_pasid_exception())
> > > +		goto exit;
> > > +
> 
> > So you're eating any random #GP that might or might not be PASID
> > related. And all that witout a comment... Enlighten?
> 
> This is moderately well commented inside the fixup_pasid_exception()
> function. Another copy of the comments here at the call-site seems
> overkill.

+static bool fixup_pasid_exception(void)
+{
+       if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
+               return false;
+
+       return __fixup_pasid_exception();
+}

/me goes looking for comments in that function, lemme get out the
electron microscope, because I can't seem to spot them with the naked
eye.
