Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26E541AF6E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbhI1MzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:55:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:61875 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240774AbhI1MzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:55:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="224337407"
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="224337407"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 05:53:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="553981976"
Received: from oogunmoy-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.221.219])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 05:53:29 -0700
Subject: Re: [PATCH v6 03/11] x86/cpufeatures: Add TDX Guest CPU feature
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210903172812.1097643-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YVL+89mKRlK9PSQs@8bytes.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <bfb0f8df-221f-5337-258d-26655d505145@linux.intel.com>
Date:   Tue, 28 Sep 2021 05:53:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVL+89mKRlK9PSQs@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/21 4:39 AM, Joerg Roedel wrote:
> On Fri, Sep 03, 2021 at 10:28:04AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> +++ b/arch/x86/kernel/tdx.c
>> @@ -0,0 +1,29 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2020 Intel Corporation */
>> +
>> +#undef pr_fmt
>> +#define pr_fmt(fmt)     "x86/tdx: " fmt
> 
> The 'x86' is implicit already and don't need to be in the printk prefix.
> How about just 'tdx' or 'intel-tdx' instead?

I am fine with tdx. I will change it in next version.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
