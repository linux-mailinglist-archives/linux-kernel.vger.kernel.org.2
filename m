Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C7B35BA12
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 08:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhDLGTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 02:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhDLGTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 02:19:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D30EF6120F;
        Mon, 12 Apr 2021 06:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618208345;
        bh=OqQ9BxvC/MpIsNTJVxdAX+jVvRznRTSxbFDCudUdUDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YbqSdBsjVTaWy67PRDy7meyuH9lidPbPl5fUK90I7EJrtAKVg2fZPoigMgV+/Bhf8
         FMc/3hhgXs9HxMyE1CGwkr0dBu0HZhvA3jupxrxcPxHxBiRmS8A+oZRrhCWL64rOgL
         Skv7A8lo/T/QfWBC8+X0uOzzTfmuKhHGaaByFi1A=
Date:   Mon, 12 Apr 2021 08:19:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        mitali_s@me.iitr.ac.in
Subject: Re: [PATCH] staging: rtl8188eu: replaced msleep() by usleep_range()
Message-ID: <YHPmVtAGH7WWGfjJ@kroah.com>
References: <YHPkbTPPra2isn5e@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHPkbTPPra2isn5e@kali>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 11:40:53AM +0530, Mitali Borkar wrote:
> Fixed the warning:-msleep < 20ms can sleep for up to 20ms by replacing
> msleep(unsigned long msecs) by usleep_range(unsigned long min, unsigned long max)
> in usecs as msleep(1ms~20ms) can sleep for upto 20 ms.
> 
> Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> index 50d3c3631be0..6afbb5bf8118 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> @@ -5396,7 +5396,7 @@ u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
>  			return H2C_SUCCESS;
>  
>  		if ((pstapriv->tim_bitmap & BIT(0)) && (psta_bmc->sleepq_len > 0)) {
> -			msleep(10);/*  10ms, ATIM(HIQ) Windows */
> +			usleep_range(10000 , 20000);/*  10ms, ATIM(HIQ) Windows */

How do you know you can sleep for 20000 here?

And given that you just changed how the sleep works, are you sure the
functionality is the same now?

Only change this type of warning if you have the hardware and can test
the change properly.

thanks,

greg k-h
