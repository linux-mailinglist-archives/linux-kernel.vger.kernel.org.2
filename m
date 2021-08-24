Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1953F689A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbhHXSCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238946AbhHXSCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:02:00 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F71C061A31
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:47:32 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id oc2-20020a17090b1c0200b00179e56772d6so2278624pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1gDeRLms/d/PgRchCO82ssAS1m7T0+GYvbCOMiGz08E=;
        b=OP8ji4GaiAhVi2KsHPmBGabJADwEbDP/kNIruomAqT35ZI0cljbBmQrdxzuJGDJJJZ
         YXIP1lHefzWnv6cwhN+ZMuk8M1mTA29ZAAsBrC/uAXMIjjUc+cseBSP6O4CwM0vZ//Db
         wAAq4L7gc14xEJ9zoeJ59sGLM43qBKigNPDca98s0BIuL0AgY0YY+mzn4Iu1+EEhdgmt
         5GSGHUG4jmHUn19HDZguvXJLGnBuk/0P67iaEktVUX7BfACMLxL3o/aUtcCUv5KlXtdT
         iWxbRVYk49uRm9Bfp3IQeUk5VQ0T91iYR2a/NJQ6NsAki7b1SA6inm+KRNVMu1V4vTdw
         /5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1gDeRLms/d/PgRchCO82ssAS1m7T0+GYvbCOMiGz08E=;
        b=b9ISB/FbMXrdn/1tZyxRm8p86GmKokDsHrUBCQ5CnA+Mp6hAV3B23AWW8JnZUiqR0S
         cD2oDi8ZunCXjxnOuoL0lsQ9RSulSGDuSnv1/OF+DvSJG97o5gD2mw6QvazNMfGkgEQP
         ERMWKnQRn/UYAXF6yfiZ3Hi2Y6pb5xp3xG4Xowjj/RCU3cSs0R5iWOLPLpEv/50A2R79
         RUt5kzfkXG7Rxc4p+8aEWK/icxMl+edPWX/R/6WZhrs/gxLOr/OHd7bUizFrVB/g9UjY
         wmUeYO4Mbh3mn484TZwIY5xdz7pPkEraSYyzrNYWxeWdBDfxk2x7cEVixca+cXop+urs
         ssQQ==
X-Gm-Message-State: AOAM532OW7hoj9Mfb/s/GEE5uwrsBARzt6EwsKvB+astuIYL0gxB6UQZ
        Bpy6XAKs0UT5RpMx0xw9mfRTQQ==
X-Google-Smtp-Source: ABdhPJxAcoqeQZzPyyC+MEpY/M/3c3M/jp6zq+eOiIfGrWDAfHx6B5FucNUgk42zs7OGN/3HAb+D+w==
X-Received: by 2002:a17:90b:1488:: with SMTP id js8mr4222306pjb.4.1629827252075;
        Tue, 24 Aug 2021 10:47:32 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j68sm24096465pgc.44.2021.08.24.10.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 10:47:31 -0700 (PDT)
Date:   Tue, 24 Aug 2021 17:47:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/12] x86/tdx: Add HLT support for TDX guest
Message-ID: <YSUwrSidivC87lBC@google.com>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-9-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YSUaAQPiBUqubBHM@zn.tnic>
 <YSUnDQUrGYc8aY9j@google.com>
 <YSUsBVx2DD7MCyn/@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSUsBVx2DD7MCyn/@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021, Borislav Petkov wrote:
> On Tue, Aug 24, 2021 at 05:06:21PM +0000, Sean Christopherson wrote:
> > It would be helpful to use local variables to document what's up, e.g.
> > 
> >  	const bool irqs_enabled = true;
> > 	const bool do_sti = true;
> > 
> > 	ret = _tdx_hypercall(EXIT_REASON_HLT, irqs_enabled0, 0, 0, do_sti, NULL);
> 
> Wait, is this do_sti thing supposed to be:
> 
> 	 * ... But this
>          * change is not required for all HLT cases. So use R15
>          * register value to identify the case which needs sti. So,
>          * if R11 is EXIT_REASON_HLT and R15 is 1, then call sti
>          * before TDCALL instruction.
> 
> ?
> 
> 
> > > > +	ret = _tdx_hypercall(EXIT_REASON_HLT, 0, 0, 0, 1, NULL);
> 						      ^^^
> Yeah, it must be it - the 1 there.
> 
> And what's with the irqs_enabled first parameter?
> 
> Is that used by the TDX module?

It's passed to the (untrusted) VMM.  The TDX Module has direct access to the guest's
entire FLAGS via the VMCS.

The VMM uses the "IRQs enabled" param to understand whether or not it should
schedule the halted vCPU if an IRQ becomes pending.  E.g. if IRQs are disabled
the VMM can keep the vCPU in virtual HLT, even if an IRQ is pending, without
hanging/breaking the guest.
