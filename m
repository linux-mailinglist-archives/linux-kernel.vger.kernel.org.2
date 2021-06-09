Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6153A165F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbhFIODM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:03:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:8950 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233544AbhFIODM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:03:12 -0400
IronPort-SDR: PA/E2CPZ2H2n+MCJjPJVxySwpebn0NQ0Mdw7CKqtSWtqfrchjO1U70O1d4mVFmOOVMrPeXAKnM
 E1j+6tVkHuAQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="184764552"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="184764552"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 07:01:17 -0700
IronPort-SDR: 7urlEGBKJViTW/EwOgU4kVm2CQSLxbgs7NQ0UxHwew0xQv9U2IG/gfWYHWIqLSKL9O4ZJP3isV
 aHBSFX8VICLg==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="402450855"
Received: from davidhok-mobl3.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.9.9])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 07:01:15 -0700
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstraction
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLkcIuL2qvo0hviU@zn.tnic>
 <82f9e5a9-682a-70be-e5ea-938bb742265f@linux.intel.com>
 <YL5kvLvCpG37zWc/@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <9466ae0b-3a2a-5a43-a4c6-39e07ebe0fbc@linux.intel.com>
Date:   Wed, 9 Jun 2021 07:01:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YL5kvLvCpG37zWc/@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/21 11:26 AM, Borislav Petkov wrote:
>> This header only exists in x86 arch code. So it is better to protect
>> it with x86 specific header file.
> That doesn't sound like a special reason to me. And compilers are
> usually very able at discarding unused symbols so I don't see a problem
> with keeping all includes at the top, like it is usually done.

I am still not clear. What happens when a driver which includes
linux/protected-guest.h is compiled for non-x86 arch (s390 or arm64)?

Since asm/sev.h and asm/tdx.h exists only in x86_64 arch, IMO, it
should be placed under CONFIG_INTEL_TDX_GUEST or CONFIG_AMD_MEM_ENCRYPT

did I miss anything?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
