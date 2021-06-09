Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A673A1CB1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 20:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFIS0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 14:26:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:5409 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhFIS0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:26:37 -0400
IronPort-SDR: BQPObcTQ1veR7s2ct4h2H+DWJ7D9cofV+LP3yKX0Z9qSIu9OX1GCHzfWksi2BiPWRpBjW+ZjMF
 L+Eygq6MHnkw==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192451371"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="192451371"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 11:24:41 -0700
IronPort-SDR: PE4eEItNyeuEV/cqnhmmDF53gAgoQBEtYZMbX+QcIcsjCv66N0FLFYYqHoRMluLdUNq5oqEZy+
 YLQRt8N2Pz1w==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="402530751"
Received: from davidhok-mobl3.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.9.9])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 11:24:41 -0700
Subject: Re: [RFC v2-fix-v4 1/1] x86/tdx: Skip WBINVD instruction for TDX
 guest
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
 <20210609011030.751451-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4gLeKPfYOx1kmg-mO1_mNd+XGqVO-CbqX+2d52GZ+DSFw@mail.gmail.com>
 <682f0239-8da0-3702-0f14-99b6244af499@linux.intel.com>
 <CAPcyv4jfFPGm2-cvPExeujZnaSKKky3AQRp69tzG1gcZ09dj8A@mail.gmail.com>
 <ffedf1d2-e5ec-e0e3-8e83-edd186231029@linux.intel.com>
 <CAPcyv4haWYhqk_xLD56QnB0ahK+fynOmqGdSD907UW-=7B176g@mail.gmail.com>
 <c2f4254d-3d28-544a-efd2-e65dd40d99f1@kernel.org>
 <59484871-8ef1-b7c3-fb29-b143bd53f074@linux.intel.com>
 <CAPcyv4hrwOuSBS9g+9=zetaCKY2=4J1e7ky1w9aojTJq9CNFQg@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <973add45-9fd2-7abc-3a97-96a26c263ea0@linux.intel.com>
Date:   Wed, 9 Jun 2021 11:24:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hrwOuSBS9g+9=zetaCKY2=4J1e7ky1w9aojTJq9CNFQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/21 10:31 AM, Dan Williams wrote:
>> If you want to apply this fix for all hypervisors (using boot_cpu_has
>> (X86_FEATURE_HYPERVISOR) check), then we don't need any TDX specific
>> reference in commit log right? It can be generalized for all VM guests.
>>
>> agree?
> No, because there is a note needed about the integrity implications in
> the TDX case that makes it distinct from typical hypervisor enabling.

Generalized the commit log (but left the TDX related info). Final version
will look like below.

x86: Skip WBINVD instruction for VM guest

VM guests that supports ACPI, use standard ACPI mechanisms to signal sleep
state entry (including reboot) to the host. The ACPI specification mandates
WBINVD on any sleep state entry with the expectation that the platform is
only responsible for maintaining the state of memory over sleep states, not
preserving dirty data in any CPU caches. ACPI cache flushing requirements
pre-date the advent of virtualization. Given guest sleep state entry does not
affect any host power rails it is not required to flush caches. The host is
responsible for maintaining cache state over its own bare metal sleep state
transitions that power-off the cache. A TDX guest, unlike a typical guest,
will machine check if the CPU cache is powered off.

--- a/arch/x86/include/asm/acenv.h
+++ b/arch/x86/include/asm/acenv.h
@@ -10,10 +10,15 @@
  #define _ASM_X86_ACENV_H

  #include <asm/special_insns.h>
+#include <asm/cpu.h>

  /* Asm macros */

-#define ACPI_FLUSH_CPU_CACHE() wbinvd()
+#define ACPI_FLUSH_CPU_CACHE()                         \
+do {                                                   \
+       if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))      \
+               wbinvd();                               \
+} while (0)

  int __acpi_acquire_global_lock(unsigned int *lock);
  int __acpi_release_global_lock(unsigned int *lock);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
