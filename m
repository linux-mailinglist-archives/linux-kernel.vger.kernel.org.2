Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E1241D2F9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 08:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348186AbhI3GBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 02:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348054AbhI3GBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 02:01:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0A6261265;
        Thu, 30 Sep 2021 06:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632981606;
        bh=+9Cimias7j0INGICFeEb++U9FTUPDMbOhsM3g32/A/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FJ9v3kPBgadWq9TqyDSkBB+ZjCCPeEb68cegwt58vk1kS1yM5e1cWDPYnwdpXz2Cv
         hAKlC9vcnNclW3U+9HxmV1aUWWR+JTuIuDnK9Rxanfkl55bGXaFDXvyYWTPXlXtKts
         dpVzVAdvmFM3U1qB5YQ8EQXj7BsZyEXZ8RjlCM9o=
Date:   Thu, 30 Sep 2021 08:00:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dawid Esterhuizen <desterhuizen@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Statements should start on a tabstop
Message-ID: <YVVSYVpUPekkUsLy@kroah.com>
References: <YVTN5i8qwjlGwOPp@kkobus.whirley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVTN5i8qwjlGwOPp@kkobus.whirley.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 10:34:46PM +0200, Dawid Esterhuizen wrote:
> This path fixes four checkpatch.pl warnings:
> 
> Statements should start on a tabstop
> 
> Signed-off-by: Dawid Esterhuizen <desterhuizen@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl871x_xmit.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl8712/rtl871x_xmit.h
> index 2e6afc7bb0a1..bc1287cc853e 100644
> --- a/drivers/staging/rtl8712/rtl871x_xmit.h
> +++ b/drivers/staging/rtl8712/rtl871x_xmit.h
> @@ -182,11 +182,11 @@ struct sta_xmit_priv {
>  };
>  
>  struct	hw_txqueue {
> -	/*volatile*/ sint	head;
> -	/*volatile*/ sint	tail;
> -	/*volatile*/ sint	free_sz;	/*in units of 64 bytes*/
> -	/*volatile*/ sint      free_cmdsz;
> -	/*volatile*/ sint	 txsz[8];
> +  /*volatile*/ sint head;
> +  /*volatile*/ sint tail;
> +  /*volatile*/ sint free_sz;	/*in units of 64 bytes*/
> +  /*volatile*/ sint free_cmdsz;
> +  /*volatile*/ sint txsz[8];

I think you now have added a new checkpatch warning, right?

This is not the correct indentation anymore, why not work to see if you
can remove the volatile comment instead?

thanks,

greg k-h
