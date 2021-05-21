Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F304E38CD14
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbhEUSUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhEUSUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:20:13 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957FBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:18:49 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id k15so14864538pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mxz28tumSCxIfUahasyNJuQOydDg4xyWfoBw7FHZ6Lc=;
        b=Zhwn1v0ICiXQCdrk6A9VGt4glyF1kzhx8IbzfULP6qgESCoOsiyK1+su80F4hI2pwJ
         QX2Z2x7gWRn2pUVXe3P/ztKxLyG2dV4OGuYOVSU3SUBIYbdTaRZnPjqzBVYy8D2JLcB8
         Ika45iMHt7On9G9otj5Kh88DO9Jw+Va/mSqUQyl/NG4oE+c3KQgQHX/zlqy+qPQLFBE4
         EN4IHKokUaigMql4aFLwbHpmvnjx1Uh2aHGwvmE6oVDDeAvUngG/g2jKrOpXO78/oOJM
         GFYwOTNmkDExNxTg1omNvqUhKvRZfOTI8tPuaQhFJ2Dkvro+jOQfIZqdcFQ7izENBK3m
         epkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mxz28tumSCxIfUahasyNJuQOydDg4xyWfoBw7FHZ6Lc=;
        b=LPxFaXpTZiDghvcKLs+wC+Clcb825bk7cFDifj6mofO+DUmtaI0MLxIl3fGXo8IXWT
         KJ6e0YShlRtF86ZIdEkOqkUDsWtTEG7iSSULogBnvt6C/Mqu2LfM4+SjMM6D5gpLpSXk
         cSZuHmnBHGhLYgzBsAGU4H8ODgxoQQIPDi/wyIz+aBXOUz1I5Y7mvxJKrDHtGI819UhE
         D6vedkqx9XgWnmT71Fxs6j0d+KBwDnYiUH2Ayo4Whoknih+AilqK5ji+vuQ/oDQ1jENG
         pXg/NNYo/K/17jcgTRJDFp8RPcXcBdDLdP1FqAq8pbeUIYEQt5plnxIAVij7z0sixyTI
         ibGg==
X-Gm-Message-State: AOAM530bzD5L5cpu8bb+CIiuyYlcJDz7ZZmprGanxOTnE0zdUP2Y84wc
        QAMqHTwLevO0lIAzRvcm054dsw==
X-Google-Smtp-Source: ABdhPJw87baz4DCtZTGVFuasVY1li2cHnfNmYSFUiJ/5BYrmfAefUONqmk8aPEJw6UMjnuR4/8dcsw==
X-Received: by 2002:a62:5a46:0:b029:2d5:a67:1460 with SMTP id o67-20020a625a460000b02902d50a671460mr11295811pfb.75.1621621128921;
        Fri, 21 May 2021 11:18:48 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id jz7sm9332261pjb.32.2021.05.21.11.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 11:18:48 -0700 (PDT)
Date:   Fri, 21 May 2021 18:18:44 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC v2-fix-v2 1/1] x86/boot: Avoid #VE during boot for TDX
 platforms
Message-ID: <YKf5hObmGXNgx0vS@google.com>
References: <b1aafcbb-c5db-efa5-0343-014585e73191@intel.com>
 <20210521143524.2527690-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <f33c63b2-7b41-4c99-abd6-b47a8e7a4e26@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f33c63b2-7b41-4c99-abd6-b47a8e7a4e26@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021, Dave Hansen wrote:
> > +	/*
> > +	 * Preserve current value of EFER for comparison and to skip
> > +	 * EFER writes if no change was made (for TDX guest)
> > +	 */
> > +	movl    %eax, %edx
> >  	btsl	$_EFER_SCE, %eax	/* Enable System Call */
> >  	btl	$20,%edi		/* No Execute supported? */
> >  	jnc     1f
> >  	btsl	$_EFER_NX, %eax
> >  	btsq	$_PAGE_BIT_NX,early_pmd_flags(%rip)
> > -1:	wrmsr				/* Make changes effective */
> >  
> > +	/* Avoid writing EFER if no change was made (for TDX guest) */
> > +1:	cmpl	%edx, %eax
> > +	je	1f
> > +	xor	%edx, %edx
> > +	wrmsr				/* Make changes effective */
> > +1:
> 
> Just curious, but what if this goes wrong?  Say the TDX firmware didn't
> set up EFER correctly and this code does the WRMSR.

By firmware, do you mean TDX-module, or guest firmware?  EFER is read-only in a
TDX guest, i.e. the guest firmware can't change it either.

> What ends up happening?  Do we get anything out on the console, or is it
> essentially undebuggable?

Assuming "firmware" means TDX-module, if TDX-Module botches EFER (and only EFER)
then odds are very, very good that the guest will never get to the kernel as it
will have died long before in guest BIOS.

If the bug is such that EFER is correct in hardware, but RDMSR returns the wrong
value (due to MSR interception), IIRC this will triple fault and so nothing will
get logged.  But, the odds of that type of bug being hit in production are
practically zero because the EFER setup is very static, i.e. any such bug should
be hit during qualification of the VMM+TDX-Module.

In any case, even if a bug escapes, the shutdown is relatively easy to debug even
without logs because the failure will cleary point at the WRMSR (that info can be
had by running a debug TD or a debug TDX-Module).  By TDX standards, debugging
shutdowns on a specific instruction is downright trivial :-).
