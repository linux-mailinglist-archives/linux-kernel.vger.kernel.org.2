Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0AF41A41A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 02:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbhI1AVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 20:21:09 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:33799 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbhI1AVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 20:21:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HJKrJ5M3zz4xLs;
        Tue, 28 Sep 2021 10:19:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1632788368;
        bh=mIwKTL/6vQf6UwYRTbvOgxIEqEcbaxe7nzUDzD7ufKk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WY0WSjfKEYV81l5c4MWdMF3j3Y/k5/zK/IffwOYcBARS5Iupu3Connde/bNmIDjee
         MTscRq5RVYLAcr/uJOiXlIp5qEsHZSHFqpeNoy1cF5oO1kN38XiCMbvMLOxEaDT4oZ
         kPH8eGG38SPEZ8l8fLYVT7d4UcWTtvYVOJv1pXtUa/FEOQrSEP+NSDpo2JsoVkz9fm
         TyVoxuMM5nwXiFJnr7yOW2JGsNgGvrFbTtQVnxGyQ2hLTdb+y4EMLmGe2n78StUyB2
         gp91MY21/yF1KPXSFDUoPj4q5lVPlkkiqOzTZqPm/lepPlkkEvL9ts+9H9R6fhcDBX
         B6ILLbR+5x6kg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        cp <carlojpisani@gmail.com>
Subject: Re: [PATCH] powerpc/40x: Map 32Mbytes of memory at startup
In-Reply-To: <e2b142ad4a44535d5aa81b0c00c5f05f312f9097.1632738876.git.christophe.leroy@csgroup.eu>
References: <e2b142ad4a44535d5aa81b0c00c5f05f312f9097.1632738876.git.christophe.leroy@csgroup.eu>
Date:   Tue, 28 Sep 2021 10:19:28 +1000
Message-ID: <87mtnx1rhr.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> As reported by Carlo, 16Mbytes is not enough with modern kernels
> that tend to be a bit big, so map another 16M page at boot.

I guess we're not expecting systems with less than 32MB, so making it
unconditional is OK?

cheers

> diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
> index 7d72ee5ab387..5fce4680d2d3 100644
> --- a/arch/powerpc/kernel/head_40x.S
> +++ b/arch/powerpc/kernel/head_40x.S
> @@ -650,7 +650,7 @@ start_here:
>  	b	.		/* prevent prefetch past rfi */
>  
>  /* Set up the initial MMU state so we can do the first level of
> - * kernel initialization.  This maps the first 16 MBytes of memory 1:1
> + * kernel initialization.  This maps the first 32 MBytes of memory 1:1
>   * virtual to physical and more importantly sets the cache mode.
>   */
>  initial_mmu:
> @@ -687,6 +687,12 @@ initial_mmu:
>  	tlbwe	r4,r0,TLB_DATA		/* Load the data portion of the entry */
>  	tlbwe	r3,r0,TLB_TAG		/* Load the tag portion of the entry */
>  
> +	li	r0,62			/* TLB slot 62 */
> +	addis	r4,r4,SZ_16M
> +	addis	r3,r3,SZ_16M
> +	tlbwe	r4,r0,TLB_DATA		/* Load the data portion of the entry */
> +	tlbwe	r3,r0,TLB_TAG		/* Load the tag portion of the entry */
> +
>  	isync
>  
>  	/* Establish the exception vector base
> -- 
> 2.31.1
