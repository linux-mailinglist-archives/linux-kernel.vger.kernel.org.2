Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5923E5014
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 01:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbhHIXnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 19:43:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:14649 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232717AbhHIXnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 19:43:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="201975157"
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="201975157"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 16:42:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="468834025"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by orsmga008.jf.intel.com with ESMTP; 09 Aug 2021 16:42:37 -0700
Received: from tjmaciei-mobl5.localnet (10.212.156.33) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 10 Aug 2021 00:42:34 +0100
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
CC:     "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 14/26] x86/arch_prctl: Create ARCH_SET_STATE_ENABLE/ARCH_GET_STATE_ENABLE
Date:   Mon, 9 Aug 2021 16:42:30 -0700
Message-ID: <3144206.qcAzhSVzjS@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To: <E9C8AF5E-E229-4BA2-AEC8-4289EF7428CA@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com> <3718618.i2J648eyUT@tjmaciei-mobl5> <E9C8AF5E-E229-4BA2-AEC8-4289EF7428CA@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.212.156.33]
X-ClientProxiedBy: orsmsx605.amr.corp.intel.com (10.22.229.18) To
 IRSMSX605.ger.corp.intel.com (163.33.146.138)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 9 August 2021 15:08:19 PDT Bae, Chang Seok wrote:
> I suspect the EBUSY situation is somewhat imaginative. In theory, the
> situation might be possible one thread calls this syscall at some point when
> a new task is being created -- after task data duplication [1] and before
> enlisted [2].
> 
> As stated in the changelog, the alternative is possible:
> > An alternative implementation would not save the permission bitmap in
> > every task. But instead would extend the per-process signal data, and
> > that would not be subject to this race.
> 
> But it involves quite a bit of code complexity and this is pretty much
> backend. I think it is possible to follow up and update when the case ever
> turns out to be real. At least, I'm not aware of any report against the
> PR_SET_FP_MODE prctl(2) [3] which took the same way -- walk and update the
> task list.
> 
> Perhaps, the hunk above can be improved to be atomic.
> 
> <snip>

Hello Chang

Thanks for taking a look at this. I agree that this is a very, very tiny 
corner case and the issue can be treated as a bugfix later. The API between 
userspace and kernel is fine, which is the big issue right now.

But explaining what the issue I see is: a userspace library cannot enforce 
that other threads in the same process aren't either making this same system 
call or starting/exiting threads. So I see two scenarios where the corner case 
can be reached:

1) two simultaneous ARCH_SET_STATE_ENABLE calls
Imagine two threads, each setting a different bit (say bits 18 and 19). Since 
they race with each other and this line:
              t->thread.fpu.dynamic_state_perm |= req_dynstate_perm;
is not using an atomic, the compiler won't emit LOCK OR, so it's possible the 
two calls will step over each other and partially undo the other's work. The 
result after the two calls is completely indeterminate, yet both functions 
returned success.

Since right now there's only one bit that can be set, we know that the two 
calls are doing the same thing, so they're not effectively racing each other. 
So this case is not an issue *right* *now*. There's only duplicate work.

2) one thread calls ARCH_SET_STATE_ENABLE while another thread exits/starts
In this case, the nr_threads != tsk->signal->nr_threads test will fail 
resulting in the dynamic state to be rolled back and the EBUSY condition. I'd 
like a recommendation from the kernel on how to deal with that signal: should 
I retry? For now, I'm going to treat EBUSY like EINVAL and assume I cannot use 
the feature.

1+2) both situations at the same time
This means the corruption can get worse since the rollback code can undo or 
partially undo the progression of the other ARCH_SET_STATE_ENABLE.

> > So I have to insist that the XGETBV instruction's result match exactly
> > what is permitted to run. That means we either enable AMX unconditionally
> > with no need for system calls (with or without XFD trapping to
> > dynamically allocate more state), or that the XCR0 register be set
> > without the AMX bits by default, until the system call is issued.
> 
> XCR0 provokes VMEXIT which will impact the performance hardly. At least the
> opt-in model is a consensus out of the long debate [4]. Let alone the
> question on how well advertise this new syscall though.

I understand.

I am pointing out that this will cause crashes because of improperly / 
insufficiently-tested software. That is, software that violates the contract 
of the new API because we inserted a new requirement that didn't exist for old 
features. Yes, said software is buggy.

The problem is that the crashes can be surprising and will only show up after 
the software gets run on an AMX-capable machine. That may happen, for example, 
if a cloud provider "upgrades" the instance of a VM from a previous generation 
of processor to a new one, or if a batch job does include the new instance 
type. That is, the crashes will not happen for the developer of the software 
in question, but instead for the user.

However, given the requirements that:
 a) XCR0 not be context-switched
 b) a new API call be required to allow the new instructions

Then there's no alternative.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel DPG Cloud Engineering



