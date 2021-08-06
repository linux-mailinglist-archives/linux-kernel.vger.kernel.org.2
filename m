Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50F43E2E7E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 18:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbhHFQqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 12:46:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:62418 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235319AbhHFQqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 12:46:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10068"; a="275447371"
X-IronPort-AV: E=Sophos;i="5.84,301,1620716400"; 
   d="scan'208";a="275447371"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 09:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,301,1620716400"; 
   d="scan'208";a="523560916"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by fmsmga002.fm.intel.com with ESMTP; 06 Aug 2021 09:46:29 -0700
Received: from tjmaciei-mobl5.localnet (10.212.136.161) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 6 Aug 2021 17:46:26 +0100
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     <bp@suse.de>, <luto@kernel.org>, <tglx@linutronix.de>,
        <mingo@kernel.org>, <x86@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
CC:     <len.brown@intel.com>, <dave.hansen@intel.com>,
        <jing2.liu@intel.com>, <ravi.v.shankar@intel.com>,
        <linux-kernel@vger.kernel.org>, <chang.seok.bae@intel.com>
Subject: Re: [PATCH v9 14/26] x86/arch_prctl: Create ARCH_SET_STATE_ENABLE/ARCH_GET_STATE_ENABLE
Date:   Fri, 6 Aug 2021 09:46:22 -0700
Message-ID: <3718618.i2J648eyUT@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To: <20210730145957.7927-15-chang.seok.bae@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com> <20210730145957.7927-15-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.212.136.161]
X-ClientProxiedBy: orsmsx605.amr.corp.intel.com (10.22.229.18) To
 IRSMSX605.ger.corp.intel.com (163.33.146.138)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 30 July 2021 07:59:45 PDT Chang S. Bae wrote:
> +       for_each_thread(tsk, t) {
> +               t->thread.fpu.dynamic_state_perm |= req_dynstate_perm;
> +               nr_threads++;
> +       }
> +
> +       if (nr_threads != tsk->signal->nr_threads) {
> +               for_each_thread(tsk, t)
> +                       t->thread.fpu.dynamic_state_perm =
> old_dynstate_perm; 
> +               pr_err("x86/fpu: ARCH_XSTATE_PERM failed
> as thread number mismatched.\n"); 
> +               return -EBUSY;
> +       }
> +       return 0;
> +}

Hello all

As I was trying to write the matching userspace code, I think the solution 
above had two problems. 

First the simpler one: that EBUSY. It must go and you can do that with a lock. 
Library code cannot ensure that it is running in single-threaded state and 
that no other threads are started or exit while they make the system call. 
There's nothing the library in question can do if it got an EBUSY. Do you want 
me to try again? What if it fails again? What's the state of the dynamically 
permitted states after an EBUSY? It's probably inconsistent. Moreover, there's 
an ABA problem there: what happens if a thread starts and another exits while 
this system call is running? And what happens if two threads are making this 
system call? 
(also, shouldn't tsk->signal->nr_threads be an atomic read?)

The second and bigger problem is the consequence of not issuing the 
ARCH_SET_STATE_ENABLE call: a SIGILL. Up until now, this hasn't happened, so I 
expect this to be a surprise to people, in the worst possible way. The Intel 
Software Developer Manual and every single tutorial out there says that the 
sequence of actions is:
 1) check that OSXSAVE is enabled
 2) check that the AVX, AVX512 or AMX instructions are supported with CPUID
 3) execute XGETBV EAX=0
 4) disable any instructions whose matching state is not enabled by the OS

This is what software developers will write for AMX and any new future state, 
until they learn better. This is also all that other OSes will require to run. 
Moreover, until developers can actually run their software on CPUs with AMX 
support, they will not notice any missed system calls (the Software 
Development Emulator tool will execute the instructions whether you've issued 
the syscall or not).

As a consequence, there's a large chance that a test escape like that will 
cause software to start crashing when run on AMX-capable CPUs when those start 
showing up and get enabled in public clouds.

So I have to insist that the XGETBV instruction's result match exactly what is 
permitted to run. That means we either enable AMX unconditionally with no need 
for system calls (with or without XFD trapping to dynamically allocate more 
state), or that the XCR0 register be set without the AMX bits by default, 
until the system call is issued.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel DPG Cloud Engineering



