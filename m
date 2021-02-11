Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2BF3187C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhBKKGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:06:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229939AbhBKKDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:03:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FAC664EAA;
        Thu, 11 Feb 2021 10:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613037775;
        bh=o6lGyeY2MIoy9PRfw/I9U4mRzEDKFsaYxG9F5OpF9so=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1BNFZkGfKSnDmUr1ZIk/lEbwrINtYeDrlgilobHr1y4jQKIQ/sjdqE9PO28HDm+3p
         +wHgcrkh0wGydKqnI11HlGdsKdqthPRkNrbH3APRE0jvmytjf7gXJxN1rAUizeSr0I
         BQIf/LCU/UAirGPA7LnO7Z5TYziE+huw0htQLXIk=
Date:   Thu, 11 Feb 2021 11:02:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fatih Yildirim <yildirim.fatih@gmail.com>
Cc:     gustavo@embeddedor.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] staging: ks7010: Macros with complex values
Message-ID: <YCUAy1VhLV3lwa3H@kroah.com>
References: <20210211092239.10291-1-yildirim.fatih@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211092239.10291-1-yildirim.fatih@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 12:22:39PM +0300, Fatih Yildirim wrote:
> Fix for checkpatch.pl warning:
> Macros with complex values should be enclosed in parentheses.
> 
> Signed-off-by: Fatih Yildirim <yildirim.fatih@gmail.com>
> ---
>  drivers/staging/ks7010/ks_hostif.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
> index 39138191a556..c62a494ed6bb 100644
> --- a/drivers/staging/ks7010/ks_hostif.h
> +++ b/drivers/staging/ks7010/ks_hostif.h
> @@ -498,20 +498,20 @@ struct hostif_mic_failure_request {
>  #define TX_RATE_FIXED		5
>  
>  /* 11b rate */
> -#define TX_RATE_1M	(u8)(10 / 5)	/* 11b 11g basic rate */
> -#define TX_RATE_2M	(u8)(20 / 5)	/* 11b 11g basic rate */
> -#define TX_RATE_5M	(u8)(55 / 5)	/* 11g basic rate */
> -#define TX_RATE_11M	(u8)(110 / 5)	/* 11g basic rate */
> +#define TX_RATE_1M	((u8)(10 / 5))	/* 11b 11g basic rate */
> +#define TX_RATE_2M	((u8)(20 / 5))	/* 11b 11g basic rate */
> +#define TX_RATE_5M	((u8)(55 / 5))	/* 11g basic rate */
> +#define TX_RATE_11M	((u8)(110 / 5))	/* 11g basic rate */

But these are not "complex macros" that need an extra () added to them,
right?

Checkpatch is a hint, it's not a code parser and can not always know
what is happening.  With your knowledge of C, does this look like
something that needs to be "fixed"?

thanks,

greg k-h
