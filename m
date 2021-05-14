Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5743804AE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhENHx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232804AbhENHx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:53:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B072861446;
        Fri, 14 May 2021 07:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620978736;
        bh=tauFPhaHs/I1wxs1340eEUTGjw6C403rcF9eVU4OHyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WzMC5erhqHrK8hDyW6hnZOXzX0EYS8KbCaNRFYqCXYPeRDvuC3qpaQ73EJBiUnpDa
         CcaL/TaX7oAst4BshEg1BpiK/KpXfcmD3Ba0IpvoBtuCIttUFGGfyCGrilr0fiTAdW
         aZ9O3LAO7bLys8IBOJQXeraunBOmktfe7gb1GklI=
Date:   Fri, 14 May 2021 09:52:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     linux-kernel@vger.kernel.org, abbotti@mev.co.uk,
        hsweeten@visionengravers.com, grandmaster@al2klimov.de
Subject: Re: [PATCH -next v2] staging: =?utf-8?Q?co?=
 =?utf-8?Q?medi=3A_Remove_unused_variable_=E2=80=98min=5Ffull=5Fscale?=
 =?utf-8?B?4oCZ?= and function 'get_min_full_scales'
Message-ID: <YJ4sLVlncZoQkNJm@kroah.com>
References: <20210514085214.53941-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210514085214.53941-1-cuibixuan@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 04:52:14PM +0800, Bixuan Cui wrote:
> The variable ‘min_full_scale’ and function 'get_min_full_scales' are
> not used, So delete them.
> 
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
> Changes from v2:
> * Delete function 'get_min_full_scales'
> 
>  drivers/comedi/drivers/jr3_pci.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
> index 7a02c4fa3cda..f963080dd61f 100644
> --- a/drivers/comedi/drivers/jr3_pci.c
> +++ b/drivers/comedi/drivers/jr3_pci.c
> @@ -186,19 +186,6 @@ static void set_full_scales(struct jr3_sensor __iomem *sensor,
>  	set_s16(&sensor->command_word0, 0x0a00);
>  }
>  
> -static struct six_axis_t get_min_full_scales(struct jr3_sensor __iomem *sensor)
> -{
> -	struct six_axis_t result;
> -
> -	result.fx = get_s16(&sensor->min_full_scale.fx);
> -	result.fy = get_s16(&sensor->min_full_scale.fy);
> -	result.fz = get_s16(&sensor->min_full_scale.fz);
> -	result.mx = get_s16(&sensor->min_full_scale.mx);
> -	result.my = get_s16(&sensor->min_full_scale.my);
> -	result.mz = get_s16(&sensor->min_full_scale.mz);
> -	return result;

Are you _SURE_ that this is ok to do?  You are reading from the
hardware, and that is sometimes required depending on the
internal-to-the-device state machine.

Have you tested to verify that not doing these reads does not break
something?

This is a constant theme in these "remove variables that are not being
used" patches, please be aware that how hardware works is very specific
and when you mess with how it is accessed, that has the chance of
causing problems.

thanks,

greg k-h
