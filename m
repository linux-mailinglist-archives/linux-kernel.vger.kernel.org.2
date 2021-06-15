Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182EA3A739C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhFOCPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhFOCPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:15:37 -0400
Received: from ozlabs.org (unknown [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E71C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:13:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4G3rnx5X1hz9sCD;
        Tue, 15 Jun 2021 11:48:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1623721734;
        bh=Bl3XHAS0bQtI+6g13gkACgICPslVhebB4ZXpE+X695Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ep0XF0NFMgmx7oI70j7Ccn7QSx4ln77fHPJldlNbo/qwJmwsQXkJGdFjSSYKAzKQz
         il7/UdavTO905wqZRRqzvtTn/zNF2h1WZlaOySLEbyCt+MJUel8Z+LKySzCjueJrAg
         tubenPnGVZKbyfbvs4j1njr8UxP45mNJke8msYpHAWwa50DdHqL12mHXLiuipm5ZlK
         glRriVXjb8aY/WEqIUOPnlx9sSuI50PxJj91i5noJKkRoHNLfiVRbSCuTYA8WRU915
         1jSptRsjdKJAXcICZjx5nySyznFRceANtPrYXD2CKUmSXEBi9WWl5vGIrbqDcuJCIE
         sSrSNWMPBYPOA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 10/12] powerpc/lib/feature-fixups: Use PPC_RAW_xxx()
 macros
In-Reply-To: <e79cd8e111ca13bf8c61a384bac365aa7e207647.1621506159.git.christophe.leroy@csgroup.eu>
References: <5d146b31b943e7ad674894421db4feef54804b9b.1621506159.git.christophe.leroy@csgroup.eu>
 <e79cd8e111ca13bf8c61a384bac365aa7e207647.1621506159.git.christophe.leroy@csgroup.eu>
Date:   Tue, 15 Jun 2021 11:48:49 +1000
Message-ID: <874kdzvqwu.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
> index fe26f2fa0f3f..f0fc521b82ae 100644
> --- a/arch/powerpc/lib/feature-fixups.c
> +++ b/arch/powerpc/lib/feature-fixups.c
> @@ -180,32 +180,31 @@ static void do_stf_exit_barrier_fixups(enum stf_barrier_type types)
>  	start = PTRRELOC(&__start___stf_exit_barrier_fixup);
>  	end = PTRRELOC(&__stop___stf_exit_barrier_fixup);
>  
> -	instrs[0] = 0x60000000; /* nop */
> -	instrs[1] = 0x60000000; /* nop */
> -	instrs[2] = 0x60000000; /* nop */
> -	instrs[3] = 0x60000000; /* nop */
> -	instrs[4] = 0x60000000; /* nop */
> -	instrs[5] = 0x60000000; /* nop */
> +	instrs[0] = PPC_RAW_NOP();
> +	instrs[1] = PPC_RAW_NOP();
> +	instrs[2] = PPC_RAW_NOP();
> +	instrs[3] = PPC_RAW_NOP();
> +	instrs[4] = PPC_RAW_NOP();
> +	instrs[5] = PPC_RAW_NOP();
>  
>  	i = 0;
>  	if (types & STF_BARRIER_FALLBACK || types & STF_BARRIER_SYNC_ORI) {
>  		if (cpu_has_feature(CPU_FTR_HVMODE)) {
> -			instrs[i++] = 0x7db14ba6; /* mtspr 0x131, r13 (HSPRG1) */
> -			instrs[i++] = 0x7db04aa6; /* mfspr r13, 0x130 (HSPRG0) */
> +			instrs[i++] = PPC_RAW_MTSPR(SPRN_HSPRG1, _R13);
> +			instrs[i++] = PPC_RAW_MFSPR(_R13, SPRN_HSPRG0);
>  		} else {
> -			instrs[i++] = 0x7db243a6; /* mtsprg 2,r13	*/
> -			instrs[i++] = 0x7db142a6; /* mfsprg r13,1    */
> +			instrs[i++] = PPC_RAW_MTSPR(SPRN_SPRG2, _R13);
> +			instrs[i++] = PPC_RAW_MFSPR(_R13, SPRN_SPRG1);
>  	        }
> -		instrs[i++] = 0x7c0004ac; /* hwsync		*/
> -		instrs[i++] = 0xe9ad0000; /* ld r13,0(r13)	*/
...
> +		instrs[i++] = PPC_RAW_LD(_R10, _R13, 0);

This conversion was wrong, r13 became r10.

I fixed it up.

cheers
