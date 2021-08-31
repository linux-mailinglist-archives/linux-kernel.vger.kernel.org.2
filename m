Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69983FCED3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241247AbhHaUuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:50:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:51488 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229916AbhHaUux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:50:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="215434694"
X-IronPort-AV: E=Sophos;i="5.84,367,1620716400"; 
   d="scan'208";a="215434694"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 13:49:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,367,1620716400"; 
   d="scan'208";a="460331329"
Received: from krbo1-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.32.188])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 13:49:57 -0700
Subject: Re: [PATCH v5 08/12] x86/tdx: Add HLT support for TDX guest
To:     Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-9-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YSUaAQPiBUqubBHM@zn.tnic> <YSUnDQUrGYc8aY9j@google.com>
 <YSUsBVx2DD7MCyn/@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <0d2421ac-c501-d33f-d3fc-be9dac7e221c@linux.intel.com>
Date:   Tue, 31 Aug 2021 13:49:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSUsBVx2DD7MCyn/@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 8/24/21 10:27 AM, Borislav Petkov wrote:
> I think in the next version all those _tdx_hypercall() wrappers should
> spell it out what the parameters they pass are used for.
> 
> Hohumm.

Regarding details about _tdx_hypercall() wrapper usage, do you want me
to document the ABI details?

For example for MSR read,

static u64 tdx_read_msr_safe(unsigned int msr, int *err)
{
         struct tdx_hypercall_output out = {0};
         u64 ret;

         WARN_ON_ONCE(tdx_is_context_switched_msr(msr));

         /*
          * TDX MSR READ Hypercall ABI:
          *
          * Input Registers:
          *
          * R11(EXIT_REASON_MSR_READ) - hypercall sub function id
          * R12(msr) - MSR index
          *
          * Output Registers:
          *
          * R10(out.r10) - Hypercall return error code
          * R11(out.r11) - MSR read value
          * RAX(ret) - TDCALL error code
          */
         ret = _tdx_hypercall(EXIT_REASON_MSR_READ, msr, 0, 0, 0, &out);

Let me know if you agree with above format?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
