Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB86C422F37
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 19:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhJERbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 13:31:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45830 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234144AbhJERb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 13:31:29 -0400
Received: from zn.tnic (p200300ec2f0d2000861dea28ca60d046.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:2000:861d:ea28:ca60:d046])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 65F2E1EC0489;
        Tue,  5 Oct 2021 19:29:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633454957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E499HOUWhPyw38pPbrGR32wughsFQipdvvKNstCi1Ms=;
        b=dU2HLmxzEl050XWZZ5E9lqzHpgNF5qA9qweJptNr8cQIXbHLMmJLLqc0et/r0WtVo/9Rvx
        sJUUnNMqgYkAh4+kiO0ltGmty6eEI8tRhjyb8sX8CzIvw4hDVwWTFQwesvjPZKrVTxspr/
        J9r2ilYQwh8jmJdvSakX0G3A1oLVpYY=
Date:   Tue, 5 Oct 2021 19:29:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Sathyanarayanan Kuppuswamy Natarajan 
        <sathyanarayanan.nkuppuswamy@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config option
Message-ID: <YVyLaLTK6MgLi/rS@zn.tnic>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <cf33750f-615a-1edd-0fee-28e720bb38ce@infradead.org>
 <CAC41dw-U85dCGDm_QzyyOQfhbbaZZ5m9CvLuDjdXjuxEyid8qw@mail.gmail.com>
 <YVxdhtRbJfd9feA4@zn.tnic>
 <ba068e29-aefd-8e78-48e0-5431abd93f31@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba068e29-aefd-8e78-48e0-5431abd93f31@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 07:48:25AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Since x2APIC will always exist in TDX guest case, we have used select to
> enable the support. But since we have dependency on it, I  think "depends"
> might be a better choice.

Right, and while we're on the subject, this looks silly to me too:

+       depends on SECURITY
...
+       select SECURITY_LOCKDOWN_LSM

because

Symbol: SECURITY_LOCKDOWN_LSM [=n]
  │ Type  : bool
  │ Defined at security/lockdown/Kconfig:1
  │   Prompt: Basic module for enforcing kernel lockdown
  │   Depends on: SECURITY [=n]
		  ^^^^^^^^^

so that symbol already depends on SECURITY.

And I have SECURITY=n in my config so I still have to go select SECURITY
by hand so that CONFIG_INTEL_TDX_GUEST becomes visible. And when I
select it, SECURITY_LOCKDOWN_LSM gets enabled too.

But since I have to go select SECURITY, I can just as well enable
SECURITY_LOCKDOWN_LSM in order to have TDX guest support.

IOW, I don't see the point for the evil "select"s - just make everything
depends on and be done with it.

Unless there's an aspect I'm missing...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
