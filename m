Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF3D389AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 02:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhETAoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 20:44:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:23486 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhETAoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 20:44:08 -0400
IronPort-SDR: G38rjGFrGFMmIzzq9zSCNC2FIEZ1lw/drxLgd6EpiBa3jQzXLFvPUTldfqmz/ybLwpYqjAWJvF
 O/yBrfwJ7Q4w==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="198020388"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="198020388"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 17:42:48 -0700
IronPort-SDR: TzleCD93hzaPE30Lz10g4uMxhaIwdyf3PTd+7AgAJv1TskKUfgnh170Od6xUu2Y47a9tPldA0l
 fa7nnbaIzsOw==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="411964025"
Received: from ccheung-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.97.108])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 17:42:47 -0700
Subject: Re: [RFC v2-fix 1/1] x86/boot: Add a trampoline for APs booting in
 64-bit mode
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@intel.com>
References: <CAPcyv4ipWTv7yRyLHA0Un0KZDdXjpCZXMbrEn7SJXbdRhhn=jA@mail.gmail.com>
 <20210518005404.258660-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4hvFe5v72zm5+4mpmsv1u4pEizXMCcjFysKZAEkkOSrGw@mail.gmail.com>
 <861a316c-09f6-5969-6238-e402fca917db@linux.intel.com>
 <CAPcyv4hv4brS7Vp4rjtnPvF5z7FDuEQkCp+sQ0q6FOxpnKCYCA@mail.gmail.com>
 <a92f339b-3e37-0988-06b0-d290c656dc52@linux.intel.com>
 <CAPcyv4hpn+fmeZT+=EiD0G0Hw1iYqhUh4_cdhnT1i-BBcN_tsQ@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <2977129b-c568-8ce5-9a85-31473096719f@linux.intel.com>
Date:   Wed, 19 May 2021 17:42:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hpn+fmeZT+=EiD0G0Hw1iYqhUh4_cdhnT1i-BBcN_tsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/21 5:40 PM, Dan Williams wrote:
> I would clarify how the boot code uses this:
> 
> "When a bootloader hands off to the kernel in 32-bit mode an IDT with
> a 2-byte limit and 4-byte base is needed. When a boot loader hands off
> to a kernel 64-bit mode the base address extends to 8-bytes. Reserve
> enough space for either scenario."

I will add it. Thanks.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
