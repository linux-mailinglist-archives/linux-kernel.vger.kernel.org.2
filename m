Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBB4348E05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhCYK3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229676AbhCYK3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:29:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4505461A25;
        Thu, 25 Mar 2021 10:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616668149;
        bh=AFUyzHBtuSU08dOdAwXN/Tg3vZjRCjPnCF7jRRn33ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oCoS4LNck/UpmIPgmg3KUfoVgXTWtOxUPFRvA8dSz+PeySXtvd83HlS279Qahh6qF
         6tok1JKdC7XfFwtkg/q+G1UYDH5POL5GiMDDMbqyb+QMSiR4bbHl2LJWAmHWDRYlvM
         3Isrlr3MyV4KGwceyT4i5+QVj1wvK65ADOrVBuZE=
Date:   Thu, 25 Mar 2021 11:29:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jian Dong <dj0227@163.com>
Cc:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com,
        Jian Dong <dongjian@yulong.com>
Subject: Re: [PATCH]  staging: greybus: fix fw is NULL but dereferenced
Message-ID: <YFxl8hyx7murtlzW@kroah.com>
References: <1616667566-58997-1-git-send-email-dj0227@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616667566-58997-1-git-send-email-dj0227@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 06:19:26PM +0800, Jian Dong wrote:
> From: Jian Dong <dongjian@yulong.com>
> 
>  fixes coccicheck Error:
> 
>  drivers/staging/greybus/bootrom.c:301:41-45: ERROR:
>  fw is NULL but dereferenced.
> 
>  if procedure goto label directly, ret will be nefative, so the fw is NULL
>  and the if(condition) end with dereferenced fw. let's fix it.

Why is this all indented a space?

> 
> Signed-off-by: Jian Dong <dongjian@yulong.com>
> ---
>  drivers/staging/greybus/bootrom.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
> index a8efb86..0439efa 100644
> --- a/drivers/staging/greybus/bootrom.c
> +++ b/drivers/staging/greybus/bootrom.c
> @@ -246,7 +246,7 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
>  	struct gb_bootrom_get_firmware_response *firmware_response;
>  	struct device *dev = &op->connection->bundle->dev;
>  	unsigned int offset, size;
> -	enum next_request_type next_request;
> +	enum next_request_type next_request = NEXT_REQ_GET_FIRMWARE;
>  	int ret = 0;
>  
>  	/* Disable timeouts */
> @@ -298,10 +298,10 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
>  
>  queue_work:
>  	/* Refresh timeout */
> -	if (!ret && (offset + size == fw->size))
> -		next_request = NEXT_REQ_READY_TO_BOOT;
> -	else
> +	if (!!ret)

That is hard to understand, please make this more obvious.

thanks,

greg k-h
