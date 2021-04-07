Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7857435732E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354858AbhDGR1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:27:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343919AbhDGR1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:27:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B331D6121E;
        Wed,  7 Apr 2021 17:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617816461;
        bh=wML+tSnxv9IbA86AT88LJuFFqghf3Jd4Gqq7cIZVAjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TWIntSl8ESTsWfdXaab1zkv8l1PqPUKvLETbEskfSPyETrRZMXAV2mLm/RRba235w
         8LejBLCGve0bCLm7zsHYLrmjwKoXEwgzioWmjuVxDm9Puarr3gbE68932ZuvgmKFbY
         tyKnIHwMLJikfU3qOCcBofZhr/GGKjKj/eV7E4/U=
Date:   Wed, 7 Apr 2021 19:27:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: hal: Remove
 camelcase
Message-ID: <YG3rihKrS2tvr1tS@kroah.com>
References: <20210407163000.27611-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407163000.27611-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 06:30:00PM +0200, Fabio M. De Francesco wrote:
> Remove camelcase. Issue detected by checkpatch.pl. For now, change only
> names of static functions in order to not break the driver's code.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/sdio_ops.c | 44 ++++++++++++------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> index b1f02bb9f0a9..5e28818e58e0 100644
> --- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
> +++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> @@ -19,7 +19,7 @@
>  /*  */
>  /*  Creadted by Roger, 2011.01.31. */
>  /*  */
> -static void HalSdioGetCmdAddr8723BSdio(
> +static void hal_sdio_get_cmd_addr_8723b_sdio(
>  	struct adapter *adapter,
>  	u8 device_id,
>  	u32 addr,
> @@ -97,7 +97,7 @@ static u8 get_deviceid(u32 addr)
>  
>  /*
>   * Ref:
> - *HalSdioGetCmdAddr8723BSdio()
> + *hal_sdio_get_cmd_addr_8723b_sdio()

What does this comment even mean?

I think you can delete it.

But really, that's a crazy function name length, can you make it any
shorter?

thanks,

greg k-h
