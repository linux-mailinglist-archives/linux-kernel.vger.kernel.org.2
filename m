Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CD238B7B3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbhETTnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:43:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:52656 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232281AbhETTne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:43:34 -0400
IronPort-SDR: mYlcwGvtUV4+rjX6XkkIPoCswZxOwcfDXaSZlX711ijQ9+uy/woKsOkl6wsfAoo4XDDO3PP0zF
 6/8CJO5m0wdQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="188448091"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188448091"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 12:42:12 -0700
IronPort-SDR: QxHqHpGMN8SvdqbhSSK8fiICIdwjN1BiX1imTgdTcpYAdY7u7fdRmc07l+4gmQrqbfHLtrlmxU
 r3Hlj2e8T2dA==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="440592248"
Received: from shaunnab-mobl2.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.65.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 12:42:11 -0700
Subject: Re: [RFC v2 27/32] x86/tdx: Exclude Shared bit from __PHYSICAL_MASK
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <87b31425b79df3cc44d2bdc6a79d6aa36c42d116.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3ae38a0b-0676-1543-7015-39a589b2807a@intel.com>
 <0df80c0f-e0da-e86e-0ab8-abc58f0da559@linux.intel.com>
 <YKa5gkwGTIUFpzzH@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <b27a6d31-8fd9-e650-0adf-5f7a8fc96a1c@linux.intel.com>
Date:   Thu, 20 May 2021 12:42:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKa5gkwGTIUFpzzH@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/21 12:33 PM, Sean Christopherson wrote:
>> Initially we have used tdx_* prefix for the guest code. But when the code from
>> host side got merged together, we came across many name conflicts.
> Whatever the conflicts are, they are by no means an unsolvable problem.  I am
> more than happy to end up with slightly verbose names in KVM if that's what it
> takes to avoid "tdg".
> 
>> So to avoid such issues in future, we were asked not to use the "tdx_" prefix
>> and our alternative choice was "tdg_".
> Who asked you not to use tdx_?  More specifically, did that feedback come from a
> maintainer (or anyone on-list), or was it an Intel-internal decision?

It is the Intel internal feedback.

> 
>> Also, IMO, "tdg" prefix is more meaningful for guest code (Trusted Domain Guest)
>> compared to "tdx" (Trusted Domain eXtensions). I know that it gets confusing
>> when grepping for TDX related changes. But since these functions are only used
>> inside arch/x86 it should not be too confusing.
>>
>> Even if rename is requested, IMO, it is easier to do it in one patch over
>> making changes in all the patches. So if it is required, we can do it later
>> once these initial patches were merged.
> Hell no, we are not merging known bad crud that requires useless churn to get
> things right.

So what is your proposal? "tdx_guest_" / "tdx_host_" ?

If there is supposed be a rename, lets wait till we know about maintainers
feedback as well. If possible I would prefer not to go through another
rename.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
