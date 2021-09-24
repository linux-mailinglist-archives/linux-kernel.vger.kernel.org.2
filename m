Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3BA41783D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 18:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347324AbhIXQNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:13:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:13102 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347225AbhIXQNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:13:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="285115864"
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="285115864"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 09:12:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="559675914"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 09:12:08 -0700
Date:   Fri, 24 Sep 2021 09:12:07 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Message-ID: <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com>
 <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com>
 <87o88jfajo.ffs@tglx>
 <87k0j6dsdn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0j6dsdn.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 03:18:12PM +0200, Thomas Gleixner wrote:
> On Thu, Sep 23 2021 at 19:48, Thomas Gleixner wrote:
> > On Thu, Sep 23 2021 at 09:40, Tony Luck wrote:
> >
> > fpu_write_task_pasid() can just grab the pasid from current->mm->pasid
> > and be done with it.
> >
> > The task exit code can just call iommu_pasid_put_task_ref() from the
> > generic code and not from within x86.
> 
> But OTOH why do you need a per task reference count on the PASID at all?
> 
> The PASID is fundamentaly tied to the mm and the mm can't go away before
> the threads have gone away unless this magically changed after I checked
> that ~20 years ago.

It would be possible to avoid a per-task reference to the PASID by
taking an extra reference when mm->pasid is first allocated using
the CONFIG_PASID_TASK_REFS you proposed yesterday to define a function
to take the extra reference, and another to drop it when the mm is
finally freed ... with stubs to do nothing on architectures that
don't create per-task PASID context.

This solution works, but is functionally different from Fenghua's
proposal for this case:

	Process clones a task
	task binds a device
	task accesses device using PASID
	task unbinds device
	task exits (but process lives on)

Fenghua will free the PASID because the reference count goes
back to zero. The "take an extra reference and keep until the
mm is freed" option would needlessly hold onto the PASID.

This seems like an odd usage case ... even if it does exist, a process
that does this may spawn another task that does the same thing.

If you think it is sufficiently simpler to use the "extra reference"
option (invoking the "perfect is the enemy of good enough" rule) then we
can change.

-Tony
