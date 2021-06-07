Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D5439E935
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 23:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhFGVyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 17:54:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:59257 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230359AbhFGVyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 17:54:13 -0400
IronPort-SDR: QxUsVQvhHaI40VlgjfunMvB79wBipanx9QzOeB7BD5J+5zFkS3GW8n3LKCuOlwCsk3As3eyBk2
 oujirIKL2U5g==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="265872465"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="265872465"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 14:52:09 -0700
IronPort-SDR: l9vvd8gzcND4FQkTfOq1fqytD5uK+SHg/6kGl2eWzJzBFcdmlwhJBg4CO0gOZxLk/3Emj41hmL
 On1yW0s5J9WQ==
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="619084289"
Received: from ssanje1x-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.251.153.170])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 14:52:05 -0700
Subject: Re: [RFC v2-fix-v1 3/3] x86/tdx: Handle port I/O
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAPcyv4gBNqDFQEYjWqYTckPg-yy=LrvMw_FNY+tUuEwD35CfyA@mail.gmail.com>
 <20210527042356.3983284-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210527042356.3983284-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jRCZwoJoKGP4v3e8V6u4Y+1VZo_k=umQuh-rrAoMKg4Q@mail.gmail.com>
 <ca836226-46e1-389c-e5c8-c5f1c91130ea@linux.intel.com>
 <CAPcyv4gmokd5YTbL0X8w3KKV6EEO0xraaB-OEFJyncjaHQUUuw@mail.gmail.com>
 <2aba694b-ec36-d57f-06e0-a269f9953bb3@linux.intel.com>
 <CAPcyv4iOJJjghTPTLCkvT-Y_SJOhCbfm66m_NO5Ue+eVr_0NZA@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <cd4983e4-a3e8-7c33-3197-dd3f7e8f7538@linux.intel.com>
Date:   Mon, 7 Jun 2021 14:52:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iOJJjghTPTLCkvT-Y_SJOhCbfm66m_NO5Ue+eVr_0NZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/21 10:17 AM, Dan Williams wrote:
>> Did it answer your query?
> Yes, all but the concern of printk recursion.

I think recursion is not possible because printk will
handle it (using console_lock). If another print is
triggered during the current printk handling, it will
be directed to logbuf and delayed.

https://elixir.bootlin.com/linux/latest/source/kernel/printk/printk_safe.c#L382

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
