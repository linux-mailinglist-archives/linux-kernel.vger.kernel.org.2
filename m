Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59853533F2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 13:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbhDCLwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 07:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbhDCLwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 07:52:22 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A46C061788
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 04:52:19 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FCFdr5WjMz9sW0; Sat,  3 Apr 2021 22:52:16 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <bde9154e5351a5ac7bca3d59cdb5a5e8edacbb79.1617199569.git.christophe.leroy@csgroup.eu>
References: <bde9154e5351a5ac7bca3d59cdb5a5e8edacbb79.1617199569.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/signal32: Fix Oops on sigreturn with unmapped VDSO
Message-Id: <161745070541.936361.6883787979113499379.b4-ty@ellerman.id.au>
Date:   Sat, 03 Apr 2021 22:51:45 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 14:07:04 +0000 (UTC), Christophe Leroy wrote:
> PPC32 encounters a KUAP fault when trying to handle a signal with
> VDSO unmapped.
> 
> 	Kernel attempted to read user page (7fc07ec0) - exploit attempt? (uid: 0)
> 	BUG: Unable to handle kernel data access on read at 0x7fc07ec0
> 	Faulting instruction address: 0xc00111d4
> 	Oops: Kernel access of bad area, sig: 11 [#1]
> 	BE PAGE_SIZE=16K PREEMPT CMPC885
> 	CPU: 0 PID: 353 Comm: sigreturn_vdso Not tainted 5.12.0-rc4-s3k-dev-01553-gb30c310ea220 #4814
> 	NIP:  c00111d4 LR: c0005a28 CTR: 00000000
> 	REGS: cadb3dd0 TRAP: 0300   Not tainted  (5.12.0-rc4-s3k-dev-01553-gb30c310ea220)
> 	MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 48000884  XER: 20000000
> 	DAR: 7fc07ec0 DSISR: 88000000
> 	GPR00: c0007788 cadb3e90 c28d4a40 7fc07ec0 7fc07ed0 000004e0 7fc07ce0 00000000
> 	GPR08: 00000001 00000001 7fc07ec0 00000000 28000282 1001b828 100a0920 00000000
> 	GPR16: 100cac0c 100b0000 105c43a4 105c5685 100d0000 100d0000 100d0000 100b2e9e
> 	GPR24: ffffffff 105c43c8 00000000 7fc07ec8 cadb3f40 cadb3ec8 c28d4a40 00000000
> 	NIP [c00111d4] flush_icache_range+0x90/0xb4
> 	LR [c0005a28] handle_signal32+0x1bc/0x1c4
> 	Call Trace:
> 	[cadb3e90] [100d0000] 0x100d0000 (unreliable)
> 	[cadb3ec0] [c0007788] do_notify_resume+0x260/0x314
> 	[cadb3f20] [c000c764] syscall_exit_prepare+0x120/0x184
> 	[cadb3f30] [c00100b4] ret_from_syscall+0xc/0x28
> 	--- interrupt: c00 at 0xfe807f8
> 	NIP:  0fe807f8 LR: 10001060 CTR: c0139378
> 	REGS: cadb3f40 TRAP: 0c00   Not tainted  (5.12.0-rc4-s3k-dev-01553-gb30c310ea220)
> 	MSR:  0000d032 <EE,PR,ME,IR,DR,RI>  CR: 28000482  XER: 20000000
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/signal32: Fix Oops on sigreturn with unmapped VDSO
      https://git.kernel.org/powerpc/c/acca57217c688c5bbbd5140974533d81e8757cc9

cheers
