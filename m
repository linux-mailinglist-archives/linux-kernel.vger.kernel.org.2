Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2507C44CA7C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 21:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhKJUXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 15:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhKJUXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 15:23:37 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ADBC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 12:20:49 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d24so6139704wra.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 12:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k8N5zck2lZ73SkM2NQ11BK2t2B+PlRhdbOumhV63HC0=;
        b=qKFvJ0mRzS4onF9aP8HHoue6h98f/odyPmuXAAZhMkapdkqBL9h0Md4lh/FGwrkXuV
         n8JHRLvMxTIzM5QN+SlzNAWr1ocp1bZgTo9qcotLoxaEO1e2supJ1irdbW8JRM/RyYeu
         QUpOpI/0pKHwGvbkzQZ7+6qeNyuaORPzTewNfiip6lxqo255Kvtut7I83qebCkbl8RMX
         MmnWKkIC+cz0IwYa9JHGs1hV9qOwDLs1RD/KWhzq9IG5kYa82gBPRQmMgnc2LWeE6u64
         AcpkSzfIcm3ETlDl/08zG2wcwPqJ+kK/uVFXkWe1XkW30fUQrPlAz0CqjareIg3cNCTs
         4TNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k8N5zck2lZ73SkM2NQ11BK2t2B+PlRhdbOumhV63HC0=;
        b=RwxVIfZSZcH9WUfMZjZzBwelCyjqHl2PErQ7Q8unPpPigNXUcy5ei05Ud9/aBJbeuR
         Fpv4BC+jhsoegLLsXQzO57B9SSqpaC6F/SAP7VCOjTNzhBb65t5mVnHpFsMm9fQasaXT
         fLXzih8Ara8h43kasMmhoLsM04L/yCrjUD01e29b6T1D+a51k5Gfc2aYZ/UR3Mi5Cyoz
         r45KEn5zD9eYto4qvC0lgmWEljvoTWmqAWXN9R9R0FpPApi/OARbdeZYFksfu6ecAAvK
         F31DEpMuFGFe/kM7IEz8DyfDayKopFrXelukYfklsdZ0W5LM9YJVSbQRXYULdAQIfOXz
         QFOg==
X-Gm-Message-State: AOAM532h9CAm3Sy3b1B1hHK6iIriP947xxPsi6UAZubTdtesZhEB9UXF
        OxOQe/sQhiSvt66z1VaadkI=
X-Google-Smtp-Source: ABdhPJzftTRU6i59iGtVuByIAKaTeVB7dAcPFzpVU6OM08HJx1k+5MKpS/V+oIDwsKi1KY00XkkYhw==
X-Received: by 2002:a5d:5244:: with SMTP id k4mr2220805wrc.77.1636575647926;
        Wed, 10 Nov 2021 12:20:47 -0800 (PST)
Received: from kista.localnet (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id x13sm931574wrr.47.2021.11.10.12.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:20:47 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Alex Bee <knaerzche@gmail.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Alex Bee <knaerzche@gmail.com>
Subject: Re: [PATCH] drm: bridge: dw-hdmi: Fix RGB to YUV color space conversion
Date:   Wed, 10 Nov 2021 21:20:46 +0100
Message-ID: <12887538.uLZWGnKmhe@kista>
In-Reply-To: <20211106130044.63483-1-knaerzche@gmail.com>
References: <20211106130044.63483-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Dne sobota, 06. november 2021 ob 14:00:44 CET je Alex Bee napisal(a):
> As per CEA-861 quantization range is always limited in case of YUV
> output - indepentently which CEA mode it is or if it is an DMT mode.
> 
> This is already correctly setup in HDMI AVI inforame, but we always do
> a RGB to YUV conversion which doesn't consider that RGB input can be
> full range as well.
> That leads to incorrect colors for all CEA modes except mode 1 for HDMI
> and always for DVI.
> 
> To fix this, provide additional csc coefficents for converting from RGB
> full range to EITU601/EITU709 limited range and rename the existing
> arrays to clarify their meaning.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 24 +++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/
bridge/synopsys/dw-hdmi.c
> index 62ae63565d3a..1cba08b70091 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -80,13 +80,25 @@ static const u16 csc_coeff_rgb_out_eitu709[3][4] = {
>  	{ 0x2000, 0x0000, 0x3b61, 0x7e25 }
>  };
>  
> -static const u16 csc_coeff_rgb_in_eitu601[3][4] = {
> +static const u16 csc_coeff_rgb_full_in_eitu601[3][4] = {

I would rather move "full" and "limited" to the end, since RGB always has full 
range and we want YUV to have full or limited range.

Just one observation - no other matrix sets bit 15 in any coefficient, but yours 
do. I can't see anywhere documented if bit 15 is ignored or not. Can you try 
with it set to 0? If it still works, I would set it to 0 for consistency.

Best regards,
Jernej

> +	{ 0x2044, 0x106f, 0x0644, 0x0040 },
> +	{ 0xe677, 0x1c1c, 0xfd46, 0x0200 },
> +	{ 0xed60, 0xf685, 0x1c1c, 0x0200 }
> +};
> +
> +static const u16 csc_coeff_rgb_limited_in_eitu601[3][4] = {
>  	{ 0x2591, 0x1322, 0x074b, 0x0000 },
>  	{ 0x6535, 0x2000, 0x7acc, 0x0200 },
>  	{ 0x6acd, 0x7534, 0x2000, 0x0200 }
>  };
>  
> -static const u16 csc_coeff_rgb_in_eitu709[3][4] = {
> +static const u16 csc_coeff_rgb_full_in_eitu709[3][4] = {
> +	{ 0x2750, 0x0baf, 0x03f8, 0x0040 },
> +	{ 0xe677, 0x1c1c, 0xfd6d, 0x0200 },
> +	{ 0xea55, 0xf98f, 0x1c1c, 0x0200 }
> +};
> +
> +static const u16 csc_coeff_rgb_limted_in_eitu709[3][4] = {
>  	{ 0x2dc5, 0x0d9b, 0x049e, 0x0000 },
>  	{ 0x62f0, 0x2000, 0x7d11, 0x0200 },
>  	{ 0x6756, 0x78ab, 0x2000, 0x0200 }
> @@ -1023,9 +1035,13 @@ static void dw_hdmi_update_csc_coeffs(struct dw_hdmi 
*hdmi)
>  			csc_coeff = &csc_coeff_rgb_out_eitu709;
>  	} else if (is_input_rgb && !is_output_rgb) {
>  		if (hdmi->hdmi_data.enc_out_encoding == 
V4L2_YCBCR_ENC_601)
> -			csc_coeff = &csc_coeff_rgb_in_eitu601;
> +			csc_coeff = hdmi->hdmi_data.rgb_limited_range
> +				? &csc_coeff_rgb_limited_in_eitu601
> +				: &csc_coeff_rgb_full_in_eitu601;
>  		else
> -			csc_coeff = &csc_coeff_rgb_in_eitu709;
> +			csc_coeff = hdmi->hdmi_data.rgb_limited_range
> +				? &csc_coeff_rgb_limted_in_eitu709
> +				: &csc_coeff_rgb_full_in_eitu709;
>  		csc_scale = 0;
>  	} else if (is_input_rgb && is_output_rgb &&
>  		   hdmi->hdmi_data.rgb_limited_range) {
> 
> base-commit: 89636a06fa2ee7826a19c39c19a9bc99ab9340a9
> -- 
> 2.30.2
> 
> 


