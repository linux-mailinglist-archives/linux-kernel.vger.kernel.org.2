Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4E73F6E99
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 06:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhHYEz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 00:55:28 -0400
Received: from ozlabs.org ([203.11.71.1]:33109 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231487AbhHYEz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 00:55:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GvYYV4ptyz9sW4;
        Wed, 25 Aug 2021 14:54:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1629867279;
        bh=6USkAhJ0oXluViRbqhukVgyp9Ff7O5VeFJemuQn0/z0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=D2Nwdl+ZVgX3SeYJ2ojs0HTtnSjp/ebc7zdM9XMo70wcykh9w69FAZguzIykAggIT
         gP2IjEe2OpeLyOJC1U/IKVmcxeqhXZDL69Tn7QVrvPTTzKIwUotqVshZn48lr0qTzX
         trmBFTGN1Ojx37NzfaEIvLa7SP6LFDJsU6e9dtyKqbTHvoubOhluSK7h0Q7DpmUY32
         b1lLJbGeeVggmb+9YkX4UjsoP+Uh8JH4kYMkZW48AF6iTV2oMmMvwoxx8oUPc5Gnpx
         ooq6Vj+n4kdfga4chsOukErEhGdcsEnwnT9/lc28RHBRqN1sJf8uOwsUCTVJjMcToM
         hXnLapTZCVWMw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 3/3] powerpc: Define and use MSR_RI only on non
 booke/40x
In-Reply-To: <627ead32d40c840f9e8a329b60647b649eceb2aa.1629707037.git.christophe.leroy@csgroup.eu>
References: <385ead49ccb66a259b25fee3eebf0bd4094068f3.1629707037.git.christophe.leroy@csgroup.eu>
 <627ead32d40c840f9e8a329b60647b649eceb2aa.1629707037.git.christophe.leroy@csgroup.eu>
Date:   Wed, 25 Aug 2021 14:54:32 +1000
Message-ID: <8735qyceev.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 40x and BOOKE don't have MSR_RI.
>
> Define MSR_RI only for platforms where it exists. For the other ones,
> defines it as BUILD_BUG for C and do not define it for ASM.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v3: Fixes kvm_emul.S and include <linux/bug.h> in <asm/reg.h>
> ---
>  arch/powerpc/include/asm/reg.h       |  5 +++++
>  arch/powerpc/include/asm/reg_booke.h |  6 +++---
>  arch/powerpc/kernel/head_32.h        |  4 ++++
>  arch/powerpc/kernel/kvm_emul.S       | 13 +++++++++++++
>  arch/powerpc/kernel/process.c        |  2 +-
>  arch/powerpc/lib/sstep.c             |  2 +-
>  6 files changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index be85cf156a1f..b270b570fb51 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -109,7 +109,12 @@
>  #ifndef MSR_PMM
>  #define MSR_PMM		__MASK(MSR_PMM_LG)	/* Performance monitor */
>  #endif
> +#if !defined(CONFIG_BOOKE) && !defined(CONFIG_40x)
>  #define MSR_RI		__MASK(MSR_RI_LG)	/* Recoverable Exception */

This breaks 64-bit BookE, which is using MSR_RI in bookehv_interrupts.S.

eg. ppc64_book3e_allmodconfig gives:

  arch/powerpc/kvm/bookehv_interrupts.S: Assembler messages:
  arch/powerpc/kvm/bookehv_interrupts.S:221: Error: invalid operands (*ABS* and *UND* sections) for `|'
  etc.

ISA v2.07B says MSR_RI is Book3S only, but looking at the e500mc manual
it does have bit 62 defined as RI.

I can fix it with:

+#if !(defined(CONFIG_BOOKE) && !defined(CONFIG_PPC_BOOK3E)) && !defined(CONFIG_40x)
 #define MSR_RI         __MASK(MSR_RI_LG)       /* Recoverable Exception */


But that's getting really ugly, and we'd have to repeat it elsewhere.

I think we need a kconfig symbol that captures which platforms should
use MSR_RI, something like:

  CONFIG PPC_MSR_RI
    def_bool y
    depends on !40x && (!BOOKE || PPC_BOOK3E)


Or maybe we should just define MSR_RI to 0 for platforms that don't use
it, to avoid so much ifdefing?

cheers
