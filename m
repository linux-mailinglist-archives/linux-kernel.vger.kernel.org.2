Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DA23D489A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 18:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhGXPrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 11:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGXPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 11:47:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468D7C061575;
        Sat, 24 Jul 2021 09:27:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m13so7307789lfg.13;
        Sat, 24 Jul 2021 09:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YcXc97W9m2IrtIW4+cq+6qN4IgUVhjsEqgUpGYMdKxs=;
        b=dTjp9M21yO3mgsreEIAn76JzWjG4QSw/q4JCB64VqIqnniezQhILHzVfkcE0KpVdo+
         Z8TT9/PDSVJ+/rwMEN5OFN2HYBE1J3daCjncpFbkNeyjQH4YZa4M7thUC4yV9CFqTIP/
         0O+agnBAQZwHfjGSK+eUfCcBwvKZh8PAA5gXCB+u2Zg0tbQXmEArfJGAnj7YwtAqW/ro
         /x427SQTojh5sesuFyDumOKRz0QU0hUu5t2+reLg411ZXHsQX0HxxyRXPEai+bgJd5Fy
         lliiO9xmKXLNpDXFfPacmjPYMZQj4hKtj6Vesnk5pK6TOxzAt58a8blQ+MhjDOc0ey8o
         wEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YcXc97W9m2IrtIW4+cq+6qN4IgUVhjsEqgUpGYMdKxs=;
        b=ascJ4bWENeV2xox6o6PDLmCfN/95A0Sa7+EPZxAZRhRUaC2GQ7FpBcGpeZa8bozY6p
         /BeF41zl3RYpaD55ywoeEOw1ZXI2pO75g6FHaxw9QRKYlZX0UH5Ge9RxQI4jzIj320pd
         siGgMReg3TT43DIh+uFGDoYHo5rpUHhkFFDmnobnlLu2pFkvWo4xwPoa73g/wcn/fq8N
         i4FATD+g3lAakEgJtKTK7gsKVDLnNrFuwm3olmT5s4m4+JgT40u0B4lZiFXP7ct/ZI08
         gBo+JV7VxNQhHT1LJmt2UO6o4r3cKO8CZmM6aeIayZ//6xny+17crjwHUGnm8AMW9Xub
         GG0w==
X-Gm-Message-State: AOAM530JMtKBAB8edjteTVEakQQAickaJubAkKszUBrP9C74kQEwVnci
        jbOG7rHoroMzqCqVvjMKbaeNcW9m87PdXw==
X-Google-Smtp-Source: ABdhPJwgYGlsSY++yZJOCKX9/pyuXKeLxgkzFMsfIyQxdhhBNVw/dFK8ngl+PU7BaKqkopYbi0n7ug==
X-Received: by 2002:a19:ef15:: with SMTP id n21mr3337017lfh.206.1627144064407;
        Sat, 24 Jul 2021 09:27:44 -0700 (PDT)
Received: from [192.168.1.4] ([194.79.5.201])
        by smtp.gmail.com with ESMTPSA id u13sm2341883lfq.142.2021.07.24.09.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 09:27:43 -0700 (PDT)
Subject: Re: [PATCH 3/3] drm/panel-simple: add Gopher 2b LCD panel
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210722140432.1426173-1-akawolf0@gmail.com>
 <20210722140432.1426173-4-akawolf0@gmail.com>
 <7TGNWQ.L2GCQQC1CJ603@crapouillou.net>
From:   Artjom Vejsel <akawolf0@gmail.com>
Message-ID: <27d31ea9-2a8d-803c-ef3c-e99fdf7192fa@gmail.com>
Date:   Sat, 24 Jul 2021 19:27:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7TGNWQ.L2GCQQC1CJ603@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, thanks, Paul. I've sent V2.

