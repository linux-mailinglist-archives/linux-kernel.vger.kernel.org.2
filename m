Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6DF3F0A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 19:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhHRRWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 13:22:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:55431 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229661AbhHRRWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:22:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="203529559"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="203529559"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 10:21:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="531775841"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2021 10:21:05 -0700
Received: from tjmaciei-mobl5.localnet (10.209.60.224) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 18 Aug 2021 18:21:02 +0100
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@alien8.de>
CC:     <luto@kernel.org>, <tglx@linutronix.de>, <mingo@kernel.org>,
        <x86@kernel.org>, <len.brown@intel.com>, <dave.hansen@intel.com>,
        <jing2.liu@intel.com>, <ravi.v.shankar@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to protect dynamic user state
Date:   Wed, 18 Aug 2021 10:20:58 -0700
Message-ID: <3181031.RqgVF4sTRC@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To: <YR00U19168BGoRB9@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com> <20210730145957.7927-13-chang.seok.bae@intel.com> <YR00U19168BGoRB9@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.209.60.224]
X-ClientProxiedBy: orsmsx605.amr.corp.intel.com (10.22.229.18) To
 IRSMSX605.ger.corp.intel.com (163.33.146.138)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 18 August 2021 09:24:51 PDT Borislav Petkov wrote:
> > +#define X86_FEATURE_XFD                        (10*32+ 4) /* eXtended
> > Feature Disabling */
> 
> Add "" at the marker above - it doesn't look like we wanna show "xfd" in
> /proc/cpuinfo.

Why not?

It could help diagnosing why this code has a failure if XFD is somehow 
missing. That can happen with hypervisors or future CPUs.

> > +                               /* Raise a signal when it failed to
> > handle. */ +                               if (err)
> > +                                       force_sig_fault(SIGILL,
> > ILL_ILLOPC,
> > +                                                      
> > error_get_trap_addr(regs));> 
> Where is it documented that that configuration of SIG* types means,
> failure to allocate the dynamic buffer?

This wasn't part of the memory failure, but now that you've pointed out, yes, 
we are getting a SIGILL in case the kernel failed to allocate memory too. 

This is the same code path we get if the task executes an AMX instruction 
without first requesting support for it via the system call. At my request, 
Chang changed it from SIGSEGV to SIGILL, because that's the behaviour one 
would see if the kernel did not support AMX at all, hadn't enabled it in XCR0 
or the CPU didn't support the instructions.

I don't know how to best handle killing the application if the kernel is OOM 
(see below, though). Maybe it should SIGKILL instead. The problem with sending 
a SIGSEGV is debuggability: if I get a core dump of this crash, which is 
likely going to happen in a load instruction, I'll spend a lot time trying to 
understand why the pointer in that instruction wasn't correct. Very few people 
will ever consider it may have another reason.

> To the general picture: why is this thing even allocating a buffer in #NM?
> 
> Why isn't the buffer pre-allocated for the process after latter having
> done prctl() so that when an #NM happens, no allocation happens at all?

That's a good question, but I thought it had been discussed and agreed that we 
didn't want to extend the buffers at the moment the application requested the 
bits, because it may never need them. This was probably a defence against 
applications requesting all bits without knowing whether they'll need them at 
all.

The way the API to userspace is implemented, the only way to find out if the 
kernel supports a given state is to enable it. It's not currently possible to 
ask "do you support AMX tile data?" and then go about the application's merry 
way until it determines it really wants to do matrix multiplications. In the 
case of applications with plugins, they need to have that answer before the 
load the plugin, which usually happens at application start.

I was going to suggest a new API to return the supported bits, but hadn't yet 
because it wasn't required for this patchset to work. So long as that API 
landed at or before the time a new bit was added, userspace would be able to 
cope. But if the kernel is going to allocate the bits at the moment of the 
system call *and* we wish for userspace not to request more than it really 
needs, then we'll need this extra API right now.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel DPG Cloud Engineering



