Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6722344EB3C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhKLQUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:20:44 -0500
Received: from mga03.intel.com ([134.134.136.65]:37882 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233793AbhKLQUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:20:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10166"; a="233100337"
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="233100337"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 08:17:52 -0800
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="670694016"
Received: from harshilp-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.57.123])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 08:17:51 -0800
Subject: Re: [PATCH v8 08/11] x86/tdx: Wire up KVM hypercalls
To:     Sean Christopherson <seanjc@google.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-9-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YYWbJVTNr5QMTQGb@google.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <f516ee8f-508d-79e8-55c0-54491fd6f8d6@linux.intel.com>
Date:   Fri, 12 Nov 2021 08:17:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YYWbJVTNr5QMTQGb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Isaku

Hi Isaku/Kirill,

On 11/5/21 1:59 PM, Sean Christopherson wrote:
> Why use a magic string?  There are already mechanisms for the host to announce
> itself to the guest, i.e. the guest shouldn't be attempting these hypercalls unless
> it knows it's running on KVM (or something that implements KVM's ABI, whatever
> that may be).
> 
> The only use case I can think of is to support multiple flavors of hypercalls in
> the VMM, e.g. to let KVM support both KVM and Hyper-V hypercalls when KVM is
> masquerading as Hyper-V, but this magic value alone isn't sufficient.
> 
> And if there is a future where KVM wants to support multiple sets of hypercalls,
> using the entire 64-bit GPR for a magic value is unnecessary and wasteful, e.g.
> it requires an overside MOV imm, reg.
> 
> Why not use a single high bit?  Actually, looking at KVM's set of hypercalls,
> the guest can literally pass @nr as is.  The GHCI defines all non-zero values as
> vendor owned, i.e. this needs to ensure only that @nr is non-zero.  For whatever
> reason, perhaps to avoid false positives if the guest forgets to fill the value,
> KVM's hypercalls start at '1'.
> 
> Regardless of what is stuffed into r10 for the TDVMCALL, if it's anything other
> than KVM's raw hypercall number, it absolutely must go into
> include/uapi/linux/kvm_para.h and it should be done as a standalone commit,
> because what you're proposing here is effectively committing KVM to supporting
> an ABI.  That is not remotely clear from the changelog.


Do you see any issues with using a single bit or just passing the @nr as
it is?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
