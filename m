Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8F43A1840
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbhFIO6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:58:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:34554 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238665AbhFIO6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:58:30 -0400
IronPort-SDR: Ely1pydhf3aoBfmZCW96vnlSNGdmRvv/UR5KaKKyLsFpkQqbBDI8Us318srSkwCTxYjwUq1aHh
 IE9C5hB5KyxA==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="268941346"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="268941346"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 07:56:17 -0700
IronPort-SDR: 6txSjpr6D+kqPJpYe/nUtdYtEsWip7PyNeKc1J07KBC/Xw1TIh/0Nbmm8HB8IXZJimudE2xer4
 LA9r+gDodfBA==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="402464762"
Received: from davidhok-mobl3.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.9.9])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 07:56:17 -0700
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstraction
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLkcIuL2qvo0hviU@zn.tnic>
 <82f9e5a9-682a-70be-e5ea-938bb742265f@linux.intel.com>
 <YL5kvLvCpG37zWc/@zn.tnic>
 <9466ae0b-3a2a-5a43-a4c6-39e07ebe0fbc@linux.intel.com>
 <YMDRDmO751Dc2igX@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <040a760a-de34-f184-1157-0c8c2d5fcacd@linux.intel.com>
Date:   Wed, 9 Jun 2021 07:56:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMDRDmO751Dc2igX@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/21 7:32 AM, Borislav Petkov wrote:
> On Wed, Jun 09, 2021 at 07:01:13AM -0700, Kuppuswamy, Sathyanarayanan wrote:
>> I am still not clear. What happens when a driver which includes
>> linux/protected-guest.h is compiled for non-x86 arch (s390 or arm64)?
> 
> I was wondering what felt weird: why is prot{ected,}_guest_has() in a
> generic linux/ namespace header and not in an asm/ one?
> 
> I think the proper way is for the other arches should be to provide
> their own prot_guest_has() implementation which generic code uses and
> the generic header would contain only the PR_GUEST_* defines.
> 
> Take ioremap() as an example:
> 
> arch/x86/include/asm/io.h
> arch/arm64/include/asm/io.h
> arch/s390/include/asm/io.h
> ...
> 
> and pretty much every arch has that arch-specific io.h header which
> defines ioremap() and generic code includes include/linux/io.h which
> includes the respective asm/io.h header so that users can call the
> respective ioremap() implementation.
> 
> prot_guest_has() sounds just the same to me.

ioremap() is required for all architectures. So I think adding support for it
and creating io.h for every arch seems valid. But are you sure every arch cares
about protected guest support?

IMHO, its better to leave it to arch maintainers to decide if they want
to support protected guest or not.

This can be easily achieved by defining generic arch independent config
option ARCH_HAS_PORTECTED_GUEST.

And any arch which wants to support prot_guest_has() can enable above
config option and create their own asm/protected_guest.h

This model is similar to linux/mem_encrypt.h.

With above suggested change, header file will look like below. And we
don't need implement asm/protected_guest.h for every available arch.

--- a/include/linux/protected_guest.h
+++ b/include/linux/protected_guest.h

#ifndef _LINUX_PROTECTED_GUEST_H
#define _LINUX_PROTECTED_GUEST_H 1

/* Protected Guest Feature Flags (leave 0-0xff for arch specific flags) */

/* Support for guest encryption */
#define PR_GUEST_MEM_ENCRYPT			0x100
/* Encryption support is active */
#define PR_GUEST_MEM_ENCRYPT_ACTIVE		0x101
/* Support for unrolled string IO */
#define PR_GUEST_UNROLL_STRING_IO		0x102
/* Support for host memory encryption */
#define PR_GUEST_HOST_MEM_ENCRYPT		0x103
/* Support for shared mapping initialization (after early init) */
#define PR_GUEST_SHARED_MAPPING_INIT		0x104

#ifdef ARCH_HAS_PROTECTED_GUEST
#include <asm/protected_guest.h>
#else
static inline bool prot_guest_has(unsigned long flag) { return false; }
#endif

#endif /* _LINUX_PROTECTED_GUEST_H */


> 
> Better?
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
