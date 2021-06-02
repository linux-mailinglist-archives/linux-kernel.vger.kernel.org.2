Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6E53994AB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 22:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhFBUjm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Jun 2021 16:39:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:24841 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhFBUjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 16:39:40 -0400
IronPort-SDR: 4svAFfmeR2PEYnI4v+6GX/mmFcSLW3Cosh4fvDYC05+unmHAAmvL+fl/1T2m7AS+T2GrvdFJW3
 9WMx4WR8MuqQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="289519877"
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="289519877"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 13:37:53 -0700
IronPort-SDR: 7o4Ko8qf/YRzlDUJz4aakcBst7Sj7ZsY8RdyqRwMdV8376kw73r6vMeokEPqWEPnk11j7Qk3T3
 JmLdWAInr/6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="617366863"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga005.jf.intel.com with ESMTP; 02 Jun 2021 13:37:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 2 Jun 2021 13:37:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 2 Jun 2021 13:37:48 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.008;
 Wed, 2 Jun 2021 13:37:48 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Ingo Molnar" <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and
 remove update_pasid()
Thread-Topic: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and
 remove update_pasid()
Thread-Index: AQHXVGt3asHLaBFynUG7zSoQX2rt5Kr9vnIAgAAaOACAA1lTUA==
Date:   Wed, 2 Jun 2021 20:37:47 +0000
Message-ID: <36866b38ec92425b879881a88acf547b@intel.com>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
 <87mtsd6gr9.ffs@nanos.tec.linutronix.de> <YLShmFEzddfm7WQs@zn.tnic>
 <87y2bv438p.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87y2bv438p.ffs@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> ... so on a PASID system, your trivial reproducer would theoretically
>> fire the same way and corrupt FPU state just as well.
>
> This is worse and you can't selftest it because the IPI can just hit in
> the middle of _any_ FPU state operation and corrupt state.

That sounds like we should abandon the "IPI all the other threads
to force enable the PASID for them" approach. It would just be a
nightmare of papering over cracks when the IPI was delivered at
some inconvenient moment when the recipient was in the middle
of touching xsave state.

I've told Fenghua to dig out the previous iteration of this patch where
the plan was to lazily fix the PASID_MSR in other threads in the #GP
handler.

That algorithm is very simple and easy to check. Pseudo-code:

#GP
	if (usermode && current->mm->pasid && rdmsr(PASID_MSR) != valid) {
		wrmsr(PASID_MSR, current->mm->pasid | PASID_VALID);
		return;
	}

Worst case is that some thread of a multi-threaded process that is using PASID
takes some unrelated #GP ... this code will try to fix it by enabling the PASID_MSR.
That will just #GP a second time and this test will see the MSR is already set,
so fall into the usual #GP handling code.

Seems like a better direction than trying to fix the IPI method. The virtualization
folks will like this way more because IPI in guest causes a couple of VMEXIT
so is somewhat expensive.

-Tony
