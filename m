Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC2C44FFC3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbhKOIK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:10:57 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:60435 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230292AbhKOIJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:09:04 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Ht1wZ35mLz9sSH;
        Mon, 15 Nov 2021 09:06:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0GicMj1TSfUZ; Mon, 15 Nov 2021 09:06:06 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Ht1wZ2GzRz9sS8;
        Mon, 15 Nov 2021 09:06:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 35AB18B767;
        Mon, 15 Nov 2021 09:06:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0-dUyzFHv-UY; Mon, 15 Nov 2021 09:06:06 +0100 (CET)
Received: from [172.25.230.108] (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 05CDC8B763;
        Mon, 15 Nov 2021 09:06:06 +0100 (CET)
Message-ID: <2ebdfb0c-867e-37f0-2c77-41c83b4048d0@csgroup.eu>
Date:   Mon, 15 Nov 2021 09:06:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] soc: fsl: qe: Fix typo in a comment
Content-Language: fr-FR
To:     Jason Wang <wangborong@cdjrlc.com>, leoyang.li@nxp.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, qiang.zhao@nxp.com
References: <20211113055900.212568-1-wangborong@cdjrlc.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20211113055900.212568-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 13/11/2021 à 06:59, Jason Wang a écrit :
> The double `is' in a comment is repeated, thus one of them
> should be removed.

You are also clean blanks it seems, so say it or don't do it.

> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>   drivers/soc/fsl/qe/qe.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
> index 4d38c80f8be8..b3c226eb5292 100644
> --- a/drivers/soc/fsl/qe/qe.c
> +++ b/drivers/soc/fsl/qe/qe.c
> @@ -147,7 +147,7 @@ EXPORT_SYMBOL(qe_issue_cmd);
>    * memory mapped space.
>    * The BRG clock is the QE clock divided by 2.
>    * It was set up long ago during the initial boot phase and is
> - * is given to us.
> + * given to us.
>    * Baud rate clocks are zero-based in the driver code (as that maps
>    * to port numbers). Documentation uses 1-based numbering.
>    */
> @@ -421,7 +421,7 @@ static void qe_upload_microcode(const void *base,
>   
>   	for (i = 0; i < be32_to_cpu(ucode->count); i++)
>   		iowrite32be(be32_to_cpu(code[i]), &qe_immr->iram.idata);
> -	
> +

This change is not linked to the double "is".

>   	/* Set I-RAM Ready Register */
>   	iowrite32be(QE_IRAM_READY, &qe_immr->iram.iready);
>   }
> 
