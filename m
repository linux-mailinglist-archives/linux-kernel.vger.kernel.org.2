Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFEF39927E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhFBS1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:27:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:42858 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhFBS1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:27:31 -0400
IronPort-SDR: tVlssgAe9yFKLFLYOXGmAW27oC3D1hOoRGiWhTAWFkPz1ouGl8H7J5rpYM+J2E3uADXCVNdtPq
 /AmHa13j2gVg==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="265037822"
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="265037822"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 11:25:47 -0700
IronPort-SDR: VVsyhCtSAfniCgZoAi8WEAq1CFWJswCeyVmKtdYKbUkIvJwN79WSKJGVS7LpXvWJ9FeZbBTIdm
 3Ka4Iuz7PCww==
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="416996201"
Received: from sboinap-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.150.149])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 11:25:46 -0700
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstraction
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLe92NXx1jZPtPqB@google.com> <3036a655-9d09-0f04-62a2-7a72ba9af5c7@amd.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <ebd50589-2cc3-6b6e-37ec-5bc968c40fe3@linux.intel.com>
Date:   Wed, 2 Jun 2021 11:25:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3036a655-9d09-0f04-62a2-7a72ba9af5c7@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/21 11:15 AM, Tom Lendacky wrote:
> The original suggestion from Boris, IIRC, was for protected_guest_has()
> function (below) to be:
> 
> 	if (intel)
> 		return intel_protected_guest_has();

Yes. But for Intel, I think currently we can only check for is_tdx_guest() here.

if (is_tdx_guest())
	return intel_protected_guest_has();

So if we use is_tdx_guest(), it is better to call tdx_protected_guest_has() here.

Once we start using protected_guest_has for other Intel technologies, may be
we can generalize it. Let me know your comments.

> 	else if (amd)
> 		return amd_protected_guest_has();
> 	else
> 		return false;
> 
> And then you could check for TDX or SME/SEV in the respective functions.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
