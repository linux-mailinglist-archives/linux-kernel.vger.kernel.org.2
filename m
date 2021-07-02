Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9A83BA24E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 16:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhGBOqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 10:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230424AbhGBOqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 10:46:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94FFF613FE;
        Fri,  2 Jul 2021 14:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625237050;
        bh=tQbOmOYm52sqPdnKBHSq7Q8mipiiNLQCBkJZv7Ts5mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dlvppMt6J9x4cFjD5sqPNkUFLKCc9HNF+xb6trH2ja/+l+bnmCQEJT0naFGH93Z/+
         6qHD1i8IIOlwo0P/waN3WyAC1uC7MlOY5UeQCfPThtca4FM7Y4/USFA3PNV2WFGWkn
         ksAGsl2c+dnK6GvCvPEZFUHS8PiRncYQby6eH64Q=
Date:   Fri, 2 Jul 2021 16:44:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dio: return -ENOMEM when kzalloc() fails
Message-ID: <YN8mN3mtRH+S6D3o@kroah.com>
References: <20210702133114.GA314157@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702133114.GA314157@pc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 02:31:14PM +0100, Salah Triki wrote:
> Return -ENOMEM when kzalloc() fails in order to inform the caller of the
> failure.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/dio/dio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
> index 193b40e7aec0..4c06c93c93d3 100644
> --- a/drivers/dio/dio.c
> +++ b/drivers/dio/dio.c
> @@ -219,7 +219,7 @@ static int __init dio_init(void)
>                  /* Found a board, allocate it an entry in the list */
>  		dev = kzalloc(sizeof(struct dio_dev), GFP_KERNEL);
>  		if (!dev)
> -			return 0;
> +			return -ENOMEM;

Do you have this hardware to test with?

While this patch looks correct, it still is leaking lots of resources if
this every happens.  Can you fix this up "properly" so that all of the
resources allocated at this point in time will be correctly freed?

Or, really, this is an impossible error path to hit, given that it is at
boot time, so maybe it's just not worth it given that I doubt anyone has
this hardware...

thanks,

greg k-h
