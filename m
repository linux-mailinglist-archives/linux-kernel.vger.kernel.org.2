Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B966F388148
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240786AbhERUWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:22:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:16598 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236196AbhERUW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:22:29 -0400
IronPort-SDR: L7L+9drAfoa2hq8CVm9MEteJnHEedOcnLGJpSGYLdlKdb0Gk6sbeHB/M7N8tJtiXkF0qm/991l
 dhSmmaIifQNA==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="180413889"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="180413889"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 13:20:51 -0700
IronPort-SDR: 1s+fv5Q7+YbZ5bkbCM73lxZjqaM9gP9ICHbVeEH2kjoelySdebsULAN4dv8/hprsFScixOL1Ob
 xCZHXkM0H6XA==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439616846"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.65.183]) ([10.209.65.183])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 13:20:50 -0700
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Handle in-kernel MMIO
To:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210518004807.258503-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <36cd2665-6d8b-9c0b-eec1-25152dcca2a3@intel.com>
 <43e583a3-ee2b-52d8-5275-e26a6609c126@linux.intel.com>
 <YKP1Xty7EEzHkZ6Y@google.com>
 <8fb0e52c-ed0a-2185-585a-27007c27ed56@linux.intel.com>
 <d711ca30-ff84-2efa-4b9e-d9b46f53c0a5@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <a46544ba-e995-1e95-4e62-e9f48eec0db1@linux.intel.com>
Date:   Tue, 18 May 2021 13:20:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d711ca30-ff84-2efa-4b9e-d9b46f53c0a5@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/18/2021 10:46 AM, Dave Hansen wrote:
> On 5/18/21 10:21 AM, Andi Kleen wrote:
>> Besides instruction decoding works fine for all the existing
>> hypervisors. All we really want to do is to do the same thing as KVM
>> would do.
> Dumb question of the day: If you want to do the same thing that KVM
> does, why don't you share more code with KVM?  Wouldn't you, for
> instance, need to crack the same instruction opcodes?

We're talking about ~60 lines of codes that calls an established 
standard library.

https://github.com/intel/tdx/blob/8c20c364d1f52e432181d142054b1c2efa0ae6d3/arch/x86/kernel/tdx.c#L490

You're proposing a gigantic refactoring to avoid 60 lines of straight 
forward code.

That's not a practical proposal.

>
> I'd feel a lot better about this if you said:
>
> 	Listen, this doesn't work for everything.  But, it will run
> 	every single driver as a TDX guest that KVM can handle as a
> 	host.  So, if the TDX code is broken, so is the KVM host code.

I don't really know what problem you're trying to solve here. We only 
have a small number of drivers and we tested them and they work fine. 
There are special macros that limit the number of instructions. If there 
are ever more instructions and the macros break somehow we'll add them. 
There will be a clean error if it ever happens. We're not trying to 
solve hypothetical problems here.

-Andi


