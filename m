Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C98036964B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242976AbhDWPiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:38:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:46575 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231437AbhDWPiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:38:50 -0400
IronPort-SDR: BCIuvbWxEFgUV4bjIFDiFbc5bHvPct+aCkPeWNOu96+wf4z/dUB6GErT3Qp6aa2te2GEoC/sUq
 8JrLIVT9pQYg==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="193970046"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="193970046"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 08:38:12 -0700
IronPort-SDR: aH4akTIP2teA/UjFL9N/7tOnMKBK0JgtC5Q2nwl/rVNAiWUaBIfBqeSRdp58Gu6Es0yMZhrrhD
 ASnKQuOVr3kQ==
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="385123549"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 08:38:12 -0700
Date:   Fri, 23 Apr 2021 08:38:10 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] x86/tdx: Add __tdcall() and __tdvmcall() helper
 functions
Message-ID: <20210423153810.GL1401198@tassilo.jf.intel.com>
References: <77a13ae9-0220-030e-7ae4-fd26edd7b110@intel.com>
 <2a3f6b3d-cd80-0734-ce83-c067666c8326@linux.intel.com>
 <14332abf-c78c-3bc2-9a7c-ceacfa7a0661@intel.com>
 <596175e3-9d1e-6c9c-fadb-ad02c396e3ad@linux.intel.com>
 <d99941db-6ee6-267e-dece-6220af0ea305@intel.com>
 <9161efc0-fd25-d239-32b7-5d2c726579b0@linux.intel.com>
 <4ac4ed35-212b-f7ad-55f4-937946ffec1a@intel.com>
 <20210423013546.GK1401198@tassilo.jf.intel.com>
 <YILkl3C4YjGPM5Jr@google.com>
 <CAPcyv4gwDeLzG98CegHQs8AAAdctD4vLrAzncu=ciVMyBSDxAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gwDeLzG98CegHQs8AAAdctD4vLrAzncu=ciVMyBSDxAQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 08:28:45AM -0700, Dan Williams wrote:
> On Fri, Apr 23, 2021 at 8:15 AM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Thu, Apr 22, 2021, Andi Kleen wrote:
> > > On Thu, Apr 22, 2021 at 06:21:07PM -0700, Dave Hansen wrote:
> > > > On 4/22/21 6:09 PM, Kuppuswamy, Sathyanarayanan wrote:
> > > > > But let me try to explain it here. What I meant by complication is,
> > > > > for in/out instruction, we use alternative_io() to substitute in/out
> > > > > instructions with tdg_in()/tdg_out() assembly calls. So we have to ensure
> > > > > that we don't corrupt registers or stack from the substituted instructions
> > > > >
> > > > > If you check the implementation of tdg_in()/tdg_out(), you will notice
> > > > > that we have added code to preserve the caller registers. So, if we use
> > > > > C wrapper for this use case, there is a chance that it might mess
> > > > > the caller registers or stack.
> > > > >
> > > > >     alternative_io("in" #bwl " %w2, %" #bw "0",            \
> > > > >             "call tdg_in" #bwl, X86_FEATURE_TDX_GUEST,    \
> >
> > Has Intel "officially" switched to "tdg" as the acronym for TDX guest?  As much
> > as I dislike having to juggle "TDX host" vs "TDX guest" concepts, tdx_ vs tdg_
> > isn't any better IMO.  The latter looks an awful lot like a typo, grepping for
> > "tdx" to find relevant code will get fail (sometimes), and confusion seems
> > inevitable as keeping "TDX" out of guest code/comments/documentation will be
> > nigh impossible.
> >
> > If we do decide to go with "tdg" for the guest stuff, then _all_ of the guest
> > stuff, file names included, should use tdg.  Maybe X86_FEATURE_TDX_GUEST could
> > be left as a breadcrumb for translating TDX->TDG.
> >
> > > > >             "=a"(value), "d"(port))
> > > >
> > > > Are you saying that calling C functions from inline assembly might
> > > > corrupt the stack or registers?  Are you suggesting that you simply
> > >
> > > It's possible, but you would need to mark a lot more registers clobbered
> > > (the x86-64 ABI allows to clobber many registers)
> > >
> > > I don't think the stack would be messed up, but there might be problems
> > > with writing the correct unwind information (which tends to be tricky)
> > >
> > > Usually it's better to avoid it.
> >
> > For me, the more important justification is that, if calling from alternative_io,
> > the input parameters will be in the wrong registers.  The OUT wrapper would be
> > especially gross as RAX (the value to write) isn't an input param, i.e. shifting
> > via "ignored" params wouldn't work.
> >
> > But to Dave's point, that justfication needs to be in the changelog.
> 
> It's not clear to me that in()/out() need to be inline asm with an
> alternative vs out-of-line function calls with a static branch?

I doubt it matters at all on a modern machine (the cost of a IO port
access is many orders of magnitudes greater than a call), but it might
have mattered on really old systems, like 486 class. Maybe if someone
is still running those moving it out of line could be a problem.

But likely it's fine.

I think actually for the main kernel we could just rely on #VE here
and drop it all.
Doing it without #VE only really matters for the old boot code, where
performance doesn't really matter.

-Andi
