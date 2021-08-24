Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3789F3F685A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241806AbhHXRrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:47:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57118 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239147AbhHXRrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:47:02 -0400
Received: from zn.tnic (p200300ec2f114400ce3b938495d443bc.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:4400:ce3b:9384:95d4:43bc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 015121EC01FC;
        Tue, 24 Aug 2021 19:46:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629827173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oWf4vA3IaJb7vMimxT4L3B6A+JXDrm2LxrX0YuikrKE=;
        b=EhGXCWwkVzZZQfEuhSMVwcNnGsoDxbWNOsp5wU+Y88ONF9QXpIN82MpPuuqSsK884GsSiF
        pVjBXs5cmaPewnNFG+HomVNCIOCBvmJMWazWgos6BPvH2ZUdsHEwvHaa9Te/VMSAD3njX+
        bQIpxvw06jberGnOEV5AQ6V5N5t/W7U=
Date:   Tue, 24 Aug 2021 19:46:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/12] x86/traps: Add #VE support for TDX guest
Message-ID: <YSUwi2HraMFVanTP@zn.tnic>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-8-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YSTHMAUA1LjjOQPe@zn.tnic>
 <99c5f6e9-a747-1a4a-d0f4-95b8b28e0d02@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99c5f6e9-a747-1a4a-d0f4-95b8b28e0d02@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 10:32:13AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Mainly chose it avoid future name conflicts with KVM (tdx) calls. But

What name conflicts with KVM calls? Please explain.

> It is required to handle #VE exceptions raised by unhandled MSR
> read/writes.

Example? Please elaborate.

> Ok. I can check it. But there is only one statement after this call.
> So it may not be very helpful.

Looking at die_addr(), that calls the die notifier too. So do you
even *have* to call it here with VEFSTR? As yo say, there's only one
statement after that call and box is dead in the water after that so why
even bother...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
