Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D283EB4EE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 13:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbhHML7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 07:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239888AbhHML72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 07:59:28 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25308C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 04:59:02 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GmMXh1tNzz9t2b; Fri, 13 Aug 2021 21:59:00 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <75287841cbb8740edd44880fe60be66d489160d9.1628097995.git.christophe.leroy@csgroup.eu>
References: <75287841cbb8740edd44880fe60be66d489160d9.1628097995.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/smp: Fix OOPS in topology_init()
Message-Id: <162885586726.2317031.18007540873140070843.b4-ty@ellerman.id.au>
Date:   Fri, 13 Aug 2021 21:57:47 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2021 18:24:10 +0000 (UTC), Christophe Leroy wrote:
> Running an SMP kernel on an UP platform not prepared for it,
> I encountered the following OOPS:
> 
> 	BUG: Kernel NULL pointer dereference on read at 0x00000034
> 	Faulting instruction address: 0xc0a04110
> 	Oops: Kernel access of bad area, sig: 11 [#1]
> 	BE PAGE_SIZE=4K SMP NR_CPUS=2 CMPCPRO
> 	Modules linked in:
> 	CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-pmac-00001-g230fedfaad21 #5234
> 	NIP:  c0a04110 LR: c0a040d8 CTR: c0a04084
> 	REGS: e100dda0 TRAP: 0300   Not tainted  (5.13.0-pmac-00001-g230fedfaad21)
> 	MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 84000284  XER: 00000000
> 	DAR: 00000034 DSISR: 20000000
> 	GPR00: c0006bd4 e100de60 c1033320 00000000 00000000 c0942274 00000000 00000000
> 	GPR08: 00000000 00000000 00000001 00000063 00000007 00000000 c0006f30 00000000
> 	GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000005
> 	GPR24: c0c67d74 c0c67f1c c0c60000 c0c67d70 c0c0c558 1efdf000 c0c00020 00000000
> 	NIP [c0a04110] topology_init+0x8c/0x138
> 	LR [c0a040d8] topology_init+0x54/0x138
> 	Call Trace:
> 	[e100de60] [80808080] 0x80808080 (unreliable)
> 	[e100de90] [c0006bd4] do_one_initcall+0x48/0x1bc
> 	[e100def0] [c0a0150c] kernel_init_freeable+0x1c8/0x278
> 	[e100df20] [c0006f44] kernel_init+0x14/0x10c
> 	[e100df30] [c00190fc] ret_from_kernel_thread+0x14/0x1c
> 	Instruction dump:
> 	7c692e70 7d290194 7c035040 7c7f1b78 5529103a 546706fe 5468103a 39400001
> 	7c641b78 40800054 80c690b4 7fb9402e <81060034> 7fbeea14 2c080000 7fa3eb78
> 	---[ end trace b246ffbc6bbbb6fb ]---
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/smp: Fix OOPS in topology_init()
      https://git.kernel.org/powerpc/c/8241461536f21bbe51308a6916d1c9fb2e6b75a7

cheers
