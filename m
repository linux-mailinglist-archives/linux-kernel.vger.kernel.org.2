Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AF93E0AAD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 01:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbhHDXAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 19:00:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:17519 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhHDXAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 19:00:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="214059107"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="214059107"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 16:00:21 -0700
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="512261135"
Received: from bguvendi-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.99.93])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 16:00:20 -0700
Subject: Re: [PATCH v5 04/12] x86/tdx: Add protected guest support for TDX
 guest
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQsNpG55v7dhFqIb@google.com>
 <9c576f24-e6de-f816-623d-408a4a2ae747@intel.com>
 <4f28fe6e-a8ce-e444-51db-d0eb564eca8f@linux.intel.com>
 <YQsX54MPVYFuLmFr@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <ca4aa25c-7d88-9812-4852-ced3274493a8@linux.intel.com>
Date:   Wed, 4 Aug 2021 16:00:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQsX54MPVYFuLmFr@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/21 3:42 PM, Sean Christopherson wrote:
> What other possible use case is there for invoking tdx_prot_guest_has() beyond
> running as a TDX guest?  If it were e.g. intel_prot_guest_has() then I would at
> least understand the code, if not agree with the sub-optimal approach, but as is
> it makes no sense.

Yes. I think his original intention is to implement intel_prot_guest_has() in
arch/x86/kernel/cpu/intel.c and then call tdx_prot_guest_has() from it. But since
we have no other use cases, we have called tdx_prot_*() directly here.

Boris, how do you want to proceed? Do you want me to implement intel_prot_guest_has()
or change comparison log to TDX specific?


> 
> Given amd_prot_guest_has(), my guess is Boris intended intel_prot_guest_has()...

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
