Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5435139E993
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 00:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhFGW2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 18:28:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:20349 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbhFGW2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 18:28:48 -0400
IronPort-SDR: tan22k0OQbCP8nEBO8iRsSuiLRsf9f+diONMhKaGoIpHM2ZoselvMATxhn9Whhn2jm+GMHTwRW
 Rvd3UMDa6nrA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="191836117"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="191836117"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 15:26:55 -0700
IronPort-SDR: L1Oqxf6/YcrJyEasuyDTiubV0+zBzpPaR+R4cvg4+ud+99ycMSH3Ewdk0x8ansxYeg50vsFXuj
 2sHSiX+XAqGQ==
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="619091717"
Received: from ssanje1x-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.251.153.170])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 15:26:53 -0700
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstractionn
To:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLkcIuL2qvo0hviU@zn.tnic> <YLkcUts9dWDkDKpY@zn.tnic>
 <20210607195544.qlya6i5s2l2fkms2@box> <YL5+JkxaQbN4pNqD@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <fcc0d043-105b-79e4-f138-9888e7952549@linux.intel.com>
Date:   Mon, 7 Jun 2021 15:26:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YL5+JkxaQbN4pNqD@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/21 1:14 PM, Borislav Petkov wrote:
> On Mon, Jun 07, 2021 at 10:55:44PM +0300, Kirill A. Shutemov wrote:
>> I think conversions like this are wrong: relocate_kernel(), which got
>> called here, only knows how to deal with SME, not how to handle some
>> generic case.
> 
> What do you mean wrong? Wrong for TDX?
> 
> If so, then that can be
> 
> protected_guest_has(SME)
> 
> or so, which would be false on Intel.

I agree. Since most of the code changed in this patch is
not applicable to TDX, it might need product specific or
new function specific flags.

> 
> And this patch was only a mechanical conversion to see how it would look
> like.
> 
>> If code is written to handle a specific technology we need to stick
>> with a check that makes it clear. Trying to make sound generic only
>> leads to confusion.
> 
> Sure, fine by me.
> 
> And I don't want a zoo of gazillion small checking functions per
> technology. sev_<something>, tdx_<something>, yadda yadda.
> 
> So stuff better be unified. Even if you'd have vendor-specific defines
> you hand into that function - and you will have such - it is still much
> saner than what it turns into with the AMD side of things.

Agree. Currently we share code with AMD SEV in memory encryption support and
string I/O handling code. So defining common flag for such code is
useful.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
