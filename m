Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988CF3F6ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 07:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhHYF2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 01:28:12 -0400
Received: from ozlabs.org ([203.11.71.1]:49817 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhHYF2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 01:28:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GvZHH0xwTz9sW8;
        Wed, 25 Aug 2021 15:27:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1629869244;
        bh=piMp678SY23RlkKblnlJz3x7vve0PTSeMYbmkKycX6E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HwJnYeTKh8xD9IFZCs53L4xkr1Usjvrd6AS9CTigFtJMcrqlVTfbidEeDj38/w3VG
         flLS25RORjjXJqRqSKiPBxfa1P/VGGbbAIZq2p77HTSxVZQpUmYvMh57uokmK4lmnZ
         FFqmjK1Qn3CkJkprLbxVCiXwoSV2M9czV7wzvLiW+ULPWmh/O0rH5zRDsD01Of2n82
         ewgPWCmspZXFsE4PZ1asTmSCOZvwFznLZtz1F4YVj0axH8zDQAYjHmMhxUabEFlDxO
         WUx6mXn7UF8BPKQdwt8nJbtQFYeFy9wPMBwam7V6ApFAi+rIXRXIyiXrHOEVqhzcWC
         bqq0kCM1NdfsA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/3] powerpc: Remove MSR_PR check in
 interrupt_exit_{user/kernel}_prepare()
In-Reply-To: <385ead49ccb66a259b25fee3eebf0bd4094068f3.1629707037.git.christophe.leroy@csgroup.eu>
References: <385ead49ccb66a259b25fee3eebf0bd4094068f3.1629707037.git.christophe.leroy@csgroup.eu>
Date:   Wed, 25 Aug 2021 15:27:22 +1000
Message-ID: <87zgt6aybp.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> In those hot functions that are called at every interrupt, any saved
> cycle is worth it.
>
> interrupt_exit_user_prepare() and interrupt_exit_kernel_prepare() are
> called from three places:
> - From entry_32.S
> - From interrupt_64.S
> - From interrupt_exit_user_restart() and interrupt_exit_kernel_restart()
>
> In entry_32.S, there are inambiguously called based on MSR_PR:
>
> 	interrupt_return:
> 		lwz	r4,_MSR(r1)
> 		addi	r3,r1,STACK_FRAME_OVERHEAD
> 		andi.	r0,r4,MSR_PR
> 		beq	.Lkernel_interrupt_return
> 		bl	interrupt_exit_user_prepare
> 	...
> 	.Lkernel_interrupt_return:
> 		bl	interrupt_exit_kernel_prepare
>
> In interrupt_64.S, that's similar:
>
> 	interrupt_return_\srr\():
> 		ld	r4,_MSR(r1)
> 		andi.	r0,r4,MSR_PR
> 		beq	interrupt_return_\srr\()_kernel
> 	interrupt_return_\srr\()_user: /* make backtraces match the _kernel variant */
> 		addi	r3,r1,STACK_FRAME_OVERHEAD
> 		bl	interrupt_exit_user_prepare
> 	...
> 	interrupt_return_\srr\()_kernel:
> 		addi	r3,r1,STACK_FRAME_OVERHEAD
> 		bl	interrupt_exit_kernel_prepare
>
> In interrupt_exit_user_restart() and interrupt_exit_kernel_restart(),
> MSR_PR is verified respectively by BUG_ON(!user_mode(regs)) and
> BUG_ON(user_mode(regs)) prior to calling interrupt_exit_user_prepare()
> and interrupt_exit_kernel_prepare().
>
> The verification in interrupt_exit_user_prepare() and
> interrupt_exit_kernel_prepare() are therefore useless and can be removed.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Acked-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/interrupt.c | 2 --
>  1 file changed, 2 deletions(-)

I'll pick this one up independent of the other two patches.

cheers
