Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971C33E0A7D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 00:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbhHDWnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 18:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhHDWnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 18:43:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD319C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 15:42:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a8so5168465pjk.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 15:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Huhb/ZWYkqoMTFohaR6PMUez2GhXcYt3lJghVmrrsg=;
        b=QlgNMDJfDZLTWBn3U4zM0Og4yLBPOn+xZe6IhRk1m8mzGP8ikKbLsVyYHkTd7olAjE
         BfrfOrW12EwMqNe67di/0aFhlWLI1jX2yoZgmA1i54Um2EhGGMuEM454Tpzm3pbnX2xs
         JfdMI4AEfh/4Q+xPe2BChpfYJJYo3v9OLe6z+rP9NAbycSn2s4P+CnBDKP/9nV/Mg8e1
         fGwezbYKfrVQ6HcPv1H0e2GkjaTa/RaAYy9lOSaqf5zNn8B6ECBXiOsNs5pMXBvXnNfB
         H5d6d6sW4cOveRQXC12wZRMwsRXAA4PGRlXep5dmXPsmuQGlOzUUtskFjA152/ohQOwS
         eSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Huhb/ZWYkqoMTFohaR6PMUez2GhXcYt3lJghVmrrsg=;
        b=kQkedeuIFyqtLWvYaeuokoryYfrnNU+YNW4dytLUb+SAuCwRYSAFju2OBSLW+3FXvR
         ZBj50bRwKGWabtrbjRtB3mohkd5Nzi/loEcu8FnV9L0fFZFX7rltKRn9RuoWON8mHWoD
         nHtM3JQi9Ivg5t+38uyTKNIf9s2iJTxgY64EZvIt/7MYH45+/9/VpaC1j1WhjatCBeC1
         4YqTV2DOT3LIrrHq2jIpdEGkAtW4gvyepsZW6fugJsEUBst8S6WALI2V/wkQiV2hHLDI
         BT89BdvypAtY6F1dOLW06m9H4s+c/2IjC0VYI0siA+pyynxKX0sZLaE1qSp+KymiDLSg
         95DQ==
X-Gm-Message-State: AOAM530TFDfZJwTREWI4+MOzrRD15fhmlb5Z/FwclqxzjDbyJw4M8vTO
        4OtE0oZrEzajM+Pbq1B6sSJK1g==
X-Google-Smtp-Source: ABdhPJydmrYbz5uh6AAEQ6utdvOp7NV15BxwePykUAeQxF3FVYlEW4Xi0wy+cihgFvmYPW6dauvEUg==
X-Received: by 2002:a17:90a:604b:: with SMTP id h11mr1342460pjm.220.1628116972126;
        Wed, 04 Aug 2021 15:42:52 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f5sm4001697pfn.134.2021.08.04.15.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 15:42:51 -0700 (PDT)
Date:   Wed, 4 Aug 2021 22:42:47 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/12] x86/tdx: Add protected guest support for TDX
 guest
Message-ID: <YQsX54MPVYFuLmFr@google.com>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQsNpG55v7dhFqIb@google.com>
 <9c576f24-e6de-f816-623d-408a4a2ae747@intel.com>
 <4f28fe6e-a8ce-e444-51db-d0eb564eca8f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f28fe6e-a8ce-e444-51db-d0eb564eca8f@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021, Kuppuswamy, Sathyanarayanan wrote:
> 
> On 8/4/21 3:03 PM, Dave Hansen wrote:
> > > > +#include <asm/processor.h>
> > > > +#include <asm/tdx.h>
> > > > +
> > > >   #ifndef __ASSEMBLY__
> > > >   static inline bool prot_guest_has(unsigned int attr)
> > > >   {
> > > >   	if (sme_me_mask)
> > > >   		return amd_prot_guest_has(attr);
> > > > +	else if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> > > Why not "boot_cpu_has(X86_FEATURE_TDX_GUEST)"?
> > Even better: cpu_feature_enabled(X86_FEATURE_TDX_GUEST).  That gets you
> > both static patching*and*  compile-time optimization if you hook

Ah, I keep forgetting it can be compiled out.

> > X86_FEATURE_TDX_GUEST into disabled-features.h.
> 
> This is how Borislav preferred it. tdx_prot_guest_has() internally uses
> cpu_feature_enabled(X86_FEATURE_TDX_GUEST) to return the status.
> 
> I think the intention is to keep the first call generic (non TDX
> specific). So that it can be extended for other use cases.

What other possible use case is there for invoking tdx_prot_guest_has() beyond
running as a TDX guest?  If it were e.g. intel_prot_guest_has() then I would at
least understand the code, if not agree with the sub-optimal approach, but as is
it makes no sense.

Given amd_prot_guest_has(), my guess is Boris intended intel_prot_guest_has()...
