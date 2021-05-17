Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC68386CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 00:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343818AbhEQWdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 18:33:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:47293 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238052AbhEQWdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 18:33:23 -0400
IronPort-SDR: cPW1V6n0WLiAYaMWDlzYxMiEzGsDHVD6QYUFI0e0qudyHYh2sulyPPHebYKgakoF0egFH2RqgK
 Ek5kKd+FtcMQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="200632718"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="200632718"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 15:32:06 -0700
IronPort-SDR: 3pPbgw7KR3+4EfEe+dtQOrQE887y10H1DxmYzQT8KwAHjrBK4I3/Ziojxgrakddz7GKwb9ft9X
 rR8+Eh0+RHCQ==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="543866390"
Received: from daltonda-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.182.28])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 15:32:05 -0700
Subject: Re: [RFC v2 26/32] x86/mm: Move force_dma_unencrypted() to common
 code
To:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <bbcb688c-5aa0-eeb1-192a-45edaccc2f32@intel.com>
 <20210512130821.7r2rtzcyjltecun7@box.shutemov.name>
 <e8886298-83fa-212e-ab3a-5e5b21a7ab6c@intel.com>
 <YJv6EWJmDYQL4Eqt@google.com>
 <c6b40305-d643-6023-907b-e6858d422a36@linux.intel.com>
 <943645b7-3974-bf05-073c-03ef4f889379@intel.com>
 <a72bce3a-d7da-c595-9456-cfda42d9cdc3@linux.intel.com>
 <YKKzCOW9u6q06E5I@google.com>
 <d5fb2565-110e-17d1-ea00-35cf4d196f1e@linux.intel.com>
 <5cc06488-09fe-17b5-077b-02c4ba9ca198@intel.com>
 <YKK4AHhfv1nrYiw2@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <37da11b3-0313-982d-5a2b-af592db6f9e8@linux.intel.com>
Date:   Mon, 17 May 2021 15:32:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKK4AHhfv1nrYiw2@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/21 11:37 AM, Sean Christopherson wrote:
>> Just remember, a "common framework" doesn't mean that it can't be backed
>> by extremely arch-specific mechanisms.
>>
>> For instance, there's a lot of pkey-specific code in mm/mprotect.c.  It
>> still gets optimized away on x86 with all the goodness of X86_FEATUREs.
> Ya, exactly.  Ideally, generic code shouldn't have to differentiate between SEV,
> SEV-ES, SEV-SNP, TDX, etc..., a vanilla "bool is_protected_guest(void)" should
> suffice.  Under the hood, x86's implementation for is_protected_guest() can be
> boot_cpu_has() checks (if we want).

What about the use case of protected_guest_has(flag)? Do you want to call it with
with X86_FEATURE_* flags outside arch/x86 code ?


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
