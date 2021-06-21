Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCB43AF516
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhFUSbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhFUSbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:31:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F6AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 11:29:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f15so5308379wro.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 11:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0h7qTLw7iVbT8QbSsm0zBOuy3gLWBPfMMVwH84B0A6E=;
        b=caiwhYlEUQbVaBms76Ua1Mcy5TQCvcHwN38R360aXilH1yWBuoBB8JY8yyujL7w+hg
         VOImO6JkzqlIgksrbB3BQMozaFUGQt9EYsVrMPVnIRtlfx8aVEA/SwmskHMol70MZ76E
         oKCuZzxhLaJR8vlkVWhkQsFJC2gsxDNuBeGZsVDobXcjHtuqKJQrUsehVro3YvlgMo4H
         WlW9QIF3GPIyHpV4+IpxTRU/wUX0SCKEKGdahd9sEGndFurOZztjbZQIhcUW9b8HUJZq
         0+fdRjvNgsMi//qVrnjuhIiW11BZulbBkDiim3gaUL4TXoZzA1rU5PUMMtOzEzz7uHTP
         0fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0h7qTLw7iVbT8QbSsm0zBOuy3gLWBPfMMVwH84B0A6E=;
        b=pI6a5CCyvM2hWC+PdJxMFgo6akzC5GwBCTWQwt9sNJ1FYSvHYvJML6rkcivqjbShcQ
         P9O/BJVx2vc9FAn9wNq0q1EIoF0cUt2Vkd+hEMV0eFtAWI5gUdzuTfDGipOxr1sF4FgP
         d+XkFtM1g3VtZ06mPDIpcpbJyS2awi0T+Vaslvb/CcZj2YwtEzMvukAt4ErIyXVAF4vE
         LncIYIImebK2qS9R2Z+qoBqr7Xpn3en+j049fmjUdqlSRsf5c4OacmF5DkOprtIv+Kkh
         Tk5D8vWtcsh/m399zjbcMKcqHOUOXXjeH9yglFpzNpWKYe3TRk3H57LCY01m83ztayih
         3dFA==
X-Gm-Message-State: AOAM533WYngM9C2lIU1rX2BP+W5lcho2joCCl+idS5titjP3N/G8c9Zr
        p8OpYPNzROZCgk8uZ7PUHDz1rK5PKOEL1s9d
X-Google-Smtp-Source: ABdhPJwPxfVG4w0Lz2q4SXNxbZfRCeQ5g1BryLvFq3XRveWZT/82P4U5rh+6QPi4nV7uOkjbCWj7eA==
X-Received: by 2002:a05:6000:50d:: with SMTP id a13mr29289561wrf.130.1624300156936;
        Mon, 21 Jun 2021 11:29:16 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5ebd:8bd9:d549:4211? ([2a01:e34:ed2f:f020:5ebd:8bd9:d549:4211])
        by smtp.googlemail.com with ESMTPSA id k2sm18235911wrw.93.2021.06.21.11.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 11:29:16 -0700 (PDT)
Subject: Re: [PATCH] Fix mt7622.dtsi thermal cpu
To:     ericwouds@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210619121927.32699-1-ericwouds@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e30a2d01-a200-80cb-88d9-6aea62dd49f1@linaro.org>
Date:   Mon, 21 Jun 2021 20:29:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210619121927.32699-1-ericwouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2021 14:19, ericwouds@gmail.com wrote:
> From: Eric Woudstra <ericwouds@gmail.com>
> 
> Cpu-thermal is set to use all frequencies already at 47 degrees. 
> Using the CPU at 50 for a minute, the CPU has reached 48 degrees, is 
> throttled back to lowest setting, making the mt7622 terrribly slow. 
> Even at this low speed, the CPU does not cool down lower then 47 so
> the CPU is stuck at lowest possible frequency until it shut down and
> stays off for 15 minutes.
> 
> cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>                  <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> 
> This should not be set al every cooling map. It should only be set at
> the highest cooling map. Same as in the example:
> 
> https://www.kernel.org/doc/Documentation/devicetree/bindings/
> thermal/thermal.txt  line 272
> 
> But then without the fan and added a third map.
> 
> Now temperature will be regulated at 87 degrees celcius. At temperatures
> lower then 87, all frequencies can be used.

47°C is really a too low temperature and this performance drop is normal.

I would not remove the passive mitigation but try by increasing the CPU
temp to 70°C and by changing the active trip point to 80°C. If it works
fine, try 75°C and 85°C.

To test, the thermal killer is dhrystone (one thread per cpu).

With a 75°C passive trip point, the step wise thermal governor, I think
the mitigation will happen smoothly providing better performances, and
probably the fan won't fire.

> Also see the post:
> 
> http://forum.banana-pi.org/t/bpi-r64-only-10-cpu-speed-at-already-48-
> degrees-celcius-speed-not-increasing-anymore/12262
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 890a942ec..b779c7aa6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -170,14 +170,14 @@ cpu-crit {
>  			cooling-maps {
>  				map0 {
>  					trip = <&cpu_passive>;
> -					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					cooling-device = <&cpu0 0 0>,
> +							 <&cpu1 0 0>;
>  				};
>  
>  				map1 {
>  					trip = <&cpu_active>;
> -					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					cooling-device = <&cpu0 0 0>,
> +							 <&cpu1 0 0>;
>  				};
>  
>  				map2 {
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
