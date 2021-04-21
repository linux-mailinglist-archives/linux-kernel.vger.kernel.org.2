Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE4367567
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 00:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbhDUW6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 18:58:18 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38771 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhDUW6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 18:58:18 -0400
Received: by mail-ot1-f49.google.com with SMTP id e89-20020a9d01e20000b0290294134181aeso14631778ote.5;
        Wed, 21 Apr 2021 15:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7gUtOOV9KcLOf0wlBAVa9uVjHIcSuYOVO49M1SrRIXU=;
        b=ZL1ABcn3gmho7DhVZoFDYIviddHrCe3rcjHXFpeoEF2LJfETBzMcvdPc+mQxgnv9ME
         XacaQAl8OHL2CmM+nDQIb2BxzBiaTYSkAYHW+ju012CZpG3UFM9tFCaZy3vx3DNlLfhZ
         Bh9ImNjcELLfrKlcO1KpbFqRrjInwR/Pvm8ObrauDkqYbZ58DM+V80U6jevw5i1pVHe0
         xK32QDp6IFDaFYDnIaju1XLJtTuKAjZJoSAuRTubz229Jp8lJt6DEbLVk4EK/LkiUU1g
         alfA545pS8iKmzGv9LYTq7ju2+fx3mbjgKiP9H69zxd+j+ojasSB2++RROyd6sVm7aeS
         6PPA==
X-Gm-Message-State: AOAM533TwaLlXyv0Dx6lzrYNbc3N2z4zaxjshZM0nVfPPjBQB0ak7gWV
        2kxUiGoHanYMbb7zvKnfKg==
X-Google-Smtp-Source: ABdhPJwzx7yNCetR6H1tZfEMFFVR4TklZtpIg9nFQeKreaeUFAVoF2RRu0yi1+aoWeqpKfQmikN4oA==
X-Received: by 2002:a9d:74d3:: with SMTP id a19mr389635otl.120.1619045862714;
        Wed, 21 Apr 2021 15:57:42 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n37sm226073otn.9.2021.04.21.15.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 15:57:42 -0700 (PDT)
Received: (nullmailer pid 1768471 invoked by uid 1000);
        Wed, 21 Apr 2021 22:57:40 -0000
Date:   Wed, 21 Apr 2021 17:57:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, krzk@kernel.org,
        shawnguo@kernel.org, daniel@0x0f.com, linux@rempel-privat.de,
        kuninori.morimoto.gx@renesas.com, Max.Merchel@tq-group.com,
        geert+renesas@glider.be, airlied@linux.ie, daniel@ffwll.ch,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/panel: Add support for E Ink VB3300-KCA
Message-ID: <20210421225740.GA1761342@robh.at.kernel.org>
References: <20210418210956.3024-1-alistair@alistair23.me>
 <20210418210956.3024-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210418210956.3024-2-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 07:09:56AM +1000, Alistair Francis wrote:
> Add support for the 10.3" E Ink panel described at:
> https://www.eink.com/product.html?type=productdetail&id=7
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 4e2dad314c79..f1f6fd2517f6 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1964,6 +1964,32 @@ static const struct panel_desc edt_etm0700g0bdh6 = {
>  	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
>  };
>  
> +static const struct display_timing eink_vb3300_kca_timing = {
> +	.pixelclock = { 40000000, 40000000, 40000000 },
> +	.hactive = { 334, 334, 334 },
> +	.hfront_porch = { 1, 1, 1 },
> +	.hback_porch = { 1, 1, 1 },
> +	.hsync_len = { 1, 1, 1 },
> +	.vactive = { 1405, 1405, 1405 },
> +	.vfront_porch = { 1, 1, 1 },
> +	.vback_porch = { 1, 1, 1 },
> +	.vsync_len = { 1, 1, 1 },
> +	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
> +		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE,
> +};
> +
> +static const struct panel_desc eink_vb3300_kca = {
> +	.modes = &edt_etm0700g0dh6_mode,
> +	.num_modes = 1,
> +	.bpc = 6,
> +	.size = {
> +		.width = 157,
> +		.height = 209,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
> +};
> +
>  static const struct display_timing evervision_vgg804821_timing = {
>  	.pixelclock = { 27600000, 33300000, 50000000 },
>  	.hactive = { 800, 800, 800 },
> @@ -4232,6 +4258,9 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "edt,etm0700g0dh6",
>  		.data = &edt_etm0700g0dh6,
> +	}, {
> +		.compatible = "eink,vb3300-kca",

You have to document this string too.
