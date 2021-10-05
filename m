Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854A8423230
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbhJEUkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:40:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:35125 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236488AbhJEUkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:40:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="225743607"
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="225743607"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 13:38:50 -0700
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="477832751"
Received: from rriesen-ivm.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.35.74])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 13:38:50 -0700
Subject: Re: [PATCH v8 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config option
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Sathyanarayanan Kuppuswamy Natarajan 
        <sathyanarayanan.nkuppuswamy@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <cf33750f-615a-1edd-0fee-28e720bb38ce@infradead.org>
 <CAC41dw-U85dCGDm_QzyyOQfhbbaZZ5m9CvLuDjdXjuxEyid8qw@mail.gmail.com>
 <YVxdhtRbJfd9feA4@zn.tnic>
 <ba068e29-aefd-8e78-48e0-5431abd93f31@linux.intel.com>
 <YVyLaLTK6MgLi/rS@zn.tnic> <20211005202146.s3ptxhabwyz3nacm@treble>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <93c2f2dc-5843-a5e8-de3c-05d38124ad8d@linux.intel.com>
Date:   Tue, 5 Oct 2021 13:38:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005202146.s3ptxhabwyz3nacm@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/21 1:21 PM, Josh Poimboeuf wrote:
> It would also be helpful to explain the dependencies (particularly
> X86_X2APIC and SECURITY_LOCKDOWN_LSM) in the commit message.

I think we no longer need CONFIG_SECURITY_LOCKDOWN_LSM. I will add some
details about X2APIC dependency.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
