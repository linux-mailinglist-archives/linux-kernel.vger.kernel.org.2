Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5533307311
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhA1Jpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 04:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhA1JnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:43:00 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660F1C061574;
        Thu, 28 Jan 2021 01:42:19 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id l9so6787970ejx.3;
        Thu, 28 Jan 2021 01:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VS2BXLiTQG5Ywx+8YI/6vIBJgTmi0BPOFN3mLacxjo4=;
        b=rlxtghjBfMv4sBljBAWBUtNHU7Amys8VPM6WUQ97fwHB6t2TC77Dzg71iFL+GpzU0v
         mNXzfIZRMQv+lYOPDgWb1DBPIeGc0M6wNql9PRFg9ptBFb72lx+7T2BXDREJhgee7iwL
         j/ZyszTs9ktqcwXXxCJ5rnQ5iGTXtmpCTc/7RubSPyHLZaPVuQXMUAqMCe6Q7Z1KK3nC
         +a9lmbGrrgOjw76O9rPePmHpW59cNJ9rG75PiVQXoFQL2JOV176Xpo405L1DVYgMvjoB
         wI80jK1WReqzS+ilePNs5t6MiE+P9/WkzamG9pa6I7tbx/pfONBOZBApQCPxuMqza233
         pvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VS2BXLiTQG5Ywx+8YI/6vIBJgTmi0BPOFN3mLacxjo4=;
        b=fgPFED/VmgSVriiccufxD9CpnHPo6Yp++CbZoyYKSCy+nye+XJv7t5wkdtGKc5b3wR
         gq27IvEyhZSaqOfAocixe/f++cILhsISsBkWcbgKA6u1mo5MsdVubuxIEFxSlh/aJzWC
         miJkMM3MCco50+mw5xUytGW4S8XNRVjrGfO1U/pJz+lraQM0Gj3DgLRebF7cJbi2onEd
         vY2cjp7yKs5Oa5ZAqk0yhp792Snt6a8Vk6sGIE8appxMazZduuI8rvwqUiP+Xkgu2dnq
         cJZTSXI1+5pbnaoCFvFUcKlAYtym2O0mH8sT1w6XZsZ/sWJQ6hLdP4R3EB25sqCGSCgg
         YeCg==
X-Gm-Message-State: AOAM532rRihYxaaHfHe1B3kLz27h2AHCTm7QonkM964nF3GXvNEQM5yR
        UMQI9+5dkCjsDz5oihJrqeg=
X-Google-Smtp-Source: ABdhPJwwQr9fpLfw/ULp0RvD+T6rOzO4W88QBT5qcyDraLNmTY0zXsKsqA/nLyzQSi69y6wF0zp7HQ==
X-Received: by 2002:a17:907:7255:: with SMTP id ds21mr10178552ejc.258.1611826937030;
        Thu, 28 Jan 2021 01:42:17 -0800 (PST)
Received: from [192.168.74.106] (178-169-161-196.razgrad.ddns.bulsat.com. [178.169.161.196])
        by smtp.gmail.com with ESMTPSA id cx6sm2810192edb.53.2021.01.28.01.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 01:42:16 -0800 (PST)
Subject: Re: [PATCH 2/2] drm/panel: simple: add samsung,s6e3fa2 panel
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Samuel Pascua <pascua.samuel.14@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20201230151711.3619846-1-iskren.chernev@gmail.com>
 <20201230151711.3619846-2-iskren.chernev@gmail.com>
Message-ID: <e8701e3c-b0b2-559c-e808-1e6983b85b00@gmail.com>
Date:   Thu, 28 Jan 2021 11:42:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20201230151711.3619846-2-iskren.chernev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/30/20 5:17 PM, Iskren Chernev wrote:
> From: Samuel Pascua <pascua.samuel.14@gmail.com>
> 
> This panel is used on the Samsung Galaxy S5 (klte).
> 
> Signed-off-by: Samuel Pascua <pascua.samuel.14@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 30 ++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 41bbec72b2dad..5f16826f3ae06 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -4611,6 +4611,33 @@ static const struct panel_desc_dsi osd101t2045_53ts = {
>  	.lanes = 4,
>  };
> 
> +static const struct drm_display_mode s6e3fa2_mode = {
> +	.clock = 149769,
> +	.hdisplay = 1080,
> +	.hsync_start = 1080 + 162,
> +	.hsync_end = 1080 + 162 + 10,
> +	.htotal = 1080 + 162 + 10 + 36,
> +	.vdisplay = 1920,
> +	.vsync_start = 1920 + 13,
> +	.vsync_end = 1920 + 13 + 2,
> +	.vtotal = 1920 + 13 + 2 + 3,
> +};
> +
> +static const struct panel_desc_dsi samsung_s6e3fa2 = {
> +	.desc = {
> +		.modes = &s6e3fa2_mode,
> +		.num_modes = 1,
> +		.bpc = 8,
> +		.size = {
> +			.width = 65,
> +			.height = 115,
> +		},
> +	},
> +	.flags = MIPI_DSI_MODE_VIDEO_BURST,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.lanes = 4,
> +};
> +
>  static const struct of_device_id dsi_of_match[] = {
>  	{
>  		.compatible = "auo,b080uan01",
> @@ -4633,6 +4660,9 @@ static const struct of_device_id dsi_of_match[] = {
>  	}, {
>  		.compatible = "osddisplays,osd101t2045-53ts",
>  		.data = &osd101t2045_53ts
> +	}, {
> +		.compatible = "samsung,s6e3fa2",
> +		.data = &samsung_s6e3fa2

I just want to share some details to avoid issues in the future.

This setup (with simple panel and bindings), works in the sense that the
display shows stuff, after being left on by the bootloader on the Samsung
Galaxy S5 (klte). There is no provisions for turning the screen off and
back on, backlight, or anything else.

The display is a rather advanced one, containing many features, but so far
none of them (including on/off) has been made to work. It is possible that
in the future some of those features will be figured out, and these might
very well include additional DT properties.

So would it be better to put the bindings in a separate file, ready to
grow, and for the panel - include a simple custom driver that works no
better than the simple-panel one now, but can accommodate future expansion?

>  	}, {
>  		/* sentinel */
>  	}
> --
> 2.29.2
> 
