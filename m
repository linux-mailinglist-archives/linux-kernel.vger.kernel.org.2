Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426C141CAE6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 19:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345225AbhI2RN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 13:13:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:34194 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343872AbhI2RN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 13:13:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="288650541"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="288650541"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 10:07:55 -0700
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="563435641"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 10:07:54 -0700
Date:   Wed, 29 Sep 2021 17:07:48 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Message-ID: <YVSdZGhbiqXbUaXV@otcwcpicx3.sc.intel.com>
References: <20210920192349.2602141-6-fenghua.yu@intel.com>
 <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com>
 <87o88jfajo.ffs@tglx>
 <87k0j6dsdn.ffs@tglx>
 <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
 <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
 <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net>
 <87r1d78t2e.ffs@tglx>
 <57d0e4efcf2d4e9abb91801520a3f386@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57d0e4efcf2d4e9abb91801520a3f386@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

On Wed, Sep 29, 2021 at 09:51:15AM -0700, Luck, Tony wrote:
> > There is zero requirement to look at TIF_NEED_FPU_LOAD or
> > fpregs_state_valid() simply because the #GP comes straight from user
> > space which means the FPU registers contain the current tasks user space
> > state.
> 
> Just to double confirm ... there is no point in the #GP handler up to this point
> where pre-emption can occur?

Same question here. The fixup function is called after cond_local_irq_enable().
If an interrupt comes before fixup_pasid_exception(), the interrupt may
use FPU and call kernel_fpu_begin_mask()->set(TIF_NEED_FPU_LOAD)->
__cpu_invalidate_fpregs_state(). Then writing to the IA32_PASID MSR. When
exiting to user, the FPU states will be restored to the FPU regs including
the IA32_PASID MSR. So the MSR could be different from the value written in
fixup_pasid_execption(). Is it possible?

Or should fixup_pasid_exception() be called before cond_local_irq_enable()?

Thanks.

-Fenghua
