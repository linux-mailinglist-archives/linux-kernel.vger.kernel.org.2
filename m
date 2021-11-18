Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EE84564BC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 22:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhKRVGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 16:06:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:42381 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233169AbhKRVGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 16:06:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="231774645"
X-IronPort-AV: E=Sophos;i="5.87,245,1631602800"; 
   d="scan'208";a="231774645"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 13:03:32 -0800
X-IronPort-AV: E=Sophos;i="5.87,245,1631602800"; 
   d="scan'208";a="455202586"
Received: from jchun-mobl1.gar.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.255.86.248])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 13:03:31 -0800
Subject: Re: [PATCH v1 1/1] x86/tdx: Don't write CSTAR MSR on Intel
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211116005103.2929441-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <878rxl41p3.ffs@tglx>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <66a3304f-d885-f029-1043-9a4b1829b179@linux.intel.com>
Date:   Thu, 18 Nov 2021 13:03:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <878rxl41p3.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/18/21 1:02 PM, Thomas Gleixner wrote:
>>   DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_STACK;
>>   
>> +/* Don't write CSTAR MSR on Intel platforms */
>> +void wrmsrl_cstar(unsigned long val)
> static, no?

Yes. It should be static. I will fix it.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
