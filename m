Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C659D389A63
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 02:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhETAUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 20:20:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:46428 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229598AbhETAUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 20:20:16 -0400
IronPort-SDR: 2kY2YYEwc6Atwmluj8vIhbh5MjvhwCRUg3lPlnkhVyTEqv/zas1mFOT2GigGU6WPs6TPR/DDXC
 0mTyrZyQ7lag==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="201165398"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="201165398"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 17:18:56 -0700
IronPort-SDR: qj58NiAbcEmWTXcMXiYlqnmWgBe2IyOSLo3brLbpWiHwJzDbexLYODcDCUZ05v8EeaF5//FeSe
 LFciUtsU1x0A==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="411959002"
Received: from ccheung-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.97.108])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 17:18:54 -0700
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
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <a92f339b-3e37-0988-06b0-d290c656dc52@linux.intel.com>
Date:   Wed, 19 May 2021 17:18:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hv4brS7Vp4rjtnPvF5z7FDuEQkCp+sQ0q6FOxpnKCYCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 5/17/21 9:08 PM, Dan Williams wrote:
>> SYM_DATA_START_LOCAL(tr_idt)
>>           .short  0
>>           .quad   0
>> SYM_DATA_END(tr_idt)
> This format implies that tr_idt is reserving space for 2 distinct data
> structure attributes of those sizes, can you just put those names here
> as comments? Otherwise the .fill format is more compact.

Initially its 6 bytes (2 bytes for IDT limit, 4 bytes for 32 bit linear
start address). This patch extends it by another 4 bytes for supporting
64 bit mode.

2 bytes IDT limit (.short)
8 bytes for 64 bit IDT start address (.quad)

This info is included in commit log. But I will add comment here as you
have mentioned.

Will following comment log do ?

/* Use 10 bytes for IDT (in 64 bit mode), 8 bytes for IDT start address
    2 bytes for IDT limit size */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
