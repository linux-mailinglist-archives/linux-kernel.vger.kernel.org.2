Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882A63A1F25
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhFIVoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:44:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:60077 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhFIVof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:44:35 -0400
IronPort-SDR: ykykX7IhucxrJmkwCZ1qFC+TUKKZfEKh0QcIRPAUZuzjkzRX7voEGYc3MEDG/6AbhrIMmoWMeg
 hvsTgnCvkNCg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="202150765"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="202150765"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:42:40 -0700
IronPort-SDR: 8lJ90QieKXiF2nbXI6rgmJp7jaYGkh6iProettwo8D0QW/OZGUiG7AnZpqIEB4lekubnI6zmHn
 Vcvq3MyAXtyw==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="402579860"
Received: from davidhok-mobl3.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.9.9])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:42:39 -0700
Subject: Re: [RFC v2-fix-v5 1/1] x86: Skip WBINVD instruction for VM guest
To:     Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <973add45-9fd2-7abc-3a97-96a26c263ea0@linux.intel.com>
 <20210609194926.1949859-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <7c06b567-9a65-8c7c-6046-3dcb32d4bb15@intel.com>
 <CAPcyv4ismoYra_8=Qj=XLLs9+18tRiv8Y48GJWOAHvpzi3BZiw@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <2184400d-856e-ed4c-b23d-77b7dfd72658@linux.intel.com>
Date:   Wed, 9 Jun 2021 14:42:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4ismoYra_8=Qj=XLLs9+18tRiv8Y48GJWOAHvpzi3BZiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/21 2:38 PM, Dan Williams wrote:
>> In TDX guests, these WBINVD operations cause #VE exceptions.  For debug,
>> it would be ideal for the #VE handler to be able to WARN() when an
>> unexpected WBINVD occurs. (<--- problem #2)
> ...but it doesn't WARN() it triggers unhandled #VE, unless I missed
> another patch that precedes this that turns it into a WARN()? If a
> code path expects WBINVD for correct operation and the guest can't
> execute that sounds fatal, not a WARN to me.

Yes. It is not WARN. It is a fatal unhandled exception.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
