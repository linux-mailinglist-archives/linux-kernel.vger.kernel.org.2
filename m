Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D6A3EA955
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbhHLRTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:19:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:28815 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229905AbhHLRTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:19:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="215395118"
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="215395118"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 10:18:40 -0700
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="517535725"
Received: from smachee-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.169.15])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 10:18:40 -0700
Subject: Re: [PATCH v5 04/12] x86/tdx: Add protected guest support for TDX
 guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
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
 <ca4aa25c-7d88-9812-4852-ced3274493a8@linux.intel.com>
 <YRTTZU3Pzm/1tH9M@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <486afc0e-0396-e57b-63fe-31a8433bd603@linux.intel.com>
Date:   Thu, 12 Aug 2021 10:18:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRTTZU3Pzm/1tH9M@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/21 12:53 AM, Borislav Petkov wrote:
>>> Given amd_prot_guest_has(), my guess is Boris intended intel_prot_guest_has()...
> Yap, exactly.

I can implement intel_prot_guest_has() in arch/x86/kernel/cpu/intel.c. And call
tdx_prot_guest_has() from it.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
