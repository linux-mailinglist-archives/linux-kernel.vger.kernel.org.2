Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78693B46DF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 17:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhFYPtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 11:49:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:39907 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229949AbhFYPtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 11:49:04 -0400
IronPort-SDR: Aa2U7ZbjrdpEnaziMS3lGxY6Eux8kqcioK3CAqMmGclFy6LFsebLrfnNrjkfOf3UqeyQMF9tRi
 nlBgtZ/x7NHA==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="187381866"
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="187381866"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 08:46:43 -0700
IronPort-SDR: naYMx/2TuUTBUpSSAraBxCgF3wfQbSHEMQLlxRd9OQDOkMswUSaqNBbXUMJPpPzxc941VjHmG9
 quwb4ls5X/2A==
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="557733938"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 08:46:42 -0700
Date:   Fri, 25 Jun 2021 08:46:41 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
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
Subject: Re: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and
 remove update_pasid()
Message-ID: <20210625154641.GA1206684@agluck-desk2.amr.corp.intel.com>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
 <87mtsd6gr9.ffs@nanos.tec.linutronix.de>
 <YLShmFEzddfm7WQs@zn.tnic>
 <87y2bv438p.ffs@nanos.tec.linutronix.de>
 <36866b38ec92425b879881a88acf547b@intel.com>
 <db552f51-76ee-b7f5-20f1-14f1c703d423@kernel.org>
 <7d8788a9e04d4901a03bcea11e8e842b@intel.com>
 <bd5bb38c-0b81-a302-dd20-ef56fd970c9e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd5bb38c-0b81-a302-dd20-ef56fd970c9e@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 04:34:31PM -0700, Andy Lutomirski wrote:
> On 6/9/21 10:32 AM, Luck, Tony wrote:
> >>> I've told Fenghua to dig out the previous iteration of this patch where
> >>> the plan was to lazily fix the PASID_MSR in other threads in the #GP
> >>> handler.
> >>
> >> Blech.  Also this won't work for other PASID-like features.
> >>
> >> I have a half-written patch to fix this up for real.  Stay tuned.
> > 
> > Andy: Any update on this?
> > 
> > -Tony
> > 
> 
> Let me try to merge my pile with tglx's pile and come up with something
> halfway sane.

Looks like Thomas' pile is done (well done enough to be queued in TIP).

Can we see your "pile" soon?

-Tony
