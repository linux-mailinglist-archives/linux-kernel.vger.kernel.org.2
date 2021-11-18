Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616B445522F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 02:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242244AbhKRB3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 20:29:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:42880 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232650AbhKRB3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 20:29:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="297512297"
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="297512297"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 17:26:17 -0800
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="454859205"
Received: from rsyep-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.140.227])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 17:26:16 -0800
Subject: Re: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
To:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
References: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
 <YZVLVfd5E6d6YQig@hirez.programming.kicks-ass.net>
 <20211117184225.6e257nfpdd2qhrj4@box.shutemov.name>
 <4824bf30-851e-c927-a50f-87fa2a429b2a@linux.intel.com>
 <YZVOfGtHyiZg1pIP@zn.tnic>
 <980ceab6-6686-c8f3-72b8-5743ca517bdf@linux.intel.com>
 <0f0b9784-1902-1526-2796-7d1a7ab17fb6@intel.com>
 <21f1325d-d97e-1bb7-ea87-d84e44089ab4@linux.intel.com>
 <YZVvdyHhPTzzZbiu@zn.tnic>
 <d826f932-a6a4-de7d-b0ea-f8e1f9bfe012@linux.intel.com>
 <99c70f8d-3275-8aed-5bb3-8b386dcb5e82@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d3fa3c72-b420-0b5c-f385-bad1d56fcd0d@linux.intel.com>
Date:   Wed, 17 Nov 2021 17:26:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <99c70f8d-3275-8aed-5bb3-8b386dcb5e82@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/21 3:33 PM, Dave Hansen wrote:
> On 11/17/21 3:04 PM, Sathyanarayanan Kuppuswamy wrote:
>> 1. Directly substitute TDVMCALLs in places where we require emulation.
> ...
>> Since option#1 is not a scalable approach,
> 
> Why is this not "scalable"?  Just eyeballing the problem, here's my
> laptop's kernel:

I meant it not scalable because, for any new use case of HLT
instruction, it would need substitution again. We cannot always keep
tracking its uses in the future, right?

Also, If we make any changes to the core emulation code (like arguments
change), we will have to re-touch these use cases to handle it.

If this approach is taken to add some performance benefit, then it
makes sense.  But for our case, I think it is simpler to use PV ops.



> 
> $ objdump  -d vmlinux | grep 'hlt ' | awk -F: '{print $1}' |  while read
> addr; do  addr2line -e vmlinux $addr; done
> arch/x86/include/asm/irqflags.h:51
> arch/x86/include/asm/irqflags.h:51
> arch/x86/include/asm/irqflags.h:57
> arch/x86/include/asm/irqflags.h:57
> arch/x86/include/asm/irqflags.h:57
> arch/x86/include/asm/irqflags.h:57
> arch/x86/include/asm/irqflags.h:51
> arch/x86/include/asm/irqflags.h:51
> arch/x86/include/asm/irqflags.h:51
> arch/x86/kernel/fpu/init.c:84
> arch/x86/include/asm/irqflags.h:57
> 
> There are a grand total of 3 sites from which a hlt originates.  With
> only 11 possible instances and 3 sites to patch, I'm not sure anything
> here needs to be "scalable".
> 
> I'd suspect half these sites aren't even reachable on a TDX system.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
