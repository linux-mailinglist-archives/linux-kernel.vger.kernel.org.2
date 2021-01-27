Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB192305AE3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbhA0MJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:09:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:41058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237436AbhA0MBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:01:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAC4320770;
        Wed, 27 Jan 2021 12:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611748840;
        bh=qovR8b6obg/+C2aAJyNjJh+/aJICMootmi3BriCc59w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sr4iPfoQBoy30bKObSK4x6S59hIlRiqskqolruHNu/9+oTkb1ums4Ize04t4qVdsH
         jnbjjdD/oXPPsCDQ0q5WoQqlz5fx0t5//tiPZGBhq24Ldx6ozjEd8jgTyDvZj2tfid
         v/nBCDRfyrvN/pOcOoPVAXnp4lwvLT7WRRun+94s=
Date:   Wed, 27 Jan 2021 13:00:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: audio_helper.c: Replace strlcpy() with
 strscpy()
Message-ID: <YBFV5eo5AYmLd4E0@kroah.com>
References: <20210109132731.tczawd5p74xnfz7p@pesu.pes.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109132731.tczawd5p74xnfz7p@pesu.pes.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 06:57:31PM +0530, B K Karthik wrote:
> In gbaudio_remove_controls() , replace the usage of strlcpy() with
> strscpy() because strlcpy() only limits the *destination*
> size, and the source is always read fully.
> 
> https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> was quoted by checkpatch while showing this warning.
> 
> Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
> ---
>  drivers/staging/greybus/audio_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
> index 3011b8abce38..1ed4772d2771 100644
> --- a/drivers/staging/greybus/audio_helper.c
> +++ b/drivers/staging/greybus/audio_helper.c
> @@ -166,7 +166,7 @@ static int gbaudio_remove_controls(struct snd_card *card, struct device *dev,
>  			snprintf(id.name, sizeof(id.name), "%s %s", prefix,
>  				 control->name);
>  		else
> -			strlcpy(id.name, control->name, sizeof(id.name));
> +			strscpy(id.name, control->name, sizeof(id.name));

Is this something that matters here?  Isn't the string coming from the
kernel (i.e. a trusted source), or if not, where is it coming from?

thanks,

greg k-h
