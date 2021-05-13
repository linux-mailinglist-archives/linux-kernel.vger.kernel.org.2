Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCE437FE54
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhEMTkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:40:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:40976 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230154AbhEMTkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:40:06 -0400
IronPort-SDR: nGqHIefn7TwLC+hIQFLlHS34anjZl+r+eG2S8mJkpkTJCOhrd+yfu6kG5WfsDtmb9y92CTJBb1
 ku16g8dVzyfQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="200089865"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="200089865"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 12:38:53 -0700
IronPort-SDR: ph7v76FgdF6xYyJz+xLL4ZCtyCNyIIYeicHc2Chz30XzAZph75AVD2RXEplTmvdGftoPv/HOjb
 w04MUOmZLLzg==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="401142998"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.17.244]) ([10.209.17.244])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 12:38:52 -0700
Subject: Re: [RFC v2 26/32] x86/mm: Move force_dma_unencrypted() to common
 code
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
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
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <a72bce3a-d7da-c595-9456-cfda42d9cdc3@linux.intel.com>
Date:   Thu, 13 May 2021 12:38:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <943645b7-3974-bf05-073c-03ef4f889379@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/13/2021 10:49 AM, Dave Hansen wrote:
> On 5/13/21 9:40 AM, Kuppuswamy, Sathyanarayanan wrote:
>> +#define PROTECTED_GUEST_BITMAP_LEN    128
>> +
>> +/* Protected Guest vendor types */
>> +#define GUEST_TYPE_TDX            (1)
>> +#define GUEST_TYPE_SEV            (2)
>> +
>> +/* Protected Guest features */
>> +#define MEMORY_ENCRYPTION        (20)
> I was assuming we'd reuse the X86_FEATURE infrastructure somehow.  Is
> there a good reason not to?


This for generic code. Would be a gigantic lift and lots of refactoring 
to move that out.

>
> That gives us all the compile-time optimization (via
> en/disabled-features.h) and static branches for "free".

There's no user so far which is anywhere near performance critical, so 
that would be total overkil

BTW right now I'm not even sure we need the bitmap for anything, but I 
guess it doesn't hurt.

-Andi


