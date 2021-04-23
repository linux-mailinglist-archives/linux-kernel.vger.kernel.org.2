Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7830F368A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 03:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239954AbhDWBgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 21:36:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:55629 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231261AbhDWBgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 21:36:23 -0400
IronPort-SDR: 0GaWCl+tLFAJLWt1E/kAOGlacWOYEMF+6Ke6WL70B72fsVS9UMcKMpYSKSvwSEX5Ve8T5T7UWr
 D658FZf+BHbQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="176123785"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="176123785"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 18:35:48 -0700
IronPort-SDR: 7COMgSPIn92wJ8pf4KhIGkThc41EHZ/MG5ENrO7WxsLlgZ/+7goY2y+DkvdDz0Jx/rUswQDV3t
 +zktEf4d18zQ==
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="428195313"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 18:35:47 -0700
Date:   Thu, 22 Apr 2021 18:35:46 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] x86/tdx: Add __tdcall() and __tdvmcall() helper
 functions
Message-ID: <20210423013546.GK1401198@tassilo.jf.intel.com>
References: <8723950c-e07c-9a03-503a-ab232701d1e9@linux.intel.com>
 <c015093fdbc8e6a5aa9fc43f78fec8d9c38295c7.1616801167.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <77a13ae9-0220-030e-7ae4-fd26edd7b110@intel.com>
 <2a3f6b3d-cd80-0734-ce83-c067666c8326@linux.intel.com>
 <14332abf-c78c-3bc2-9a7c-ceacfa7a0661@intel.com>
 <596175e3-9d1e-6c9c-fadb-ad02c396e3ad@linux.intel.com>
 <d99941db-6ee6-267e-dece-6220af0ea305@intel.com>
 <9161efc0-fd25-d239-32b7-5d2c726579b0@linux.intel.com>
 <4ac4ed35-212b-f7ad-55f4-937946ffec1a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ac4ed35-212b-f7ad-55f4-937946ffec1a@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 06:21:07PM -0700, Dave Hansen wrote:
> On 4/22/21 6:09 PM, Kuppuswamy, Sathyanarayanan wrote:
> > But let me try to explain it here. What I meant by complication is,
> > for in/out instruction, we use alternative_io() to substitute in/out
> > instructions with tdg_in()/tdg_out() assembly calls. So we have to ensure
> > that we don't corrupt registers or stack from the substituted instructions
> > 
> > If you check the implementation of tdg_in()/tdg_out(), you will notice
> > that we have added code to preserve the caller registers. So, if we use
> > C wrapper for this use case, there is a chance that it might mess
> > the caller registers or stack.
> > 
> >     alternative_io("in" #bwl " %w2, %" #bw "0",            \
> >             "call tdg_in" #bwl, X86_FEATURE_TDX_GUEST,    \
> >             "=a"(value), "d"(port))
> 
> Are you saying that calling C functions from inline assembly might
> corrupt the stack or registers?  Are you suggesting that you simply

It's possible, but you would need to mark a lot more registers clobbered
(the x86-64 ABI allows to clobber many registers)

I don't think the stack would be messed up, but there might be problems
with writing the correct unwind information (which tends to be tricky)

Usually it's better to avoid it.

-Andi


> can't call C functions from inline assembly?  Or, that you can't express
> the register clobbers of a function call in inline assembly?
> 
> You might want to check around the kernel to see how other folks do it.
