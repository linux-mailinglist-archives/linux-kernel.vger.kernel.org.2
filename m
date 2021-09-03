Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80F140087A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 01:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350474AbhICXzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 19:55:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:27142 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233868AbhICXzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 19:55:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="241829209"
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="241829209"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 16:54:05 -0700
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="447788053"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.143.21]) ([10.212.143.21])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 16:54:05 -0700
Subject: Re: [PATCH v6 11/11] x86/tdx: Handle CPUID via #VE
To:     Sean Christopherson <seanjc@google.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210903172812.1097643-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <24d0fe72-78b4-6550-e5d8-dd511dcbfef3@intel.com>
 <26e79e8f-ba96-9087-04dd-283eadd8c693@linux.intel.com>
 <YTKzFJYy0CECENRX@google.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <f0d52056-1749-9d21-8da1-041266ade437@linux.intel.com>
Date:   Fri, 3 Sep 2021 16:54:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTKzFJYy0CECENRX@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/3/2021 4:43 PM, Sean Christopherson wrote:
> On Fri, Sep 03, 2021, Kuppuswamy, Sathyanarayanan wrote:
>>
>> On 9/3/21 11:35 AM, Dave Hansen wrote:
>>> On 9/3/21 10:28 AM, Kuppuswamy Sathyanarayanan wrote:
>>>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>>>
>>>> TDX has three classes of CPUID leaves: some CPUID leaves are always
>>>> handled by the CPU, others are handled by the TDX module, and some
>>>> others are handled by the VMM. Since the VMM cannot directly intercept
>>>> the instruction these are reflected with a #VE exception to the guest,
>>>> which then converts it into a hypercall to the VMM, or handled
>>>> directly.
>>> Does this patch do any of the "handled directly" leaves?  If not, why
>>> mention it?
>> It was added to give more information about CPUID leaves handling. Since
>> it has nothing to do with this patch, I can remove it.
> What leaves are "always handled by the CPU"?  VTx doesn't allow disabling
> CPUID exiting, let alone conditionally exiting on a specific CPUID leaf.  I don't
> see anything in the TDX specs that suggests that's any different in SEAM non-root
> mode.

It means they are handled by the TDX module, but always have the same 
contents as a native CPU would.

As opposed to leaves that are modified by the TDX module.

-Andi

