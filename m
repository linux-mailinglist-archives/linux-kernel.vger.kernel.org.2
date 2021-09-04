Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7C2400895
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 02:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350756AbhIDAGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 20:06:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:9300 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240571AbhIDAGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 20:06:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="219245683"
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="219245683"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 17:05:01 -0700
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="447791653"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.143.21]) ([10.212.143.21])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 17:05:00 -0700
Subject: Re: [PATCH v6 11/11] x86/tdx: Handle CPUID via #VE
To:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
 <f0d52056-1749-9d21-8da1-041266ade437@linux.intel.com>
 <0be2590c-aad8-0d04-4f14-2081d9b66fbf@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <cb7e2ef2-29aa-4fef-b13e-42a517e2be21@linux.intel.com>
Date:   Fri, 3 Sep 2021 17:05:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0be2590c-aad8-0d04-4f14-2081d9b66fbf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/3/2021 5:00 PM, Dave Hansen wrote:
> On 9/3/21 4:54 PM, Andi Kleen wrote:
>> It means they are handled by the TDX module, but always have the same
>> contents as a native CPU would.
>>
>> As opposed to leaves that are modified by the TDX module.
> Is that distinction important for this patch?
It's not.
>
> Or, should we stick to the two-class taxonomy (#VE-inducing and not)
> that I suggested in my replacement changelog?


Seems fine.

-Andi

