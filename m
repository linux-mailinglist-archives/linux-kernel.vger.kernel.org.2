Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C1737F805
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhEMMfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:35:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233357AbhEMMfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:35:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05AC861263;
        Thu, 13 May 2021 12:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620909264;
        bh=OIpXmWLiw+xWB2AxFsY+5NcMcsldq5MSVHFAlxapjRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eA4lzZ6IEh7JfpEnHMGkcc9Rq3zRqE+MYIfyG3SGKF7lfb8Fz1qRGLJ23etZIgseE
         b5uUFEnSlmoVG2Yd34K5HJzQEf1ppGBXUjNj4/ZNNg8fH1AhPriVLQqGP2tGlTE+2j
         6MBDOlk1mPv7p/ijYBDjprlDhcpWbXySW4ks/2tM=
Date:   Thu, 13 May 2021 14:34:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     linux-kernel@vger.kernel.org, abbotti@mev.co.uk,
        hsweeten@visionengravers.com, grandmaster@al2klimov.de,
        john.wanghui@huawei.com
Subject: Re: [PATCH -next] staging: =?utf-8?Q?comed?=
 =?utf-8?Q?i=3A_Remove_unused_variable_=E2=80=98min=5Ffull=5Fscale?=
 =?utf-8?B?4oCZ?=
Message-ID: <YJ0czj6EOwW/l4sq@kroah.com>
References: <20210513133458.27766-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210513133458.27766-1-cuibixuan@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 09:34:58PM +0800, Bixuan Cui wrote:
> Fix the following build warnings:
> drivers/comedi/drivers/jr3_pci.c:507:22:
> 	warning: variable ‘min_full_scale’ set but not used
> 
> And fix build warnings after removing ‘min_full_scale’:
> drivers/comedi/drivers/jr3_pci.c:189:26:
> 	warning: ‘get_min_full_scales’ defined but not used
>  static struct six_axis_t get_min_full_scales(struct jr3_sensor __iomem *sensor)
>                           ^~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
>  drivers/comedi/drivers/jr3_pci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
> index 7a02c4fa3cda..122b95dc2bf9 100644
> --- a/drivers/comedi/drivers/jr3_pci.c
> +++ b/drivers/comedi/drivers/jr3_pci.c
> @@ -186,7 +186,7 @@ static void set_full_scales(struct jr3_sensor __iomem *sensor,
>  	set_s16(&sensor->command_word0, 0x0a00);
>  }
>  
> -static struct six_axis_t get_min_full_scales(struct jr3_sensor __iomem *sensor)
> +static __maybe_unused struct six_axis_t get_min_full_scales(struct jr3_sensor __iomem *sensor)

If it really is not used, then remove it, don't paper over a compiler
warning for no good reason please.

Fix this properly.

>  {
>  	struct six_axis_t result;
>  
> @@ -504,10 +504,8 @@ jr3_pci_poll_subdevice(struct comedi_subdevice *s)
>  			result = poll_delay_min_max(20, 100);
>  		} else {
>  			/* Set full scale */
> -			struct six_axis_t min_full_scale;
>  			struct six_axis_t max_full_scale;
>  
> -			min_full_scale = get_min_full_scales(sensor);
>  			max_full_scale = get_max_full_scales(sensor);

Did you just break the driver by messing with the order of reading from
the device?

thanks,

greg k-h
