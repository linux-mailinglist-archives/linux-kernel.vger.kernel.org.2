Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA3837AA47
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhEKPKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:10:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:15577 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231646AbhEKPKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:10:44 -0400
IronPort-SDR: 6BLwMu5fiWWSOVqUE7NW3lKqEDp2Gd3vKtJPMXCKVGfzVN1ZhbgNOIBMSFPTtCrR783TyG2xXG
 u5odva6keotA==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="179727686"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="179727686"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 08:08:24 -0700
IronPort-SDR: qcWUS6YAnkI8cK04qriPlYzjT66gmkXiVHtyCqzUgPuFVTHQ77uarh4gDSOoLUDu2GzmnQ/6xT
 OXOsuqaLwhKw==
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="621848341"
Received: from jamtsfi1-mobl2.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.177.109])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 08:08:23 -0700
Subject: Re: [RFC v2 14/32] x86/tdx: Handle port I/O
To:     Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0e7e94d1ee4bae49dfd0dd441dc4f2ab6df76668.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jPLGs6p0PNZQB6yKB3QDtEcGb234zcgCbJutXxZZEGnA@mail.gmail.com>
 <e8ac31bc-e307-f277-f928-24ebba4cbca7@linux.intel.com>
 <CAPcyv4iuRdXooQvCzEWd9babzPij4nXpM-z5fai9+SGaeFYswQ@mail.gmail.com>
 <9f89a317-11fa-d784-87a8-37124891900c@linux.intel.com>
 <CAPcyv4hymb73WZ7QqNsDyKiPzsFdPJF63+MLnOTfJMsQBFvSDg@mail.gmail.com>
 <3059c7d3-8646-2e1a-3c9f-1de67f7ed382@linux.intel.com>
 <609b1182-5629-0727-d174-849c113a3960@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <abf24e52-3fee-eda1-4606-ea2aa43061d8@linux.intel.com>
Date:   Tue, 11 May 2021 08:08:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <609b1182-5629-0727-d174-849c113a3960@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/21 7:39 AM, Dave Hansen wrote:
> To what you do you refer by "this patch allocates this memory in ASM
> code"?  Could you point to the specific ASM code that "allocates memory"?

We use 40 bytes in stack for storing the output register values. It is in
function tdg_inl().

subq $TDVMCALL_OUTPUT_SIZE, %rsp

+SYM_FUNC_START(tdg_inl)
+	io_save_registers
+	/* Set data width to 4 bytes */
+	mov $4, %rsi
+1:
+	mov %rdx, %rcx
+	/* Set 0 in RDX to select in operation */
+	mov $0, %rdx
+	/* Set TDVMCALL function id in RDI */
+	mov $EXIT_REASON_IO_INSTRUCTION, %rdi
+	/* Set TDVMCALL type info (0 - Standard, > 0 - vendor) in R10 */
+	xor %r10, %r10
+	/* Allocate memory in stack for Output */
+	subq $TDVMCALL_OUTPUT_SIZE, %rsp
+	/* Move tdvmcall_output pointer to R9 */
+	movq %rsp, %r9
+
+	call do_tdvmcall

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
