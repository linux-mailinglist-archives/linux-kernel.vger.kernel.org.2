Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9855334D9E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 00:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhC2WKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 18:10:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:55738 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231213AbhC2WJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:09:54 -0400
IronPort-SDR: 1IyTQC/eh20gpBKQbi4p+CZpFc3ChcZ0v+vhj5N6NK/xTDVc5i51+DByfkyWhOjv7lqx1YGXbc
 xqt8PqOIdc3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="171651270"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="171651270"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 15:09:54 -0700
IronPort-SDR: yo4uthLS6800mpkglfqR1mZdGxCg+52HMiBWnGsQRmQjHqiO6MupQ9JuHHrf50g2fIV9OAhaH6
 wn1EHDPW0OnA==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="444799334"
Received: from ajzangar-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.145.70])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 15:09:53 -0700
Subject: Re: [PATCH v2 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <91C0F6F1-B8C3-4130-B903-C63CD4B87F3F@amacapital.net>
 <ed7e96ba7a271e36bdfe61ee34c6d61eb78000c5.1616885306.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <498f078c-5196-a608-7f1a-8425ff056135@intel.com>
 <8e02ce39-f672-e652-b314-418b7ec5f52a@linux.intel.com>
 <d4fe4a10-7c29-5f26-25d2-b23369c38f3e@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <dac078b4-e50c-42b9-db52-6dc65b99406e@linux.intel.com>
Date:   Mon, 29 Mar 2021 15:09:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d4fe4a10-7c29-5f26-25d2-b23369c38f3e@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/21 3:02 PM, Dave Hansen wrote:
> On 3/29/21 2:55 PM, Kuppuswamy, Sathyanarayanan wrote:
>>>
>>> MONITOR is a privileged instruction, right?  So we can only end up in
>>> here if the kernel screws up and isn't reading CPUID correctly, right?
>>>
>>> That dosen't seem to me like something we want to suppress.  This needs
>>> a warning, at least.  I assume that having a MONITOR instruction
>>> immediately return doesn't do any harm.
>> Agree. Since we are not supposed to come here, I will use BUG.
> 
> "This is unexpected" is a WARN()able offense.
> 
> "This is unexpected and might be corrupting data" is where we want to
> use BUG().
> 
> Does broken MONITOR risk data corruption?
We will be reaching this point only if something is buggy in kernel. I am
not sure about impact of this buggy state. But MONITOR instruction by
itself, should not cause data corruption.

> 
>>>> +    case EXIT_REASON_MWAIT_INSTRUCTION:
>>>> +        /* MWAIT is supressed, not supposed to reach here. */
>>>> +        WARN(1, "MWAIT unexpected #VE Exception\n");
>>>> +        return -EFAULT;
>>>
>>> How is MWAIT "supppressed"?
>> I am clearing the MWAIT feature flag in early init code. We should also
>> disable this feature in firmware. setup_clear_cpu_cap(X86_FEATURE_MWAIT);
> 
> I'd be more explicit about that.  Maybe even reference the code that
> clears the X86_FEATURE.
This change is part of the same patch.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
