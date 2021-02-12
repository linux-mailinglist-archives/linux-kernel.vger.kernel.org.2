Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670E031A6FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhBLVhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhBLVht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:37:49 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC87CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:37:08 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id s15so509252plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MwmhY9Jtq1VXRLPt2kDrJ0PHKPslNn99ZUy3M4M7wck=;
        b=iRhdK6YukpWLEYCktLjzWQHKrYoLWeRiY6D+ntYICgHNX7zfG80fxgLFA8y4NAWgIu
         h5yFxebvTO9m9Fxxk5YsV2hlP3B3pJN7Jpq9MrnzNN3qALaLRisi5Ss6Fp8RNjabsC3B
         DojCnh5c/jINIPrZBHu+2UZHCyCrxwWu4h2OvRHjPs3p2cBEnAiWCebSl9NRiWfsUueg
         JJ81HzlcAsxGk3TMmMlaweCayUALK1pMnifnVHUciAfHN32MSDTyNOzIJTItNGA7xvXy
         y6lfl8UTWDieuMq81TtTf3y1JR3WXmhzSePRxmf8MYfxv9e89PYZw0C/o5fBF7Hrqfjj
         SAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MwmhY9Jtq1VXRLPt2kDrJ0PHKPslNn99ZUy3M4M7wck=;
        b=mXUm9V7ks8Yif395cQj653xAEy+PIDQMOlO6ZLeSDqlwpJ//CrgZqzuhc6FYd5w/LQ
         HuP2TwsSZ1Xer9NsOz83kldTgidb0oTdFuI6Trdu2YY4Pp2nEg7nadFgB71VsZ+OybG0
         bZFUIO+334OMTdNysQGGXH3WftEBtf7DhO6fipEoyk0vCPbkPqZGmWBWvtIqx4NKuxhA
         ERjt0fFS7040CnW4V727lqlgDabrzyBI4bkmI1tO8Gsk07oONlFpPRlgrYTVKe/F432/
         ikDXq3y+FGum8gUnsmo11J6zMsEBiTFF1U3bhZdpjLgj/INq/Sy2JKHpdwrhuUH3cfYy
         Qtug==
X-Gm-Message-State: AOAM532DZCGIz0psvEaNxzXMlBh6iMoGtAm5U8OLKQ3miAj0bTA/DT8a
        54rdajCIpCcr+YZDWk+EzWbw4g==
X-Google-Smtp-Source: ABdhPJzVDb0NeUwO83Kk9sXFwlNdpWNgjZqlqab3C2FeN6P2AAbjrchX9405nrBaA10Cm4MvxKqHtw==
X-Received: by 2002:a17:902:d888:b029:e2:e57a:a503 with SMTP id b8-20020a170902d888b02900e2e57aa503mr4575971plz.14.1613165828111;
        Fri, 12 Feb 2021 13:37:08 -0800 (PST)
Received: from google.com ([2620:15c:f:10:b407:1780:13d2:b27])
        by smtp.gmail.com with ESMTPSA id d12sm10242976pgm.83.2021.02.12.13.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 13:37:07 -0800 (PST)
Date:   Fri, 12 Feb 2021 13:37:00 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC v1 05/26] x86/traps: Add #VE support for TDX guest
Message-ID: <YCb0/Dg28uI7TRD/@google.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <48a702f536ccf953eee5778023ed6d1a452f6dcf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CALCETrWPCTmoeFBEJvw98zwNpw316Xii_16COZAWoYNC=obF+w@mail.gmail.com>
 <YCbfyde9jl7ti0Oz@google.com>
 <8c23bbfd-e371-a7cf-7f77-ec744181547b@intel.com>
 <YCbm/umiGUS7UuVb@google.com>
 <514734d9-d8be-03ee-417e-4d0ad2f56276@intel.com>
 <YCbq+UEMIsE0NIWI@google.com>
 <7d0b08c4-5ae7-f914-e217-767a9fae7b78@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d0b08c4-5ae7-f914-e217-767a9fae7b78@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021, Dave Hansen wrote:
> On 2/12/21 12:54 PM, Sean Christopherson wrote:
> > Ah, I see what you're thinking.
> > 
> > Treating an EPT #VE as fatal was also considered as an option.  IIUC it was
> > thought that finding every nook and cranny that could access a page, without
> > forcing the kernel to pre-accept huge swaths of memory, would be very difficult.
> > It'd be wonderful if that's not the case.
> 
> We have to manually set up the page table entries for every physical
> page of memory (except for the hard-coded early stuff below 8MB or
> whatever).  We *KNOW*, 100% before physical memory is accessed.
> 
> There aren't nooks and crannies where memory is accessed.  There are a
> few, very well-defined choke points which must be crossed before memory
> is accessed.  Page table creation, bootmem and the core page allocator
> come to mind.

Heh, for me, that's two places too many beyond my knowledge domain to feel
comfortable putting a stake in the ground saying #VE isn't necessary.

Joking aside, I agree that treating EPT #VEs as fatal would be ideal, but from a
TDX architecture perspective, when considering all possible kernels, drivers,
configurations, etc..., it's risky to say that there will _never_ be a scenario
that "requires" #VE.

What about adding a property to the TD, e.g. via a flag set during TD creation,
that controls whether unaccepted accesses cause #VE or are, for all intents and
purposes, fatal?  That would allow Linux to pursue treating EPT #VEs for private
GPAs as fatal, but would give us a safety and not prevent others from utilizing
#VEs.

I suspect it would also be helpful for debug, e.g. if the kernel manages to do
something stupid and maps memory it hasn't accepted, in which case debugging a
#VE in the guest is likely easier than an opaque EPT violation in the host.

> If Linux doesn't have a really good handle on which physical pages are
> accessed when, we've got bigger problems on our hands.  Remember, we
> even have debugging mechanisms that unmap pages from the kernel when
> they're in the allocator.  We know so well that nobody is accessing
> those physical addresses that we even tell hypervisors they can toss the
> page contents and remove the physical backing (guest free page hinting).
