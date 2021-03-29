Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD39734DBFF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 00:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhC2WnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 18:43:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:45995 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230161AbhC2WnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:43:01 -0400
IronPort-SDR: IrDIstuF2mvzeRV3NeguReGOO8PwuvjxQIv0fthU9O08kFh0QXiFN85del6LRrYW/NrQor1Jef
 ZMdA6EyCvdXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="211842365"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="211842365"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 15:42:59 -0700
IronPort-SDR: rAzl/u12UhV5AsFp1B8Fst+yy4vupG/DRj2BhmvDTxDGCd/hloM55dj6uXNd6RBZnCkpyVAHuu
 U4we0eHzQB9g==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="444814260"
Received: from ajzangar-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.145.70])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 15:42:58 -0700
Subject: Re: [PATCH v2 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <91C0F6F1-B8C3-4130-B903-C63CD4B87F3F@amacapital.net>
 <ed7e96ba7a271e36bdfe61ee34c6d61eb78000c5.1616885306.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <498f078c-5196-a608-7f1a-8425ff056135@intel.com>
 <8e02ce39-f672-e652-b314-418b7ec5f52a@linux.intel.com>
 <d4fe4a10-7c29-5f26-25d2-b23369c38f3e@intel.com>
 <dac078b4-e50c-42b9-db52-6dc65b99406e@linux.intel.com>
 <0356a84a-765e-b20b-2efd-c5d94fc2347e@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <bab2b4b1-fa65-ecb9-e275-3e5ca4008d43@linux.intel.com>
Date:   Mon, 29 Mar 2021 15:42:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0356a84a-765e-b20b-2efd-c5d94fc2347e@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/21 3:12 PM, Dave Hansen wrote:
> On 3/29/21 3:09 PM, Kuppuswamy, Sathyanarayanan wrote:
>>>>>> +    case EXIT_REASON_MWAIT_INSTRUCTION:
>>>>>> +        /* MWAIT is supressed, not supposed to reach here. */
>>>>>> +        WARN(1, "MWAIT unexpected #VE Exception\n");
>>>>>> +        return -EFAULT;
>>>>>
>>>>> How is MWAIT "supppressed"?
>>>> I am clearing the MWAIT feature flag in early init code. We should also
>>>> disable this feature in firmware.
>>>> setup_clear_cpu_cap(X86_FEATURE_MWAIT);
>>>
>>> I'd be more explicit about that.  Maybe even reference the code that
>>> clears the X86_FEATURE.
>> This change is part of the same patch.
> 
> Right, but if someone goes and looks at the switch() statement in 10
> years is it going to be obvious how MWAIT was "suppressed"?
Ok. I can add a comment line for it.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
