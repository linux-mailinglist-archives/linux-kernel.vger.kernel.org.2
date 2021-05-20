Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AAB38B660
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbhETS6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:58:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:12434 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233902AbhETS6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:58:19 -0400
IronPort-SDR: mEpwZYCCywRCFECbhlcMcnC9ix+eoD2IL9IIk3ukbbdOyk27/hSnaRs5vWM8F/iBOm5U/ruJKE
 bOYw0dt7wYeg==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="181590765"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="181590765"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 11:56:57 -0700
IronPort-SDR: jn4JPmUx9DKas1wX5mZy1VMXsLh8Gk1pZMMtHCQFsnQ6iFfoRMpyTIyYJNGfTvP3LXvU2D9DKC
 re03J0G8n5dA==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="440578942"
Received: from shaunnab-mobl2.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.65.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 11:56:56 -0700
Subject: Re: [RFC v2 27/32] x86/tdx: Exclude Shared bit from __PHYSICAL_MASK
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <87b31425b79df3cc44d2bdc6a79d6aa36c42d116.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3ae38a0b-0676-1543-7015-39a589b2807a@intel.com>
 <0df80c0f-e0da-e86e-0ab8-abc58f0da559@linux.intel.com>
Message-ID: <e1502131-ec8b-df1e-cb94-9285799f7e79@linux.intel.com>
Date:   Thu, 20 May 2021 11:56:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <0df80c0f-e0da-e86e-0ab8-abc58f0da559@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/21 11:48 AM, Kuppuswamy, Sathyanarayanan wrote:
> BTW, do you find it confusing that the subject says: '__PHYSICAL_MASK'
> and yet the code only modifies 'physical_mask'?

"physical_mask" is defined as __PHYSICAL_MASK in page_types.h. MM code seems to
use __PHYSICAL_MASK for common usage. But for our use case, if it makes it more
readable, I am fine with using "physical_mask".

arch/x86/include/asm/page_types.h:57:#define __PHYSICAL_MASK		physical_mask
arch/x86/mm/pat/memtype.c:560:		return address & __PHYSICAL_MASK;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
