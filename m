Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844353799FA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhEJWYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:24:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:24460 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhEJWYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:24:14 -0400
IronPort-SDR: ArUwDwcoZr7K/2Ls0g0RBHWUOAnb8OCGD01iCuqEFz47vhD82naffFp2MgVKVVkfI83gRLY0Nj
 NRbZfDQcIJbQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="196208612"
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="196208612"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 15:23:08 -0700
IronPort-SDR: v9D5f0p3E1j4UcRjtDlD/DpbLQYbBoYivf/K6TAGzj3oiSW1o9KUsYftWnU9wyPt9CO/qmifZl
 26qv90sygVeg==
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="609256490"
Received: from kcmorris-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.165.53])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 15:23:07 -0700
Subject: Re: [RFC v2 28/32] x86/tdx: Make pages shared in ioremap()
To:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <eaaa692ce1ed897f66f864bbfa2df8683768d79e.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <b884067a-19d6-105f-9f8c-28feb3b43446@intel.com>
 <312879fb-d201-a16d-2568-150152044c54@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <797c95bf-9516-8aee-59d0-f5259d77bb75@linux.intel.com>
Date:   Mon, 10 May 2021 15:23:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <312879fb-d201-a16d-2568-150152044c54@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 5/7/21 3:38 PM, Andi Kleen wrote:
> 
> On 5/7/2021 2:55 PM, Dave Hansen wrote:
>> On 4/26/21 11:01 AM, Kuppuswamy Sathyanarayanan wrote:
>>>   static unsigned int __ioremap_check_encrypted(struct resource *res)
>>>   {
>>> -    if (!sev_active())
>>> +    if (!sev_active() && !is_tdx_guest())
>>>           return 0;
>> I think it's time to come up with a real name for all of the code that's
>> under: (sev_active() || is_tdx_guest()).
>>
>> "encrypted" isn't it, for sure.
> 
> I called it protected_guest() in some other patches.

If you are also fine with above mentioned function name, I can include it
in this series. Since we have many use cases of above condition, it will
be useful define it as helper function.

> 
> -Andi
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
