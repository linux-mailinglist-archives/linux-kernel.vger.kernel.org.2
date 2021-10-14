Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D8642DAB2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 15:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhJNNtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 09:49:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:50082 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhJNNtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:49:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="227961864"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="227961864"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 06:47:16 -0700
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="492000922"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.55.2]) ([10.209.55.2])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 06:47:15 -0700
Message-ID: <641e8b18-230d-699c-6ec5-1aa107d7d5bb@linux.intel.com>
Date:   Thu, 14 Oct 2021 06:47:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v10 10/11] x86/tdx: Don't write CSTAR MSR on Intel
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-11-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87czo77uia.ffs@tglx>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <87czo77uia.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> -	wrmsrl(MSR_CSTAR, (unsigned long)entry_SYSCALL_compat);
>> +	/*
>> +	 * CSTAR is not needed on Intel because it doesn't support
>> +	 * 32bit SYSCALL, but only SYSENTER. On a TDX guest
>> +	 * it leads to a #GP.
> Sigh. Above you write it raises #VE, but now it's #GP !?!


The unhandled #VE trap is handled like a #GP, which is then caught by 
the kernel wrmsr code.

So both are correct.

>
>          Intel CPUs do not support 32-bit SYSCALL. Writing to MSR_CSTAR
>          is normaly ignored by the CPU, but raises a #VE trap in a TDX
>          guest.
>
> Hmm?

