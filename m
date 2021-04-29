Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089E836EBC6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbhD2ODN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbhD2ODM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:03:12 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9023AC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:02:25 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FWHHy2GM8z9t15; Fri, 30 Apr 2021 00:02:20 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cb4cec9131c8577803367f1699209a7e104cec2a.1619025821.git.christophe.leroy@csgroup.eu>
References: <cb4cec9131c8577803367f1699209a7e104cec2a.1619025821.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/52xx: Fix an invalid ASM expression ('addi' used instead of 'add')
Message-Id: <161970488335.4033873.16440956180112521180.b4-ty@ellerman.id.au>
Date:   Fri, 30 Apr 2021 00:01:23 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 17:24:03 +0000 (UTC), Christophe Leroy wrote:
>   AS      arch/powerpc/platforms/52xx/lite5200_sleep.o
> arch/powerpc/platforms/52xx/lite5200_sleep.S: Assembler messages:
> arch/powerpc/platforms/52xx/lite5200_sleep.S:184: Warning: invalid register expression
> 
> In the following code, 'addi' is wrong, has to be 'add'
> 
> 	/* local udelay in sram is needed */
>   udelay: /* r11 - tb_ticks_per_usec, r12 - usecs, overwrites r13 */
> 	mullw	r12, r12, r11
> 	mftb	r13	/* start */
> 	addi	r12, r13, r12 /* end */

Applied to powerpc/next.

[1/1] powerpc/52xx: Fix an invalid ASM expression ('addi' used instead of 'add')
      https://git.kernel.org/powerpc/c/8a87a507714386efc39c3ae6fa24d4f79846b522

cheers
