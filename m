Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F5B34F5D1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhCaBKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:35 -0400
Received: from ozlabs.org ([203.11.71.1]:41039 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232978AbhCaBKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:13 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97XN4Y8gz9sXh; Wed, 31 Mar 2021 12:10:12 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cover.1615398498.git.christophe.leroy@csgroup.eu>
References: <cover.1615398498.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 0/8] Miscellaneous user access improvement
Message-Id: <161715296775.226945.5121364536588519701.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:27 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 17:56:59 +0000 (UTC), Christophe Leroy wrote:
> Patches 1-3 are cleaning parts of uaccess.h not related
> to put_user/get_user
> Patch 4 removes some usage of consecutives __get_user
> Patches 5 rewrite __patch_instruction to not use uaccess.h internals.
> Patches 6-8 switch some parts of code to user_access_begin/end blocks
> 
> All patches are independant.
> 
> [...]

Applied to powerpc/next.

[1/8] powerpc/uaccess: Also perform 64 bits copies in unsafe_copy_to_user() on ppc32
      https://git.kernel.org/powerpc/c/c6adc835c68b713360f918d21372c2f34fc228e2
[2/8] powerpc/uaccess: Swap clear_user() and __clear_user()
      https://git.kernel.org/powerpc/c/7472199a6eda6a79f9e3b126f52f67f9ce3e1f77
[3/8] powerpc/uaccess: Move copy_mc_xxx() functions down
      https://git.kernel.org/powerpc/c/4b8cda58812c1e1bf79d37f2ddff3cf03b7025da
[4/8] powerpc/syscalls: Use sys_old_select() in ppc_select()
      https://git.kernel.org/powerpc/c/fd69d544b0e785b11699675154bdfe01a04538cd
[5/8] powerpc/lib: Don't use __put_user_asm_goto() outside of uaccess.h
      https://git.kernel.org/powerpc/c/e63ceebdad82f85e48b018abfc6af4ed6958179e
[6/8] powerpc/net: Switch csum_and_copy_{to/from}_user to user_access block
      https://git.kernel.org/powerpc/c/164dc6ce368fa23b0aae0e5d12883fff9bf80458
[7/8] powerpc/futex: Switch to user_access block
      https://git.kernel.org/powerpc/c/870779f40e99c795ddfafa0dfc43318e51f15127
[8/8] powerpc/ptrace: Convert gpr32_set_common() to user access block
      https://git.kernel.org/powerpc/c/93c043e393af7fa218c928d8c62396ba28f1bb84

cheers
