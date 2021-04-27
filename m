Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA0D36C7A3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbhD0OTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbhD0OTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:19:15 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C02DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 07:18:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 26-20020a05600c22dab029013efd7879b8so5346318wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 07:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=165yj5PkdwmVik5VeyWeaT6sFuK6E9xbEbgXNsgUc+4=;
        b=MpGLSY3sBoEXBf9vni3QXebi/HlCEjyvl/3T1NAr9wrrEtnqp2eLbVuAtT7TPb/l6+
         SvIuSVer3YMVAtobnyfM1cPYRbuVxh6GQ3UOQ7KiIWuWTOA0MCOs0yM9Gbzjtg85hqHY
         loL6/qzCn7aKddRcCJ4b3iauO2QyeJgFeU41jpH3r6KgNGRXCVxBq4QOpC+5ILc8tdw+
         V+sLgidc3dBUrBQ9RkegXbJ5tvT37jqsnhQ2ek1pJ/KAAfDy/v2z4KIYtynUxJhYCbng
         N/Yd1sJUMSzfNLVyU52qCWQJFx1XB6jwEWUyElDG9lZxWmr4FBj1FvF1vZPK4GKhQdvO
         KMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=165yj5PkdwmVik5VeyWeaT6sFuK6E9xbEbgXNsgUc+4=;
        b=GShtRlFPRs7LzEn+EZ08UUL8DDdQu1Jz/aXoV7dH4cPDSf74HWIr9c4hrsymRL07Te
         +i65xPHPadclZWYyza+aQSV3Y9W59V6/RWKgtdmwo89wBCOwOoYtZt7RGrYaRYyWcpAt
         qXoP+21WIiMpEWx18KsfsaTUA/sJdTlrmil4Gh5lpKwTBevBEisEISgzgahM2ouzrpDM
         9icip4Pt2ugOGAaGwpf/aI/U1YWfMW+xdLz2ssO1NnNvzgpRmR4tU9vAhGS5r/gF2nIL
         WLMWuWxTrxH10oIGhEWur0CHRHjNg5Ib0bwsFE0X9rC0mjZe8y8b5QIcB+C1wO7rSbSE
         AE2g==
X-Gm-Message-State: AOAM530kGgAQbvyLZlUUTk//usGGMHDAgOikGd1PEyLtz9P7qCmwRRtL
        E03sne8rBvnnJfSN2BiZQFsvlw==
X-Google-Smtp-Source: ABdhPJw2Eu9SuVUUFa4vKzSfI0cO927HfuqA0NePw24pctc6Whx6Wu2Bgryqm1sUeD2Ua3ObsQVy9Q==
X-Received: by 2002:a1c:254:: with SMTP id 81mr4552291wmc.125.1619533110304;
        Tue, 27 Apr 2021 07:18:30 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:2338:91ec:bf8:872b? ([2a01:e0a:90c:e290:2338:91ec:bf8:872b])
        by smtp.gmail.com with ESMTPSA id o82sm15350wmo.36.2021.04.27.07.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 07:18:29 -0700 (PDT)
Subject: Re: [PATCH] drm: bridge: add missing word in Analogix help text
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Torsten Duwe <duwe@suse.de>, Maxime Ripard <maxime@cerno.tech>
References: <20210424061817.7339-1-rdunlap@infradead.org>
 <ecbe576f-1a96-a873-3716-6fa478a8269e@baylibre.com>
 <CAG3jFyv1kc3+B6SkVwdV7gNV+HUEWMAjmH8GSXaw8rDcHLadeQ@mail.gmail.com>
 <481c3f44-1686-2c58-29fa-c71fec520ba7@baylibre.com>
Organization: Baylibre
Message-ID: <ee194435-3e17-f5c4-d300-a74cc0f8988c@baylibre.com>
Date:   Tue, 27 Apr 2021 16:18:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <481c3f44-1686-2c58-29fa-c71fec520ba7@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2021 10:59, Neil Armstrong wrote:
> On 26/04/2021 09:42, Robert Foss wrote:
>>
>>
>> On Mon, Apr 26, 2021, 09:15 Neil Armstrong <narmstrong@baylibre.com <mailto:narmstrong@baylibre.com>> wrote:
>>
>>
>>
>>     Le 24/04/2021 à 08:18, Randy Dunlap a écrit :
>>     > Insert a missing word "power" in Kconfig help text.
>>     >
>>     > Fixes: 6aa192698089 ("drm/bridge: Add Analogix anx6345 support")
>>     > Signed-off-by: Randy Dunlap <rdunlap@infradead.org <mailto:rdunlap@infradead.org>>
>>     > Cc: Andrzej Hajda <a.hajda@samsung.com <mailto:a.hajda@samsung.com>>
>>     > Cc: Neil Armstrong <narmstrong@baylibre.com <mailto:narmstrong@baylibre.com>>
>>     > Cc: Robert Foss <robert.foss@linaro.org <mailto:robert.foss@linaro.org>>
>>     > Cc: David Airlie <airlied@linux.ie <mailto:airlied@linux.ie>>
>>     > Cc: Daniel Vetter <daniel@ffwll.ch <mailto:daniel@ffwll.ch>>
>>     > Cc: dri-devel@lists.freedesktop.org <mailto:dri-devel@lists.freedesktop.org>
>>     > Cc: Icenowy Zheng <icenowy@aosc.io <mailto:icenowy@aosc.io>>
>>     > Cc: Vasily Khoruzhick <anarsoul@gmail.com <mailto:anarsoul@gmail.com>>
>>     > Cc: Torsten Duwe <duwe@suse.de <mailto:duwe@suse.de>>
>>     > Cc: Maxime Ripard <maxime@cerno.tech>
>>     > ---
>>     >  drivers/gpu/drm/bridge/analogix/Kconfig |    2 +-
>>     >  1 file changed, 1 insertion(+), 1 deletion(-)
>>     >
>>     > --- linux-next-20210423.orig/drivers/gpu/drm/bridge/analogix/Kconfig
>>     > +++ linux-next-20210423/drivers/gpu/drm/bridge/analogix/Kconfig
>>     > @@ -6,7 +6,7 @@ config DRM_ANALOGIX_ANX6345
>>     >       select DRM_KMS_HELPER
>>     >       select REGMAP_I2C
>>     >       help
>>     > -       ANX6345 is an ultra-low Full-HD DisplayPort/eDP
>>     > +       ANX6345 is an ultra-low power Full-HD DisplayPort/eDP
>>     >         transmitter designed for portable devices. The
>>     >         ANX6345 transforms the LVTTL RGB output of an
>>     >         application processor to eDP or DisplayPort.
>>     >
>>
>>     Reviewed-by: Neil Armstrong <narmstrongt@baylibre.com <mailto:narmstrongt@baylibre.com>>
>>
>>
>> I think a typo in the email snuck in ;)
>>
> 
> Ah ah indeed !
> 
> Reviewed-by: Neil Armstrong <narmstrongt@baylibre.com>
> 
Wow, twice the same error... Monday was a bead day for me

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
