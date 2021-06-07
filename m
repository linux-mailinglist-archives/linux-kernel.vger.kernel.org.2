Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E48F39E49E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 18:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhFGRBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:01:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:36609 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230287AbhFGRBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:01:04 -0400
IronPort-SDR: 7doATfue6PVbLF6UumkoHh6CAyQvmojjgLXBGqMynRRSLjYUwDFozR2d+PU4ab5DSYUSrdd+as
 pLQT9zjJ+uCg==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="265814342"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="265814342"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 09:59:12 -0700
IronPort-SDR: MOgdgZ32XVkW3V6jQYrgfxki8Qd5VFax9bsoN2uVQHdf5fIatbXg1/F8PNdO3mbxHvV4ymvaFZ
 rsuZTYPoE4Pw==
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="619007404"
Received: from ssanje1x-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.251.153.170])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 09:59:11 -0700
Subject: Re: [PATCH v1 03/11] x86/cpufeatures: Add TDX Guest CPU feature
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210602022136.2186759-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <dc064764-7736-33c7-7a32-b4dec68eb745@amd.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <f2019557-3e2a-dd91-a858-b60732c0bf23@linux.intel.com>
Date:   Mon, 7 Jun 2021 09:59:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <dc064764-7736-33c7-7a32-b4dec68eb745@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/21 7:32 AM, Tom Lendacky wrote:
>> +	tdx_early_init();
>> +
> Just a real minor nit, but does this have to be after kasan_early_init()?
> If not, keeping the SME/SEV/TDX calls "together" might read clearer. So
> just moving it up before kasan_early_init() will group them.

We have more patches in this series, and they are dependent on some
boot command line options. So we will eventually move tdx_early_init()
below copy_bootdata(__va(real_mode_data))

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
