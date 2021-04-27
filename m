Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B152F36CB8C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhD0TS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:18:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:9028 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236327AbhD0TS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:18:56 -0400
IronPort-SDR: kyvqSWjgEsfoAviJaFODORTyNV/woCFsfsWX60DzQD3ds5PjKzbeqksMTw3AfuVPlXMYvLowlZ
 AjPtbf8h4ZZA==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="183714965"
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="183714965"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 12:18:11 -0700
IronPort-SDR: hhiPByXCUgJ0qam0xQ08fAXfcR2Ud0vR8cbsAe5q03nrfz4tphEq1KZDQgLdgDF+onkmXKKG2F
 1OhUwdw+jCSw==
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="386253902"
Received: from mchintha-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.5.143])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 12:18:10 -0700
Subject: Re: [RFC v2 05/32] x86/tdx: Add __tdcall() and __tdvmcall() helper
 functions
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <2f81f67efdf8c68838cdfbb2314e98747cf70120.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <c2edea0c-8de7-3bd3-1dbe-66b585d78e03@intel.com>
 <f310c626-5fd9-7fd3-23fa-e319c0f2aa98@linux.intel.com>
 <33af5bd4-7ada-8450-5a86-90023145d481@intel.com>
 <849d8039-b43c-0790-be1c-aaac8c06608a@linux.intel.com>
 <2f26e352-99e4-8531-221a-eb9641c67ec0@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <95444e56-a674-1152-3039-4e425e5f5a72@linux.intel.com>
Date:   Tue, 27 Apr 2021 12:18:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2f26e352-99e4-8531-221a-eb9641c67ec0@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 4/27/21 7:29 AM, Dave Hansen wrote:
>> Do we need to rename the helper functions ?
>>
>> tdvmcall(), tdvmcall_out_r11()
> Yes.
> 
>> Also what about output structs?
>>
>> struct tdcall_output
>> struct tdvmcall_output
> Yes, they need sane, straightforward names which are not confusing too.
> 

Following is the rename diff. Please let me know if you agree with the
names used.

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 6c3c71bb57a0..95a6a6c6061a 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h

-struct tdcall_output {
+struct tdx_module_output {
         u64 rcx;
         u64 rdx;
         u64 r8;
@@ -19,7 +19,7 @@ struct tdcall_output {
         u64 r11;
  };

-struct tdvmcall_output {
+struct tdx_hypercall_output {
         u64 r11;
         u64 r12;
         u64 r13;
@@ -33,12 +33,12 @@ bool is_tdx_guest(void);
  void __init tdx_early_init(void);

  /* Helper function used to communicate with the TDX module */
-u64 __tdcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
-            struct tdcall_output *out);
+u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+                     struct tdx_module_output *out);

  /* Helper function used to request services from VMM */
-u64 __tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
-              struct tdvmcall_output *out);
+u64 __tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
+                   struct tdx_hypercall_output *out);

--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -8,11 +8,11 @@
  /*
   * Wrapper for use case that checks for error code and print warning message.
   */
-static inline u64 tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
+static inline u64 tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
  {
         u64 err;

-       err = __tdvmcall(fn, r12, r13, r14, r15, NULL);
+       err = __tdx_hypercall(fn, r12, r13, r14, r15, NULL);

         if (err)
                 pr_warn_ratelimited("TDVMCALL fn:%llx failed with err:%llx\n",
@@ -24,13 +24,14 @@ static inline u64 tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
  /*
   * Wrapper for the semi-common case where we need single output value (R11).
   */
-static inline u64 tdvmcall_out_r11(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
+static inline u64 tdx_hypercall_out_r11(u64 fn, u64 r12, u64 r13,
+                                       u64 r14, u64 r15)


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
