Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B4B3F1EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhHSRUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232505AbhHSRT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:19:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FE6B61075;
        Thu, 19 Aug 2021 17:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629393562;
        bh=qoLCUB8hdlY6dt5B1iccs3/ypgnDf4kMfDKvX1WGKjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o48wtOMmiwdfQGDw0eIPc8nz1CuZw3345c1PYuemNAsOQAbR6uVsKnjm5W0vWJ7Wn
         lGxz1UXCSMepTiSbP5hajlbxNNcPQTb/8Gfiq98WEkvsl077WLEhfSyfmmyTbTZ2cT
         zDPOrE64DUn1ejibyaKt8D1X5ajHJ0x4fDIBGppI=
Date:   Thu, 19 Aug 2021 19:19:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] staging: r8188eu: cast to restricted __be32
Message-ID: <YR6SlQFV0HRov/fC@kroah.com>
References: <cover.1629360917.git.aakashhemadri123@gmail.com>
 <602aefc30b0d979dc6e402d52da2f096ea5c67cf.1629360917.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <602aefc30b0d979dc6e402d52da2f096ea5c67cf.1629360917.git.aakashhemadri123@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 01:47:54PM +0530, Aakash Hemadri wrote:
> Fix sparse warning:
> > rtw_br_ext.c:836:54: warning: cast to restricted __be32
> 
> Unnecessary double cast, remove them.
> 
> Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index 404fa8904e47..6a0462ce6230 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -671,7 +671,7 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
>  				    (udph->dest == __constant_htons(SERVER_PORT))) { /*  DHCP request */
>  					struct dhcpMessage *dhcph =
>  						(struct dhcpMessage *)((size_t)udph + sizeof(struct udphdr));
> -					u32 cookie = be32_to_cpu((__be32)dhcph->cookie);
> +					u32 cookie = dhcph->cookie;

Wait, what?  The cookie was in big endian format, and now you just
ignore it?  Why is this ok?  This breaks the code, have you tested this?

thanks,

greg k-h
