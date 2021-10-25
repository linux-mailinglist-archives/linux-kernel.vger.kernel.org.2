Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232E6438FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhJYG7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:59:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229727AbhJYG7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:59:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9AA760EE9;
        Mon, 25 Oct 2021 06:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635145049;
        bh=qXTrgFKBZ/n7lg4e/LDWfdvUn0D7rhQ2YdfqbfD2apQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BZlChCmFlmiM7n7WytFjcrMvNPs1N1M4pBJ66VE63SYxU8JCCE5OyEJqZHL87p4SB
         +m8zAPE3VM0/8ncNrY8d/Yr8TYKghBDlLYnRyqiLUDwOvGHA/6S1tJ6LD1lzsRLXux
         8kN66AlLiSijQX0dUf1zXyZWSPdUVY8Z+ijjoREQ=
Date:   Mon, 25 Oct 2021 08:57:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: avoid use of goto statement
Message-ID: <YXZVV9j2DMA22MUS@kroah.com>
References: <YXY5jtR6neQ+ad+C@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXY5jtR6neQ+ad+C@Sauravs-MacBook-Air.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 10:28:54AM +0530, Saurav Girepunje wrote:
> Remove the goto statement from _rtw_init_cmd_priv(). In this function
> goto statement can be replace by return statement. By replacing the
> goto statement with return statement local variable "res" is also
> not required.As on goto label exit, function only return it is not

You need a ' ' after the '.' here please.

> performing any cleanup.Avoiding goto will simplify the function.

Same here.

> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_cmd.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index e17332677daa..22046bd5cf82 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -19,7 +19,6 @@ No irqsave is necessary.
> 
>  static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
>  {
> -	int res = _SUCCESS;
> 

Please also remove the extra blank line.

thanks,

greg k-h
