Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6763639E3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbhDSEEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:04:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56521 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233258AbhDSEEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:04:39 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVK2KxVz9vFw; Mon, 19 Apr 2021 14:04:09 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, linux@roeck-us.net
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <aad2cb1801a3cc99bc27081022925b9fc18a0dfb.1618159169.git.christophe.leroy@csgroup.eu>
References: <aad2cb1801a3cc99bc27081022925b9fc18a0dfb.1618159169.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/signal32: Fix build failure with CONFIG_SPE
Message-Id: <161880479652.1398509.9868352965277693855.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 13:59:56 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Apr 2021 16:39:53 +0000 (UTC), Christophe Leroy wrote:
> Add missing fault exit label in unsafe_copy_from_user() in order to
> avoid following build failure with CONFIG_SPE
> 
>   CC      arch/powerpc/kernel/signal_32.o
> arch/powerpc/kernel/signal_32.c: In function 'restore_user_regs':
> arch/powerpc/kernel/signal_32.c:565:36: error: macro "unsafe_copy_from_user" requires 4 arguments, but only 3 given
>   565 |           ELF_NEVRREG * sizeof(u32));
>       |                                    ^
> In file included from ./include/linux/uaccess.h:11,
>                  from ./include/linux/sched/task.h:11,
>                  from ./include/linux/sched/signal.h:9,
>                  from ./include/linux/rcuwait.h:6,
>                  from ./include/linux/percpu-rwsem.h:7,
>                  from ./include/linux/fs.h:33,
>                  from ./include/linux/huge_mm.h:8,
>                  from ./include/linux/mm.h:707,
>                  from arch/powerpc/kernel/signal_32.c:17:
> ./arch/powerpc/include/asm/uaccess.h:428: note: macro "unsafe_copy_from_user" defined here
>   428 | #define unsafe_copy_from_user(d, s, l, e) \
>       |
> arch/powerpc/kernel/signal_32.c:564:3: error: 'unsafe_copy_from_user' undeclared (first use in this function); did you mean 'raw_copy_from_user'?
>   564 |   unsafe_copy_from_user(current->thread.evr, &sr->mc_vregs,
>       |   ^~~~~~~~~~~~~~~~~~~~~
>       |   raw_copy_from_user
> arch/powerpc/kernel/signal_32.c:564:3: note: each undeclared identifier is reported only once for each function it appears in
> make[3]: *** [arch/powerpc/kernel/signal_32.o] Error 1

Applied to powerpc/next.

[1/1] powerpc/signal32: Fix build failure with CONFIG_SPE
      https://git.kernel.org/powerpc/c/af072b1a9d4d9edc24da84a071b0671e147026cb

cheers
