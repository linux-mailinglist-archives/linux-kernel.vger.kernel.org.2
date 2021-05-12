Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6298137BE30
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhELNZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:25:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:12642 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230452AbhELNZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:25:34 -0400
IronPort-SDR: Nu+QsXIE7qdmqG/fTUk6Cgwn7D0wNwqq6IHOISjz4ht5hWl6w8vqxqY4YiSofqgh4hl1aDl1k2
 TRblAWEjDKrQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="179295096"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="179295096"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 06:24:19 -0700
IronPort-SDR: g5AGXqEVqXD86+BSNrf0+aPS2nAh12n9UL131agrsM+8vWFTN8KzEJ8zRdtoSZicQoVVyN5LbM
 B3JHV7Vr5/bg==
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="400105510"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.126.19]) ([10.209.126.19])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 06:24:18 -0700
Subject: Re: [RFC v2 01/32] x86/paravirt: Introduce CONFIG_PARAVIRT_XL
To:     Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <4f8c9559dd04d8e8485c419c5ebc9471613f7928.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YIhKXcNuinL0ar0O@zn.tnic> <f62354fe-e202-ad38-5466-03e79954f757@suse.com>
 <a24884ac-452e-751f-fb3e-82b3a9978ed1@linux.intel.com>
 <41463493-48bb-0e69-dcb2-3072e2ddf208@suse.com>
 <YJvVwXqGZWrXWPvP@hirez.programming.kicks-ass.net>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <f1ae9d97-a23e-d902-4ddb-6ec7b5d8cb91@linux.intel.com>
Date:   Wed, 12 May 2021 06:24:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJvVwXqGZWrXWPvP@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/12/2021 6:18 AM, Peter Zijlstra wrote:
> On Mon, May 10, 2021 at 05:56:05PM +0200, Juergen Gross wrote:
>
>> No. We have PARAVIRT_XXL for Xen PV guests, and we have PARAVIRT for
>> other hypervisor's guests, supporting basically the TLB flush operations
>> and time related operations only. Adding the halt related operations to
>> PARAVIRT wouldn't break anything.
> Also, I don't think anything modern should actually ever hit any of the
> HLT instructions, most everything should end up at an MWAIT.
>
> Still, do we wants to give arch_safe_halt() and halt() the
> PVOP_ALT_VCALL0() treatment?

 From performance reasons it's pointless to patch. HLT (and MWAIT) are 
so slow anyways that using patching or an indirect pointer is completely 
in the noise. So I would use whatever is cleanest in the code.

-Andi



