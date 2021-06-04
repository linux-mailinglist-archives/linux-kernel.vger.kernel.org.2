Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F66C39C35B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 00:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFDWPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 18:15:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:11886 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbhFDWPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 18:15:44 -0400
IronPort-SDR: cYmIyDUZRlJ0GeHf+HeEqFABh1n8ty/57UCIEedHPaIBIYwosg4dIiihP1Awdtko0Z9qrHU/Zg
 7n6Kpv3uH2QQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="225701217"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="225701217"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 15:13:56 -0700
IronPort-SDR: xzTsR82Z6jjnJGkKJ6OYrF3ai/Y3+fl+97Zuv9IFROD5+4P1uertJghsoz08YZqduyeuCYOnAR
 r4zg27fM26hg==
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="480795510"
Received: from ticela-or-240.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.152.3])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 15:13:55 -0700
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstractionn
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLkcIuL2qvo0hviU@zn.tnic> <YLkcUts9dWDkDKpY@zn.tnic>
 <1c8938fb-c9e9-af51-5224-70fc869eedea@amd.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <df3fdcfb-a0e4-b2ce-0123-ba3cdbc7e76f@linux.intel.com>
Date:   Fri, 4 Jun 2021 15:13:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1c8938fb-c9e9-af51-5224-70fc869eedea@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/4/21 3:01 PM, Tom Lendacky wrote:
>>   	 */
>> -	if (sme_active())
>> +	if (protected_guest_has(VM_HOST_MEM_ENCRYPT))
>>   		swiotlb = 1;
> I still feel this is confusing. SME is a host/bare-metal technology, so
> calling protected_guest_has() seems odd and using VM_HOST_MEM_ENCRYPT,
> where I assume VM is short for virtual machine, also seems odd.
> 
> How about just protected_os_has()? Then you could have
> - HOST_MEM_ENCRYPT  for host memory encryption
> - GUEST_MEM_ENCRYPT for guest memory encryption
> - MEM_ENCRYPT       for either host or guest memory encryption.
> 
> The first is analogous to sme_active(), the second to sev_active() and the
> third to mem_encrypt_active(). Just my opinion, though...
> 

I am not sure whether OS makes sense here. But I am fine with it if
it is maintainers choice.

Other option could be protected_boot_has()?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
