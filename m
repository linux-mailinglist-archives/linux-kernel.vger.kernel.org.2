Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAC93F0AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 19:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhHRR7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 13:59:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:32771 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhHRR7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:59:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="280127097"
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="280127097"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 10:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="521178622"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Aug 2021 10:58:48 -0700
Received: from tjmaciei-mobl5.localnet (10.209.60.224) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 18 Aug 2021 18:58:45 +0100
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Chang S. Bae" <chang.seok.bae@intel.com>, <luto@kernel.org>,
        <tglx@linutronix.de>, <mingo@kernel.org>, <x86@kernel.org>,
        <len.brown@intel.com>, <dave.hansen@intel.com>,
        <jing2.liu@intel.com>, <ravi.v.shankar@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to protect dynamic user state
Date:   Wed, 18 Aug 2021 10:58:42 -0700
Message-ID: <4493449.UzBjrsCbmA@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To: <YR1HYRRN0HMTxXrw@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com> <3181031.RqgVF4sTRC@tjmaciei-mobl5> <YR1HYRRN0HMTxXrw@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.209.60.224]
X-ClientProxiedBy: orsmsx605.amr.corp.intel.com (10.22.229.18) To
 IRSMSX605.ger.corp.intel.com (163.33.146.138)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 18 August 2021 10:46:09 PDT Borislav Petkov wrote:
> You're new to this...
> 
> tools/arch/x86/kcpuid/kcpuid.c should be used for all CPUID querying
> needs.

That tells me what the CPU supports, not what the kernel does. By omitting the 
"xfd" entry in /proc/cpuinfo, we are assuming that all kernels with "amxtile" 
also implicitly support xfd. That is a valid assumption.

> I don't see a problem with the app doing at load time:
> 
> A: Heey, kernel, do you support AMX?
> K: Yes
> A: Allocate a dynamic FPU buffer for me then pls.

Many applications need to determine which plugins and code paths to enable 
before getting the data that will tell them what to do. It's entirely possible 
for them to never need to run the AMX instructions, so they may wish to defer 
the request to allocate the XSAVE state until they have read their input data.

It's indeed possible that the allocation then fails and the application be 
unable to continue. But OOM conditions are unlikely, so it may be an 
acceptable price to pay. In fact, by *not* allocating the extra state for 
every thread in the current process, it may avoid the OOM.

> > I was going to suggest a new API to return the supported bits, but
> > hadn't yet because it wasn't required for this patchset to work.
> 
> I think you should. The important part is having the API good and
> complete.
> 
> > So long as that API landed at or before the time a new bit was added,
> > userspace would be able to cope. But if the kernel is going to
> > allocate the bits at the moment of the system call *and* we wish for
> > userspace not to request more than it really needs, then we'll need
> > this extra API right now.
> 
> No no, once the API hits upstream, it is cast in stone. So it better
> be done in full with the patchset, in one go. No later significant API
> additions or changes, none especially after apps start using it.

Sorry, that's not what I meant. I was going to request an extra API, a third 
call. We'd have:
 - get current state
 - set new state
 - get available bits to set

The first two are in Chang's patch set, the third one is not. Right now, 
there's a single bit that can be set, so there's no need to have the third 
one. Any future software that wants to request a new bit will know if the 
kernel supports it by the very presence of the API. That is, if they ask and 
the API fails with -EINVAL, then this new bit isn't supported.

I didn't make the request because, as I said, it didn't seem required. 
Therefore, I didn't want to add further work before the minimum functionality 
got merged.

Now, if we are going to have this API any way, it might be a good idea to 
combine the two getters in one by adding a second pointer parameter.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel DPG Cloud Engineering



