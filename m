Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9854D41691F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 02:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243709AbhIXA7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 20:59:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:32524 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243693AbhIXA7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 20:59:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="224004327"
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="224004327"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 17:57:47 -0700
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="514332940"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 17:57:46 -0700
Date:   Fri, 24 Sep 2021 00:57:40 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] tools/objtool: Check for use of the ENQCMD
 instruction in the kernel
Message-ID: <YU0ihC6EYBZCSylV@otcwcpicx3.sc.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-8-fenghua.yu@intel.com>
 <20210922210343.GU4323@worktop.programming.kicks-ass.net>
 <YUu/6YPYwvaDwthy@otcwcpicx3.sc.intel.com>
 <YUwp7VkjApRQr/pb@hirez.programming.kicks-ass.net>
 <YUycliX+lPSMhWfR@otcwcpicx3.sc.intel.com>
 <20210924005540.kunsfif7hdta6dlp@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924005540.kunsfif7hdta6dlp@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Josh,

On Thu, Sep 23, 2021 at 05:55:40PM -0700, Josh Poimboeuf wrote:
> On Thu, Sep 23, 2021 at 03:26:14PM +0000, Fenghua Yu wrote:
> > > > +		} else if (op2 == 0x38 && op3 == 0xf8) {
> > > > +			if (insn.prefixes.nbytes == 1 &&
> > > > +			    insn.prefixes.bytes[0] == 0xf2) {
> > > > +				/* ENQCMD cannot be used in the kernel. */
> > > > +				WARN("ENQCMD instruction at %s:%lx", sec->name,
> > > > +				     offset);
> > > > +
> > > > +				return -1;
> > > > +			}
> > > 
> > > The only concern here is if we want it to be fatal or not. But otherwise
> > > this seems to be all that's required.
> > 
> > objtool doesn't fail kernel build on this fatal warning.
> > 
> > Returning -1 here stops checking the rest of the file and won't report any
> > further warnings unless this ENQCMD warning is fixed. Not returning -1
> > continues checking the rest of the file and may report more warnings.
> > Seems that's the only difference b/w them.
> > 
> > Should I keep this "return -1" or not? Please advice.
> 
> I'd say remove the "return -1" since it's not a fatal-type analysis
> error and there's nothing to prevent objtool from analyzing the rest of
> the file.

Sure. It does make sense to remove "return -1". I will remove it.

Thanks.

-Fenghua
