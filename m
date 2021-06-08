Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2ED039FED2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbhFHSUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:20:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:5806 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232521AbhFHSUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:20:03 -0400
IronPort-SDR: XduQUeL01uRYfR/tqmiAi3uw65J0pbR4Qgaio/DuP4ebUAtnEL+zNgWcq7s8JIDUp1ct8g7sb3
 VkaZ5Wrz/qXA==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="204930586"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="204930586"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 11:18:08 -0700
IronPort-SDR: oLWSWDovY6EX4fhKDWjYRH4gwvxj6M++fHPgwwbd2Ic4wnVhE9BwgGKGf4lJnRWFmTeugmcxSi
 C1lEdAszhcXg==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="551702593"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.24.11]) ([10.209.24.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 11:18:08 -0700
Subject: Re: [RFC v2 08/32] x86/traps: Add #VE support for TDX guest
To:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <8a1d6930f784cb57c957cf20cea870947db91e05.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <fe05830e-e82b-f338-2ba1-02651cb8087e@intel.com>
 <YL+tfGOMWEvDJTwc@google.com>
 <42f6b603-7c21-28fa-b6ec-e53268aa6ff7@intel.com>
 <3afaebee-77dc-83ff-c397-aa64991c52be@linux.intel.com>
 <4635488d-b98b-330f-1485-fecfcf6e72ff@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <a9a5c603-d9ac-b422-5ffd-834cf7e52ed8@linux.intel.com>
Date:   Tue, 8 Jun 2021 11:18:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <4635488d-b98b-330f-1485-fecfcf6e72ff@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/8/2021 11:15 AM, Dave Hansen wrote:
> On 6/8/21 11:12 AM, Andi Kleen wrote:
>> I believe neither does mmio/msr normally (except maybe
>> ftrace+tp_printk, but that will likely work because it shouldn't
>> recurse more than once due to ftrace's reentry protection)
> Can it do MMIO:
>
>> +DEFINE_IDTENTRY(exc_virtualization_exception)
>> +{
> =======> HERE
>> +    ret = tdg_get_ve_info(&ve);
> Recursion isn't the problem.  It would double-fault there, right?

Yes that's right. tp_printk already has a lot of other corner cases that 
break though, so it's not a real issue.

-Andi

