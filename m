Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C4233CEC2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 08:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhCPHmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 03:42:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:15409 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231932AbhCPHm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 03:42:27 -0400
IronPort-SDR: GlKDxsDVuD/MYI/OnkfVdCiz+ni/hBs8a03weW60Gh3nQTejD5uHy+bM1+uW9PUS3RaSBtGDjD
 5Ip3C8VczrYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="209144726"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="209144726"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 00:42:27 -0700
IronPort-SDR: SOT3kEfl2i+UFJz7aX3kVYyPYVNk9PEgsM3EumSA/I/dD/xUNUYZy2+DGwg2CyTtTRsguKhqaq
 qQ5Gonrn9S7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="410959022"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga007.jf.intel.com with ESMTP; 16 Mar 2021 00:42:24 -0700
Date:   Tue, 16 Mar 2021 15:42:23 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/x86/kcpuid: Add AMD leaf 0x8000001E
Message-ID: <20210316074223.GC49151@shbuild999.sh.intel.com>
References: <20210315125901.30315-1-bp@alien8.de>
 <20210315125901.30315-2-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315125901.30315-2-bp@alien8.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 01:59:01PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Contains core IDs, node IDs and other topology info.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Acked-by: Feng Tang <feng.tang@intel.com>

Also I'm wondering for some basic leaf and extended leaf which
may has different definition for different vendors, do we need
to seprate the csv to a general one and vendor specific ones.

Thanks,
Feng

> ---
>  tools/arch/x86/kcpuid/cpuid.csv | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
> index dd94c07421a8..4f1c4b0c29e9 100644
> --- a/tools/arch/x86/kcpuid/cpuid.csv
> +++ b/tools/arch/x86/kcpuid/cpuid.csv
> @@ -379,12 +379,22 @@
>  0x80000008,    0,  EAX,   15:8, lnr_adr_bits, Linear Address Bits
>  0x80000007,    0,  EBX,      9, wbnoinvd, WBNOINVD
>  
> +# 0x8000001E
> +# EAX: Extended APIC ID
> +0x8000001E,	0, EAX,   31:0, extended_apic_id, Extended APIC ID
> +# EBX: Core Identifiers
> +0x8000001E,	0, EBX,    7:0, core_id, Identifies the logical core ID
> +0x8000001E,	0, EBX,   15:8, threads_per_core, The number of threads per core is threads_per_core + 1
> +# ECX: Node Identifiers
> +0x8000001E,	0, ECX,    7:0, node_id, Node ID
> +0x8000001E,	0, ECX,   10:8, nodes_per_processor, Nodes per processor { 0: 1 node, else reserved }
> +
>  # 8000001F: AMD Secure Encryption
> -0x8000001F,	0, EAX, 0, sme,	Secure Memory Encryption
> -0x8000001F,	0, EAX, 1, sev,	Secure Encrypted Virtualization
> -0x8000001F,	0, EAX, 2, vmpgflush, VM Page Flush MSR
> -0x8000001F,	0, EAX, 3, seves, SEV Encrypted State
> -0x8000001F,	0, EBX, 5:0, c-bit, Page table bit number used to enable memory encryption
> -0x8000001F,	0, EBX, 11:6, mem_encrypt_physaddr_width, Reduction of physical address space in bits with SME enabled
> -0x8000001F,	0, ECX, 31:0, num_encrypted_guests, Maximum ASID value that may be used for an SEV-enabled guest
> -0x8000001F,	0, EDX, 31:0, minimum_sev_asid, Minimum ASID value that must be used for an SEV-enabled, SEV-ES-disabled guest
> +0x8000001F,	0, EAX,	     0, sme,	Secure Memory Encryption
> +0x8000001F,	0, EAX,      1, sev,	Secure Encrypted Virtualization
> +0x8000001F,	0, EAX,      2, vmpgflush, VM Page Flush MSR
> +0x8000001F,	0, EAX,      3, seves, SEV Encrypted State
> +0x8000001F,	0, EBX,    5:0, c-bit, Page table bit number used to enable memory encryption
> +0x8000001F,	0, EBX,   11:6, mem_encrypt_physaddr_width, Reduction of physical address space in bits with SME enabled
> +0x8000001F,	0, ECX,   31:0, num_encrypted_guests, Maximum ASID value that may be used for an SEV-enabled guest
> +0x8000001F,	0, EDX,   31:0, minimum_sev_asid, Minimum ASID value that must be used for an SEV-enabled, SEV-ES-disabled guest
> -- 
> 2.29.2
