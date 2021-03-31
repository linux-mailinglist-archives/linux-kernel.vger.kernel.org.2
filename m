Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720F5350A3E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 00:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhCaW3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 18:29:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:65505 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232356AbhCaW3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:29:01 -0400
IronPort-SDR: JcedoJInlTVCj0BsNXI2e7scTy29Fqo8AcSJZjlIQ2IiiDdirf/ej2PUl5EP22rLgb1MRl8cDD
 Carzr3NlERAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="171519342"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="171519342"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 15:29:00 -0700
IronPort-SDR: rggyjLaZ054D0F0Tf3SJWQaFT5jD6r/HD0fsEAPJqBJ1TnF3qP+gciBG23FlV2gYGvIczOgMLH
 Iqv/OljLYUew==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="394233606"
Received: from sjard-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.174.17])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 15:29:00 -0700
Subject: Re: [PATCH v4 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <2FE32855-EA5D-44E4-AACC-25E9B1476547@amacapital.net>
 <e62cfd0ae90de435e6819979d9027f76d835a22a.1617224710.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YGTvSvr2T2v3t3XA@google.com>
 <5d961c25-3dee-4a5d-4bba-a97d157a5a49@intel.com>
 <YGTyWUQbxVZeeko+@google.com>
 <d8078f5d-735c-2b0f-98eb-663be2118762@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <ef49222a-8ffc-dacc-4f21-3bd1ef13a2ac@linux.intel.com>
Date:   Wed, 31 Mar 2021 15:28:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d8078f5d-735c-2b0f-98eb-663be2118762@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/21 3:11 PM, Dave Hansen wrote:
> On 3/31/21 3:06 PM, Sean Christopherson wrote:
>> I've no objection to a nice message in the #VE handler.  What I'm objecting to
>> is sanity checking the CPUID model provided by the TDX module.  If we don't
>> trust the TDX module to honor the spec, then there are a huge pile of things
>> that are far higher priority than MONITOR/MWAIT.
> 
> In other words:  Don't muck with CPUID or the X86_FEATURE at all.  Don't
> check it to comply with the spec.  If something doesn't comply, we'll
> get a #VE at *SOME* point.  We don't need to do belt-and-suspenders
> programming here.
> 
> That sounds sane to me.
But I think there are cases (like MCE) where SEAM does not disable them because
there will be future support for it. We should at-least suppress such features
in kernel.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
