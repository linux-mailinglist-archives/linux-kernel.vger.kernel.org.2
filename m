Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C1242C16E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhJMNe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:34:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:6646 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhJMNeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:34:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="313625336"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="313625336"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 06:32:17 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="486907483"
Received: from dravindr-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.11.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 06:32:16 -0700
Subject: Re: [PATCH v10 03/11] x86/cpufeatures: Add TDX Guest CPU feature
To:     Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
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
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YWaWSmWn6AZ6OLx+@zn.tnic>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuwamy@linux.intel.com>
Message-ID: <221e9a08-9380-5503-063c-897621757eb4@linux.intel.com>
Date:   Wed, 13 Oct 2021 06:32:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YWaWSmWn6AZ6OLx+@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/13/21 1:18 AM, Borislav Petkov wrote:
> On Fri, Oct 08, 2021 at 10:37:39PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> @@ -500,6 +501,14 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
>>   
>>   	copy_bootdata(__va(real_mode_data));
>>   
>> +	/*
>> +	 * A future dependency on cmdline parameters is expected (for
>> +	 * adding debug options). So the order of calling it should be
>> +	 * after copy_bootdata() (in which command line parameter is
>> +	 * initialized).
>> +	 */
> Plain and simple:
>
>          /*
>           * Keep this after copy_bootdata() so that TDX cmdline options can take
>           * effect.
>           */
ok. I will fix this in next version.
>
>
>> +	tdx_early_init();
>> +
>>   	/*
>>   	 * Load microcode early on BSP.
>>   	 */
>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>> new file mode 100644
>> index 000000000000..88bf12788684
>> --- /dev/null
>> +++ b/arch/x86/kernel/tdx.c
>> @@ -0,0 +1,38 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2020 Intel Corporation */
>> +
>> +#undef pr_fmt
>> +#define pr_fmt(fmt)     "tdx: " fmt
>> +
>> +#include <asm/tdx.h>
>> +
>> +bool is_tdx_guest(void)
>> +{
>> +	static int tdx_guest = -1;
> Put that one at the top of the file because such static variables do not
> belong among the automatic function vars.
ok. I will fix this in next version.
>
> Thx.
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

