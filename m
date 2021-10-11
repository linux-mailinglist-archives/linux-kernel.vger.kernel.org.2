Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5344294C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 18:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhJKQv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 12:51:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:20202 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhJKQv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 12:51:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="287797930"
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="287797930"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 09:49:16 -0700
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="440871699"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.255.229.69]) ([10.255.229.69])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 09:49:15 -0700
Message-ID: <924d36a6-480b-2ef4-4691-dc010ed82d45@linux.intel.com>
Date:   Mon, 11 Oct 2021 09:49:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v8 06/11] x86/traps: Add #VE support for TDX guest
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
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
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAJhGHyAqapG2MHfANeHG+LFHYr3a8AcHtbxcL3xUR_rmEOTqiQ@mail.gmail.com>
 <YWRS41aZH9A6fekt@google.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <YWRS41aZH9A6fekt@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Minor clarification: it eliminates the chance of a #VE during the syscall gap
> _if the VMM is benign_.  If the VMM is malicious, it can unmap and remap the
> syscall page to induce an EPT Violation #VE due to the page not being accepted.

This has been addressed. The TDX module will support a mode that forbids 
unmapping pages permanently, and Linux is going to check/enforce that 
this mode is enabled. The patch for the check is not included in the 
posted patches yet though.


>
> This question?
>
>    Can the hypervisor cause an already-accepted secure-EPT page to transition to
>    the unaccepted state?
>
> Yep.  I wrote the above before following the link, I should have guessed which
> question it was :-)
>
> IIRC, the proposed middle ground was to add a TDCALL and/or TDPARAMS setting that
> would allow the guest to opt-out of EPT Violation #VE due to page not accepted,

It's a TDPARAMS setting


-Andi

