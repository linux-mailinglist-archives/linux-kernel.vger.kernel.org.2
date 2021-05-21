Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9538C38CE6D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhEUT6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:58:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:45724 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhEUT6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:58:45 -0400
IronPort-SDR: NtVTZ2MRFCt3rRSwDY+6ndqYmoYekIG/YpJ+dL95K9g5zl8PG8XzZWnVL3j3/7/jLFKr+JFOgx
 JoYt6iV6cwcA==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="287103265"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="287103265"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 12:57:22 -0700
IronPort-SDR: XejAXBwJ5QqkG3tyPUTzaK3tQuEh1jvG9AxkoP8Pqx4rnRyZlKTz4sCsIcIGbA2I1bBiaEitEn
 3erk34Z+JGIw==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441215658"
Received: from orxpovpvmu02.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.181.51])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 12:57:21 -0700
Subject: Re: [RFC v2-fix 1/1] x86/traps: Add #VE support for TDX guest
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <afd85e8f-ab26-aa3b-e4e9-a0b3bfd472c8@intel.com>
 <20210518000957.257869-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <3573599f-56bc-f21e-7a7e-0d441ab9d68e@linux.intel.com>
 <867d1271-ff97-40b0-16a5-ccf875c0ad7b@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <23effbe3-b008-8351-4cb4-34bc37c45605@linux.intel.com>
Date:   Fri, 21 May 2021 12:57:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <867d1271-ff97-40b0-16a5-ccf875c0ad7b@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/21 12:15 PM, Dave Hansen wrote:
> On 5/21/21 11:45 AM, Kuppuswamy, Sathyanarayanan wrote:
>> You have any other comments on this patch? If not, can you reply with your
>> Reviewed-by tag?
> 
> Sathya, I've been rather busy with your own patches and your colleagues
> TDX patches.  I've clearly communicated to you which patches I plan to
> provide a review for.  I'll get to them, although not quite at the speed
> you would like.
> 

My impression so far is, for TDX patch submissions, you usually reply to
the patch submission/comments in 1-2 days (sorry if this assumption is
incorrect). Since I did not see any major objections for this patch, I
was just checking with you to understand if this patch review is pending
due to something missing from my end. My intention was not to rush you,
but just to understand if it needs some work from my end.

Sorry if the reminder emails trouble you. Since we are aiming for v5.14
merge window, I am trying to avoid any delays from my end.

> If you would like to get a quicker review, I'd highly suggest you go
> find some of your TDX colleagues' code that needs its quality improved
> and help by providing them reviews.  Reviews are a two-way street, not
> just a service provided by maintainers to contributors.
> 
> You could also make good use of your time by going back over all of the
> review comments I've made up to this point and doing a pass over your
> work to ensure that I don't have to continue to repeat myself and waste
> review efforts.

I have considered your comments and fixed the common issues reported by
you in this patch-set. But when addressing recent comments and while
updating the commit log, some of these issues got introduced again. I will
try to avoid them in future.



-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
