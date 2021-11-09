Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5E444A6D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 07:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbhKIG2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 01:28:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:57192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhKIG2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 01:28:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1F91610A2;
        Tue,  9 Nov 2021 06:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636439147;
        bh=NAD7GpZaIjjRMJijOuf+4p3g+bGUcS5kzM+DFYjVjQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCJlgy0wtzwpn7AkCQ+pFs/O0qD2rVNdTagddowGpQlk6+5RJBFEBRbxxd/mja3c6
         2mtadBBeCUwmUX/wfhSoFOCrc5kxdxQ+IbZeeoTRZSIb5cbtZBglqbyoTubuFkEKXA
         Yjx9Eo1L14UxHPvGje/E1/4qUF4fOMyArzv5ikj0=
Date:   Tue, 9 Nov 2021 07:25:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vihas Mak <makvihas@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: ppdev: fixed a validation issue
Message-ID: <YYoUYOyyP4EFYTSJ@kroah.com>
References: <20211108185818.GA73382@makvihas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108185818.GA73382@makvihas>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 12:28:18AM +0530, Vihas Mak wrote:
> Make sure the mode is a valid IEEE1284 mode.

What is a valid mode?

> Signed-off-by: Vihas Mak <makvihas@gmail.com>
> ---
>  drivers/char/ppdev.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
> index 38b46c7d1737..3b290cbf6c66 100644
> --- a/drivers/char/ppdev.c
> +++ b/drivers/char/ppdev.c
> @@ -333,6 +333,28 @@ static enum ieee1284_phase init_phase(int mode)
>  	return IEEE1284_PH_FWD_IDLE;
>  }
>  
> +/*
> + * Validate the mode and make sure the mode is power of two.
> + *
> + * IEEE1284_MODE_ECPRLE and IEEE1284_MODE_NIBBLE are exception
> + * to this so handle them accordingly.
> + */
> +

Why the extra line?

> +static int pp_validate_mode(int mode)

bool?

> +{
> +	if (mode == IEEE1284_MODE_ECPRLE || mode == IEEE1284_MODE_NIBBLE) {
> +		return 1;
> +	} else if (!(mode & (mode - 1)) &&
> +		   (mode & (IEEE1284_MODE_BYTE | IEEE1284_MODE_COMPAT |
> +			    IEEE1284_MODE_BECP | IEEE1284_MODE_ECP |
> +			    IEEE1284_MODE_ECPSWE | IEEE1284_MODE_EPP |
> +			    IEEE1284_MODE_EPPSL | IEEE1284_MODE_COMPAT |
> +			    IEEE1284_MODE_EPPSWE))) {
> +		return 1;
> +	}
> +	return 0;
> +}

How did you test this?  And why is this needed now?  What hardware was
working that is now not going to work with this driver?

thanks,

greg k-h
