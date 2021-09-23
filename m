Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5911341686E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 01:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243531AbhIWXYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 19:24:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:38482 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235628AbhIWXYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 19:24:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="284976067"
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="284976067"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 16:22:37 -0700
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="514303216"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 16:22:37 -0700
Date:   Thu, 23 Sep 2021 16:22:35 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Message-ID: <YU0MO/WJO4rkcl0c@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com>
 <d5f00e34-f9fc-4421-8571-48c45237141c@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5f00e34-f9fc-4421-8571-48c45237141c@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 04:09:18PM -0700, Andy Lutomirski wrote:
> On Mon, Sep 20, 2021, at 12:23 PM, Fenghua Yu wrote:

> I think this is unnecessarily complicated because it's buying in to the
> existing ISA misconception that PASID has anything to do with a task.
> A PASID belongs to an mm, full stop.  Now the ISA is nasty and we have
> tasks that have *noticed* that their mm has a PASID and tasks that have
> not noticed this fact, but that should be irrelevant to essentially
> everything except the fault handler.
> 
> So just refcount the thing the obvious way: take a reference when you
> stick the PASID in the mm_struct and drop the reference in __mmdrop().
> Problem solved.  You could probably drop it more aggressively in
> __mmput(), and the comment explaining why is left as an exercise to the
> reader -- if a kernel thread starts doing ENQCMD, we have worse things
> to worry about :)

That doesn't match well with the non-x86 usage of PASIDs. The code there
bumps the reference count on each device bind, and decrements on each
device unbind.

If we don't keep a reference count for each task that has IA32_PASID
set up we could have this sequence

1) Process binds to a PASID capable device
2) Task uses ENQCMD, so PASID MSR is set up.
3) Process unbinds the device, reference count on PASID
   goes to zero. PASID is freed. PASID is reallocated to
   another task.
4) Task from step #2 uses ENQCMD to submit a descriptor
   and device now processes virtual addresses based on mappings
   in the new task.

Now you might say that at step 3 we need to hunt down all the
tasks that have PASID enabled and disabled ... but that's the
same painful code that we avoided when we said that we would
not make Linux hand out a PASID to all existing tasks in a
process on the first bind operation.

-Tony
