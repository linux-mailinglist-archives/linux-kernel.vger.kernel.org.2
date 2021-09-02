Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955133FEB2A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245447AbhIBJ06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245416AbhIBJ0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:26:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 201AB61058;
        Thu,  2 Sep 2021 09:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630574755;
        bh=Yxy8KM/Ohu/+iS5kBagZcmeiZaFKnSW9/TTj7inv4ZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fhaf3pWmgUnA6/2gPoyol3nOWFW9Zx2baVX1bw7KONGrfY5le3/P3g2TbzqVF9bFU
         jxWQZZ83QxQ0lyK0EeZndMYhLnRl9FOzYvm5Zw1tvLlbdVCFkoh7FDKOqmGktH4xXB
         x//lyqtDFvQp/2+4OZ7W0Lje4pW5X9z33xDNvoLY=
Date:   Thu, 2 Sep 2021 11:25:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] staging: r8188eu: restricted __be16 degrades to
 int
Message-ID: <YTCYodihc/U/StOw@kroah.com>
References: <cover.1630148641.git.aakashhemadri123@gmail.com>
 <652e62b7f30d216bafc6ef390ed27c2c6864fe95.1630148641.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <652e62b7f30d216bafc6ef390ed27c2c6864fe95.1630148641.git.aakashhemadri123@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 04:40:44PM +0530, Aakash Hemadri wrote:
> Fix sparse warning:
> > rtw_br_ext.c:73:23: warning: restricted __be16 degrades to integer
> 
> Here tag->tag_len is be16, use be16_to_cpu()
> 
> Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index 62a672243696..aa56cd1a8490 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -70,7 +70,7 @@ static int __nat25_add_pppoe_tag(struct sk_buff *skb, struct pppoe_tag *tag)
>  	struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
>  	int data_len;
>  
> -	data_len = tag->tag_len + TAG_HDR_LEN;
> +	data_len = be16_to_cpu(tag->tag_len) + TAG_HDR_LEN;
>  	if (skb_tailroom(skb) < data_len) {
>  		_DEBUG_ERR("skb_tailroom() failed in add SID tag!\n");
>  		return -1;
> -- 
> 2.32.0
> 

If this change happens, that means the existing driver does not work at
all on little-endian machines today?  But that seems odd and wrong, are
you sure this change is correct?

How did you test this?

thanks,

greg k-h
