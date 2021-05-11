Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DD8379D29
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 04:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhEKCwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 22:52:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:39324 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKCwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 22:52:33 -0400
IronPort-SDR: iqLvfrjiYacyiwpBF8sKmqJm/L007MR5ucDhT2PAe8GA9pSkVU9TOKtW4iYSVKyac/Ydff27Zk
 Q9MFM4BmPFSA==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="284827763"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="284827763"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 19:51:28 -0700
IronPort-SDR: GPU1pqRJ3VZNfl7amQuTQHnxjB24nO5QAFh2We7eOSxtuj0pWGVmrpE6exQrnsBBXDV8NaX149
 Yq4+QM7qwI6Q==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="434083678"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.32.217]) ([10.209.32.217])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 19:51:27 -0700
Subject: Re: [RFC v2 16/32] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d6ca05720290060e909c1f4d12858f900f1be0e7.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jGmhkrd+Zr4RNcZ5qfXkYO-416Bw2_idVbrgij41yvYg@mail.gmail.com>
 <0e577692-101e-38f7-ebe2-2e7222016a9f@linux.intel.com>
 <04c3922a-36e2-bf07-e5fd-0d2eebda250b@linux.intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <bd43b967-26ed-d38e-e237-3a274f6b276e@linux.intel.com>
Date:   Mon, 10 May 2021 19:51:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <04c3922a-36e2-bf07-e5fd-0d2eebda250b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/10/2021 7:44 PM, Kuppuswamy, Sathyanarayanan wrote:
>
>
> On 5/10/21 7:17 PM, Andi Kleen wrote:
>>>> To prevent TD guest from using MWAIT/MONITOR instructions,
>>>> support for these instructions are already disabled by TDX
>>>> module (SEAM). So CPUID flags for these instructions should
>>>> be in disabled state.
>>> Why does this not result in a #UD if the instruction is disabled by
>>> SEAM?
>>
>> It's just the TDX module (SEAM is the execution mode used by the TDX 
>> module)
>
> If it is disabled by the TDX Module, we should never execute it. But 
> for some
> reason, if we still come across this instruction (buggy TDX module?), 
> we add
> appropriate warning in  #VE handler.

I think the only case where it could happen is if the kernel jumps to a 
random address due to a bug and the destination happens to be these 
instruction bytes. Of course it is exceedingly unlikely.

Or we make some mistake, but that's hopefully fixed quickly.


-Andi
