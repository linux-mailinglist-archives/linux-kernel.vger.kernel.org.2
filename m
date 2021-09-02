Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D52B3FEB21
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245356AbhIBJWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244800AbhIBJV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:21:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2777960F6C;
        Thu,  2 Sep 2021 09:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630574459;
        bh=Q2uYr1StgndRxWJ5vI83t1KnU1e0/MBW/UEtfaBfT8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OIP+QkNrbd8Sb9tSGQg/GS2C8xuDV0VPA2aZiKGuLQ/3mtyZoPB4hZBhW7ED/i81m
         ty5/bxVjc0IJZXGurW4oqKTny0uvjIXZnIxRVZkeKruzbsoaAphl5fZ5PMs+bYanqn
         XE0mq6DFZFCaKPCOdVlj8Zq2nlUqKMt0M461P0Zw=
Date:   Thu, 2 Sep 2021 11:20:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: os_dep: use kmemdup instead of kzalloc
 and memcpy
Message-ID: <YTCXef5o9JHtQhuD@kroah.com>
References: <YSp9z2/JmvHGhW5m@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSp9z2/JmvHGhW5m@user>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 11:47:51PM +0530, Saurav Girepunje wrote:
> Fixes coccicheck warning:WARNING opportunity for kmemdup in ioctl_linux.c
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 81d4255d1785..495fadd2b8c8 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -585,14 +585,12 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
>  	}
> 
>  	if (ielen) {
> -		buf = kzalloc(ielen, GFP_KERNEL);
> +		buf = kmemdup(pie, ielen, GFP_KERNEL);
>  		if (!buf) {
>  			ret =  -ENOMEM;
>  			goto exit;
>  		}
> 
> -		memcpy(buf, pie, ielen);
> -
>  		/* dump */
>  		{
>  			int i;
> --
> 2.32.0
> 
> 

This patch never showed up on lore.kernel.org for some reason.  Please
resend and see if it was a mailing issue on your side...

thanks,

greg k-h
