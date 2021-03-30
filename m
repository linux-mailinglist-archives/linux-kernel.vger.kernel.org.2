Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E6B34EEEC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 19:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhC3RDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 13:03:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:1860 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232394AbhC3RC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:02:58 -0400
IronPort-SDR: yqCtB0NT7Dl6cK62gDm5QOSfsVcVL5SP5LlV6RJWKjJIKCwyNcxp3x8CigeZx1Zg8jQ/scjHKC
 aPCDm3XAyyDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="178943959"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="178943959"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 10:02:57 -0700
IronPort-SDR: mQj5NkXyBE8hml62gH62ZjnnvZ6pZAPDpvYStsZcTgi2dmBNmvt4wPndDdd4qQfqMp1AtrcjTu
 6A1BLFuxAdBw==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="516507520"
Received: from nmsaleng-mobl2.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.49.189])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 10:02:56 -0700
Subject: Re: [PATCH v1 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <CALCETrUgEFy4shmh_pxOTzEVJZq8y23zK7cr51UhXba0KhQ8qg@mail.gmail.com>
 <331b34e3d6153f0a7b0ab0a9a8cb5de71f0bfd93.1616803999.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d78f5f76-e04f-cab1-48f5-b6c1ba6a3811@intel.com>
 <20210330150048.GB1285835@tassilo.jf.intel.com>
 <840efd72-65b1-385c-e9a6-343410c85221@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <770415c9-38d7-08fc-e255-56c168967b7c@linux.intel.com>
Date:   Tue, 30 Mar 2021 10:02:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <840efd72-65b1-385c-e9a6-343410c85221@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/21 8:10 AM, Dave Hansen wrote:
> On 3/30/21 8:00 AM, Andi Kleen wrote:
>>>> +	/* MWAIT is not supported in TDX platform, so suppress it */
>>>> +	setup_clear_cpu_cap(X86_FEATURE_MWAIT);
>>> In fact, MWAIT bit returned by CPUID instruction is zero for TD guest. This
>>> is enforced by SEAM module.
>> Good point.
>>> Do we still need to safeguard it by setup_clear_cpu_cap() here?
>> I guess it doesn't hurt to do it explicitly.
> 
> If this MWAIT behavior (clearing the CPUID bit) is part of the guest
> architecture, then it would also be appropriate to WARN() rather than
> silently clearing the X86_FEATURE bit.
Makes sense. It will be useful to find the problem with TDX Module.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
