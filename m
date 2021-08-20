Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05ABA3F342E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 21:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbhHTTBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 15:01:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:4596 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhHTTBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:01:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="197082645"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="197082645"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 12:01:08 -0700
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="506580400"
Received: from jmorauga-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.135.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 12:01:06 -0700
Subject: Re: [PATCH v5 06/12] x86/tdx: Get TD execution environment
 information via TDINFO
To:     Andi Kleen <ak@linux.intel.com>, Borislav Petkov <bp@alien8.de>
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
 <5c4b8cff-ebc0-515f-acb3-aee53f955e4c@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <428c09d3-f636-2a99-e394-e46b57c38b29@linux.intel.com>
Date:   Fri, 20 Aug 2021 12:01:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5c4b8cff-ebc0-515f-acb3-aee53f955e4c@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/21 11:58 AM, Andi Kleen wrote:
> 
> 
> Without working TDCALLs the error message won't appear anywhere. The only practical way to debug 
> such a problem is a kernel debugger.
> 
> Also printing an error message might end up recursing because the console write would trigger TDCALL 
> again, or eventually stop because the console lock is already taken. In any case it won't work.

Yes, good point. In this case, adding debug print will not work. But I
can add more comments to the code.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
