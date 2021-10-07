Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E58842594B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhJGRYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:24:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:38039 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232418AbhJGRYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:24:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="213455361"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="213455361"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 10:22:20 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="624345044"
Received: from kgahmed1-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.67.99])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 10:22:18 -0700
Subject: Re: [PATCH v8 06/11] x86/traps: Add #VE support for TDX guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YV8pE+QYcS/fUe98@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <9693938e-4171-90ec-1bbe-ee88e6452bd0@linux.intel.com>
Date:   Thu, 7 Oct 2021 10:22:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YV8pE+QYcS/fUe98@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/21 10:06 AM, Borislav Petkov wrote:
> Same question as before - why do you need to clear this @out thing above
> when __tdx_module_call() will overwrite it?

Now checking again, I think we don't to initialize the @out pointer. I will
fix this in call cases.

But for tdx_get_ve_info() case, we are updating the @ve pointer without
checking the tdcall return value and __tdx_module_call() will update the
@out only if tdcall is successful. Currently due to @out=0 initialization,
this logic does not cause any issue. But to properly fix it, I need to
check for tdcall return value before updating the @ve value.

> 
> What you should do instead is check that @ve pointer which you get
> passed in - it might be NULL.

Current use case of tdx_get_ve_info() can never be NULL. But if you
want to add this check for possible future issues, I can do it.

arch/x86/kernel/traps.c:1205:	ret = tdx_get_ve_info(&ve);
arch/x86/kernel/tdx.c:945:	if (tdx_get_ve_info(&ve))


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
