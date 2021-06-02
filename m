Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7560439928C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhFBSba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:31:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:58461 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhFBSb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:31:26 -0400
IronPort-SDR: kFcdakKeau532rztDjSxBvZyIvUP7qb1+5evylMeRnHqjr25kyNznJik/e0xGVFD8K4I5Cc2M6
 GcTH6d7ahj4Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="203891441"
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="203891441"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 11:29:41 -0700
IronPort-SDR: i9m/QbcLHDxrW89s6s1fLktuv3KRHbORImGBjayuq3ycuGpoVJGsZI/+wJaStFJmDsLD3vHKSL
 LpXNE56TzOYQ==
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="416997241"
Received: from sboinap-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.150.149])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 11:29:40 -0700
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstraction
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <dfb6b319-97ad-4c16-67ae-de4ce4ef415b@amd.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <9852f974-6fb0-d7d6-326c-f92ba3b52af3@linux.intel.com>
Date:   Wed, 2 Jun 2021 11:29:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <dfb6b319-97ad-4c16-67ae-de4ce4ef415b@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/21 11:19 AM, Tom Lendacky wrote:
> This certainly doesn't capture all of the situations where true would need
> to be returned. For example, SEV, but not SEV-ES, requires that string I/O
> be unrolled, etc.

For AMD following cases should be true right? I can fix it in next version.

case VM_UNROLL_STRING_IO:
case VM_HOST_MEM_ENCRYPT:

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
