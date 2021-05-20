Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECC638B872
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbhETUcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:32:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:37433 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235538AbhETUcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:32:42 -0400
IronPort-SDR: dqD6JvrRXuKGjvkp0dWgFxL7OA03mVA3uv8dXBkSA9eXV1wS8mlKE0Z2fJHADugzuSbhI9qX4q
 fxNfOz8DhWvg==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="262553249"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="262553249"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 13:31:20 -0700
IronPort-SDR: EVUx6zJQVeJDjOiLEwOxA8zkizKqjhnPG0Kuf2adK5gWpJjD/yfEPrsfjIE7JEdcfylegkz3db
 j13lfu1evqiw==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="475366526"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.197.177]) ([10.212.197.177])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 13:31:19 -0700
Subject: Re: [RFC v2 27/32] x86/tdx: Exclude Shared bit from __PHYSICAL_MASK
To:     Sean Christopherson <seanjc@google.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <87b31425b79df3cc44d2bdc6a79d6aa36c42d116.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3ae38a0b-0676-1543-7015-39a589b2807a@intel.com>
 <0df80c0f-e0da-e86e-0ab8-abc58f0da559@linux.intel.com>
 <YKa5gkwGTIUFpzzH@google.com>
 <b27a6d31-8fd9-e650-0adf-5f7a8fc96a1c@linux.intel.com>
 <YKbDtt2K4Z5gtYRc@google.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <f348c391-c665-2987-898c-718d2c53729f@linux.intel.com>
Date:   Thu, 20 May 2021 13:31:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKbDtt2K4Z5gtYRc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/20/2021 1:16 PM, Sean Christopherson wrote:
> On Thu, May 20, 2021, Kuppuswamy, Sathyanarayanan wrote:
>> So what is your proposal? "tdx_guest_" / "tdx_host_" ?
>    1. Abstract things where appropriate, e.g. I'm guessing there is a clever way
>       to deal with the shared vs. private inversion and avoid tdg_shared_mask
>       altogether.
>
>    2. Steal what SEV-ES did for the #VC handlers and use ve_ as the prefix for
>       handlers.
>
>    3. Use tdx_ everywhere else and handle the conflicts on a case-by-case basis
>       with a healthy dose of common sense.  E.g. there should be no need to worry
>       about "static __cpuidle void tdg_safe_halt(void)" colliding because neither
>       the guest nor KVM should be exposing tdx_safe_halt() outside of its
>       compilation unit.


Sorry Sean, but your suggestion is against all good code hygiene 
practices. Normally we try to pick unique prefixes for every module, and 
trying to coordinate with lots of other code that is maintained by other 
people is just a long term recipe for annoying merging problems.  Same 
with coordinating with SEV-ES for ve_.

Is it really that hard to adjust your grep patterns?

I'm not against changing tdg_, but if it's changed it should be 
something unique, and also not too long. Today tdg_ fits that criteria 
nicely.


-Andi

