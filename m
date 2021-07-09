Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656233C25CC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhGIOX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 10:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhGIOX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 10:23:28 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E04C0613E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 07:20:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t17so23651763lfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 07:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XkgFIUp5iLs9nU5JEu6HehRGh39QNsQ3xKszMt50D9Q=;
        b=nnvEugLL4kUaZI9GXDpIfcLy1E9zwjMePxX22SuHIBXzMGviHjvnuQxC+HsblD7A7s
         Th1dvRbYWP4rcXx3evnioxr1liZAFO4EqfDjePeNBLen6ioa2Z1hr333yq8ZRCb8D/v7
         c/E5JLRSbSZSF2FIOTw57704r2CGQSCPAMsT2SJqCrK8BZMFIm02r8G84BZbPvv8nI8I
         0vMuSJT+yHHkrRSTvdSlOZmxcmnrzqZ+mj/JGk6yOORSOYijc5ld+Cwvkpr6/S0O15A2
         wXP+zieaxvEO+P+WchQKKPnvOXYkgGM50JOGgoOLvsisDH1zkdsVS00TwQ2ssN/A5Lxr
         qq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XkgFIUp5iLs9nU5JEu6HehRGh39QNsQ3xKszMt50D9Q=;
        b=qZVErfNpJ2AtQ+99CFRIHAxCIe5QqroY/JZXDpuSBsZNGIzrCBFQFPxzXsEDNcC0DT
         TIUPZBXlQcnUQvunWR1LIY/XFCM+eX6xs098Ww/gVff2aBwsrA/le5HvjcoFb+xltWj6
         2oIgEBZOwYvixudczgtS2+bYsY10vXcnWpXOH/bWs3u/ma0Lhsnbz6TFgsLCElIj40Ir
         l3enPKuiiYEFK4gC8eZkfOTJdpeeN2ql9ZauqAZo3UuK8lvyRuoXNZuuQp8pSXpjID3h
         WR0NY2xCA/NRgKYlv5LnWnRR0XBfNIH3dMOTLDjE8jT3jDfOaeHoPfWuQLcNxlm3OCg0
         +Leg==
X-Gm-Message-State: AOAM531lUB6dD8xxKLOg7Vbrpv7S5ZANAOQazOQh04dVa60sucz/b0ja
        7nkFPlTZw6q3LX0tc/f67APIMOOptbZZyCek
X-Google-Smtp-Source: ABdhPJwxjeI7so/CQeRaJZgPKVtDxnOFUhKAfFqZ2Q95ta5CH49HKObMP0+3hbSx4A3QQwqr+ZbVDw==
X-Received: by 2002:ac2:41c5:: with SMTP id d5mr29096943lfi.56.1625840442217;
        Fri, 09 Jul 2021 07:20:42 -0700 (PDT)
Received: from localhost (h-46-59-88-219.A463.priv.bahnhof.se. [46.59.88.219])
        by smtp.gmail.com with ESMTPSA id r11sm617640ljp.9.2021.07.09.07.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 07:20:41 -0700 (PDT)
Date:   Fri, 9 Jul 2021 16:20:40 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Dennis Rachui <drachui@de.adit-jv.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: rcar-csi2: do not update format while streaming
Message-ID: <YOhbOHnCn9eFgKWG@oden.dyn.berto.se>
References: <1625750578-108454-1-git-send-email-drachui@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1625750578-108454-1-git-send-email-drachui@de.adit-jv.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dennis,

Thanks for your patch.

On 2021-07-08 15:22:58 +0200, Dennis Rachui wrote:
> Verify that streaming is not active before setting the pad format.
> 
> According to the VIDIOC documentation [1] changes to the active
> format of a media pad via the VIDIOC_SUBDEV_S_FMT ioctl are
> applied to the underlying hardware.
> In rcar-csi2 a format change only applies to hardware, when the
> pipeline is started. While the device is not in use, it is therefore
> okay to update the format.
> 
> However, when the pipeline is active, this leads to a format
> mismatch between driver and device.
> Other applications can query the format with
> VIDIOC_SUBDEV_G_FMT at any time and would be reported
> a format that does not fit the current stream.
> 
> This commit prevents format update while streaming is active
> and returns -EBUSY to user space, as suggested by [1].
> 
> [1] Documentation/userspace-api/media/v4l/vidioc-subdev-g-fmt.rst

I like that this is addressed, but I wonder is this not something that 
should be fixed in the V4L2 core and not in drivers?

> 
> Note: after creation of this commit, it was noticed that Steve
> Longerbeam has a very similar solution in his fork.
> 
> Fixes: 769afd212b16 ("media: rcar-csi2: add Renesas R-Car MIPI CSI-2 receiver driver")
> Cc: Steve Longerbeam <slongerbeam@gmail.com>
> Signed-off-by: Dennis Rachui <drachui@de.adit-jv.com>
> ---
>  drivers/media/platform/rcar-vin/rcar-csi2.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
> index e28eff0..98152e1 100644
> --- a/drivers/media/platform/rcar-vin/rcar-csi2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
> @@ -724,18 +724,37 @@ static int rcsi2_set_pad_format(struct v4l2_subdev *sd,
>  {
>  	struct rcar_csi2 *priv = sd_to_csi2(sd);
>  	struct v4l2_mbus_framefmt *framefmt;
> +	int ret = 0;
> +
> +	mutex_lock(&priv->lock);
>  
>  	if (!rcsi2_code_to_fmt(format->format.code))
>  		format->format.code = rcar_csi2_formats[0].code;
>  
>  	if (format->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
> +
> +		/*
> +		 * Do not apply changes to active format while streaming.
> +		 *
> +		 * Since video streams could be forwarded from sink pad to any
> +		 * source pad (depending on CSI-2 channel routing), all
> +		 * media pads are effected by this rule.
> +		 */
> +		if (priv->stream_count > 0) {
> +			ret = -EBUSY;
> +			goto out;
> +		}
> +
>  		priv->mf = format->format;
>  	} else {
>  		framefmt = v4l2_subdev_get_try_format(sd, sd_state, 0);
>  		*framefmt = format->format;
>  	}
>  
> -	return 0;
> +out:
> +	mutex_unlock(&priv->lock);
> +
> +	return ret;
>  }
>  
>  static int rcsi2_get_pad_format(struct v4l2_subdev *sd,
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund
