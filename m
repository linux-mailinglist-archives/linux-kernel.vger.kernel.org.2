Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AF83F6912
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbhHXS3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:29:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:26037 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232993AbhHXS3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:29:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="281091227"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="281091227"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 11:28:33 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="526728839"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.119.65]) ([10.209.119.65])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 11:28:32 -0700
Subject: Re: [PATCH v5 08/12] x86/tdx: Add HLT support for TDX guest
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-9-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YSUaAQPiBUqubBHM@zn.tnic> <YSUnDQUrGYc8aY9j@google.com>
 <bab4b049-f659-1a63-a0ce-8398589073d7@linux.intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <67faf8de-0bd6-7991-c9bd-f36810df4bd0@linux.intel.com>
Date:   Tue, 24 Aug 2021 11:28:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <bab4b049-f659-1a63-a0ce-8398589073d7@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> It would be helpful to use local variables to document what's up, e.g.
>>
>>       const bool irqs_enabled = true;
>>     const bool do_sti = true;
>>
>>     ret = _tdx_hypercall(EXIT_REASON_HLT, irqs_enabled0, 0, 0, 
>> do_sti, NULL);
>
> Ok. I can follow your suggestion in next submission.


I would use defines for the argument values, then it's self documenting.


-Andi


