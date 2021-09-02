Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C893FEB3C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245693AbhIBJ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:29:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245516AbhIBJ3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:29:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C924461058;
        Thu,  2 Sep 2021 09:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630574927;
        bh=fUOx3RPY+JkEhnWQkrq5pibbynHmCRSVbkLIIy/K9nk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=03dDXfS3oONFchOlowgS9EjFgv0kxw9zCFvntxPSiLakgXv+eM0BI3RBDAjMRDLKT
         zt4Gw8h8vBuQVQaZ/3aUXqijreQqKIe6bwTNCqkQi8mmvNdVq0LohrxZ7id0Q7ZVlP
         tBSexhZHpAyxS1btCgGZ6PKqzUosBYBsWsmOfiQs=
Date:   Thu, 2 Sep 2021 11:28:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] staging: r8188eu: incorrect type in assignment
Message-ID: <YTCZTY1WsHhTBjUE@kroah.com>
References: <cover.1630148641.git.aakashhemadri123@gmail.com>
 <74c156553614f44a900e987f1185f3388dd740f6.1630148641.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74c156553614f44a900e987f1185f3388dd740f6.1630148641.git.aakashhemadri123@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 04:40:46PM +0530, Aakash Hemadri wrote:
> Fix sparse warning:
> > rtw_br_ext.c:516:57: warning: incorrect type in assignment
>     (different base types)
> > rtw_br_ext.c:516:57:    expected unsigned short
> > rtw_br_ext.c:516:57:    got restricted __be16 [usertype]
> 
> *pMagic holds __be16 change it's type to __be16

I do not understand this sentence, what are you trying to say?

Remember, "it's" is short for "it is".

> Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index 38f1bd591da9..bce73e8cbd52 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -474,7 +474,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  		/*                Handle PPPoE frame                 */
>  		/*---------------------------------------------------*/
>  		struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
> -		unsigned short *pMagic;
> +		__be16 *pMagic;
>  
>  		switch (method) {
>  		case NAT25_CHECK:
> @@ -512,7 +512,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  						tag->tag_len = htons(MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN+old_tag_len);
>  
>  						/*  insert the magic_code+client mac in relay tag */
> -						pMagic = (unsigned short *)tag->tag_data;
> +						pMagic = (__be16 *)tag->tag_data;

Is this whole function ever actually called?

Can someone run a ftrace on the driver to see if this function ever
runs, and if not, remove it?

thanks,

greg k-h
