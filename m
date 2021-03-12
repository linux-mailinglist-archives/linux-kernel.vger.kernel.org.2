Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E45D338E51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhCLNJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:09:31 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:55158 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbhCLNJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:09:11 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DxmNj2M3Nz9ttBX;
        Fri, 12 Mar 2021 14:09:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hVMvcGhuLUiu; Fri, 12 Mar 2021 14:09:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DxmNj0Vbsz9ttBW;
        Fri, 12 Mar 2021 14:09:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1ED378B812;
        Fri, 12 Mar 2021 14:09:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PiXVMXcPudGi; Fri, 12 Mar 2021 14:09:09 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A0B5B8B764;
        Fri, 12 Mar 2021 14:09:08 +0100 (CET)
Subject: Re: [PATCH] powerpc/vdso32: Add missing _restgpr_31_x to fix build
 failure
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <a7aa198a88bcd33c6e35e99f70f86c7b7f2f9440.1615270757.git.christophe.leroy@csgroup.eu>
Message-ID: <d28e06ff-ade0-588f-42a5-ca01e6ebda80@csgroup.eu>
Date:   Fri, 12 Mar 2021 14:09:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <a7aa198a88bcd33c6e35e99f70f86c7b7f2f9440.1615270757.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/03/2021 à 07:19, Christophe Leroy a écrit :
> With some defconfig including CONFIG_CC_OPTIMIZE_FOR_SIZE,
> (for instance mvme5100_defconfig and ps3_defconfig), gcc 5
> generates a call to _restgpr_31_x.
> 
> Until recently it went unnoticed, but
> commit 42ed6d56ade2 ("powerpc/vdso: Block R_PPC_REL24 relocations")
> made it rise to the surface.
> 
> Provide that function (copied from lib/crtsavres.S) in
> gettimeofday.S
> 
> Fixes: ab037dd87a2f ("powerpc/vdso: Switch VDSO to generic C implementation.")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Fixes the following builds:

http://kisskb.ellerman.id.au/kisskb/buildresult/14492138/
http://kisskb.ellerman.id.au/kisskb/buildresult/14492041/

Christophe


> ---
> I don't know if there is a way to tell GCC not to emit that call, because at the end we get more instructions than needed.
> ---
>   arch/powerpc/kernel/vdso32/gettimeofday.S | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
> index a6e29f880e0e..d21d08140a5e 100644
> --- a/arch/powerpc/kernel/vdso32/gettimeofday.S
> +++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
> @@ -65,3 +65,14 @@ V_FUNCTION_END(__kernel_clock_getres)
>   V_FUNCTION_BEGIN(__kernel_time)
>   	cvdso_call_time __c_kernel_time
>   V_FUNCTION_END(__kernel_time)
> +
> +/* Routines for restoring integer registers, called by the compiler.  */
> +/* Called with r11 pointing to the stack header word of the caller of the */
> +/* function, just beyond the end of the integer restore area.  */
> +_GLOBAL(_restgpr_31_x)
> +_GLOBAL(_rest32gpr_31_x)
> +	lwz	r0,4(r11)
> +	lwz	r31,-4(r11)
> +	mtlr	r0
> +	mr	r1,r11
> +	blr
> 
