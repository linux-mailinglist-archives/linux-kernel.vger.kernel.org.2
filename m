Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B47A4177F8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 17:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347269AbhIXPlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 11:41:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:16216 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347246AbhIXPlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 11:41:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="287766991"
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="287766991"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 08:39:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="551854501"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 08:39:28 -0700
Date:   Fri, 24 Sep 2021 08:39:24 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YU3xLNJsSjIEpocT@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <20210922210722.GV4323@worktop.programming.kicks-ass.net>
 <YUy2AmabA4ODOgAC@agluck-desk2.amr.corp.intel.com>
 <YU3UkvNdzCqAANSY@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU3UkvNdzCqAANSY@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 03:37:22PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 23, 2021 at 10:14:42AM -0700, Luck, Tony wrote:
> > On Wed, Sep 22, 2021 at 11:07:22PM +0200, Peter Zijlstra wrote:
> > > On Mon, Sep 20, 2021 at 07:23:45PM +0000, Fenghua Yu wrote:
> > > > @@ -538,6 +547,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
> > > >  
> > > >  	cond_local_irq_enable(regs);
> > > >  
> > > > +	if (user_mode(regs) && fixup_pasid_exception())
> > > > +		goto exit;
> > > > +
> > 
> > > So you're eating any random #GP that might or might not be PASID
> > > related. And all that witout a comment... Enlighten?
> > 
> > This is moderately well commented inside the fixup_pasid_exception()
> > function. Another copy of the comments here at the call-site seems
> > overkill.
> 
> +static bool fixup_pasid_exception(void)
> +{
> +       if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> +               return false;
> +
> +       return __fixup_pasid_exception();
> +}
> 
> /me goes looking for comments in that function, lemme get out the
> electron microscope, because I can't seem to spot them with the naked
> eye.

If you have ctags installed then a ctrl-] on that
__fixup_pasid_exception() will take you to the function with
the comments. No electron microscope needed.

+
+/*
+ * Try to figure out if there is a PASID MSR value to propagate to the
+ * thread taking the #GP.
+ */
+bool __fixup_pasid_exception(void)
+{
+       u32 pasid;
+
+       /*
+        * This function is called only when this #GP was triggered from user
+        * space. So the mm cannot be NULL.
+        */
+       pasid = current->mm->pasid;
+
+       /* If no PASID is allocated, there is nothing to propagate. */
+       if (pasid == PASID_DISABLED)
+               return false;
+
+       /*
+        * If the current task already has a valid PASID MSR, then the #GP
+        * fault must be for some non-ENQCMD related reason.
+        */
+       if (current->has_valid_pasid)
+               return false;
+
+       /* Fix up the MSR by the PASID in the mm. */
+       fpu__pasid_write(pasid);
+       current->has_valid_pasid = 1;
+
+       return true;
+}

-Tony
