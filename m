Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6519D31A711
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhBLVsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:48:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhBLVsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:48:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEC4064E36
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 21:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613166454;
        bh=Kv70a1+yCdYDmMZp2KaJ7CNkCDLjUtW0dJHR2g8xWPY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IdvlBN3htDscXoj0MZ014Aa04rMJoOlQk2mFCkeO6EGFig3efhJcxvd/C5RQ788YQ
         HVcEBThc6kFiC/vi9+P4HYCePuYqJPWzKgXsvIALWRXPnDmZ1yPXP0K6rEVQlXSbdp
         ODCJgpBdacraVhAILyoUL5q4FrDTBROnK4J3q05j8ZwzXzW5iKJ02T2LK5oZVoDNJ/
         jLEmZZLXN0rFBCPYy1RNM5IzgsBy0u1Y42nUcBvEaI9LARwIip+Nes77exBHZ6cBTM
         wHgWQH7532f725Wqi8eS2exYTryL3rcCObzTQKVSUtmbZ/5sENuUlHg/LmXFR27njx
         LjwELdNxIPtUw==
Received: by mail-ej1-f47.google.com with SMTP id y9so1503921ejp.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:47:33 -0800 (PST)
X-Gm-Message-State: AOAM530NRLaaFkVjzYk+hcY/nff3c1lWr82a9KUvBmBIRDquvKo08nh1
        ttB0l6y0+f4cYPirCIgLrOVkpp0s9hrl3RyekcOL/Q==
X-Google-Smtp-Source: ABdhPJz7be6PPmoSpUI865okhoDYmG5h7QOsEpRWjHxyeQnhCo97KYGJFZ9gOH0wSIzugA9fCveQujr1Wg5FIKfHNH4=
X-Received: by 2002:a17:906:24d1:: with SMTP id f17mr4874863ejb.503.1613166452442;
 Fri, 12 Feb 2021 13:47:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <48a702f536ccf953eee5778023ed6d1a452f6dcf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CALCETrWPCTmoeFBEJvw98zwNpw316Xii_16COZAWoYNC=obF+w@mail.gmail.com>
 <YCbfyde9jl7ti0Oz@google.com> <8c23bbfd-e371-a7cf-7f77-ec744181547b@intel.com>
 <YCbm/umiGUS7UuVb@google.com> <514734d9-d8be-03ee-417e-4d0ad2f56276@intel.com>
 <YCbq+UEMIsE0NIWI@google.com> <7d0b08c4-5ae7-f914-e217-767a9fae7b78@intel.com>
 <YCb0/Dg28uI7TRD/@google.com>
In-Reply-To: <YCb0/Dg28uI7TRD/@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 12 Feb 2021 13:47:20 -0800
X-Gmail-Original-Message-ID: <CALCETrUnOVvC4d8c_Z=5ZDefAo+0t6-9hadttOjTypJykN6_3A@mail.gmail.com>
Message-ID: <CALCETrUnOVvC4d8c_Z=5ZDefAo+0t6-9hadttOjTypJykN6_3A@mail.gmail.com>
Subject: Re: [RFC v1 05/26] x86/traps: Add #VE support for TDX guest
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 1:37 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Fri, Feb 12, 2021, Dave Hansen wrote:
> > On 2/12/21 12:54 PM, Sean Christopherson wrote:
> > > Ah, I see what you're thinking.
> > >
> > > Treating an EPT #VE as fatal was also considered as an option.  IIUC it was
> > > thought that finding every nook and cranny that could access a page, without
> > > forcing the kernel to pre-accept huge swaths of memory, would be very difficult.
> > > It'd be wonderful if that's not the case.
> >
> > We have to manually set up the page table entries for every physical
> > page of memory (except for the hard-coded early stuff below 8MB or
> > whatever).  We *KNOW*, 100% before physical memory is accessed.
> >
> > There aren't nooks and crannies where memory is accessed.  There are a
> > few, very well-defined choke points which must be crossed before memory
> > is accessed.  Page table creation, bootmem and the core page allocator
> > come to mind.
>
> Heh, for me, that's two places too many beyond my knowledge domain to feel
> comfortable putting a stake in the ground saying #VE isn't necessary.
>
> Joking aside, I agree that treating EPT #VEs as fatal would be ideal, but from a
> TDX architecture perspective, when considering all possible kernels, drivers,
> configurations, etc..., it's risky to say that there will _never_ be a scenario
> that "requires" #VE.
>
> What about adding a property to the TD, e.g. via a flag set during TD creation,
> that controls whether unaccepted accesses cause #VE or are, for all intents and
> purposes, fatal?  That would allow Linux to pursue treating EPT #VEs for private
> GPAs as fatal, but would give us a safety and not prevent others from utilizing
> #VEs.

That seems reasonable.
