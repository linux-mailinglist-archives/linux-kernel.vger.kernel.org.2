Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A09144FFCC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhKOINl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:13:41 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:34113 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237098AbhKOIHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:07:44 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Ht1v323vdz9sSH;
        Mon, 15 Nov 2021 09:04:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Qe2v3QVn8OFm; Mon, 15 Nov 2021 09:04:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Ht1v26RDGz9sS8;
        Mon, 15 Nov 2021 09:04:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C71BA8B767;
        Mon, 15 Nov 2021 09:04:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id EsYuPdIrXK02; Mon, 15 Nov 2021 09:04:46 +0100 (CET)
Received: from [172.25.230.108] (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 964918B763;
        Mon, 15 Nov 2021 09:04:46 +0100 (CET)
Message-ID: <f48406ee-6bd8-2340-c79f-96f8882bd757@csgroup.eu>
Date:   Mon, 15 Nov 2021 09:04:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mm: Remove a repeated word in a comment
Content-Language: fr-FR
To:     Jason Wang <wangborong@cdjrlc.com>, benh@kernel.crashing.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20211113044018.130835-1-wangborong@cdjrlc.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20211113044018.130835-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 13/11/2021 à 05:40, Jason Wang a écrit :
> The double word `up' in a comment is repeated, thus one of
> them should be removed.

If you do other changes than this one, say it here as well, see below.

> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>   drivers/macintosh/mediabay.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
> index eab7e83c11c4..ec23094263e7 100644
> --- a/drivers/macintosh/mediabay.c
> +++ b/drivers/macintosh/mediabay.c
> @@ -129,7 +129,7 @@ enum {
>   /*
>    * Functions for polling content of media bay
>    */
> -
> +

This change is not part of your description.

>   static u8
>   ohare_mb_content(struct media_bay_info *bay)
>   {
> @@ -331,12 +331,12 @@ static void keylargo_mb_un_reset_ide(struct media_bay_info* bay)
>   
>   static inline void set_mb_power(struct media_bay_info* bay, int onoff)
>   {
> -	/* Power up up and assert the bay reset line */
> +	/* Power up and assert the bay reset line */
>   	if (onoff) {
>   		bay->ops->power(bay, 1);
>   		bay->state = mb_powering_up;
>   		pr_debug("mediabay%d: powering up\n", bay->index);
> -	} else {
> +	} else {

This change is not part of your description.

>   		/* Make sure everything is powered down & disabled */
>   		bay->ops->power(bay, 0);
>   		bay->state = mb_powering_down;
> @@ -577,7 +577,7 @@ static int media_bay_attach(struct macio_dev *mdev,
>   		macio_release_resources(mdev);
>   		return -ENOMEM;
>   	}
> -	
> +

This change is not part of your description.

>   	i = media_bay_count++;
>   	bay = &media_bays[i];
>   	bay->mdev = mdev;
> @@ -745,7 +745,7 @@ static int __init media_bay_init(void)
>   	if (!machine_is(powermac))
>   		return 0;
>   
> -	macio_register_driver(&media_bay_driver);	
> +	macio_register_driver(&media_bay_driver);

This change is not part of your description.

>   
>   	return 0;
>   }
> 
