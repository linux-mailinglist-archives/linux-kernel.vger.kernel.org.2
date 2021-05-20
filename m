Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABF038BA5E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 01:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhETX0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 19:26:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:31362 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233032AbhETX0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 19:26:37 -0400
IronPort-SDR: 3RneZUIdDGPwtyOlirvVkVI8C6gDd8hfR1V0vAk+Tmi8bl+ja7z1auSRzvyiX/NxevVs+3nMp7
 sbDAtqfOZvog==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="201068151"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="201068151"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 16:25:15 -0700
IronPort-SDR: J0gOtlZQ8GZdPG3UzlJ6lHZEb4Yr2tMFcw7ka/cKgseryEAxeiLaLoNP/pirWnN/07FfVamb3/
 oEs0rl4Dd86g==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="475437911"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.197.177]) ([10.212.197.177])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 16:25:15 -0700
Subject: Re: [RFC v2 27/32] x86/tdx: Exclude Shared bit from __PHYSICAL_MASK
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <87b31425b79df3cc44d2bdc6a79d6aa36c42d116.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3ae38a0b-0676-1543-7015-39a589b2807a@intel.com>
 <0df80c0f-e0da-e86e-0ab8-abc58f0da559@linux.intel.com>
 <YKa5gkwGTIUFpzzH@google.com>
 <b27a6d31-8fd9-e650-0adf-5f7a8fc96a1c@linux.intel.com>
 <YKbDtt2K4Z5gtYRc@google.com>
 <f348c391-c665-2987-898c-718d2c53729f@linux.intel.com>
 <YKbSOJOKBV1Rjb0T@google.com>
 <283b3d47-f1f6-3c53-0909-ba0540993203@intel.com>
 <6d508f80-4a76-64c2-9772-da23bb467e0b@linux.intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <0bcb46ed-4bdf-9a82-3bdc-2c4d5ffcb627@linux.intel.com>
Date:   Thu, 20 May 2021 16:25:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <6d508f80-4a76-64c2-9772-da23bb467e0b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/20/2021 2:28 PM, Kuppuswamy, Sathyanarayanan wrote:
>
>
> On 5/20/21 2:23 PM, Dave Hansen wrote:
>> Sathya has even mis-typed "tdx" instead of "tdg" this in his own
>> changelogs up to this point.  That massively weakens the argument that
>> "tdg" is a good idea.
>
> It is not a typo. But when we did the initial rename from "tdx_" -> 
> "tdg_",
> somehow I missed the change log change. That's why I am bit reluctant
> to go for another rename (since we have scan change log, comments and 
> code)
> in all the patches.


Yes I agree. If there's another rename it should be after a full review 
by all the maintainers. If there is still consensus that a rename is 
needed then it can be done then.

And we'll just hope that Sean's brain will get used to tdg_ by then.


-Andi

