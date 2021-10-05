Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88F0422B78
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhJEOu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:50:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:4380 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235322AbhJEOu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:50:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="249022710"
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="249022710"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 07:48:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="656587448"
Received: from cthurman-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.18.154])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 07:48:27 -0700
Subject: Re: [PATCH v8 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config option
To:     Borislav Petkov <bp@alien8.de>,
        Sathyanarayanan Kuppuswamy Natarajan 
        <sathyanarayanan.nkuppuswamy@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <cf33750f-615a-1edd-0fee-28e720bb38ce@infradead.org>
 <CAC41dw-U85dCGDm_QzyyOQfhbbaZZ5m9CvLuDjdXjuxEyid8qw@mail.gmail.com>
 <YVxdhtRbJfd9feA4@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <ba068e29-aefd-8e78-48e0-5431abd93f31@linux.intel.com>
Date:   Tue, 5 Oct 2021 07:48:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVxdhtRbJfd9feA4@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/21 7:13 AM, Borislav Petkov wrote:
> On Tue, Oct 05, 2021 at 06:29:43AM -0700, Sathyanarayanan Kuppuswamy Natarajan wrote:
>> For the TDX guest, x2apic will be emulated. So it will exist in our
>> case. Even if x2apic or TDX guest is not supported by CPU, it will
>> boot just fine.
> 
> Sure but why is it "select" and not "depends"?
> 
> Why does X86_X2APIC need to be selected while the others are "depends"?

Since x2APIC will always exist in TDX guest case, we have used select to
enable the support. But since we have dependency on it, I  think "depends"
might be a better choice.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
