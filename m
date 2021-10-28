Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43E343E66B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhJ1QpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231178AbhJ1QpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:45:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2574060238;
        Thu, 28 Oct 2021 16:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635439353;
        bh=nhnhDs6r4p5EaPCqcbb6JFQVDxWedPO0J85OCd8/7nQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7N7VrJw7X062UMMNUg4E0GnT97i81zY9kp/kHyi0LO46U2eNQQhuGRtl2zO29SWj
         soUlHlKwEORzy2NB4RekAYP2K22Zb9mDka3JQRWkXcmnKmYdSOgoKQcGGnIPe8Ra0/
         RVyEnaYEL6M7bo4NacBNZlSKOjLT1/Tr5cxJ6ljM=
Date:   Thu, 28 Oct 2021 18:42:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Senthu Sivarajah <ssivaraj@stud.fra-uas.de>
Cc:     vaibhav.sr@gmail.com, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: greybus: audio_codec: changed a void function
 to return 0
Message-ID: <YXrS9xwJf5AcBoFJ@kroah.com>
References: <20211028153808.9509-1-ssivaraj@stud.fra-uas.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028153808.9509-1-ssivaraj@stud.fra-uas.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 05:38:08PM +0200, Senthu Sivarajah wrote:
> From: Senthuran Sivarajah <ssivaraj@stud.fra-uas.de>
> 
> Fixed a coding style issue.

What coding style exactly?

> 
> Signed-off-by: Senthuran Sivarajah <ssivaraj@stud.fra-uas.de>
> 
> ---
>  drivers/staging/greybus/audio_codec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> index b589cf6b1d03..9f99862791dc 100644
> --- a/drivers/staging/greybus/audio_codec.c
> +++ b/drivers/staging/greybus/audio_codec.c
> @@ -1028,7 +1028,7 @@ static int gbcodec_probe(struct snd_soc_component *comp)
>  static void gbcodec_remove(struct snd_soc_component *comp)
>  {
>  	/* Empty function for now */
> -	return;
> +	return 0;

Did you build this change?

Exactly what tool reported a problem with this code and what was the
exact error?

thanks,

greg k-h
