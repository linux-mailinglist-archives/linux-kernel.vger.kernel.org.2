Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B820E3F320A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhHTRMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:12:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:8940 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhHTRME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:12:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="216813830"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="216813830"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 10:11:25 -0700
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="506529849"
Received: from jmorauga-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.135.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 10:11:24 -0700
Subject: Re: [PATCH v5 04/12] x86/tdx: Add protected guest support for TDX
 guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210804181329.2899708-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQsNpG55v7dhFqIb@google.com>
 <9c576f24-e6de-f816-623d-408a4a2ae747@intel.com>
 <4f28fe6e-a8ce-e444-51db-d0eb564eca8f@linux.intel.com>
 <YQsX54MPVYFuLmFr@google.com>
 <ca4aa25c-7d88-9812-4852-ced3274493a8@linux.intel.com>
 <YRTTZU3Pzm/1tH9M@zn.tnic>
 <486afc0e-0396-e57b-63fe-31a8433bd603@linux.intel.com>
 <YR+78mxnKW0T9Vdv@zn.tnic>
 <d419406e-749a-f851-f65e-a6582462c8a2@linux.intel.com>
 <YR/fYu6kn7DKpOCi@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <8129ef50-467f-fe2e-c770-a32c690c5177@linux.intel.com>
Date:   Fri, 20 Aug 2021 10:11:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR/fYu6kn7DKpOCi@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/21 9:59 AM, Borislav Petkov wrote:
> Err, why?
> 
> TDX is Intel technology. That's like asking to have
> 
> sev_prot_guest_has() and amd_prot_guest_has() on AMD.
> 
> Maybe I still don't get what you're trying to achieve but from where I'm
> standing that sounds wrong.

My intention was to keep intel_* function clean and hide all TDX specific
customization in tdx_* function (within in tdx.c) and call it from
intel_* function (within cpu/intel.c).

But I understand your point as well. I am fine with moving TDX specific checks to
intel_* function.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
