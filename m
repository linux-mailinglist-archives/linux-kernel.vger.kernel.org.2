Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A790C376CE5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 00:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhEGWkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 18:40:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:40597 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhEGWj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 18:39:59 -0400
IronPort-SDR: h4ixepHKINKwu7gSAwAGjavpF/WTcTFMD/v/XV30Ia9Sk4i5eO0ojGn6LOmyW4jUDuT9bSgckT
 iyZIULZShnRw==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="195717481"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="195717481"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 15:38:58 -0700
IronPort-SDR: ZBXrPw25IXrU/4YmVlfdSF0uphUGiQ/4F7neXlJQ2WEn6DAB4Als/TudqBquHSTXWYoaQLCXPq
 zDZ1SVZyuJ3g==
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="533853025"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.54.125]) ([10.209.54.125])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 15:38:56 -0700
Subject: Re: [RFC v2 28/32] x86/tdx: Make pages shared in ioremap()
To:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <eaaa692ce1ed897f66f864bbfa2df8683768d79e.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <b884067a-19d6-105f-9f8c-28feb3b43446@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <312879fb-d201-a16d-2568-150152044c54@linux.intel.com>
Date:   Fri, 7 May 2021 15:38:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b884067a-19d6-105f-9f8c-28feb3b43446@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/7/2021 2:55 PM, Dave Hansen wrote:
> On 4/26/21 11:01 AM, Kuppuswamy Sathyanarayanan wrote:
>>   static unsigned int __ioremap_check_encrypted(struct resource *res)
>>   {
>> -	if (!sev_active())
>> +	if (!sev_active() && !is_tdx_guest())
>>   		return 0;
> I think it's time to come up with a real name for all of the code that's
> under: (sev_active() || is_tdx_guest()).
>
> "encrypted" isn't it, for sure.

I called it protected_guest() in some other patches.

-Andi

