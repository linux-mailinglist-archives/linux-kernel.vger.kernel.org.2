Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E9F4296FE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 20:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhJKSk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 14:40:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:30833 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhJKSk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 14:40:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="250332208"
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="250332208"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 11:38:57 -0700
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="440901786"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.255.229.69]) ([10.255.229.69])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 11:38:56 -0700
Message-ID: <2c03ae77-640e-fc25-a65b-2416f090281d@linux.intel.com>
Date:   Mon, 11 Oct 2021 11:38:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v10 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config
 option
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211011181948.fkt7o2fezmuyynze@treble>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20211011181948.fkt7o2fezmuyynze@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/2021 11:19 AM, Josh Poimboeuf wrote:
> On Fri, Oct 08, 2021 at 10:37:38PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> +config INTEL_TDX_GUEST
>> +	bool "Intel Trusted Domain Extensions (TDX) Guest Support"
>> +	depends on X86_64 && CPU_SUP_INTEL && PARAVIRT
>> +	depends on SECURITY
>> +	depends on X86_X2APIC
>> +	help
>> +	  Provide support for running in a trusted domain on Intel processors
>> +	  equipped with Trusted Domain Extensions. TDX is a Intel technology
>> +	  that extends VMX and Memory Encryption with a new kind of virtual
>> +	  machine guest called Trust Domain (TD). A TD is designed to run in
>> +	  a CPU mode that protects the confidentiality of TD memory contents
>> +	  and the TD’s CPU state from other software, including VMM. TDX guest
>> +	  uses virtual X2APIC for interrupt management.
> Why does it depend on SECURITY?  It should at least be explained in the
> commit message.

It can be dropped, it was only needed in an earlier version that used a LSM.

-Andi

>
