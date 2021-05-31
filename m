Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0AD395746
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhEaIo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhEaIos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:44:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A02C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 01:43:08 -0700 (PDT)
Received: from zn.tnic (p200300ec2f080f006c0d0ceb240e6208.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:f00:6c0d:ceb:240e:6208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 68B531EC04E4;
        Mon, 31 May 2021 10:43:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622450586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Msp6/mOzC+reDvbox8TBHENLxJVuN3KTGhQXfGNqILQ=;
        b=FZF0oT4e1GlPmzBdC0e7FNh+013Gmgv1blbMPHdTuIvHp0TwDqPr5GpE+1K8SLm2yfTzri
        wu0Um0wg5IP8ceCy86/NY2IQfCTYL2OYBAq5GF+wLSHiQC62Ue4SaUJ5yk4M87W9L/31hZ
        oOMLqeQbUvHLw18N/Nc0VniOlhFBRFM=
Date:   Mon, 31 May 2021 10:43:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Subject: Re: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and
 remove update_pasid()
Message-ID: <YLShmFEzddfm7WQs@zn.tnic>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
 <87mtsd6gr9.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mtsd6gr9.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2021 at 11:17:30AM +0200, Thomas Gleixner wrote:
> While digesting the XSAVE related horrors, which got introduced with the
> supervisor/user split, the recent addition of ENQCMD related functionality
> got on the radar and turned out to be similarly broken.
> 
> update_pasid(), which is only required when X86_FEATURE_ENQCMD is
> available, is invoked from two places:
> 
>  1) From switch_to() for the incoming task
> 
>  2) Via a SMP function call from the IOMMU/SMV code
> 
> #1 is half-ways correct as it hacks around the brokenness of get_xsave_addr()
>    by enforcing the state to be 'present', but all the conditionals in that
>    code are completely pointless for that.
> 
>    Also the invocation is just useless overhead because at that point
>    it's guaranteed that TIF_NEED_FPU_LOAD is set on the incoming task
>    and all of this can be handled at return to user space.
> 
> #2 is broken beyond repair. The comment in the code claims that it is safe
>    to invoke this in an IPI, but that's just wishful thinking.
> 
>    FPU state of a running task is protected by fregs_lock() which is
>    nothing else than a local_bh_disable(). As BH disabled regions run
>    usually with interrupts enabled the IPI can hit a code section which
>    modifies FPU state and there is absolutely no guarantee that any of the
>    assumptions which are made for the IPI case is true.

... so on a PASID system, your trivial reproducer would theoretically
fire the same way and corrupt FPU state just as well.

Hohumm, I'd say we need all those reproducers turned into proper self
tests and run on everything new that touches xstate. *At* *least*.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
