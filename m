Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D7441527D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbhIVVPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbhIVVPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:15:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A75C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T9aqR6ds6fZf+ziFJLavcqledvnXK6/xbqEb0NC2lrs=; b=NEYoGGh5giSDV/HksndZuN4zNa
        Po/LERjVXKQBI/dJr5ysIGCq242l11aKwDhMB7GKASgYDOgLnDvSdCKaRxeI0ft4RrXffTd+/RwXl
        50lCYZ6ZQ0cyLk2RzjNvGlMpctJDH3X4GnbnwFUibxYtcpmLoT/9sqiAZIiIOjJfWXdCmIzOBpi/H
        ddPPFCHfgniaDI0aAxkpJA1VbjN9maJhz0J539MwAkWEBPqNZIv80TDr0Oab7wW+uZ/D2R82pXzad
        9EjGnwQRIr6VfgnL4W5v1c9Pd8+K6mOzxhX6C4sAkOy2HmVu3xoW0LbMAnvNn/OoNjNrpREPJZm87
        IkD577VQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT9Ws-0059St-Hm; Wed, 22 Sep 2021 21:12:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91BCC9811F0; Wed, 22 Sep 2021 23:11:45 +0200 (CEST)
Date:   Wed, 22 Sep 2021 23:11:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
Message-ID: <20210922211145.GF5106@worktop.programming.kicks-ass.net>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <20210922210722.GV4323@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922210722.GV4323@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 11:07:22PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 20, 2021 at 07:23:45PM +0000, Fenghua Yu wrote:
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index a58800973aed..a25d738ae839 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -61,6 +61,7 @@
> >  #include <asm/insn.h>
> >  #include <asm/insn-eval.h>
> >  #include <asm/vdso.h>
> > +#include <asm/iommu.h>
> >  
> >  #ifdef CONFIG_X86_64
> >  #include <asm/x86_init.h>
> > @@ -526,6 +527,14 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
> >  	return GP_CANONICAL;
> >  }
> >  
> > +static bool fixup_pasid_exception(void)
> > +{
> > +	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> > +		return false;
> > +
> > +	return __fixup_pasid_exception();
> > +}

That is, shouldn't the above at the very least decode the instruction
causing the #GP and check it's this ENQCMD thing?

> >  #define GPFSTR "general protection fault"
> >  
> >  DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
> > @@ -538,6 +547,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
> >  
> >  	cond_local_irq_enable(regs);
> >  
> > +	if (user_mode(regs) && fixup_pasid_exception())
> > +		goto exit;
> > +
> >  	if (static_cpu_has(X86_FEATURE_UMIP)) {
> >  		if (user_mode(regs) && fixup_umip_exception(regs))
> >  			goto exit;
> 
> So you're eating any random #GP that might or might not be PASID
> related. And all that witout a comment... Enlighten?
