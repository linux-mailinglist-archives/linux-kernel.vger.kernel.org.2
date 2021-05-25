Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83D938F71F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 02:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhEYA4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 20:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhEYA4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 20:56:32 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17EBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:55:02 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 29so10285551pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IZeU/A9yIi+/g05svxSpw72vxvUCkWOx0fUPTYN6M08=;
        b=eplEQYpcs5Nw7/kLTcQ0PbHmduw2nJw5zBlh4wdLXR+O+1r82K0puk0oJku7KkJfCy
         KrW2fjNArhqScLb/R2yML5AYt/2XDFx3z5iYnB1cWCMhcI3i/Dd5N0L92t3ffcbTFivj
         qWlhdXc0a8D+cKfi9v9u24AsYzi9j4QwVOQkfwELmx9YVSK5gxnG6K3Eg1mE+RZIMSCV
         obTLl90IkI23wwgvEUmrutyz8Qn34QFOvARpHJUH6qW8AoaxWII2DWLRDNflvOIXIDKs
         qE+bzM8AMjAuKl9SqrBISi0R69QxCUd3W76BvWdJ4hmNoavSc/yjc1jlGhcsMkBhL7lm
         ekGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IZeU/A9yIi+/g05svxSpw72vxvUCkWOx0fUPTYN6M08=;
        b=QcFkaaFNGGE1//kDiUivpml+9/B0cMEvkSQtF5QWp6ron8ec6b8wDLTy0ZTchCzw+H
         aqqokoGHuvumoXD7CS8Qb6rHyvi/78xiMAb/tHN5pCmL2F+rDoGbOUxdbAB6oBSMJFuN
         0FaBwfIzUSL51VTO8P8ZQZwh2JqnbauOsdzAd02AMGrwlc3Lu1jm1V8vprWkGLNNAw+B
         eZLoBCKU900a4qo/bg0H/UutJkVkNxQ8cEHEwlQMqOyWUSxyy+ZhEZqMI/CtM9fwKMzu
         fZz51rTImKI3p/8KlE9AuLqEU3TWuxGnwM9TK8RUL1RJSdo5uSUfnIw1GHMdXyhStuDM
         JZ+A==
X-Gm-Message-State: AOAM532SE+CELBgYpDTMdOW5oFBoR2ijQEo2FVYM8KDc7maqmwrUO+cv
        5CxyQF4NdmsN+Vhr2N25JtG0YA==
X-Google-Smtp-Source: ABdhPJxm+1HYFjEpI1cbd6a96qEbXzT1xTvzvLAtSsoYyrrMmiIp90vo5DSg7ciBooYLfFYoScO64w==
X-Received: by 2002:a63:f717:: with SMTP id x23mr16309402pgh.141.1621904102296;
        Mon, 24 May 2021 17:55:02 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id a15sm11730750pfc.29.2021.05.24.17.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 17:55:01 -0700 (PDT)
Date:   Tue, 25 May 2021 00:54:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v2-fix-v2 2/2] x86/tdx: Ignore WBINVD instruction for TDX
 guest
Message-ID: <YKxK4jD2mhfDmOYf@google.com>
References: <37ad50ca-f568-4c62-56e2-9e9b1f34084c@linux.intel.com>
 <20210524233211.802033-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210524233211.802033-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jKY0rmewFnyL6My5-b+w8ANAwDY2tLXZk4CYKydoVbtg@mail.gmail.com>
 <b420a7af-5202-fee9-9e0b-39680d0cc9c8@linux.intel.com>
 <CAPcyv4gNz9gKsHVcindp3OsHz4hMRWPZgsNu1A5xrDQg7tYqNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gNz9gKsHVcindp3OsHz4hMRWPZgsNu1A5xrDQg7tYqNA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021, Dan Williams wrote:
> On Mon, May 24, 2021 at 5:30 PM Kuppuswamy, Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >
> >
> >
> > On 5/24/21 4:39 PM, Dan Williams wrote:
> > >> Functionally only DMA devices can notice a side effect from
> > >> WBINVD's cache flushing. But, TDX does not support DMA,
> > >> because DMA typically needs uncached access for MMIO, and
> > >> the current TDX module always sets the IgnorePAT bit, which
> > >> prevents that.
> >
> > > I thought we discussed that there are other considerations for wbinvd
> > > besides DMA? In any event this paragraph is actively misleading
> > > because it disregards ACPI and Persistent Memory secure-erase whose
> > > usages of wbinvd have nothing to do with DMA. I would much prefer a
> > > patch to shutdown all the known wbinvd users as a precursor to this
> > > patch rather than assuming it's ok to simply ignore it. You have
> > > mentioned that TDX does not need to use those paths, but rather than
> > > assume they can't be used why not do the audit to explicitly disable
> > > them? Otherwise this statement seems to imply that the audit has not
> > > been done.
> >
> > But KVM also emulates WBINVD only if DMA is supported. Otherwise it
> > will be treated as noop.
> >
> > static bool need_emulate_wbinvd(struct kvm_vcpu *vcpu)
> > {
> >          return kvm_arch_has_noncoherent_dma(vcpu->kvm);
> > }
> 
> That makes KVM also broken for the cases where wbinvd is needed, but
> it does not make the description of this patch correct.

Yep!  KVM has a long and dubious history of making things work for specific use
cases without stricitly adhering to the architecture.

KVM also has to worry about malicious/buggy guests, e.g. letting the guest do
WBINVD at will would be a massive noisy neighbor problem (at best), while
ratelimiting might unnecessarily harm legitimate use case.  I.e. KVM has a
somewhat sane reason for "emulating" WBINVD as a nop.

And FWIW, IIRC all modern hardware has a coherent IOMMU, though that could be me
making things up.
