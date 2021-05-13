Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7606237FD25
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 20:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhEMSTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 14:19:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:19164 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhEMSTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 14:19:11 -0400
IronPort-SDR: WMIzrQUxr1VnAkMgbpf1Guloj9XPrUmXnF0LP0jS23FJRRXkkLgEkDqim0b1RI+DUQ/v2X4f5C
 h+bMmkwqG28w==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="199701172"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="199701172"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 11:18:00 -0700
IronPort-SDR: q3CDgFd2QcdDrVZyCjCdru8HSbhQTpbpbXdSUqygF1xG40q+wogb06tfx1QJR7YGQWErxcqTRP
 JmutrwjL48FQ==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="437756347"
Received: from dleves-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.146.134])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 11:17:59 -0700
Subject: Re: [RFC v2 26/32] x86/mm: Move force_dma_unencrypted() to common
 code
To:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <7c5adf75d69ea327b22b404b7c37b29712d73640.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5536639a-918d-de8d-ff32-934a13902a03@intel.com>
 <d04e5992-8800-a8df-99de-4dbb40e45d09@linux.intel.com>
 <bbcb688c-5aa0-eeb1-192a-45edaccc2f32@intel.com>
 <20210512130821.7r2rtzcyjltecun7@box.shutemov.name>
 <e8886298-83fa-212e-ab3a-5e5b21a7ab6c@intel.com>
 <YJv6EWJmDYQL4Eqt@google.com>
 <c6b40305-d643-6023-907b-e6858d422a36@linux.intel.com>
 <943645b7-3974-bf05-073c-03ef4f889379@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <25f39c78-276f-529e-a62a-5444f9a94d14@linux.intel.com>
Date:   Thu, 13 May 2021 11:17:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <943645b7-3974-bf05-073c-03ef4f889379@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/21 10:49 AM, Dave Hansen wrote:
> On 5/13/21 9:40 AM, Kuppuswamy, Sathyanarayanan wrote:
>>
>> +#define PROTECTED_GUEST_BITMAP_LEN    128
>> +
>> +/* Protected Guest vendor types */
>> +#define GUEST_TYPE_TDX            (1)
>> +#define GUEST_TYPE_SEV            (2)
>> +
>> +/* Protected Guest features */
>> +#define MEMORY_ENCRYPTION        (20)
> 
> I was assuming we'd reuse the X86_FEATURE infrastructure somehow.  Is
> there a good reason not to?

My assumption is, protected guest abstraction can be also used by
non-x86 arch's in future. So I have tried to keep these definitions
in common code.


> 
> That gives us all the compile-time optimization (via
> en/disabled-features.h) and static branches for "free".
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
