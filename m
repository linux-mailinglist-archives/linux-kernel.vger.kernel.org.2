Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101D8417840
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 18:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347307AbhIXQOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:14:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:43617 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347225AbhIXQOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:14:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="220906272"
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="220906272"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 09:12:49 -0700
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="559676132"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 09:12:49 -0700
Date:   Fri, 24 Sep 2021 16:12:43 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <YU34+1J4v0cn9ZRs@otcwcpicx3.sc.intel.com>
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

Hi, Thomas,

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

There are up to 1M PASIDs because PASID is 20-bit. I think there are a few ways
to allocate and free PASID:

1. Statically allocate a PASID once a mm is created and free it in mm
   exit. No PASID allocation/free during the mm's lifetime. Then
   up to 1M processes can be created due to 1M PASIDs limitation.
   We don't want this method because the 1M processes limitation.

2. A PASID is allocated to the mm in open(dev)->bind(dev, mm). There
   are three ways to free it:
   (a) Actively free it in close(fd)->unbind(dev, mm) by sending
       IPIs to tell all tasks using the PASID to clear the IA32_PASID
       MSR. This has locking issues similar to the actively loading
       IA32_PASID MSR which was force disabled in upstream. So won't work.
   (b) Passively free the PASID in destroy_context(mm) in mm exit. Once
       the PASID is allocated, it stays with the process for the lifetime. It's
       better than #1 because the PASID is allocated only on demand.
   (c) Passively free the PASID in deactive_mm(mm) or unbind() whenever there
       is no usage as implemented in this series. Tracking the PASID usage
       per task provides a chance to free the PASID on task exit. The
       PASID has a better chance to be freed earlier than mm exit in #(b).

This series uses #2 and #(c) to allocate and free the PASID for a better
chance to ease the 1M PASIDs limitation pressure. For example, a thread
doing open(dev)->ENQCMD->close(fd)->exit(2) will not occupy a PASID while
its sibling threads are still running.

Thanks.

-Fenghua
