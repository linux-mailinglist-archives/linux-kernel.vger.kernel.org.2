Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D1D39268C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhE0Erq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:47:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:20290 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhE0Ero (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:47:44 -0400
IronPort-SDR: VoEjo+DQdxW37IWnPDFQ+FepY/c1+MepCeJ8vafskodxW+DxTnkD65+0bWRpmVev57c+O90CVV
 b2yDGE7PKvjQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="189768101"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="189768101"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:46:11 -0700
IronPort-SDR: 62Tm5zi7TGbqjS64796oOtrEvTUtHN8hacdWLq7e1MlkexgR4oePMmqUiPom0tT3hAuH0+ENCu
 w/acnlkA2Jng==
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="547534955"
Received: from skgiroua-mobl2.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.251.151.24])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:46:10 -0700
Subject: Re: [RFC v2 26/32] x86/mm: Move force_dma_unencrypted() to common
 code
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <7c5adf75d69ea327b22b404b7c37b29712d73640.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5536639a-918d-de8d-ff32-934a13902a03@intel.com>
 <d04e5992-8800-a8df-99de-4dbb40e45d09@linux.intel.com>
 <bbcb688c-5aa0-eeb1-192a-45edaccc2f32@intel.com>
 <20210512130821.7r2rtzcyjltecun7@box.shutemov.name>
 <e8886298-83fa-212e-ab3a-5e5b21a7ab6c@intel.com>
 <3ad7a35d-45f2-9c62-23cd-3b7a167c5d83@linux.intel.com>
Message-ID: <8ae486b9-6e03-52fd-ee4d-b106e087ef8d@linux.intel.com>
Date:   Wed, 26 May 2021 21:46:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3ad7a35d-45f2-9c62-23cd-3b7a167c5d83@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/21 6:28 PM, Kuppuswamy, Sathyanarayanan wrote:
>> Because the code is already separate.  You're actually going to some
>> trouble to move the SEV-specific code and then combine it with the
>> TDX-specific code.
>>
>> Anyway, please just give it a shot.  Should take all of ten minutes.  If
>> it doesn't work out in practice, fine.  You'll have a good paragraph for
>> the changelog.
> 
> After reviewing the code again, I have noticed that we don't really have
> much common code between AMD and TDX. So I don't see any justification for
> creating this common layer. So, I have decided to drop this patch and move
> Intel TDX specific memory encryption init code to patch titled "[RFC v2 30/32]
> x86/tdx: Make DMA pages shared". This model is similar to how AMD-SEV
> does the initialization.
> 
> I have sent the modified patch as reply to patch titled "[RFC v2 30/32]
> x86/tdx: Make DMA pages shared". Please check and let me know your comment

My method of using separate initialization file for Intel only code will not
work if we want to support both AMD SEV and TDX guest support in same binary.
So please ignore my previous reply. I will address the issue as per your
original comments and send you an updated patch.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
