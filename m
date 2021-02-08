Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500D5313DA9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhBHSgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:36:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:56479 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234386AbhBHQYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:24:55 -0500
IronPort-SDR: R86VVuV5TWHoH7XsLokun5P0u5v+8njqJuos50hY4yxYmtFWzNcHUDA4wLUck0WAHrk/5Vp0kb
 t5PYUaEOlhBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="245808148"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="245808148"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 08:23:07 -0800
IronPort-SDR: XgokToR/vwQMpgN/NoXF/Xw+qqURHCxxdE2gq4ZFUzA3eUV+rTJTyC/f6+dVP3Qv+vqEtxheqj
 Vy+PvYpw02Ag==
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="411103555"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 08:23:06 -0800
Date:   Mon, 8 Feb 2021 08:23:01 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC v1 05/26] x86/traps: Add #VE support for TDX guest
Message-ID: <20210208162301.GA365765@tassilo.jf.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <48a702f536ccf953eee5778023ed6d1a452f6dcf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YCEQiDNSHTGBXBcj@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCEQiDNSHTGBXBcj@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Which is supposedly then set up to avoid #VE during the syscall gap,
> yes? Which then results in #VE not having to be IST.

Yes that is currently true because all memory is pre-accepted.

If we ever do lazy accept we would need to make sure the memory accessed in
the syscall gap is already accepted, or move over to an IST.

> > +#ifdef CONFIG_INTEL_TDX_GUEST
> > +DEFINE_IDTENTRY(exc_virtualization_exception)
> > +{
> > +	struct ve_info ve;
> > +	int ret;
> > +
> > +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> > +
> > +	/* Consume #VE info before re-enabling interrupts */
> 
> So what happens if NMI happens here, and triggers a nested #VE ?

Yes that's a gap. We should probably bail out and reexecute the original
instruction. The VE handler would need to set a flag for that.

Or alternatively the NMI always gets the VE information and puts
it on some internal stack, but that would seem clunkier.


-Andi
