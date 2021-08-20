Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E7E3F2BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbhHTMPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbhHTMPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:15:53 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F19C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:15:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GrgZ76jtVz9sSs;
        Fri, 20 Aug 2021 22:15:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1629461712;
        bh=609cs8/ZKSokRrE5mm7yk2+EH7BrmOScRj51bRNnHGc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=f9PP9ngn8mbR1XFMZkHqpg+kv5siFN27WlLpKJIciuS1c5jsP3d7q1Z80nfJDoUgP
         KzEkad0pPoYc6Gl45PfQ7OFetPHwpu+qU+K8wiCC7LZ8sIQzFhahLu1BohB5gPqG7f
         2d+HNjE2Sc7P0ojy3h+xUBOknEsCkFwOP5xQwySZRWJpx1N0257yV2GAqElDMvy9uo
         r2FwlCIRx/Xu5r0OAojiYEh7qJxaDn0VLDJDj/l376Z/bWt9O3lHzBc3tJ7y7ulqb9
         flrfj2Gqi4w9Q+3jCoIuMoEblOwyein3gZLuAqdJ+WP/mLHCxizfkK94S/x3Z28vy8
         980Kas9oeGpow==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32: indirect function call use bctrl rather
 than blrl in ret_from_kernel_thread
In-Reply-To: <91b1d242525307ceceec7ef6e832bfbacdd4501b.1629436472.git.christophe.leroy@csgroup.eu>
References: <91b1d242525307ceceec7ef6e832bfbacdd4501b.1629436472.git.christophe.leroy@csgroup.eu>
Date:   Fri, 20 Aug 2021 22:15:11 +1000
Message-ID: <871r6oe2i8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Copied from commit 89bbe4c798bc ("powerpc/64: indirect function call
> use bctrl rather than blrl in ret_from_kernel_thread")
>
> blrl is not recommended to use as an indirect function call, as it may
> corrupt the link stack predictor.

Do we know if any 32-bit CPUs have a link stack predictor or similar?

cheers

> This is not a performance critical path but this should be fixed for
> consistency.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/entry_32.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 0273a1349006..61fdd53cdd9a 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -161,10 +161,10 @@ ret_from_fork:
>  ret_from_kernel_thread:
>  	REST_NVGPRS(r1)
>  	bl	schedule_tail
> -	mtlr	r14
> +	mtctr	r14
>  	mr	r3,r15
>  	PPC440EP_ERR42
> -	blrl
> +	bctrl
>  	li	r3,0
>  	b	ret_from_syscall
>  
> -- 
> 2.25.0
