Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71B841CAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 19:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345203AbhI2RKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 13:10:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:1355 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344818AbhI2RKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 13:10:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="247522719"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="247522719"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 10:07:55 -0700
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="538924770"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 10:07:55 -0700
Date:   Wed, 29 Sep 2021 10:07:54 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YVSdauvwzs1HJlLz@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
 <YVIxeBh3IKYYK711@agluck-desk2.amr.corp.intel.com>
 <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
 <YVNj8sm8iectc6iU@agluck-desk2.amr.corp.intel.com>
 <3f97b77e-a609-997b-3be7-f44ff7312b0d@intel.com>
 <YVN652x14dMgyE85@agluck-desk2.amr.corp.intel.com>
 <f6014b16-7b4c-cbb6-c975-1ec34092956f@intel.com>
 <YVOg7zgpdQlc7Zjt@agluck-desk2.amr.corp.intel.com>
 <308a72e4-6aa9-0c84-21e6-ee613eea35a8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <308a72e4-6aa9-0c84-21e6-ee613eea35a8@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 09:58:22AM -0700, Andy Lutomirski wrote:
> On 9/28/21 16:10, Luck, Tony wrote:
> > Moving beyond pseudo-code and into compiles-but-probably-broken-code.
> > 
> > 
> > The intent of the functions below is that Fenghua should be able to
> > do:
> > 
> > void fpu__pasid_write(u32 pasid)
> > {
> > 	u64 msr_val = pasid | MSR_IA32_PASID_VALID;
> > 	struct ia32_pasid_state *addr;
> > 
> > 	addr = begin_update_one_xsave_feature(current, XFEATURE_PASID, true);
> > 	addr->pasid = msr_val;
> > 	finish_update_one_xsave_feature(current);
> > }
> > 
> 
> This gets gnarly because we would presumably like to optimize the case where
> we can do the update directly in registers.  I wonder if we can do it with a
> bit of macro magic in a somewhat generic way:

Can we defere the optimizations until there is a use case that
cares? The existing use case (fixing up the #GP fault by setting
the PASID MSR) isn't performance critical.

Let's just have something that is clear (or as clear as any xsave
code can be) and correct.

-Tony
