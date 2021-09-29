Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F7C41BC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 03:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243622AbhI2BRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 21:17:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:50798 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242636AbhI2BRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 21:17:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="221632191"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="221632191"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 18:16:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="562791541"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 18:16:09 -0700
Date:   Wed, 29 Sep 2021 01:16:08 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YVO+WAqroakEYI/D@otcwcpicx3.sc.intel.com>
References: <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
 <YVNj8sm8iectc6iU@agluck-desk2.amr.corp.intel.com>
 <3f97b77e-a609-997b-3be7-f44ff7312b0d@intel.com>
 <YVN652x14dMgyE85@agluck-desk2.amr.corp.intel.com>
 <f6014b16-7b4c-cbb6-c975-1ec34092956f@intel.com>
 <YVOg7zgpdQlc7Zjt@agluck-desk2.amr.corp.intel.com>
 <YVOp60LOL+bfh3iT@otcwcpicx3.sc.intel.com>
 <YVOuYAFaTG6Khotb@agluck-desk2.amr.corp.intel.com>
 <ae7a12650d2741f9970449a08721a28e@intel.com>
 <a60c365c7bca4c84942086939fd988d1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a60c365c7bca4c84942086939fd988d1@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tony,

On Tue, Sep 28, 2021 at 06:06:52PM -0700, Luck, Tony wrote:
> >> 	fpregs_lock();
> >
> > I'm afraid we may hit the same locking issue when we send IPI to notify another task to modify its
> > PASID state. Here the API is called to modify another running task's PASID state as well without a right lock.
> > fpregs_lock() is not enough to deal with this, I'm afraid.
> 
> We don't send IPI any more to change PASID state. The only place that the
> current patch series touches the PASID MSR is in the #GP fault handler.

It's safe for the helpers to handle the PASID case (modifying the current task's
PASID state in #GP).

But the helpers seem to be generic. They take "task" as a parameter and
handle the task as non-current case. So the helpers are not for PASID only.
They may be used by others to modify a running task's FPU state. But
It's not safe to do so.

At least need some comments/restriction for the helpers to be used on
a running task?

Thanks.

-Fenghua
