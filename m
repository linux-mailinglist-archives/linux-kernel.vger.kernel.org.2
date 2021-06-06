Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2C139CEE8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhFFMOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhFFMOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:14:02 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60581C061795
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:12:13 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Fyb3H1fWTz9sj1; Sun,  6 Jun 2021 22:12:11 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1c80981548dc0c4f145109cdd473022c1aad8d2b.1620223302.git.christophe.leroy@csgroup.eu>
References: <1c80981548dc0c4f145109cdd473022c1aad8d2b.1620223302.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/2] powerpc/asm-offset: Remove unused items
Message-Id: <162298131492.2353459.7654424742326960159.b4-ty@ellerman.id.au>
Date:   Sun, 06 Jun 2021 22:08:34 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 May 2021 14:02:12 +0000 (UTC), Christophe Leroy wrote:
> Following PACA related items are not used anymore by ASM code:
> PACA_SIZE, PACACONTEXTID, PACALOWSLICESPSIZE, PACAHIGHSLICEPSIZE,
> PACA_SLB_ADDR_LIMIT, MMUPSIZEDEFSIZE, PACASLBCACHE, PACASLBCACHEPTR,
> PACASTABRR, PACAVMALLOCSLLP, MMUPSIZESLLP, PACACONTEXTSLLP,
> PACALPPACAPTR, LPPACA_DTLIDX and PACA_DTL_RIDX.
> 
> Following items are also not used anymore:
> SIGSEGV, NMI_MASK, THREAD_DBCR0, KUAP, TI_FLAGS, TI_PREEMPT,
> DCACHEL1BLOCKSPERPAGE, ICACHEL1BLOCKSIZE, ICACHEL1LOGBLOCKSIZE,
> ICACHEL1BLOCKSPERPAGE, STACK_REGS_KUAP, KVM_NEED_FLUSH, KVM_FWNMI,
> VCPU_DEC, VCPU_SPMC, HSTATE_XICS_PHYS, HSTATE_SAVED_XIRR and
> PPC_DBELL_MSGTYPE.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/asm-offset: Remove unused items
      https://git.kernel.org/powerpc/c/1a3c6ceed2533121e857d9b38559839487d31f33
[2/2] powerpc/paca: Remove mm_ctx_id and mm_ctx_slb_addr_limit
      https://git.kernel.org/powerpc/c/13c7dad95176d6abaf9608e4d34b2f512689775e

cheers
