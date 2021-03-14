Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E53133A214
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 01:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhCNAfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 19:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhCNAfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 19:35:38 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB9DC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 16:35:34 -0800 (PST)
Received: from zn.tnic (p200300ec2f197100245a75be5ab47287.dip0.t-ipconnect.de [IPv6:2003:ec:2f19:7100:245a:75be:5ab4:7287])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D16C01EC00F4;
        Sun, 14 Mar 2021 01:35:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615682130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WceBjBEEfXksn6Fag8ZxqkeLjM5k6VlVNuMcuRE/a4Y=;
        b=J3pKXQnXWONJP7CKMoXq/fUx73kaZazRLP5F4ZxCJ5nnHZQSQVrRiHkVi9tFK6kHcufeco
        H7wgLs4nQMZ5LwSw/Kj1gubsUyzpHW5ptG6STFdGRPWe8G2wGRapBzW1d9aw8rh297fZV9
        F/BYSqxctApiakiR84DEukD97uWCihs=
Date:   Sun, 14 Mar 2021 01:35:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Feng Tang <feng.tang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/x86/kcpuid: Add AMD Secure Encryption leaf
Message-ID: <20210314003527.GJ16144@zn.tnic>
References: <20210313140118.17010-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210313140118.17010-1-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 03:01:18PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Add the 0x8000001f leaf's fields.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  tools/arch/x86/kcpuid/cpuid.csv | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
> index f4a5b85073f4..7cb5c2189345 100644
> --- a/tools/arch/x86/kcpuid/cpuid.csv
> +++ b/tools/arch/x86/kcpuid/cpuid.csv
> @@ -378,3 +378,13 @@
>  0x80000008,    0,  EAX,    7:0, phy_adr_bits, Physical Address Bits
>  0x80000008,    0,  EAX,   15:8, lnr_adr_bits, Linear Address Bits
>  0x80000007,    0,  EBX,      9, wbnoinvd, WBNOINVD
> +
> +# 8000001F: AMD Secure Encryption
> +0x8000001F,	0, EAX, 0, SME,	Secure Memory Encryption
> +0x8000001F,	0, EAX, 1, SEV,	Secure Encrypted Virtualization
> +0x8000001F,	0, EAX, 2, VmPgFlush, VM Page Flush MSR
> +0x8000001F,	0, EAX, 3, SevEs, SEV Encrypted State
> +0x8000001F,	0, EBX, 5:0, C-Bit, Page table bit number used to enable memory encryption
> +0x8000001F,	0, EBX, 11:6, MemEncryptPhysAddWidth, Reduction of physical address space in bits when SME is enabled
> +0x8000001F,	0, ECX, 31:0, NumEncryptedGuests, Maximum ASID value that may be used for an SEV-enabled guest
> +0x8000001F,	0, EDX, 31:0, MinimumSEVASID, Minimum ASID value that must be used for an SEV-enabled, SEV-ES-disabled guest

Yeah, I guess we should keep the bit names in lowercase, for simplicity.

---
From: Borislav Petkov <bp@suse.de>
Date: Sat, 13 Mar 2021 14:56:16 +0100
Subject: [PATCH] tools/x86/kcpuid: Add AMD Secure Encryption leaf

Add the 0x8000001f leaf's fields.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 tools/arch/x86/kcpuid/cpuid.csv | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index f4a5b85073f4..dd94c07421a8 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -378,3 +378,13 @@
 0x80000008,    0,  EAX,    7:0, phy_adr_bits, Physical Address Bits
 0x80000008,    0,  EAX,   15:8, lnr_adr_bits, Linear Address Bits
 0x80000007,    0,  EBX,      9, wbnoinvd, WBNOINVD
+
+# 8000001F: AMD Secure Encryption
+0x8000001F,	0, EAX, 0, sme,	Secure Memory Encryption
+0x8000001F,	0, EAX, 1, sev,	Secure Encrypted Virtualization
+0x8000001F,	0, EAX, 2, vmpgflush, VM Page Flush MSR
+0x8000001F,	0, EAX, 3, seves, SEV Encrypted State
+0x8000001F,	0, EBX, 5:0, c-bit, Page table bit number used to enable memory encryption
+0x8000001F,	0, EBX, 11:6, mem_encrypt_physaddr_width, Reduction of physical address space in bits with SME enabled
+0x8000001F,	0, ECX, 31:0, num_encrypted_guests, Maximum ASID value that may be used for an SEV-enabled guest
+0x8000001F,	0, EDX, 31:0, minimum_sev_asid, Minimum ASID value that must be used for an SEV-enabled, SEV-ES-disabled guest
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
