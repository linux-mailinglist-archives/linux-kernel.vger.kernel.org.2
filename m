Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C623A0AEC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 05:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhFID6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 23:58:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:39375 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233410AbhFID6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 23:58:36 -0400
IronPort-SDR: FhLlkfVlCuI1wXzfbXdCYVXcsUGya9JK/1q/kG2cf8KwaiCzcQMhe8+pLMEXEFZzqJBq3u3uRs
 Yjrnw8BfJdCw==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="192106095"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="192106095"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 20:56:29 -0700
IronPort-SDR: Cd9eow8wzx6HxWE1eLyLNLGaIVsFrH6TLHLwvmmEx4RY6oglqGQyRV0NeYU/zrui9KIp5lJ1XR
 9qJwBrISgSnA==
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="402305187"
Received: from dabarred-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.185.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 20:56:28 -0700
Subject: Re: [RFC v2-fix-v4 1/1] x86/tdx: Skip WBINVD instruction for TDX
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
References: <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
 <20210609011030.751451-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4gLeKPfYOx1kmg-mO1_mNd+XGqVO-CbqX+2d52GZ+DSFw@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <682f0239-8da0-3702-0f14-99b6244af499@linux.intel.com>
Date:   Tue, 8 Jun 2021 20:56:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gLeKPfYOx1kmg-mO1_mNd+XGqVO-CbqX+2d52GZ+DSFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/21 8:40 PM, Dan Williams wrote:
> ..."KVM gets away with it" is not a justification that TDX can stand
> on otherwise we would not be here fixing up ACPICA properly.
> 
> How about:
> 
> "TDX guests use standard ACPI mechanisms to signal sleep state entry
> (including reboot) to the host. The ACPI specification mandates WBINVD
> on any sleep state entry with the expectation that the platform is
> only responsible for maintaining the state of memory over sleep
> states, not preserving dirty data in any CPU caches. ACPI cache
> flushing requirements pre-date the advent of virtualization. Given TDX
> guest sleep state entry does not affect any host power rails it is not
> required to flush caches. The host is responsible for maintaining
> cache state over its own bare metal sleep state transitions that
> power-off the cache. If the host fails to manage caches over its sleep
> state transitions the guest..."

> 
> I don't know how to finish the last sentence. What does TDX do if it
> is resumed after host suspend and the host somehow arranged for dirty
> TDX lines to be lost.

TDX guest does not support S3. It will be disabled in ACPI tables. It
is a TDX firmware spec requirement. Please check the following spec,
sec 2.1

https://software.intel.com/content/dam/develop/external/us/en/documents/tdx-virtual-firmware-design-guide-rev-1.pdf

In TDX guest, we encounter cache flushes only in shutdown and reboot path.
So there is no resume path.


  Will that be noticed by TDX integrity
> mechanisms? I did not immediately find an answer to this with a brief
> look at the specs.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
