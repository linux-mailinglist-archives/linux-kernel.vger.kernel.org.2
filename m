Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887FB3D7CED
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhG0R6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhG0R6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:58:13 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BDEC061764
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 10:58:12 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d9so10110150qty.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Kan4+YnSozUKYSOzN1kXIwYz3ZCh3y1E4Psib2w63Lk=;
        b=dxjiNXtfa791KgJy492dtW5Yg+vqzj4P5yngF5BB4zQOPRSiwdcFbI5UOsCyCLRuIg
         axt5wjcWCO/B+H88QYoPpuWL22vQza1m5bM0B5I/iVZq055bNZiYe7U+spCa3G9V3suK
         SuPTR+MPnbhxyum5/vpCTSd913ye4e+ZLdNfYc4/gWqkTd5r2TZaLR9iEATXF4SriOxN
         14R8KUQtybsyrIX/QZK8z258Ahw+mSg9a1AGVYy9tkSRU5jp5BcizNgy3cBwkjyBgCDX
         Kr2NtNByW3so+3PHk9dNiKYT3PORB0YgSzn7GRBLK4Ngj7Vs7Q+0S73L7VeYaP425EGM
         hFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Kan4+YnSozUKYSOzN1kXIwYz3ZCh3y1E4Psib2w63Lk=;
        b=PnjKCtGcnm/NSBpZCZuKDV9Y1nr1kq9FG0pZ9kI+7zWWzCtyV2OjcU8jFE78p01rxf
         g1XjJXFIhA+zGeV55ahivQU8HAz9RFYZkGf8a1P/PPM/mWr9z8Lx8Hk62mBYF1T4/C3q
         dvFJo8w/XHNjpCFUSZ9IL3A6v35JPO+XsvVBjGJrImCQ3y/R/E8SD03eYpw9cYC8QNR0
         WuVgOsbLIRk5sjeWUMm456OA9bIZ/KSCJBBQsrCAsx75PL1nodGBOCopSigVeJSvDSD9
         ueWVPaBAYk5//L1xqAx2w3BDhIdtzjOjXCfYk6KLLIlVnOrZu0v5x7Y/XQyobjW3q3Dl
         OE0w==
X-Gm-Message-State: AOAM533gI1INtxz8tdLGESULXAdYLfpDT2l/FJRpu3NO87vmaNwARtYp
        F0l9svpZPl9NMsTkcWJYVAixPw==
X-Google-Smtp-Source: ABdhPJxEOmDrWCWNsNEQWDAbJx8GvO36GrBFYkXY7t4A1kKHVX/CYQ4HHOHj5zuqHvmwQ1JdqqqXvw==
X-Received: by 2002:ac8:689a:: with SMTP id m26mr19888977qtq.155.1627408691535;
        Tue, 27 Jul 2021 10:58:11 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id f24sm1666814qtq.82.2021.07.27.10.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 10:58:11 -0700 (PDT)
Message-ID: <e88f70b1438d4e5b5313aacccb1f369cabe513bc.camel@ndufresne.ca>
Subject: Re: [PATCH v5 02/14] media:Add nt8 and nt10 video format.
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Tue, 27 Jul 2021 13:58:09 -0400
In-Reply-To: <ee482c18fdaae121e3c9495d07b0f3eb1661e36e.1627353315.git.ming.qian@nxp.com>
References: <cover.1627353315.git.ming.qian@nxp.com>
         <ee482c18fdaae121e3c9495d07b0f3eb1661e36e.1627353315.git.ming.qian@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 27 juillet 2021 à 11:20 +0800, Ming Qian a écrit :
> NT8 is 8-bit tiled nv12 format used by amphion decoder.
> NT10 is 10-bit tiled format used by amphion decoder.
> The tile size is 8x128
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
> Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
> ---
>  .../userspace-api/media/v4l/pixfmt-reserved.rst   | 15 +++++++++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c              |  2 ++
>  include/uapi/linux/videodev2.h                    |  2 ++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> index c9231e18859b..2deae49210a7 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> @@ -256,3 +256,18 @@ please make a proposal on the linux-media mailing list.
>  	of tiles, resulting in 32-aligned resolutions for the luminance plane
>  	and 16-aligned resolutions for the chrominance plane (with 2x2
>  	subsampling).
> +    * .. _V4L2-PIX-FMT-NT8:
> +
> +      - ``V4L2_PIX_FMT_NT8``
> +      - 'NA12'
> +      - Two-planar NV12-based format used by the video engine found on Amphion decoder,
> +    with 8x128 tiles for the luminance plane and chrominance plane.
> +    The number of bytes in one luminance or chrominance row must be divisible by 256.
> +    * .. _V4L2-PIX-FMT-NT10:

There is a large spread of "vendor specific" format that aren't really specific,
or complex enough to be worth being marked as vendor format. As per my reading
of this description, this is linearly layout 8x128 tiled format, with no
compression or anything (well unless you forgot to mention). As a side effect,
we should give that format an explicit name (NT8 is cryptic). What about
V4L2_PIX_FMT_NV12_8L128, my colleague is about to send a proposal in that
direction. That would be NV12 with plane tiled 8x128 bytes and layout linearly,
row by row, left to right. We already have cryptic formats like SUNXI, HM12 that
are literally just that, simple tiling, and we endup having to use obscure
vendor name whenever other HW uses the same.

(this comment extends to the other formats here)

> +
> +      - ``V4L2_PIX_FMT_NT10``
> +      - 'NT12'
> +      - NT10 is a tiled YUV format with 10-bits per pixel with interleaved UV.
> +    It's used by the video engine found on Amphion decoder,
> +    with 8x128 tiles for the luminance plane and chrominance plane.
> +    The number of bytes in one luminance or chrominance row must be divisible by 256.
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index eeff398fbdcc..34e6415e5722 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1402,6 +1402,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_META_FMT_UVC:		descr = "UVC Payload Header Metadata"; break;
>  	case V4L2_META_FMT_D4XX:	descr = "Intel D4xx UVC Metadata"; break;
>  	case V4L2_META_FMT_VIVID:       descr = "Vivid Metadata"; break;
> +	case V4L2_PIX_FMT_NT8:		descr = "Amphion Tiled 8x128 NV12"; break;
> +	case V4L2_PIX_FMT_NT10:		descr = "Amphion Tiled 8x128 10-bit"; break;
>  
>  	default:
>  		/* Compressed formats */
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 534eaa4d39bc..4836590a690c 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -740,6 +740,8 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Intel Planar Greyscale 10-bit and Depth 16-bit */
>  #define V4L2_PIX_FMT_SUNXI_TILED_NV12 v4l2_fourcc('S', 'T', '1', '2') /* Sunxi Tiled NV12 Format */
>  #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel 4-bit packed depth confidence information */
> +#define V4L2_PIX_FMT_NT8      v4l2_fourcc('N', 'A', '1', '2') /* Amphion Tiled 8x128 NV12 Format */
> +#define V4L2_PIX_FMT_NT10     v4l2_fourcc('N', 'T', '1', '2') /* Amphion Tiled 8x128 10 bit Format */
>  
>  /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
>  #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */


