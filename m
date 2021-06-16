Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DC83AA1E5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhFPQ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:59:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:16101 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhFPQ7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:59:16 -0400
IronPort-SDR: G7qQ2sr5BYzGuuT3lU8Rx686n/De8vCb+UXBTQaSkOacFy0MzdrHS6ktVoluZVGU6IMWVu/TMr
 WLlMLtvHuXVg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="193338460"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="193338460"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 09:57:08 -0700
IronPort-SDR: mYNoaYtyvBm9Q6MgRujcgZ0UI0idDyV4BJqp8/cyhURDGfs7g1wCZ1um+pxwZ5A3ly7eDAiRKA
 UuV2fD3rXdiQ==
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="484952606"
Received: from sbangalo-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.20.242])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 09:57:07 -0700
Subject: Re: [PATCH v2 03/12] x86/cpufeatures: Add TDX Guest CPU feature
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <YMI2MtZ/poULESej@zn.tnic>
 <20210612210219.2164766-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YMnJ5V4NU1JF2KAZ@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <ed65cf5b-0748-fcff-a476-e82963545f0e@linux.intel.com>
Date:   Wed, 16 Jun 2021 09:57:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMnJ5V4NU1JF2KAZ@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/21 2:52 AM, Borislav Petkov wrote:
> As I had typed, without the "is":
> 
> 	pr_info("Guest initialized\n");
> 
> We're trying to keep dmesg style from becoming prose.:)

Thanks for clarification. I will fix it.

> 
> Rest looks ok.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
