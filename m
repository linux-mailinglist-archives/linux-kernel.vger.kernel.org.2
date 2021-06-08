Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AC83A06F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 00:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhFHWgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 18:36:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:1751 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234272AbhFHWgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 18:36:46 -0400
IronPort-SDR: oYJVC8KdRCaVFQEleT7WA2ZUhe9hp3+8JRwCOjZP0Vb7oP454IwSQNrWsIqSYdgkq8eKbe7N+s
 qu9lqnw2yZww==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="268812997"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="268812997"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 15:34:43 -0700
IronPort-SDR: Wrvik8NFw14CecQlAqjF4ZA5fCwvLAoz27I/Ywf5+KmzUYD57kDv+neKfUH2KTV1G+1+X5xkhf
 AVdDj2Z7RASg==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="551767047"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.24.11]) ([10.209.24.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 15:34:42 -0700
Subject: Re: [RFC v2-fix-v3 1/1] x86/tdx: Skip WBINVD instruction for TDX
 guest
To:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <CAPcyv4jQ=Fcga3jyUzthjPW9O962vhy3L5XUM6jqR5Z_Zq83LQ@mail.gmail.com>
 <20210608213527.739474-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <ec55256c-3a44-5265-fea8-018a229e92da@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <987b88f7-fb65-7725-89ff-b1f0fa2787e3@linux.intel.com>
Date:   Tue, 8 Jun 2021 15:34:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <ec55256c-3a44-5265-fea8-018a229e92da@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/8/2021 3:17 PM, Dave Hansen wrote:
> On 6/8/21 2:35 PM, Kuppuswamy Sathyanarayanan wrote:
>> Persistent memory is also currently not supported. Another code
>> path that uses WBINVD is the MTRR driver, but EPT/virtualization
>> always disables MTRRs so those are not needed. This all implies
>> WBINVD is not needed with current TDX.
> It's one thing to declare something unsupported.  It's quite another to
> declare it unsupported and then back it up with code to ensure that any
> attempted use is thwarted.
>
> This patch certainly shows us half of the solution.  But, to be
> complete, we also need to see the other half: where is the patch


We had multiple patches to handle it earlier (by ignoring it which is 
the right way and deployed successfully everywhere in KVM), but you guys 
all didn't like them.

So they got removed.

You can't have your cake and eat it. Either you have the ignore or warn 
on patches or you have panic.

In this iteration now you have panic (through the exception handler) 
except we explicitely ignore it for the cases we know that can happen 
(which is reboot)


> or
> documentation for why it is not *possible* to encounter persistent
> memory in a TDX guest?


I thought we already went over this ad nauseam.

The current TDX VMMs don't support anything else than plain DRAM.

If there is support for anything else in the future we'll need to add a 
new GHCI call that implements WBINVD through the host, but right now we 
don't need it.

-Andi.

