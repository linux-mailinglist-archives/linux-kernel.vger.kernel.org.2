Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3CA38B822
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbhETUOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:14:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:52814 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233675AbhETUOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:14:24 -0400
IronPort-SDR: XdQ4xIC0XhtdNbr2rStTFbweZr3Mr/UjNcnh4Jubfq38ixePmP2dacq5dRhASxMUqmfdLdLxJ7
 4GasDXB4FBUQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="286857636"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="286857636"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 13:13:02 -0700
IronPort-SDR: PFMPvpd4Uj3LcG5c8OukCx6maliUMMhlb+FaQCXIQcziEQ3CnQlgO9OAsZ7v3sMBXzHpB26+iT
 jUhgvX8E8tLA==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="440602602"
Received: from shaunnab-mobl2.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.65.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 13:13:01 -0700
Subject: Re: [RFC v2 28/32] x86/tdx: Make pages shared in ioremap()
To:     Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <eaaa692ce1ed897f66f864bbfa2df8683768d79e.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <b884067a-19d6-105f-9f8c-28feb3b43446@intel.com>
 <312879fb-d201-a16d-2568-150152044c54@linux.intel.com>
 <797c95bf-9516-8aee-59d0-f5259d77bb75@linux.intel.com>
 <5b4b4fc0-aaa8-3407-6602-537d59572bc1@intel.com>
 <YJm5QY8omAvdpBO9@google.com> <YJpP/S8MajKNhBl4@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <0e233779-9c10-11df-b527-ef61e003ea35@linux.intel.com>
Date:   Thu, 20 May 2021 13:12:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJpP/S8MajKNhBl4@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/21 2:35 AM, Borislav Petkov wrote:
> Preach brother!:)
> 
> /me goes and greps mailboxes...
> 
> ah, do you mean this, per chance:
> 
> https://lore.kernel.org/kvm/20210421144402.GB5004@zn.tnic/
> 
> ?
> 
> And yes, this has "sev" in the name and dhansen makes sense to me in
> wishing to unify all the protected guest feature queries under a common
> name. And then depending on the vendor, that common name will call the
> respective vendor's helper to answer the protected guest aspect asked
> about.
> 
> This way, generic code will call
> 
> 	protected_guest_has()
> 
> or so and be nicely abstracted away from the underlying implementation.
> 
> Hohumm, yap, sounds nice to me.
> 
> Thx.

I see many variants of SEV/SME related checks in the common code path
between TDX and SEV/SME. Can a generic call like
protected_guest_has(MEMORY_ENCRYPTION) or is_protected_guest()
replace all these variants?

We will not be able to test AMD related features. So I need to confirm
it with AMD code maintainers/developers before making this change.

arch/x86/include/asm/io.h:313:	if (sev_key_active() || is_tdx_guest()) {			\
arch/x86/include/asm/io.h:329:	if (sev_key_active() || is_tdx_guest()) {			\
arch/x86/kernel/pci-swiotlb.c:52:	if (sme_active() || is_tdx_guest())
arch/x86/mm/ioremap.c:96:	if (!sev_active() && !is_tdx_guest())
arch/x86/mm/pat/set_memory.c:1984:	if (!mem_encrypt_active() && !is_tdx_guest())

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
