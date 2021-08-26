Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5093F81D3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 06:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbhHZE6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 00:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhHZE6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 00:58:34 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B52C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 21:57:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gw9Zb2cq8z9sXM;
        Thu, 26 Aug 2021 14:57:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1629953863;
        bh=Wc8gisJFzR+NRbBpxFzMI1jqsCul17TIuMj9lRWpS9M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=L5kddt7Q9EwoKdr7oDa9NIdSnMu6IfoKHyMvMlyv2Zt3z7ORaQZZlDD1PoeRpxEgJ
         qbYoSwg8tvBE5itxezRxDO19sV467M3aK4khMrEeqvbHSFmqR0dzgvy5P+zoMX67uV
         T4SQakC6x0/TG6zk6C7VMibohBD8ZyQxj4emEWK/CbhKA46kMfTZZnIuPZvX78zcef
         cmQ2330nS0tSNCZuacnhT3ChHxMh02k3xPxI8CwLq98BJP6ViJC8eKoFrQh1UKPzUA
         uS7hotZyB3/u5Mn4lxmqjS5s/+llsjfUD6nShhyHd7g73CCGoEiornanDS3jktue7t
         3aoXDwpzqs1Xw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Redefine HMT_xxx macros as empty on PPC32
In-Reply-To: <c5a07fadea33d640ad10cecf0ac8faaec1c524e0.1629898474.git.christophe.leroy@csgroup.eu>
References: <c5a07fadea33d640ad10cecf0ac8faaec1c524e0.1629898474.git.christophe.leroy@csgroup.eu>
Date:   Thu, 26 Aug 2021 14:57:42 +1000
Message-ID: <878s0oby61.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> HMT_xxx macros are macros for adjusting thread priority
> (hardware multi-threading) are macros inherited from PPC64
> via commit 5f7c690728ac ("[PATCH] powerpc: Merged ppc_asm.h")
>
> Those instructions are pointless on PPC32, but some common
> fonctions like arch_cpu_idle() use them.
>
> So make them empty on PPC32 to avoid those instructions.

I guess we're pretty sure no 32-bit CPUs do anything with those.

e6500 can run in 32-bit mode, and is 2-way threaded AIUI, so it's
*possible* it could use them.

But I can't find any mention of those special nops in the e6500 core
manual. And actually it does have documentation about thread priority
registers, PPR32, TPRI0/1, but it says they're not used in e6500.

So I guess this seems safe, I'll pick it up.

cheers

> diff --git a/arch/powerpc/include/asm/vdso/processor.h b/arch/powerpc/include/asm/vdso/processor.h
> index e072577bc7c0..8d79f994b4aa 100644
> --- a/arch/powerpc/include/asm/vdso/processor.h
> +++ b/arch/powerpc/include/asm/vdso/processor.h
> @@ -5,12 +5,21 @@
>  #ifndef __ASSEMBLY__
>  
>  /* Macros for adjusting thread priority (hardware multi-threading) */
> +#ifdef CONFIG_PPC64
>  #define HMT_very_low()		asm volatile("or 31, 31, 31	# very low priority")
>  #define HMT_low()		asm volatile("or 1, 1, 1	# low priority")
>  #define HMT_medium_low()	asm volatile("or 6, 6, 6	# medium low priority")
>  #define HMT_medium()		asm volatile("or 2, 2, 2	# medium priority")
>  #define HMT_medium_high()	asm volatile("or 5, 5, 5	# medium high priority")
>  #define HMT_high()		asm volatile("or 3, 3, 3	# high priority")
> +#else
> +#define HMT_very_low()
> +#define HMT_low()
> +#define HMT_medium_low()
> +#define HMT_medium()
> +#define HMT_medium_high()
> +#define HMT_high()
> +#endif
>  
>  #ifdef CONFIG_PPC64
>  #define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
> -- 
> 2.25.0
