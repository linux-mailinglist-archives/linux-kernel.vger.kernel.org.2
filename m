Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8634152E8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbhIVViB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:38:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:4683 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238033AbhIVVh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:37:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="246150924"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="246150924"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 14:36:28 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="557641969"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 14:36:28 -0700
Date:   Wed, 22 Sep 2021 21:36:22 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YUuh1habqkhk8y4B@otcwcpicx3.sc.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <20210922210722.GV4323@worktop.programming.kicks-ass.net>
 <20210922211145.GF5106@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922211145.GF5106@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

On Wed, Sep 22, 2021 at 11:11:45PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 22, 2021 at 11:07:22PM +0200, Peter Zijlstra wrote:
> > On Mon, Sep 20, 2021 at 07:23:45PM +0000, Fenghua Yu wrote:
> > > +static bool fixup_pasid_exception(void)
> > > +{
> > > +	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> > > +		return false;
> > > +
> > > +	return __fixup_pasid_exception();
> > > +}
> 
> That is, shouldn't the above at the very least decode the instruction
> causing the #GP and check it's this ENQCMD thing?

There were comments on a previous version when we used #GP fixup method:
https://lore.kernel.org/linux-iommu/f6d34d59-e6eb-ee9f-d247-8fb2f0e37549@intel.com/

There are three reasons for not decoding the instruction:

1. Parsing the instruction sets bad architectural precedent and is ugly.
2. The instruction could be modified (e.g. JVM) while decoding the
   instruction. It's.
3. Decoding is more complex than this patch and doesn't worth it.

Thanks.

-Fenghua
