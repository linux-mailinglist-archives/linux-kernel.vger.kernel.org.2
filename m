Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55A341BBB2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 02:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243417AbhI2A2R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Sep 2021 20:28:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:46963 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240715AbhI2A2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 20:28:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="221626916"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="221626916"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 17:26:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="476472221"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 28 Sep 2021 17:26:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 17:26:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 17:26:34 -0700
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.2242.012;
 Tue, 28 Sep 2021 17:26:34 -0700
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Thread-Topic: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Thread-Index: AQHXrlpps8sdI0y1ikyhBinC7AfU6auyuuKAgAYjzwCAAC8cgIABPj0AgAAIFQCAABNJgIAAB6kAgAAlrYD//5XdAIAAeikA//+NsYA=
Date:   Wed, 29 Sep 2021 00:26:34 +0000
Message-ID: <ae7a12650d2741f9970449a08721a28e@intel.com>
References: <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
 <YVIxeBh3IKYYK711@agluck-desk2.amr.corp.intel.com>
 <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
 <YVNj8sm8iectc6iU@agluck-desk2.amr.corp.intel.com>
 <3f97b77e-a609-997b-3be7-f44ff7312b0d@intel.com>
 <YVN652x14dMgyE85@agluck-desk2.amr.corp.intel.com>
 <f6014b16-7b4c-cbb6-c975-1ec34092956f@intel.com>
 <YVOg7zgpdQlc7Zjt@agluck-desk2.amr.corp.intel.com>
 <YVOp60LOL+bfh3iT@otcwcpicx3.sc.intel.com>
 <YVOuYAFaTG6Khotb@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <YVOuYAFaTG6Khotb@agluck-desk2.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tony,

> void *begin_update_one_xsave_feature(struct task_struct *tsk,
> 				     enum xfeature xfeature, bool full) {
> 	struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
> 	struct xregs_state *xinit = &init_fpstate.xsave;
> 	u64 fmask = 1ull << xfeature;
> 	void *addr;
> 
> 	BUG_ON(!(xsave->header.xcomp_bv & fmask));
> 
> 	fpregs_lock();

I'm afraid we may hit the same locking issue when we send IPI to notify another task to modify its
PASID state. Here the API is called to modify another running task's PASID state as well without a right lock.
fpregs_lock() is not enough to deal with this, I'm afraid.

Quote from Thomas in https://lore.kernel.org/linux-iommu/87mtsd6gr9.ffs@nanos.tec.linutronix.de/
"FPU state of a running task is protected by fregs_lock() which is
   nothing else than a local_bh_disable(). As BH disabled regions run
   usually with interrupts enabled the IPI can hit a code section which
   modifies FPU state and there is absolutely no guarantee that any of the
   assumptions which are made for the IPI case is true."

Maybe restrict the API's scope: don't modify another task's FPU state, just the current task's state?

> 	addr = __raw_xsave_addr(xsave, xfeature);
> 
> 	if (full || tsk != current) {
> 		memcpy(addr, __raw_xsave_addr(xinit, xfeature),
> xstate_sizes[xfeature]);
> 		goto out;
> 	}
> 
> 	if (!(xsave->header.xfeatures & fmask)) {
> 		xsave->header.xfeatures |= fmask;	//<<<<<
> 		xsaves(xsave, fmask);
> 	}
> 
> out:
> 	xsave->header.xfeatures |= fmask;
> 	return addr;
> }
> 
> void finish_update_one_xsave_feature(struct task_struct *tsk) {
> 	set_ti_thread_flag(task_thread_info(tsk), TIF_NEED_FPU_LOAD);
> 	if (tsk == current)				//<<<<<
> 		__cpu_invalidate_fpregs_state();	//<<<<<
> 	fpregs_unlock();
> }

Thanks.

-Fenghua
