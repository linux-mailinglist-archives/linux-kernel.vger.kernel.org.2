Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5351F42371F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 06:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhJFEfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 00:35:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:19894 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhJFEf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 00:35:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="225806613"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="225806613"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 21:33:37 -0700
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="589623039"
Received: from ptcotton-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.211.164])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 21:33:37 -0700
Subject: Re: [PATCH v8 03/11] x86/cpufeatures: Add TDX Guest CPU feature
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005210423.yfftpxxmj3cjprtv@treble>
 <15a07997-2659-6be1-b8a3-da57e72562b5@linux.intel.com>
 <20211006034218.ynamwigsvpgad7sr@treble>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <f15d1b41-e4fb-0203-88f7-dbac3f4e5307@linux.intel.com>
Date:   Tue, 5 Oct 2021 21:33:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006034218.ynamwigsvpgad7sr@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/21 8:42 PM, Josh Poimboeuf wrote:
>> is_tdx_guest was mainly introduced to support cc_platform_has()
>> API in early boot calls (similar to sme_me_mask in AMD code).
>> Regarding FEATURE flag it will be useful for userspace tools to
>> check the TDX feature support.
> FEATURE flags can also be checked in the kernel, with boot_cpu_has().
> Or am I missing something?

Yes, previously we have been using x86_feature_enabled() check in
cc_platform_has() call. Now with the introduction of is_tdx_guest
global variable, we don't use it in kernel. But I still want to
keep the feature flag for user space use case.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
