Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1D841D0B9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 02:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347095AbhI3Apr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 20:45:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:62899 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344935AbhI3App (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 20:45:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="224728954"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="224728954"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 17:44:01 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="479585082"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 17:44:01 -0700
Date:   Thu, 30 Sep 2021 00:44:00 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Message-ID: <YVUIUIQcMxydYLQ9@otcwcpicx3.sc.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com>
 <3156573d-0d25-db0f-57ae-b6406763a8e9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3156573d-0d25-db0f-57ae-b6406763a8e9@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Baolu,

On Thu, Sep 23, 2021 at 01:43:32PM +0800, Lu Baolu wrote:
> On 9/21/21 3:23 AM, Fenghua Yu wrote:
> > +void pasid_put(struct task_struct *tsk, struct mm_struct *mm)
> > +{
> > +	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> > +		return;
> > +
> > +	/*
> > +	 * Nothing to do if this task doesn't have a reference to the PASID.
> > +	 */
> > +	if (tsk->has_valid_pasid) {
> > +		mutex_lock(&pasid_mutex);
> > +		/*
> > +		 * The PASID's reference was taken during fix up. Release it
> > +		 * now. If the reference count is 0, the PASID is freed.
> > +		 */
> > +		iommu_sva_free_pasid(mm);
> > +		mutex_unlock(&pasid_mutex);
> > +	}
> > +}
> > 
> 
> It looks odd that both __fixup_pasid_exception() and pasid_put() are
> defined in the vendor IOMMU driver, but get called in the arch/x86
> code.
> 
> Is it feasible to move these two helpers to the files where they are
> called? The IA32_PASID MSR fixup and release are not part of the IOMMU
> implementation.

Sure. The functions will be removed in the next version. And new functions
will not be called in IOMMU driver.

Thanks.

-Fenghua
