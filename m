Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276C4387CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350397AbhERPsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:48:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:39725 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350318AbhERPq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:46:59 -0400
IronPort-SDR: W+3ucHEq/3pSbifLHjail9pJ2xUNz9R3IlgAITLKVxxnZjP+hoVPhGsN+FAE6F8dJIfjDI9u/y
 54UUwRX2JyeQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="286276347"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="286276347"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 08:45:11 -0700
IronPort-SDR: J9dsPtbby4SXKSNBWfssLgT5WjxAbZ3aGBDqhM9LswFO5Fi103DeP9fWngToYkEB+1kjRSKFC0
 ARYWrU7NxepA==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439495053"
Received: from msaber-mobl.amr.corp.intel.com (HELO [10.209.65.183]) ([10.209.65.183])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 08:45:11 -0700
Subject: Re: [RFC v2-fix 1/1] x86/traps: Add #VE support for TDX guest
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
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <afd85e8f-ab26-aa3b-e4e9-a0b3bfd472c8@intel.com>
 <20210518000957.257869-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <4fc32900-412d-fa10-520e-afa6caade33e@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <81c0f447-44b8-c2b6-ce41-a39ec0a1832b@linux.intel.com>
Date:   Tue, 18 May 2021 08:45:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <4fc32900-412d-fa10-520e-afa6caade33e@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/18/2021 8:11 AM, Dave Hansen wrote:
> On 5/17/21 5:09 PM, Kuppuswamy Sathyanarayanan wrote:
>> After TDGETVEINFO #VE could happen in theory (e.g. through an NMI),
>> although we don't expect it to happen because we don't expect NMIs to
>> trigger #VEs. Another case where they could happen is if the #VE
>> exception panics, but in this case there are no guarantees on anything
>> anyways.
> This implies: "we do not expect any NMI to do MMIO".  Is that true?  Why?

Only drivers that are not supported in TDX anyways could do it (mainly 
watchdog drivers)

panic is an exception, but that has been already covered.

-Andi



