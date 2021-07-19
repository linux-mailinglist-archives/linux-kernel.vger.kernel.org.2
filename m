Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061B33CE8A9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 19:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357090AbhGSQpU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jul 2021 12:45:20 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:9273 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349217AbhGSP0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:26:16 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GT6DF4xN0zB58n;
        Mon, 19 Jul 2021 18:06:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id COi69W5SXrwD; Mon, 19 Jul 2021 18:06:53 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GT6DF3zhRzB58l;
        Mon, 19 Jul 2021 18:06:53 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id BD3BA37C; Mon, 19 Jul 2021 18:12:05 +0200 (CEST)
Received: from 37.172.104.68 ([37.172.104.68]) by messagerie.c-s.fr (Horde
 Framework) with HTTP; Mon, 19 Jul 2021 18:12:05 +0200
Date:   Mon, 19 Jul 2021 18:12:05 +0200
Message-ID: <20210719181205.Horde.xU8C00MIRgjqhZQ3-RrANw8@messagerie.c-s.fr>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
        herbert@gondor.apana.org.au, paulus@samba.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, haren@us.ibm.com
Subject: Re: [PATCH] replace if with min
In-Reply-To: <20210712204546.GA1492390@pc>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Salah Triki <salah.triki@gmail.com> a écrit :

> Replace if with min in order to make code more clean.
>
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/crypto/nx/nx-842.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/crypto/nx/nx-842.c b/drivers/crypto/nx/nx-842.c
> index 2ab90ec10e61..0d1d5a463899 100644
> --- a/drivers/crypto/nx/nx-842.c
> +++ b/drivers/crypto/nx/nx-842.c
> @@ -134,8 +134,7 @@ EXPORT_SYMBOL_GPL(nx842_crypto_exit);
>  static void check_constraints(struct nx842_constraints *c)
>  {
>  	/* limit maximum, to always have enough bounce buffer to decompress */
> -	if (c->maximum > BOUNCE_BUFFER_SIZE)
> -		c->maximum = BOUNCE_BUFFER_SIZE;
> +	c->maximum = min(c->maximum, BOUNCE_BUFFER_SIZE);

For me the code is less clear with this change, and in addition it  
slightly changes the behaviour. Before, the write was done only when  
the value was changing. Now you rewrite the value always, even when it  
doesn't change.

>  }
>
>  static int nx842_crypto_add_header(struct nx842_crypto_header *hdr, u8 *buf)
> --
> 2.25.1


