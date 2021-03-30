Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF44C34EB6A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhC3PBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:01:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:59695 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhC3PBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:01:03 -0400
IronPort-SDR: QfvX228gDcHShjlMj8FmfTKJVOqONtuZv8yNn2Rag7CM3x6KPjFmkulxLVLDDn3GQ3umU0SER7
 Uy52zCVrdPxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="189541454"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="189541454"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 08:00:52 -0700
IronPort-SDR: cwA5g1PrkPQK7LQY22+vw/ywGsL1WN+7sV8APB1hLtEPkDNLzyZdfgLU/NPvLpdhupjPcRecI2
 YoGfVmAI6jNQ==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="418205840"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 08:00:51 -0700
Date:   Tue, 30 Mar 2021 08:00:48 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Message-ID: <20210330150048.GB1285835@tassilo.jf.intel.com>
References: <CALCETrUgEFy4shmh_pxOTzEVJZq8y23zK7cr51UhXba0KhQ8qg@mail.gmail.com>
 <331b34e3d6153f0a7b0ab0a9a8cb5de71f0bfd93.1616803999.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d78f5f76-e04f-cab1-48f5-b6c1ba6a3811@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d78f5f76-e04f-cab1-48f5-b6c1ba6a3811@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 12:56:41PM +0800, Xiaoyao Li wrote:
> On 3/27/2021 8:18 AM, Kuppuswamy Sathyanarayanan wrote:
> > In non-root TDX guest mode, MWAIT, MONITOR and WBINVD instructions
> > are not supported. So handle #VE due to these instructions as no ops.
> > 
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > ---
> > 
> > Changes since previous series:
> >   * Suppressed MWAIT feature as per Andi's comment.
> >   * Added warning debug log for MWAIT #VE exception.
> > 
> >   arch/x86/kernel/tdx.c | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> > index e936b2f88bf6..fb7d22b846fc 100644
> > --- a/arch/x86/kernel/tdx.c
> > +++ b/arch/x86/kernel/tdx.c
> > @@ -308,6 +308,9 @@ void __init tdx_early_init(void)
> >   	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
> > +	/* MWAIT is not supported in TDX platform, so suppress it */
> > +	setup_clear_cpu_cap(X86_FEATURE_MWAIT);
> 
> In fact, MWAIT bit returned by CPUID instruction is zero for TD guest. This
> is enforced by SEAM module.

Good point.
> 
> Do we still need to safeguard it by setup_clear_cpu_cap() here?

I guess it doesn't hurt to do it explicitly.


-Andi
