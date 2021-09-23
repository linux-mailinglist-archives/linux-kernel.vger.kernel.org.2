Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BB24160DA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241588AbhIWOSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:18:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46756 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241308AbhIWOS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:18:27 -0400
Received: from zn.tnic (p200300ec2f0d6800d4c5e0e0616b3501.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6800:d4c5:e0e0:616b:3501])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A3DFF1EC0570;
        Thu, 23 Sep 2021 16:16:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632406609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=efiZ+6HZwdsxnEvs1MbOCOu2S49rX4hw2KwueduGixU=;
        b=ZCgT2hL3xyPBBKuC9g6ZLwYM7POatvczaWw2N2Le4mFQpUIxGnK7WEkABvcGtCi96cyjak
        l5aFY5haTKeWoQvYO7flras/w+DDmHajWT6NoPA4nSM2YNJ4rvs1yXGumK8QIQerLKfarI
        O3PgmZSh7J81YytqCvx14OUUT6qAIdk=
Date:   Thu, 23 Sep 2021 16:16:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 04/12] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <YUyMTdM7XKa60jBX@zn.tnic>
References: <20210916183550.15349-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210916183550.15349-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YUxQzRdoH3dLJjL2@zn.tnic>
 <5a04034b-e692-6b45-bdde-f1a0fff96f7b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a04034b-e692-6b45-bdde-f1a0fff96f7b@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 07:10:00AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Initially, tdx_early_init() was added between kasan_early_init() and
> idt_setup_early_handler() in x86_64_start_kernel(). But I found that
> we have requirement to parse command line params in future
> changes to tdx_early_init() (not from the patches in this series). Since
> command line pointer is getting initialized in copy_bootdata(), I want
> move the tdx_early_init() call below it. Instead of moving the initialization
> order in future, I thought to move it appropriate place in the initial
> patch. Regarding IDT dependency, #VE handling will have a dependency on
> it (so it is better to initialize it before tdx_early_init()).

Then in your next version, pls add a comment that goes like this:

	/*
	 * This call needs to be here because...
	 * 	<insert reasons>
	 */

So that it is clear that its placement is special.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
