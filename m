Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F7B338E73
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhCLNMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:12:46 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:20715 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231232AbhCLNM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:12:28 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DxmSV0l1Cz9ttBZ;
        Fri, 12 Mar 2021 14:12:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id dbspsLRag-9D; Fri, 12 Mar 2021 14:12:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DxmST7393z9ttBX;
        Fri, 12 Mar 2021 14:12:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CB1478B814;
        Fri, 12 Mar 2021 14:12:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hkgekSXdy3BK; Fri, 12 Mar 2021 14:12:26 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3BFCA8B764;
        Fri, 12 Mar 2021 14:12:26 +0100 (CET)
Subject: Re: [PATCH] powerpc: Force inlining of cpu_has_feature() to avoid
 build failure
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <b231dfa040ce4cc37f702f5c3a595fdeabfe0462.1615378209.git.christophe.leroy@csgroup.eu>
Message-ID: <c3563256-7cde-3a42-dbf0-6ce31141ad30@csgroup.eu>
Date:   Fri, 12 Mar 2021 14:12:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <b231dfa040ce4cc37f702f5c3a595fdeabfe0462.1615378209.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/03/2021 à 13:10, Christophe Leroy a écrit :
> The code relies on constant folding of cpu_has_feature() based
> on possible and always true values as defined per
> CPU_FTRS_ALWAYS and CPU_FTRS_POSSIBLE.
> 
> Build failure is encountered with for instance
> book3e_all_defconfig on kisskb in the AMDGPU driver which uses
> cpu_has_feature(CPU_FTR_VSX_COMP) to decide whether calling
> kernel_enable_vsx() or not.
> 
> The failure is due to cpu_has_feature() not being inlined with
> that configuration with gcc 4.9.
> 
> In the same way as commit acdad8fb4a15 ("powerpc: Force inlining of
> mmu_has_feature to fix build failure"), for inlining of
> cpu_has_feature().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Fixes following build

http://kisskb.ellerman.id.au/kisskb/buildresult/14489391/

> ---
>   arch/powerpc/include/asm/cpu_has_feature.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cpu_has_feature.h b/arch/powerpc/include/asm/cpu_has_feature.h
> index 7897d16e0990..727d4b321937 100644
> --- a/arch/powerpc/include/asm/cpu_has_feature.h
> +++ b/arch/powerpc/include/asm/cpu_has_feature.h
> @@ -7,7 +7,7 @@
>   #include <linux/bug.h>
>   #include <asm/cputable.h>
>   
> -static inline bool early_cpu_has_feature(unsigned long feature)
> +static __always_inline bool early_cpu_has_feature(unsigned long feature)
>   {
>   	return !!((CPU_FTRS_ALWAYS & feature) ||
>   		  (CPU_FTRS_POSSIBLE & cur_cpu_spec->cpu_features & feature));
> @@ -46,7 +46,7 @@ static __always_inline bool cpu_has_feature(unsigned long feature)
>   	return static_branch_likely(&cpu_feature_keys[i]);
>   }
>   #else
> -static inline bool cpu_has_feature(unsigned long feature)
> +static __always_inline bool cpu_has_feature(unsigned long feature)
>   {
>   	return early_cpu_has_feature(feature);
>   }
> 
