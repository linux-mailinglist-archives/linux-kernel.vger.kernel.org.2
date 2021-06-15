Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D7A3A739D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhFOCUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhFOCUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:20:10 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE091C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:18:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4G3s4529sVz9sWD;
        Tue, 15 Jun 2021 12:01:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1623722469;
        bh=Ioz32V7w9TF+SY5v/PGD0ofSTEUn3E3EmbxAg40Km+I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pJdbSmq1eTCdU+3xkvsZXfkGUrUNxnvqycQiy7TAYrHQqEXe2H1JfXir8hEFvW5PW
         s0pYoh+OM9KregcJBM84Ab5oRqBWdQUtDxH342pO5rEtShAZ53WHVbnLubImLISSPX
         azL43TxmUj8r/nu85TSx647r0I/9Ce52y3jc8UhR31Px0eNgiQ7mWSAqkN7gtDcLJv
         PBaNN5yuaL/LqJq4YmO4s8li+oB1CsNBKXk7uPr4Fe04QRea1XJ836Qioa4Ms98u3w
         ZNtkNYUXKYmcAvK67benMlLYZ/DddfE95gn6rYDEGO1KVzRp4o3VaA/kwLNXr9rTWW
         fzv0vjEjM6Low==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 08/12] powerpc: Don't use 'struct ppc_inst' to
 reference instruction location
In-Reply-To: <7062722b087228e42cbd896e39bfdf526d6a340a.1621516826.git.christophe.leroy@csgroup.eu>
References: <cover.1621516826.git.christophe.leroy@csgroup.eu>
 <7062722b087228e42cbd896e39bfdf526d6a340a.1621516826.git.christophe.leroy@csgroup.eu>
Date:   Tue, 15 Jun 2021 12:01:08 +1000
Message-ID: <871r93vqcb.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
> index 5a0740ebf132..32d318c3b180 100644
> --- a/arch/powerpc/include/asm/inst.h
> +++ b/arch/powerpc/include/asm/inst.h
> @@ -139,7 +139,7 @@ static inline int ppc_inst_len(struct ppc_inst x)
>   * Return the address of the next instruction, if the instruction @value was
>   * located at @location.
>   */
> -static inline struct ppc_inst *ppc_inst_next(void *location, struct ppc_inst *value)
> +static inline unsigned int *ppc_inst_next(unsigned int *location, unsigned int *value)
>  {
>  	struct ppc_inst tmp;
>  

It's not visible in the diff, but the rest of the function is:

	tmp = ppc_inst_read(value);

	return location + ppc_inst_len(tmp);
}

And so changing the type of location from void * to int * changes the
result of that addition, ie. previously it was in units of bytes, now
it's units of 4 bytes.

To fix it I've kept location as unsigned int *, and added a cast where
we do the addition. That way users of the function just see unsigned int *,
the cast to void * is an implementation detail.

We only have a handful of uses of ppc_inst_len(), so maybe that should
change name and return a result in units of int *. But that can be a
separate change.

> diff --git a/arch/powerpc/platforms/86xx/mpc86xx_smp.c b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
> index 87f524e4b09c..302f2a1e0361 100644
> --- a/arch/powerpc/platforms/86xx/mpc86xx_smp.c
> +++ b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
> @@ -83,7 +83,7 @@ smp_86xx_kick_cpu(int nr)
>  		mdelay(1);
>  
>  	/* Restore the exception vector */
> -	patch_instruction((struct ppc_inst *)vector, ppc_inst(save_vector));
> +	patch_instruction(vector, ppc_inst(save_vector));
>  
>  	local_irq_restore(flags);
>  

There was another usage in here:

 	/* Setup fake reset vector to call __secondary_start_mpc86xx. */
 	target = (unsigned long) __secondary_start_mpc86xx;
-	patch_branch((struct ppc_inst *)vector, target, BRANCH_SET_LINK);
+	patch_branch(vector, target, BRANCH_SET_LINK);
 
 	/* Kick that CPU */
 	smp_86xx_release_core(nr);

I fixed it up.

cheers
