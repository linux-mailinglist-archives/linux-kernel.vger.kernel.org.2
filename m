Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4DF454DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 20:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbhKQTQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 14:16:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:26895 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233430AbhKQTQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 14:16:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="232756651"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="232756651"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 11:13:54 -0800
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="672505716"
Received: from kkempf-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.255.92.124])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 11:13:53 -0800
Subject: Re: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
References: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
 <YZVLVfd5E6d6YQig@hirez.programming.kicks-ass.net>
 <20211117184225.6e257nfpdd2qhrj4@box.shutemov.name>
 <4824bf30-851e-c927-a50f-87fa2a429b2a@linux.intel.com>
 <YZVOfGtHyiZg1pIP@zn.tnic>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <980ceab6-6686-c8f3-72b8-5743ca517bdf@linux.intel.com>
Date:   Wed, 17 Nov 2021 11:13:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YZVOfGtHyiZg1pIP@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/21 10:48 AM, Borislav Petkov wrote:
> On Wed, Nov 17, 2021 at 10:46:30AM -0800, Sathyanarayanan Kuppuswamy wrote:
>> TDX has a requirement to use HLT paravirt calls (which is currently
>> listed under PARAVIRT_XXL). Once we submit a patch to move it
>> under CONFIG_PARAVIRT, we will drop this dependency.
> 
> You already have this patch in some set:
> 
> https://lore.kernel.org/r/20211009053747.1694419-2-sathyanarayanan.kuppuswamy@linux.intel.com
> 
> So what's this churn for?

Previously, we have posted ~45+ patches for TDX guest support. But we 
have noticed that submitting too many TDX patches at the same time seems
to complicates the review process.

So to make the review process simpler, we had planned to resubmit only a 
minimum set required to boot the TDX guest to user space (which comes 
around 25 patches).

Since moving HLT PV calls under CONFIG_PARAVIRT is an optimization fix
we did not include it in the minimal set.

If you think otherwise, please let me know. We will drop the use of
PARAVIRT_XXL and just use the above-mentioned patch.


> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
