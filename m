Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899F1423542
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 02:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbhJFAu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 20:50:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:56785 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230218AbhJFAuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 20:50:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="249162348"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="249162348"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 17:48:58 -0700
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="477916976"
Received: from rriesen-ivm.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.35.74])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 17:48:57 -0700
Subject: Re: [PATCH v8 09/11] x86/tdx: Add MSR support for TDX guest
To:     Josh Poimboeuf <jpoimboe@redhat.com>
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
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-10-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005232209.ozugpocq2cvx22li@treble>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <c0241c38-e27d-ad82-218b-8c9f77c0e736@linux.intel.com>
Date:   Tue, 5 Oct 2021 17:48:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005232209.ozugpocq2cvx22li@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/21 4:22 PM, Josh Poimboeuf wrote:
> This fails to build:
> 
> arch/x86/kernel/tdx.c: In function ‘tdx_write_msr_safe’:
> arch/x86/kernel/tdx.c:135:22: error: implicit declaration of function ‘tdx_is_context_switched_msr’ [-Werror=implicit-function-declaration]
>    135 |         WARN_ON_ONCE(tdx_is_context_switched_msr(msr));
>        |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/bug.h:104:32: note: in definition of macro ‘WARN_ON_ONCE’
>    104 |         int __ret_warn_on = !!(condition);                      \
>        |                                ^~~~~~~~~


Sorry, it looks like the removal is split across two patches. So I did not catch
it in my compilation test. I will fix this and repost it.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
