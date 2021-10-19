Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2808433FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 22:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhJSUPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 16:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhJSUP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 16:15:28 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E22C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 13:13:15 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mcvTx-0003cz-34; Tue, 19 Oct 2021 22:13:09 +0200
Date:   Tue, 19 Oct 2021 22:13:09 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: fix a gcc warning
Message-ID: <20211019201309.ezngvhoddsiyms5h@viti.kaiser.cx>
References: <20211018221231.7837-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018221231.7837-1-straube.linux@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> Replace strncpy with strlcpy to fix the following gcc warning.

> drivers/staging/r8188eu/os_dep/ioctl_linux.c: In function 'rtw_wx_set_enc_ext':
> drivers/staging/r8188eu/os_dep/ioctl_linux.c:1929:9: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
>  1929 |         strncpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

> The destination buffer size is IEEE_CRYPT_ALG_NAME_LEN and the length
> of the string to copy is always < IEEE_CRYPT_ALG_NAME_LEN. So strlcpy
> will never truncate the string.

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 51f46696a593..4f0ae821d193 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -1926,7 +1926,7 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
>  		return -1;
>  	}

> -	strncpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
> +	strlcpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);

>  	if (pext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY)
>  		param->u.crypt.set_tx = 1;
> -- 
> 2.33.0

Hi Michael,

it's too late for another ack as Greg has already taken the patch.

Anyway, thanks for fixing the mess I created with my Makefile patches.

   Martin
