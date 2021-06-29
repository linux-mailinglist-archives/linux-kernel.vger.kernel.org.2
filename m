Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91AA3B71AB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 13:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhF2MBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 08:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbhF2MBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:01:18 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5F5C061767
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 04:58:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GDjgB3Fp9z9sCD;
        Tue, 29 Jun 2021 21:58:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1624967926;
        bh=533gyRZK9TmPTAfumIEpfhjf9bBGEwRDqTzjjeqan60=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HFWjSZIZkTSQj/nTgsEsjVAI7zL3d+2WyLr66KRC7mD3N066+boKXh+AGlggtXhaC
         B/bk9puwEZg34DFC0x2GFxvjNXLxyz1xZ0rPQiv4QGIjOrUZ8yfMkPIkqyke4j020g
         GFUqr9z5Q5M57CJCiMBIoUE3iTo5iDvVUVoX74llYPO06OSWBZvoFx+EYMEFYEE28H
         VHV6bPCcNH+UT98EFGkHEGhCj1+WTHsg3QVXSYSTMkrfGL1NEUwrg9p0ks53s8hGGm
         VgiE7DVILSASOs+3M6Qjl5PImVCyYKTQD/r1ZWBSw+cPFh0AStuz9cUYJC82urqp9O
         KpxTeaYxDPwXw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/4xx: Fix setup_kuep() on SMP
In-Reply-To: <b9c2a9add0f11754539e24c6f421bd2009327c36.1624863323.git.christophe.leroy@csgroup.eu>
References: <b9c2a9add0f11754539e24c6f421bd2009327c36.1624863323.git.christophe.leroy@csgroup.eu>
Date:   Tue, 29 Jun 2021 21:58:45 +1000
Message-ID: <87tulg7uh6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> On SMP, setup_kuep() is also called from start_secondary() since
> commit 86f46f343272 ("powerpc/32s: Initialise KUAP and KUEP in C").
>
> start_secondary() is not an __init function.
>
> Remove the __init marker from setup_kuep() and bail out when
> not caller on the first CPU as the work is already done.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 10248dcba120 ("powerpc/44x: Implement Kernel Userspace Exec Protection (KUEP)")
> Fixes: 86f46f343272 ("powerpc/32s: Initialise KUAP and KUEP in C").
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/mm/nohash/44x.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/nohash/44x.c b/arch/powerpc/mm/nohash/44x.c
> index 7da6d1e9fc9b..20c18bd5b9a0 100644
> --- a/arch/powerpc/mm/nohash/44x.c
> +++ b/arch/powerpc/mm/nohash/44x.c
> @@ -241,8 +241,11 @@ void __init mmu_init_secondary(int cpu)
>  #endif /* CONFIG_SMP */
>  
>  #ifdef CONFIG_PPC_KUEP
> -void __init setup_kuep(bool disabled)
> +void setup_kuep(bool disabled)
>  {
> +	if (smp_processor_id() != boot_cpuid)
> +		return;
> +
>  	if (disabled)
>  		patch_instruction_site(&patch__tlb_44x_kuep, ppc_inst(PPC_RAW_NOP()));
>  	else

Building ppc44x_defconfig gives me:

  /linux/arch/powerpc/mm/nohash/44x.c: In function 'setup_kuep':
  /linux/arch/powerpc/mm/nohash/44x.c:246:35: error: 'boot_cpuid' undeclared (first use in this function); did you mean 'boot_cpu_init'?
    246 |         if (smp_processor_id() != boot_cpuid)
        |                                   ^~~~~~~~~~
        |                                   boot_cpu_init
  /linux/arch/powerpc/mm/nohash/44x.c:246:35: note: each undeclared identifier is reported only once for each function it appears in

cheers
