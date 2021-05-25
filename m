Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2B538F6FB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 02:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhEYAbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 20:31:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:23242 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhEYAbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 20:31:22 -0400
IronPort-SDR: nJPTPfkrsan9OevJceyiionwN2rO6qMyXuXreTnplJwHdRlCbiwoCs8aSIobsH6r57AvfeUqG0
 2pDQkv6lLcIQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="223225906"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="223225906"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 17:29:51 -0700
IronPort-SDR: 9mSnlww6VoH7H7Iq/bSBAc877sWZX1OCE5sTDwndxDkuOCI5WYiTvlRC+hlt3Fzx/SuNQYH15w
 jHggnMT3e0mA==
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="396607630"
Received: from akatzin-mobl4.ger.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.71.138])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 17:29:50 -0700
Subject: Re: [RFC v2-fix-v2 2/2] x86/tdx: Ignore WBINVD instruction for TDX
 guest
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <37ad50ca-f568-4c62-56e2-9e9b1f34084c@linux.intel.com>
 <20210524233211.802033-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210524233211.802033-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jKY0rmewFnyL6My5-b+w8ANAwDY2tLXZk4CYKydoVbtg@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <b420a7af-5202-fee9-9e0b-39680d0cc9c8@linux.intel.com>
Date:   Mon, 24 May 2021 17:29:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jKY0rmewFnyL6My5-b+w8ANAwDY2tLXZk4CYKydoVbtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/21 4:39 PM, Dan Williams wrote:
>> Functionally only DMA devices can notice a side effect from
>> WBINVD's cache flushing. But, TDX does not support DMA,
>> because DMA typically needs uncached access for MMIO, and
>> the current TDX module always sets the IgnorePAT bit, which
>> prevents that.

> I thought we discussed that there are other considerations for wbinvd
> besides DMA? In any event this paragraph is actively misleading
> because it disregards ACPI and Persistent Memory secure-erase whose
> usages of wbinvd have nothing to do with DMA. I would much prefer a
> patch to shutdown all the known wbinvd users as a precursor to this
> patch rather than assuming it's ok to simply ignore it. You have
> mentioned that TDX does not need to use those paths, but rather than
> assume they can't be used why not do the audit to explicitly disable
> them? Otherwise this statement seems to imply that the audit has not
> been done.

But KVM also emulates WBINVD only if DMA is supported. Otherwise it
will be treated as noop.

static bool need_emulate_wbinvd(struct kvm_vcpu *vcpu)
{
         return kvm_arch_has_noncoherent_dma(vcpu->kvm);
}



-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
