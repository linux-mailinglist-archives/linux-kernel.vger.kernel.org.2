Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C82C355A1B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbhDFRQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbhDFRQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:16:16 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6352FC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 10:16:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ha17so8294725pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aePFuCa/3RjpudbNnyIqFR3Tp2mKK26MkG7GhSAOCSE=;
        b=a+JRqPwydb7hONlU5nHtADjR9hY0BLIHdnapwSkrBffp8kIe1pjt9bMhGxJMjbpEG9
         +z6Plhphoni/+JCioA+kiRBGxUZkKZQN0MJZjTgiz2X/BoAoVc2O08kBJgMwDXFiLl/f
         4zjhAFAShQJFSnuho59Be6eSyko5d7Ggic148Ayo196m2yrVf6YHm7W6ryO+AFIcZvNy
         BhbS4XmiyycP5KjXQOtigpzNGU48E+i8bRIdJlr6yS2di42gf7204tR0vKJhGFwT4/9c
         PXW8Nkm5vxSsFiiqblZQmUs8OCyuRdbRGc8pgGN7MktQTLPuOjcqHic1ixwHLwl2xtYc
         hAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aePFuCa/3RjpudbNnyIqFR3Tp2mKK26MkG7GhSAOCSE=;
        b=CZFjHIEe9zs4e+qC+T8lDOhrz3kaKZOECY29WrN0hafjK3bmGBb8p8eJxPbmYub5u5
         75nj0TNUzJDS40yjYLaae7h8czUPC90rUvmXNhslElx1cLhFVPFaVHV6PJKynbxo53MJ
         KeXXKI3+zBU9zP7crar4NhqVmP7Jp8y04vLxk8n65KKMvIirJpMhPgjvD3InC3ml+/Qo
         40PaleBn6RsNy+JcfCTiGYGDX9OzPN+9W4KbVm4ZfhBryc7kurdZVqQD7zqVHt+wtyVh
         zic/yI6FFunmqj1UBQrjiO0q1liCY3w1NvZ+g/Ep8AOdmBhSnplIMVNljprOoCKVGu9e
         txvw==
X-Gm-Message-State: AOAM533na5S9UvWcRpYNPOki/4mvHuKqhVMEXVCwo5uW6I3gUIZ77oSN
        IS61z4GiPFVmQH9h+G+B8vsiWbxauOO9Dg==
X-Google-Smtp-Source: ABdhPJwhOCxMBF3QoueIBZTAT1fJdEOVack0Ri3I3g7SSAx6hwioBUlv1bBu1SB/RLv+QgWAVc3Y1A==
X-Received: by 2002:a17:90a:8813:: with SMTP id s19mr5212185pjn.94.1617729366796;
        Tue, 06 Apr 2021 10:16:06 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id x2sm18954218pfx.41.2021.04.06.10.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 10:16:06 -0700 (PDT)
Date:   Tue, 6 Apr 2021 17:16:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC v1 25/26] x86/tdx: Make DMA pages shared
Message-ID: <YGyXUkl4ftKi673H@google.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0bc9209a36760ee7c8591322327ddbfe87351b09.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <cc8e2e73-9d08-894c-47f9-ec82b0642789@intel.com>
 <20210406163150.cbmcybnu6hu5alk7@box>
 <6065a93b-6bcd-2038-e994-6ec7b7b4c891@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6065a93b-6bcd-2038-e994-6ec7b7b4c891@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021, Dave Hansen wrote:
> On 4/6/21 9:31 AM, Kirill A. Shutemov wrote:
> > On Thu, Apr 01, 2021 at 02:01:15PM -0700, Dave Hansen wrote:
> >>> @@ -1999,7 +2006,8 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
> >>>  	/*
> >>>  	 * Before changing the encryption attribute, we need to flush caches.
> >>>  	 */
> >>> -	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
> >>> +	if (!enc || !is_tdx_guest())
> >>> +		cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
> >>
> >> That "!enc" looks wrong to me.  Caches would need to be flushed whenever
> >> encryption attributes *change*, not just when they are set.
> >>
> >> Also, cpa_flush() flushes caches *AND* the TLB.  How does TDX manage to
> >> not need TLB flushes?
> > 
> > I will double-check everthing, but I think we can skip *both* cpa_flush()
> > for private->shared conversion. VMM and TDX module will take care about
> > TLB and cache flush in response to MapGPA TDVMCALL.

No, on both accounts.

The guest is always responsible for flushing so called "linear mappings", i.e.
the gva -> gpa translations.  The VMM / TDX Module are responsible for flushing
the "guest-physical mappings" and "combined mappings" when the shared EPT /
secure EPT tables are modified.  E.g. the VMM could choose to keep separate
memory pools for shared vs. private and not even touch EPT tables on conversion.
But, the guest would still need to invalidate its virt->phys translations so
that accesses from within the guest generate the correct gpa.

Regarding cache flushing, the guest is responsible for flushing the cache lines
when converting from private to shared, and the VMM is responsible for flushing
the cache lines when converting from shared to private.

For private->shared, the VMM _can't_ do a targeted flush, as it can't generate
the correct physical address since stuffing a private key into its page tables
will #PF.  The VMM could do a full WBINVD, but that's not the intended ABI.
Hopefully this is documented in the GHCI...

For shared->private, the VMM is responsible for flushing the caches, assuming it
reuses the same physical page.  The TDX module does not enforce this directly,
rather TDX relies on integrity checks to detect if stale data (with the shared
key) is written back to guest private memory.  I.e. if the VMM does not do the
necessary flushing, the guest will get a poisoned memory #MC and die (or crash
the host).

> Oh, interesting.  You might also want to double check if there are any
> more places where X86_FEATURE_SME_COHERENT and TDX have similar properties.


