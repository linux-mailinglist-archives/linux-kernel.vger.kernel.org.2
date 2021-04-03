Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BBB3534EC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 19:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236910AbhDCR2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 13:28:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:49103 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236724AbhDCR2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 13:28:05 -0400
IronPort-SDR: sB47sMhZbRvcJMbQXeaWJbHZQ+0YDhgMzlHDTwCf0uGVk6ysqtkZwUjDzEUqqimJEoK5S/Gf9q
 7eg/2puWtBQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9943"; a="192121768"
X-IronPort-AV: E=Sophos;i="5.81,302,1610438400"; 
   d="scan'208";a="192121768"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2021 10:28:02 -0700
IronPort-SDR: C79qsqddGa2d/q7H/UeBko7EHA/eaQeL69YB0QOyXC2vMDSryNHkISic/3he0DNGtt8GKSuLIc
 X32ANFB9LIEA==
X-IronPort-AV: E=Sophos;i="5.81,302,1610438400"; 
   d="scan'208";a="439998102"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2021 10:28:02 -0700
Date:   Sat, 3 Apr 2021 10:28:01 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 00/26] Add TDX Guest Support
Message-ID: <20210403172801.GP1285835@tassilo.jf.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <95e97456-478b-c6a2-f851-3b19ce794262@intel.com>
 <20210402024852.GK1285835@tassilo.jf.intel.com>
 <9bfa74a5-6a56-a2e0-7432-d35766099d54@intel.com>
 <20210402213219.GM1285835@tassilo.jf.intel.com>
 <4270ec8f-7055-8562-cdb4-aa8cff10269a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4270ec8f-7055-8562-cdb4-aa8cff10269a@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2021 at 09:26:24AM -0700, Dave Hansen wrote:
> On 4/2/21 2:32 PM, Andi Kleen wrote:
> >> If we go this route, what are the rules and restrictions?  Do we have to
> >> say "no MMIO in #VE"?
> > 
> > All we have to say is "No MMIO in #VE before getting thd TDVEINFO arguments"
> > After that it can nest without problems.
> 
> Well, not exactly.  You still can't do things that will could cause a n
> unbounded recusive #VE.

> It doesn't seem *that* far fetched to think that someone might try to
> defer some work or dump data to the console.

I believe the main console code has reentry protection.

I'm not sure about early_printk (with keep), buf it that's the case
it probably should be fixed anyways. I can take a look at that.

Not sure why deferring something would cause another #VE?

 
> > If you nest before that the TDX will cause a triple fault.
> > 
> > The code that cannot do it is a few lines in the early handler which
> > runs with interrupts off.
> 
> >> Which brings up another related point: How do you debug TD guests?  Does
> >> earlyprintk work?
> > 
> > Today it works actually because serial ports are allowed. But I expect it to
> > be closed eventually because serial code is a lot of code to audit. 
> > But you can always disable the filtering with a command line option and
> > then it will always work for debugging.
> 
> Do we need a TDX-specific earlyprintk?  I would imagine it's pretty easy
> to implement.

Don't see a need at this point, the existing mechanisms work.

Maybe if we ever have a problem that only happen in lockdown *and* happens
early, but that's not very likely since lock down primarily changes code
behavior later.

There are also other debug mechanisms for such cases: in TDX if you configure
the TD for debug mode supports using the gdb stub on the hypervisor.

-Andi

