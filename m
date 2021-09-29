Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF11941BC7F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 03:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243682AbhI2B6G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Sep 2021 21:58:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:3995 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243661AbhI2B6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 21:58:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="224881061"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="224881061"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 18:56:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="655329177"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 28 Sep 2021 18:56:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 18:56:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 18:56:23 -0700
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.2242.012;
 Tue, 28 Sep 2021 18:56:23 -0700
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
Thread-Index: AQHXrlpps8sdI0y1ikyhBinC7AfU6auyuuKAgAYjzwCAAC8cgIABPj0AgAAIFQCAABNJgIAAB6kAgAAlrYD//5XdAIAAeikA//+nYIA=
Date:   Wed, 29 Sep 2021 01:56:23 +0000
Message-ID: <840148c7b70f4358852c4f1ccbc5d567@intel.com>
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
> 
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

I'm not sure why the FPU state is initialized here.

For updating the PASID state, it's unnecessary to init the PASID state.

Maybe it is necessary in other cases?

> 
> out:
> 	xsave->header.xfeatures |= fmask;

Setting the xfeatures bit plus updating the PASID state is enough
to restore the PASID state to the IA32_PASID MSR.

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
