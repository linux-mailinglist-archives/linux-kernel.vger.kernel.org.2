Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5874152BA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbhIVV1p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Sep 2021 17:27:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:18706 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237802AbhIVV1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:27:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="203859611"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="203859611"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 14:26:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="435587347"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 22 Sep 2021 14:26:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 14:26:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 14:26:10 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Wed, 22 Sep 2021 14:26:10 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Thread-Topic: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Thread-Index: AQHXrlppUXtiT4Ul9UCq0y1lpkQn1quxBE8AgAABOoD//4u5UA==
Date:   Wed, 22 Sep 2021 21:26:10 +0000
Message-ID: <abfbdfbc9a68477f985eeb4192839fca@intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <20210922210722.GV4323@worktop.programming.kicks-ass.net>
 <20210922211145.GF5106@worktop.programming.kicks-ass.net>
In-Reply-To: <20210922211145.GF5106@worktop.programming.kicks-ass.net>
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

>> > +static bool fixup_pasid_exception(void)
>> > +{
>> > +	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
>> > +		return false;
>> > +
>> > +	return __fixup_pasid_exception();
>> > +}
>
> That is, shouldn't the above at the very least decode the instruction
> causing the #GP and check it's this ENQCMD thing?

It can't reliably do that because some other thread in the process may
have re-written the memory that regs->ip points at (bizarre case, but
I think Dave Hansen brought it up).

So it would just add extra code, and still only be a hint.

Without the check this sequence is possible:

1) Process binds an accelerator (so mm->pasid is set)
2) Task in the process executes something other than ENQCMD that gets a #GP
3) Kernel says "Oh, mm->pasid is set, I'll initialize the IA32_PASID MSR to see if that fixes it"
4) Nope. Re-executing the instruction at step #2 just gives another #GP
5) Kernel says "I already set IA32_PASID, so this must be something else ... do regular #GP actions"

Now if the task catches the signal that results from step #5 and avoids termination, it will have
IA32_PASID set ... but to the right value should it go on to actually execute ENQCMD at some
future point.

So the corner case from not knowing whether this #GP was from ENQCMD or not is harmless.

-Tony


