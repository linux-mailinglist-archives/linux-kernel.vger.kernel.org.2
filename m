Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFD63A06F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 00:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhFHWiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 18:38:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:25785 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhFHWiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 18:38:24 -0400
IronPort-SDR: o/vO/02tAaL7fz1egTZT1eUaFPG2LPFuAR34d1mE2JcS9VlEumtP6cEaR8qE6Lk/tUDPqy0TIJ
 sNpvpcxPDdnA==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="204982494"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="204982494"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 15:36:30 -0700
IronPort-SDR: xJ1qcAElwWGhEWhcM5fXsZS1nHvrSVWAPejfMHtuqUT7GWyKf4WAKi1149DFrP9qGfERCG7QSB
 T97+Wkv/Tr8A==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="402231124"
Received: from dabarred-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.185.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 15:36:29 -0700
Subject: Re: [RFC v2-fix-v3 1/1] x86/tdx: Skip WBINVD instruction for TDX
 guest
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <CAPcyv4jQ=Fcga3jyUzthjPW9O962vhy3L5XUM6jqR5Z_Zq83LQ@mail.gmail.com>
 <20210608213527.739474-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <ec55256c-3a44-5265-fea8-018a229e92da@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <bc41d48e-b001-f870-e421-7c5cbc6ec1c4@linux.intel.com>
Date:   Tue, 8 Jun 2021 15:36:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ec55256c-3a44-5265-fea8-018a229e92da@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/21 3:17 PM, Dave Hansen wrote:
> On 6/8/21 2:35 PM, Kuppuswamy Sathyanarayanan wrote:
>> Persistent memory is also currently not supported. Another code
>> path that uses WBINVD is the MTRR driver, but EPT/virtualization
>> always disables MTRRs so those are not needed. This all implies
>> WBINVD is not needed with current TDX.
> 
> It's one thing to declare something unsupported.  It's quite another to
> declare it unsupported and then back it up with code to ensure that any
> attempted use is thwarted.

Only audited and supported drivers will be allowed to enumerate after
device filter support patch is merged. Till we merge that patch, If
any of these unsupported features (with WBINVD usage) are enabled in TDX,
it will lead to sigfault (due to unhandled #VE).

In this patch we only create exception for ACPI sleep driver code. If
commit log is confusing, I can remove information about other unsupported
feature (with WBINVD usage).

> 
> This patch certainly shows us half of the solution.  But, to be
> complete, we also need to see the other half: where is the patch or
> documentation for why it is not *possible* to encounter persistent
> memory in a TDX guest?
> 
> BTW, "persistent memory" is much more than Intel Optane DCPMM.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
