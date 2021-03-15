Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E809933A98C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 03:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCOCMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 22:12:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:27275 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhCOCML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 22:12:11 -0400
IronPort-SDR: zXOzwZbtZh7ysEAGddk8QIl/MjOAGT2ApoY+E+x7WJcO1njgFuTmOxouDbAOKNOBDy3ci8hMLI
 rZDk0JG4jbmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9923"; a="253041985"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="253041985"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 19:12:10 -0700
IronPort-SDR: LY+1dle2mbvLHjWDvQ2ADI6xg+6nEUEY46E963JUKjP9vApxX0h82+ab/+xEKI7VfDgVf0728G
 rurd7KqVdP1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="373280366"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2021 19:12:09 -0700
Date:   Mon, 15 Mar 2021 10:12:08 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/x86/kcpuid: Add AMD Secure Encryption leaf
Message-ID: <20210315021208.GA49151@shbuild999.sh.intel.com>
References: <20210313140118.17010-1-bp@alien8.de>
 <20210314003527.GJ16144@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314003527.GJ16144@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 01:35:27AM +0100, Borislav Petkov wrote:
> On Sat, Mar 13, 2021 at 03:01:18PM +0100, Borislav Petkov wrote:
 
> Yeah, I guess we should keep the bit names in lowercase, for simplicity.
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Sat, 13 Mar 2021 14:56:16 +0100
> Subject: [PATCH] tools/x86/kcpuid: Add AMD Secure Encryption leaf
> 
> Add the 0x8000001f leaf's fields.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Acked-by: Feng Tang <feng.tang@intel.com>

Thanks!

> ---
>  tools/arch/x86/kcpuid/cpuid.csv | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
> index f4a5b85073f4..dd94c07421a8 100644
> --- a/tools/arch/x86/kcpuid/cpuid.csv
> +++ b/tools/arch/x86/kcpuid/cpuid.csv
> @@ -378,3 +378,13 @@
>  0x80000008,    0,  EAX,    7:0, phy_adr_bits, Physical Address Bits
>  0x80000008,    0,  EAX,   15:8, lnr_adr_bits, Linear Address Bits
>  0x80000007,    0,  EBX,      9, wbnoinvd, WBNOINVD
> +
> +# 8000001F: AMD Secure Encryption
> +0x8000001F,	0, EAX, 0, sme,	Secure Memory Encryption
> +0x8000001F,	0, EAX, 1, sev,	Secure Encrypted Virtualization
> +0x8000001F,	0, EAX, 2, vmpgflush, VM Page Flush MSR
> +0x8000001F,	0, EAX, 3, seves, SEV Encrypted State
> +0x8000001F,	0, EBX, 5:0, c-bit, Page table bit number used to enable memory encryption
> +0x8000001F,	0, EBX, 11:6, mem_encrypt_physaddr_width, Reduction of physical address space in bits with SME enabled
> +0x8000001F,	0, ECX, 31:0, num_encrypted_guests, Maximum ASID value that may be used for an SEV-enabled guest
> +0x8000001F,	0, EDX, 31:0, minimum_sev_asid, Minimum ASID value that must be used for an SEV-enabled, SEV-ES-disabled guest
> -- 
> 2.29.2
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
