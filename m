Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1023B38CDC0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbhEUSrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:47:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:48945 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230475AbhEUSrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:47:03 -0400
IronPort-SDR: EMNIrF9KjjvYBBB7VPsJgSBwbF2hV21Cez5vQxBJ1P/87TBzfJydmdR0XQz6bbi3JSo6pNIhHk
 qstQo3GcOWpg==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="188945231"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="188945231"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 11:45:38 -0700
IronPort-SDR: zYtKor2tIH9weos2UI9ud325LLu8UaEUYPQjPmBo7Xw8lJTZjyB/HzMlPCrQE5mN1uIH7sMu8k
 57wpSyhcfCMQ==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441197292"
Received: from orxpovpvmu02.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.181.51])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 11:45:38 -0700
Subject: Re: [RFC v2-fix 1/1] x86/traps: Add #VE support for TDX guest
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <afd85e8f-ab26-aa3b-e4e9-a0b3bfd472c8@intel.com>
 <20210518000957.257869-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <3573599f-56bc-f21e-7a7e-0d441ab9d68e@linux.intel.com>
Date:   Fri, 21 May 2021 11:45:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210518000957.257869-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 5/17/21 5:09 PM, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov"<kirill.shutemov@linux.intel.com>
> 
> Virtualization Exceptions (#VE) are delivered to TDX guests due to
> specific guest actions which may happen in either user space or the kernel:
> 
>   * Specific instructions (WBINVD, for example)
>   * Specific MSR accesses
>   * Specific CPUID leaf accesses
>   * Access to TD-shared memory, which includes MMIO
> 
> In the settings that Linux will run in, virtual exceptions are never
> generated on accesses to normal, TD-private memory that has been
> accepted.
> 
> The entry paths do not access TD-shared memory, MMIO regions or use
> those specific MSRs, instructions, CPUID leaves that might generate #VE.
> In addition, all interrupts including NMIs are blocked by the hardware
> starting with #VE delivery until TDGETVEINFO is called.  This eliminates
> the chance of a #VE during the syscall gap or paranoid entry paths and
> simplifies #VE handling.
> 
> After TDGETVEINFO #VE could happen in theory (e.g. through an NMI),
> although we don't expect it to happen because we don't expect NMIs to
> trigger #VEs. Another case where they could happen is if the #VE
> exception panics, but in this case there are no guarantees on anything
> anyways.
> 
> If a guest kernel action which would normally cause a #VE occurs in the
> interrupt-disabled region before TDGETVEINFO, a #DF is delivered to the
> guest which will result in an oops (and should eventually be a panic, as
> we would like to set panic_on_oops to 1 for TDX guests).
> 
> Add basic infrastructure to handle any #VE which occurs in the kernel or
> userspace.  Later patches will add handling for specific #VE scenarios.
> 
> Convert unhandled #VE's (everything, until later in this series) so that
> they appear just like a #GP by calling ve_raise_fault() directly.
> ve_raise_fault() is similar to #GP handler and is responsible for
> sending SIGSEGV to userspace and cpu die and notifying debuggers and
> other die chain users.
> 
> Co-developed-by: Sean Christopherson<sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson<sean.j.christopherson@intel.com>
> Signed-off-by: Kirill A. Shutemov<kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen<ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>
> ---

You have any other comments on this patch? If not, can you reply with your
Reviewed-by tag?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
