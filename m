Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99ACD40D3B2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 09:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhIPHWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 03:22:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:33881 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234568AbhIPHWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 03:22:11 -0400
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 18G7FGqQ031443;
        Thu, 16 Sep 2021 02:15:17 -0500
Message-ID: <2c0fd775625c76c4dd09b3e923da4405a003f3bd.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: warn on emulation of dcbz instruction
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@linux-m68k.org>
Date:   Thu, 16 Sep 2021 17:15:16 +1000
In-Reply-To: <62b33ca839f3d1d7d4b64b6f56af0bbe4d2c9057.1631716292.git.christophe.leroy@csgroup.eu>
References: <62b33ca839f3d1d7d4b64b6f56af0bbe4d2c9057.1631716292.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-15 at 16:31 +0200, Christophe Leroy wrote:
> dcbz instruction shouldn't be used on non-cached memory. Using
> it on non-cached memory can result in alignment exception and
> implies a heavy handling.
> 
> Instead of silentely emulating the instruction and resulting in high
> performance degradation, warn whenever an alignment exception is
> taken due to dcbz, so that the user is made aware that dcbz
> instruction has been used unexpectedly.
> 
> Reported-by: Stan Johnson <userm57@yahoo.com>
> Cc: Finn Thain <fthain@linux-m68k.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/align.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kernel/align.c
> b/arch/powerpc/kernel/align.c
> index bbb4181621dd..adc3a4a9c6e4 100644
> --- a/arch/powerpc/kernel/align.c
> +++ b/arch/powerpc/kernel/align.c
> @@ -349,6 +349,7 @@ int fix_alignment(struct pt_regs *regs)
>  		if (op.type != CACHEOP + DCBZ)
>  			return -EINVAL;
>  		PPC_WARN_ALIGNMENT(dcbz, regs);
> +		WARN_ON_ONCE(1);

This is heavy handed ... It will be treated as an oops by various
things uselessly spit out a kernel backtrace. Isn't PPC_WARN_ALIGNMENT
enough ?

Ben.


