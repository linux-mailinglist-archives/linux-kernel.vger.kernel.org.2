Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2624E3F8132
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 05:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbhHZDm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 23:42:28 -0400
Received: from ozlabs.org ([203.11.71.1]:50059 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231720AbhHZDm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 23:42:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gw7tq63LGz9sWc;
        Thu, 26 Aug 2021 13:41:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1629949299;
        bh=DOw2l6Jda3DqQNHFGaITrApyDjSMpEMLIntdf1DiSP0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jIpmv8UVeu5dr3PjzdyCas29MtHm7Yh99AmOc530xFwa+L1Oi5y3jCO+qO+rtvYsL
         q0l5hw6pemI8mYmn7qn7j3p/GSU1rx0jDZdoyTOnHNw2M7k0D+ofKnKiYL966IwrF+
         wBwwmE3j/otN99PTlnegLwg5bKJvDTByqGf1gploLvZoMVyX47jxlorPSjdyfvZdwq
         kQtVesz74C6ZCYkwlam0vHnvUbHB2X1vns0QKCBLwqA91lMuJ7X2hl1Kd7SuvI+n6I
         W39d3/5e4GPl5ljXmTt5db9z2hh6WRytOWWWw8ictlESSmv59W4iTjcpN+BaCXZgMk
         H4cS5GIbCU/Dg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Make set_endian() return EINVAL when not
 supporting little endian
In-Reply-To: <b29c29d205737a833262df38e01c07139f1c3dec.1629899011.git.christophe.leroy@csgroup.eu>
References: <b29c29d205737a833262df38e01c07139f1c3dec.1629899011.git.christophe.leroy@csgroup.eu>
Date:   Thu, 26 Aug 2021 13:41:39 +1000
Message-ID: <87bl5kc1os.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> There is no point in modifying MSR_LE bit on CPUs not supporting
> little endian.

Isn't that an ABI break?

set_endian(PR_ENDIAN_BIG) should work on a big endian CPU, even if it
does nothing useful.

cheers

> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 185beb290580..b2b9919795a2 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1995,6 +1995,10 @@ int set_endian(struct task_struct *tsk, unsigned int val)
>  {
>  	struct pt_regs *regs = tsk->thread.regs;
>  
> +	if (!cpu_has_feature(CPU_FTR_PPC_LE) &&
> +	    !cpu_has_feature(CPU_FTR_REAL_LE))
> +		return -EINVAL;
> +
>  	if ((val == PR_ENDIAN_LITTLE && !cpu_has_feature(CPU_FTR_REAL_LE)) ||
>  	    (val == PR_ENDIAN_PPC_LITTLE && !cpu_has_feature(CPU_FTR_PPC_LE)))
>  		return -EINVAL;
> -- 
> 2.25.0
