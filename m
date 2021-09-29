Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A3A41C767
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344773AbhI2Ozj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344674AbhI2Oze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:55:34 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE76FC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:53:52 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i4so12022403lfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JQ9T4n0FIcOq17O9WIuPMXgKjJWLtigT8GSjbeG4O3A=;
        b=S1mQR2y7E7KzALcNIPbbtmqByFx0GYmKJ0JRrrnjBpA9bytzUZofjYImlWsbak/T5j
         f4DLZVDQzW8FxGZwOzQ+C+PolabNSzj4mMP046DGXle+akLBK8R1CNcI0cSiCPbI1gdo
         M4zPJP6P+WVCUy6cWfe0ibQa8IBmJbX1SGK/szjrP62B2F9snxnP1xxupUQX6x9d+Hzv
         PC/IyQp8n3OPP1vZHHtktbOhWzEyh2kHNAu8URpvnCWWt2BkbqiF6fYCuiYCGO2nwwdK
         ndr0TloFRMKPGmCwjmEaqBnxQslZK837QXi2Zp4ejnnJ/vfnD8j0EiGVedH++ZVIOeSI
         j9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JQ9T4n0FIcOq17O9WIuPMXgKjJWLtigT8GSjbeG4O3A=;
        b=nXHnZJwg1F33dyKNRvsdehho/vHaBD8WVFe342n//vDFb33PFjb5lKCzqXvb/lcSWM
         l/DpY05oQiVObrNyUNKY4rzd5aRIcrLPE1L7hvXf2zzwQBEYkQbjeZHUX9+5jaCUUwi1
         KXSaSm1uZhksJkZyj7JBJcrECpO35ooF8D0SEW1o4IMR61my1I+X/kpvBT6CcjMULJPg
         bqEs6aQUHS9dqGQnZdGZBgbn01c1Pj82SpXj/Pky6S03k6lyPGMNTsQsSL6orv7iQqzs
         V/vbVGlJGb5wOBD9rKbgohg/qURcrguKN/UyE7PiTkbWTvOA2bJMNWPvNQjipmL9dgxs
         J/Gw==
X-Gm-Message-State: AOAM533SatgabE8CUNZOhjCVPAkUng7B25utUUy99yom7eyjW52ZQfKJ
        UejsWnShMQg6f3vswQS/FZc/bw==
X-Google-Smtp-Source: ABdhPJztiED96RbyrcWQK8vcOXRAc9+CiqHZ1+aI910OqoBmXHaxGspoWkoWAgcdw9SB/Ar+5GhTjw==
X-Received: by 2002:a2e:5443:: with SMTP id y3mr346759ljd.482.1632927231242;
        Wed, 29 Sep 2021 07:53:51 -0700 (PDT)
Received: from localhost (h-46-59-88-219.A463.priv.bahnhof.se. [46.59.88.219])
        by smtp.gmail.com with ESMTPSA id a6sm14048lfr.142.2021.09.29.07.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 07:53:50 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:53:50 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Subject: Re: [PATCH v2] media: rcar-vin: add GREY format
Message-ID: <YVR9/iQIGp/T2ymx@oden.dyn.berto.se>
References: <YU2htCDCbedXi4ai@oden.dyn.berto.se>
 <20210924124315.26164-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210924124315.26164-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

Thanks for your work.

On 2021-09-24 15:43:17 +0300, Nikita Yushchenko wrote:
> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> 
> This adds support for MEDIA_BUS_FMT_Y8_1X8 input and V4L2_PIX_FMT_GREY
> output format.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> Changes from v1:
> - fix coding style issue
> 
>  drivers/media/platform/rcar-vin/rcar-dma.c  | 15 +++++++++++++++
>  drivers/media/platform/rcar-vin/rcar-v4l2.c |  4 ++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c b/drivers/media/platform/rcar-vin/rcar-dma.c
> index f5f722ab1d4e..4d0d95cf4c5f 100644
> --- a/drivers/media/platform/rcar-vin/rcar-dma.c
> +++ b/drivers/media/platform/rcar-vin/rcar-dma.c
> @@ -114,6 +114,7 @@
>  /* Video n Data Mode Register bits */
>  #define VNDMR_A8BIT(n)		(((n) & 0xff) << 24)
>  #define VNDMR_A8BIT_MASK	(0xff << 24)
> +#define VNDMR_YMODE_Y8		(1 << 12)
>  #define VNDMR_EXRGB		(1 << 8)
>  #define VNDMR_BPSM		(1 << 4)
>  #define VNDMR_ABIT		(1 << 2)
> @@ -603,6 +604,7 @@ void rvin_crop_scale_comp(struct rvin_dev *vin)
>  	case V4L2_PIX_FMT_SGBRG8:
>  	case V4L2_PIX_FMT_SGRBG8:
>  	case V4L2_PIX_FMT_SRGGB8:
> +	case V4L2_PIX_FMT_GREY:
>  		stride /= 2;
>  		break;
>  	default:
> @@ -695,6 +697,7 @@ static int rvin_setup(struct rvin_dev *vin)
>  	case MEDIA_BUS_FMT_SGBRG8_1X8:
>  	case MEDIA_BUS_FMT_SGRBG8_1X8:
>  	case MEDIA_BUS_FMT_SRGGB8_1X8:
> +	case MEDIA_BUS_FMT_Y8_1X8:
>  		vnmc |= VNMC_INF_RAW8;
>  		break;
>  	default:
> @@ -774,6 +777,14 @@ static int rvin_setup(struct rvin_dev *vin)
>  	case V4L2_PIX_FMT_SRGGB8:
>  		dmr = 0;
>  		break;
> +	case V4L2_PIX_FMT_GREY:
> +		if (input_is_yuv) {
> +			dmr = VNDMR_DTMD_YCSEP | VNDMR_YMODE_Y8;
> +			output_is_yuv = true;
> +		} else {
> +			dmr = 0;
> +		}
> +		break;
>  	default:
>  		vin_err(vin, "Invalid pixelformat (0x%x)\n",
>  			vin->format.pixelformat);
> @@ -1145,6 +1156,10 @@ static int rvin_mc_validate_format(struct rvin_dev *vin, struct v4l2_subdev *sd,
>  		if (vin->format.pixelformat != V4L2_PIX_FMT_SRGGB8)
>  			return -EPIPE;
>  		break;
> +	case MEDIA_BUS_FMT_Y8_1X8:
> +		if (vin->format.pixelformat != V4L2_PIX_FMT_GREY)
> +			return -EPIPE;
> +		break;
>  	default:
>  		return -EPIPE;
>  	}
> diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/platform/rcar-vin/rcar-v4l2.c
> index 0d141155f0e3..bdeff51bf768 100644
> --- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
> @@ -82,6 +82,10 @@ static const struct rvin_video_format rvin_formats[] = {
>  		.fourcc			= V4L2_PIX_FMT_SRGGB8,
>  		.bpp			= 1,
>  	},
> +	{
> +		.fourcc			= V4L2_PIX_FMT_GREY,
> +		.bpp			= 1,
> +	},
>  };
>  
>  const struct rvin_video_format *rvin_format_from_pixel(struct rvin_dev *vin,
> -- 
> 2.30.2
> 

-- 
Regards,
Niklas Söderlund
