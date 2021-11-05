Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D9A445FA2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 07:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhKEGQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 02:16:23 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:53167 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhKEGQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 02:16:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HlqvR23wKz4xdM;
        Fri,  5 Nov 2021 17:13:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1636092822;
        bh=Akk3WhXsvfpdeVPhfE7p2R9m6g/Ee2L7iXINN1roAwM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aZppCqTBm/BLADJpHbam080p9z5LzrnvaxmqW/JYkzoFn+KWSK/bdz5kERUEMKjGo
         MmVyNccD93tbxX5sginHmkIpJ1DZ0UKGWTXIbyiaNldwM20mAQS+NkFXIHwynf+F5z
         qMQIK9+mdJcCMVCUfmQbWTuBsGWMMIsnMtXScCOPljP6z03akr6JLLY2bo3SD7tcbY
         a3+h4BPpOfH72QKrKdJVbJBfNPIzM5BcOPunl0PdbzhLN+IXvHEQ0SiFnigpessbks
         9gfExohYy5m0Yp1eTUdGpgejMLIbprXrYXoDOwSbQJOudSfACIWy5TNGSLmo7cdVzI
         muzEztovXqMow==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     cgel.zte@gmail.com
Cc:     benh@kernel.crashing.org, paulus@samba.org, ye.guojin@zte.com.cn,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] powerpc: xmon: remove the duplicated operand of the
 bitwise operator
In-Reply-To: <20211105034011.76008-1-ye.guojin@zte.com.cn>
References: <20211105034011.76008-1-ye.guojin@zte.com.cn>
Date:   Fri, 05 Nov 2021 17:13:35 +1100
Message-ID: <87y2636sfk.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgel.zte@gmail.com writes:
> From: Ye Guojin <ye.guojin@zte.com.cn>
>
> The operands of the bitwise OR operator are duplicated, remove one of
> them.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
> ---
>  arch/powerpc/xmon/ppc-opc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, but this code is copied from binutils, we don't take cleanup
patches to it.

cheers

> diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-opc.c
> index dfb80810b16c..2cab0ec0d162 100644
> --- a/arch/powerpc/xmon/ppc-opc.c
> +++ b/arch/powerpc/xmon/ppc-opc.c
> @@ -6731,9 +6731,9 @@ const struct powerpc_opcode powerpc_opcodes[] = {
>  {"fre.",	A(63,24,1),   AFRALFRC_MASK, POWER5,	POWER7|PPCVLE,	{FRT, FRB, A_L}},
>  
>  {"fmul",	A(63,25,0),	AFRB_MASK,   PPCCOM,	PPCEFS|PPCVLE,	{FRT, FRA, FRC}},
> -{"fm",		A(63,25,0),	AFRB_MASK,   PWRCOM,	PPCVLE|PPCVLE,	{FRT, FRA, FRC}},
> +{"fm",		A(63, 25, 0),	AFRB_MASK,   PWRCOM,	PPCVLE,	{FRT, FRA, FRC}},
>  {"fmul.",	A(63,25,1),	AFRB_MASK,   PPCCOM,	PPCEFS|PPCVLE,	{FRT, FRA, FRC}},
> -{"fm.",		A(63,25,1),	AFRB_MASK,   PWRCOM,	PPCVLE|PPCVLE,	{FRT, FRA, FRC}},
> +{"fm.",		A(63, 25, 1),	AFRB_MASK,   PWRCOM,	PPCVLE,	{FRT, FRA, FRC}},
>  
>  {"frsqrte",	A(63,26,0),   AFRAFRC_MASK,  POWER7,	PPCVLE,		{FRT, FRB}},
>  {"frsqrte",	A(63,26,0),   AFRALFRC_MASK, PPC,	POWER7|PPCVLE,	{FRT, FRB, A_L}},
> -- 
> 2.25.1
