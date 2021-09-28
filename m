Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A380341AE93
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240626AbhI1MSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:18:22 -0400
Received: from 8bytes.org ([81.169.241.247]:39992 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240544AbhI1MSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:18:13 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E1DE5208; Tue, 28 Sep 2021 14:16:31 +0200 (CEST)
Date:   Tue, 28 Sep 2021 14:16:26 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/11] x86/traps: Add #VE support for TDX guest
Message-ID: <YVMHmt/cf63w93A+@8bytes.org>
References: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210903172812.1097643-7-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903172812.1097643-7-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 10:28:07AM -0700, Kuppuswamy Sathyanarayanan wrote:
> In the settings that Linux will run in, virtual exceptions are never
> generated on accesses to normal, TD-private memory that has been
> accepted.

Does this also hold true when the Hypervisor does unexpected things that
cause previously accepted pages to become unaccepted again? This means
pages like the entry code pages or other memory that is touched before
the syscall entry path switched stacks.

Can you sched some light on what happens in such a situation?

> +DEFINE_IDTENTRY(exc_virtualization_exception)
> +{
> +	struct ve_info ve;
> +	int ret;
> +
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +
> +	/*
> +	 * NMIs/Machine-checks/Interrupts will be in a disabled state
> +	 * till TDGETVEINFO TDCALL is executed. This prevents #VE
> +	 * nesting issue.
> +	 */
> +	ret = tdx_get_ve_info(&ve);
> +
> +	cond_local_irq_enable(regs);

Potentially enabling IRQs here means that TDX does not have a shared
per-cpu data structure (like the GHCB on AMD). Is that right?