On 22/07/2021 17.12, Paul Cercueil wrote:
> Hi Artjom,
>
> Le jeu., juil. 22 2021 at 17:04:32 +0300, Artjom Vejsel 
> <akawolf0@gmail.com> a écrit :
>> The Gopher 2b LCD panel is used in Gopher 2b handhelds.
>> It's simple panel with NewVision NV3047 driver,
>> but SPI lines are not connected.
>> It has no specific name, since it's unique to that handhelds.
>> lot name at AliExpress: 4.3 inch 40PIN TFT LCD Screen COG
>> NV3047 Drive IC 480(RGB)*272 No Touch 24Bit RGB Interface
>>
>> Signed-off-by: Artjom Vejsel <akawolf0@gmail.com>
>> ---
>>  drivers/gpu/drm/panel/panel-simple.c | 44 ++++++++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-simple.c 
>> b/drivers/gpu/drm/panel/panel-simple.c
>> index 9b286bd4444f..9cce6b63a147 100644
>> --- a/drivers/gpu/drm/panel/panel-simple.c
>> +++ b/drivers/gpu/drm/panel/panel-simple.c
>> @@ -4306,6 +4306,47 @@ static const struct panel_desc 
>> yes_optoelectronics_ytc700tlag_05_201c = {
>>      .connector_type = DRM_MODE_CONNECTOR_LVDS,
>>  };
>>
>> +static const struct drm_display_mode 
>> qishenglong_gopher2b_lcd_panel_modes[] = {
>> +    { /* 60 Hz */
>> +        .clock = 10800,
>> +        .hdisplay = 480,
>> +        .hsync_start = 480 + 77,
>> +        .hsync_end = 480 + 77 + 41,
>> +        .htotal = 480 + 77 + 41 + 2,
>> +        .vdisplay = 272,
>> +        .vsync_start = 272 + 16,
>> +        .vsync_end = 272 + 16 + 10,
>> +        .vtotal = 272 + 16 + 10 + 2,
>> +        .flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
>> +    },
>> +    { /* 50 Hz */
>> +        .clock = 10800,
>> +        .hdisplay = 480,
>> +        .hsync_start = 480 + 17,
>> +        .hsync_end = 480 + 17 + 41,
>> +        .htotal = 480 + 17 + 41 + 2,
>> +        .vdisplay = 272,
>> +        .vsync_start = 272 + 116,
>> +        .vsync_end = 272 + 116 + 10,
>> +        .vtotal = 272 + 116 + 10 + 2,
>> +        .flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
>> +    },
>> +};
>> +
>> +static const struct panel_desc qishenglong_gopher2b_lcd_panel = {
>> +    .modes = qishenglong_gopher2b_lcd_panel_modes,
>> +    .num_modes = ARRAY_SIZE(qishenglong_gopher2b_lcd_panel_modes),
>> +    .num_modes = 1,
>
> Thank you for your patch. From a quick look though, you have 
> .num_modes listed twice here. I believe the second line should be 
> removed.
>
> Cheers,
> -Paul
>
>> +    .bpc = 8,
>> +    .size = {
>> +        .width = 95,
>> +        .height = 54,
>> +    },
>> +    .bus_format = MEDIA_BUS_FMT_RGB888_1X24,
>> +    .bus_flags = DRM_BUS_FLAG_DE_HIGH | 
>> DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
>> +    .connector_type = DRM_MODE_CONNECTOR_DPI,
>> +};
>> +
>>  static const struct drm_display_mode arm_rtsm_mode[] = {
>>      {
>>          .clock = 65000,
>> @@ -4753,6 +4794,9 @@ static const struct of_device_id 
>> platform_of_match[] = {
>>      }, {
>>          .compatible = "yes-optoelectronics,ytc700tlag-05-201c",
>>          .data = &yes_optoelectronics_ytc700tlag_05_201c,
>> +    }, {
>> +        .compatible = "qishenglong,gopher2b-lcd-panel",
>> +        .data = &qishenglong_gopher2b_lcd_panel,
>>      }, {
>>          /* Must be the last entry */
>>          .compatible = "panel-dpi",
>> -- 
>> 2.32.0
>
>
