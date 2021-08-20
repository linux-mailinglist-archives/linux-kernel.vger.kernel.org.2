Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645213F3425
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 20:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbhHTS7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 14:59:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:50865 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhHTS7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:59:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="203970835"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="203970835"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:58:38 -0700
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="452966569"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.221.228]) ([10.212.221.228])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:58:36 -0700
Subject: Re: [PATCH v5 06/12] x86/tdx: Get TD execution environment
 information via TDINFO
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YR/in4WqEQQ/LyPA@zn.tnic>
 <c5dc6c26-6157-c022-9d6b-f1ef10e6f736@linux.intel.com>
 <YR/n5FgCUSlZ5npc@zn.tnic>
 <174d5062-3618-4343-bdfb-22b5cd2662f8@linux.intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <5c4b8cff-ebc0-515f-acb3-aee53f955e4c@linux.intel.com>
Date:   Fri, 20 Aug 2021 11:58:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <174d5062-3618-4343-bdfb-22b5cd2662f8@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/20/2021 11:29 AM, Kuppuswamy, Sathyanarayanan wrote:
>
>
> On 8/20/21 10:35 AM, Borislav Petkov wrote:
>> Ok, put that as a comment above it to explain why it cannot continue.
>> Also, make sure you issue an error message before it explodes so that
>> the user knows.
>
> Ok. I will fix this in next version.


Without working TDCALLs the error message won't appear anywhere. The 
only practical way to debug such a problem is a kernel debugger.

Also printing an error message might end up recursing because the 
console write would trigger TDCALL again, or eventually stop because the 
console lock is already taken. In any case it won't work.


-Andi

