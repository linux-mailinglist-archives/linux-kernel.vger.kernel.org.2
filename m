Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F45C33A36F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 08:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhCNHeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 03:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230265AbhCNHdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 03:33:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1272264EB2;
        Sun, 14 Mar 2021 07:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615707223;
        bh=/R7zLYFpW/po4qIK7muTX9jiWl1BZL/eh7Q4Otw6pj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJndpGIc6RG7Sw7BxyBsa8ZTozueA0bXi7sBXGGRDuZwn22Z6tBUvy9ZakKAOuvAZ
         2ppvzXw74uPhHP2+o9Umf3mPoVE9Bke4cr6WGXQTv5PzSpxfeTHvBG6wv1IRvx1bZ4
         GXYWmQWir/KDBthxwLMFcbFjvB9ZceHaBbLF78iY=
Date:   Sun, 14 Mar 2021 08:33:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Selvakumar Elangovan <selvakumar16197@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon-usb: fixed precedence issue
Message-ID: <YE28Uzs6ZhHopk8J@kroah.com>
References: <20210313173247.8676-1-selvakumar16197@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313173247.8676-1-selvakumar16197@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 11:02:47PM +0530, Selvakumar Elangovan wrote:
> Added parenthesis around reg macro to avoid precedence issue identified by
> checkpatch.pl
> 
> Signed-off-by: Selvakumar Elangovan <selvakumar16197@gmail.com>
> ---
>  drivers/staging/octeon-usb/octeon-hcd.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/octeon-usb/octeon-hcd.h b/drivers/staging/octeon-usb/octeon-hcd.h
> index 9ed619c93a4e..5aefd3fb3854 100644
> --- a/drivers/staging/octeon-usb/octeon-hcd.h
> +++ b/drivers/staging/octeon-usb/octeon-hcd.h
> @@ -51,11 +51,11 @@
>  #include <asm/bitfield.h>
>  
>  #define CVMX_USBCXBASE 0x00016F0010000000ull
> -#define CVMX_USBCXREG1(reg, bid) \
> -	(CVMX_ADD_IO_SEG(CVMX_USBCXBASE | reg) + \
> +#define CVMX_USBCXREG1((reg), bid) \

Why did you change this line?
