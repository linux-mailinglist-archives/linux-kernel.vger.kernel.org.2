Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476C8412B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245743AbhIUCLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238406AbhIUB5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:57:25 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908AEC09394E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 17:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=popple.id.au;
        s=202006; t=1632184724;
        bh=ij2y8kCniONW6Ysf/Jb2WpvHz29WAisuNW7dYflrnAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=drUTVInKYGo8s+358Ph/YIl0ujhKF6B2mEKAn2xFCa/4E11ZcMzqZtkr0UzJfYN+Z
         Xlkm/8rm9Ap+BgPf0h/BzhrRQXJlXapi6pW58NnR5LHsluDNSrLLw7HN9a+ufFP7Km
         RKx9GU7rc97ezC7RDTTGUrwL+aHKwTWkmJKrKBKJpt5HzlUrvyAizQRYPsBorOxxlI
         U0PTjgzrWzuvm62KT8e0vF5seD5VOe0w64VsSGQXhJNRftXqh6r4kxWWtZsh1Pk1O0
         rd/rzf2f7uB3bn/KO3yxT0wVVuN3GCo0CdZbyNwXo1HNmMWCS1S5wqpdggpS5AwHO1
         T/iOZCRnCZwhg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HD2bk5kVNz9t0T;
        Tue, 21 Sep 2021 10:38:42 +1000 (AEST)
From:   Alistair Popple <alistair@popple.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] powerpc/476: Fix sparse report
Date:   Tue, 21 Sep 2021 10:38:36 +1000
Message-ID: <1998989.TeVrErrrU0@cleo>
In-Reply-To: <aa6055769b92a5d8685b8d0adab99c48a0b0ef4b.1631956926.git.christophe.leroy@csgroup.eu>
References: <aa6055769b92a5d8685b8d0adab99c48a0b0ef4b.1631956926.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, looks reasonable.

Reviewed-by: Alistair Popple <alistair@popple.id.au>

On Saturday, 18 September 2021 7:22:32 PM AEST Christophe Leroy wrote:
> 	arch/powerpc/platforms/44x/ppc476.c:236:17: warning: cast removes address space '__iomem' of expression
> 	arch/powerpc/platforms/44x/ppc476.c:241:34: warning: incorrect type in argument 1 (different address spaces)
> 	arch/powerpc/platforms/44x/ppc476.c:241:34:    expected void const volatile [noderef] __iomem *addr
> 	arch/powerpc/platforms/44x/ppc476.c:241:34:    got unsigned char [usertype] *
> 	arch/powerpc/platforms/44x/ppc476.c:243:17: warning: incorrect type in argument 1 (different address spaces)
> 	arch/powerpc/platforms/44x/ppc476.c:243:17:    expected void volatile [noderef] __iomem *addr
> 	arch/powerpc/platforms/44x/ppc476.c:243:17:    got unsigned char [usertype] *[assigned] fpga
> 
> Mark 'fpga' pointer as __iomem.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: ab9a4183fddf ("powerpc: Update currituck pci/usb fixup for new board revision")
> Cc: Alistair Popple <alistair@popple.id.au>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/platforms/44x/ppc476.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/44x/ppc476.c b/arch/powerpc/platforms/44x/ppc476.c
> index 07f7e3ce67b5..fb7db5cedd4e 100644
> --- a/arch/powerpc/platforms/44x/ppc476.c
> +++ b/arch/powerpc/platforms/44x/ppc476.c
> @@ -219,7 +219,7 @@ static int board_rev = -1;
>  static int __init ppc47x_get_board_rev(void)
>  {
>  	int reg;
> -	u8 *fpga;
> +	u8 __iomem *fpga;
>  	struct device_node *np = NULL;
>  
>  	if (of_machine_is_compatible("ibm,currituck")) {
> @@ -233,7 +233,7 @@ static int __init ppc47x_get_board_rev(void)
>  	if (!np)
>  		goto fail;
>  
> -	fpga = (u8 *) of_iomap(np, 0);
> +	fpga = of_iomap(np, 0);
>  	of_node_put(np);
>  	if (!fpga)
>  		goto fail;
> 




