Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01F7387E61
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 19:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351131AbhERR3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 13:29:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:21213 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351129AbhERR3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 13:29:20 -0400
IronPort-SDR: lUob1hYAOZ7oRnit9ikS1OcM1338DxmU3xVowpPmteEkkGUTX5SE9hD5mWAxQO7UkEECZSFiH6
 9KTvybhb0F/g==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200826730"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="200826730"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 10:28:01 -0700
IronPort-SDR: jFrZ9cGVo6RbkPKXe5TRhoN+XDajbUVbCBa4omSA9oz9rO5fnw8PzK4j0FiASIESg1KVX0zze3
 RYwXubFKy0tA==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439535045"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.65.183]) ([10.209.65.183])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 10:28:01 -0700
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Handle in-kernel MMIO
From:   Andi Kleen <ak@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210518004807.258503-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <36cd2665-6d8b-9c0b-eec1-25152dcca2a3@intel.com>
 <43e583a3-ee2b-52d8-5275-e26a6609c126@linux.intel.com>
 <94dc5a5a-8c51-8624-5810-e6278783789c@intel.com>
 <c07e1f1e-f93d-dbc6-f7bb-11c7488f4e2f@linux.intel.com>
Message-ID: <b5089180-1b73-cd1b-98a2-c3cc624d2e5c@linux.intel.com>
Date:   Tue, 18 May 2021 10:28:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c07e1f1e-f93d-dbc6-f7bb-11c7488f4e2f@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/18/2021 9:10 AM, Andi Kleen wrote:
>
>>>>> For now we only handle a subset of instructions that the kernel
>>>>> uses for MMIO operations. User-space access triggers SIGBUS.
>>>> How do you know which instructions the kernel uses?
>>> They're all in MMIO macros.
>> I've heard exactly the opposite from the TDX team in the past. What I
>> remember was a claim that one can not just leverage the MMIO macros as a
>> single point to avoid MMIO.  I remember being told that not all code in
>> the kernel that does MMIO uses these macros.  APIC MMIO's were called
>> out as a place that does not use the MMIO macros.
>
> Yes x86 APIC has its own macros, but we don't use the MMIO based APIC, 
> only X2APIC in TDX.

I must correct myself here. We actually use #VE to handle MSRs, or at 
least those that are not context switched by the TDX module. So there 
can be #VE nested in NMI in normal operation, since MSR accesses in NMI 
can happen.

I don't think it needs any changes to the code -- this should all work 
-- but we need to update the commit log to document this case.


-Andi


