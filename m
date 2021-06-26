Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EDD3B4E20
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 12:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhFZKld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 06:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhFZKlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 06:41:18 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A61BC061574
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 03:38:56 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GBr2Q3R6Mz9t0Y; Sat, 26 Jun 2021 20:38:54 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <5bdc8cbc9a95d0779e27c9ddbf42b40f51f883c0.1624425798.git.christophe.leroy@csgroup.eu>
References: <5bdc8cbc9a95d0779e27c9ddbf42b40f51f883c0.1624425798.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/kprobes: Fix Oops by passing ppc_inst as a pointer to emulate_step() on ppc32
Message-Id: <162470384231.3589875.12558061004579567759.b4-ty@ellerman.id.au>
Date:   Sat, 26 Jun 2021 20:37:22 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021 05:23:30 +0000 (UTC), Christophe Leroy wrote:
> Trying to use a kprobe on ppc32 results in the below splat:
>     BUG: Unable to handle kernel data access on read at 0x7c0802a6
>     Faulting instruction address: 0xc002e9f0
>     Oops: Kernel access of bad area, sig: 11 [#1]
>     BE PAGE_SIZE=4K PowerPC 44x Platform
>     Modules linked in:
>     CPU: 0 PID: 89 Comm: sh Not tainted 5.13.0-rc1-01824-g3a81c0495fdb #7
>     NIP:  c002e9f0 LR: c0011858 CTR: 00008a47
>     REGS: c292fd50 TRAP: 0300   Not tainted  (5.13.0-rc1-01824-g3a81c0495fdb)
>     MSR:  00009000 <EE,ME>  CR: 24002002  XER: 20000000
>     DEAR: 7c0802a6 ESR: 00000000
>     <snip>
>     NIP [c002e9f0] emulate_step+0x28/0x324
>     LR [c0011858] optinsn_slot+0x128/0x10000
>     Call Trace:
>      opt_pre_handler+0x7c/0xb4 (unreliable)
>      optinsn_slot+0x128/0x10000
>      ret_from_syscall+0x0/0x28
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/kprobes: Fix Oops by passing ppc_inst as a pointer to emulate_step() on ppc32
      https://git.kernel.org/powerpc/c/511eea5e2ccdfdbf3d626bde0314e551f247dd18

cheers
