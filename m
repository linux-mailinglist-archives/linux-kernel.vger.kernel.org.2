Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01EB456DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbhKSKi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhKSKiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:38:11 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB31C061574;
        Fri, 19 Nov 2021 02:35:10 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p18so8014609wmq.5;
        Fri, 19 Nov 2021 02:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4K1D4DrJON9XEGXO4DJYRPRWAPvMfd+3qa5AuLyQzSg=;
        b=U0/3OwJVjRpy0Bytju6lhiz7QW7kaIET1ObODqDPjajxPRr66/d60fmWnTJFEAZQF0
         PgQ4VpvECIy3O+931vZV3g5NUnnqCISih3klv5IzHA8y0CAbC1+hlITYvLD8hPdu9W0W
         zzMWfXQtoaZW1cJ6uN3a5/YQJZ+r6i+Q898xdoOjMpREnqhNz5O788MIdWMRRoLrq3o9
         nuK2vxq1R0mybeWOdBrOPRc0pcN361q8XlaqzrT04tqmtNbDX5Y165ma8Ab7N/PdNDAk
         5B2bOHtwJVZYRbajSMHkWEul8MDKemY6xwM62L/ZMJG6/Vcq9J0rKFwSwVkhotQ5avMK
         3iyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4K1D4DrJON9XEGXO4DJYRPRWAPvMfd+3qa5AuLyQzSg=;
        b=v6oW786XEDY1x9rn4Gnksn9lMtpUSDQFYf/Ubn+C8t/bgA7i3aialUFirBGk0LGgnq
         xCyFazHNNPdeY9gYnSN2vXQgg0zl/wze78mvhk++A9UX9eZZsj58TtHKaoMHvukEm6V3
         zJUd7iL9X/vAXzngrka536iAzHZCAfC0Q/YqrpfZTHNprYq0s7hSvjK1/bW31ifiZfdd
         JDF/FWD8Q9/WCY26kzWa1qjmlDfAdj+Z4ZInxUPXU5Od7wdZLeKU0MHnpUt7xxtxyV8q
         FBAQOThX1pM3l6k0cZC7JLMgPBYq2Ot/+bqjJxg3GhuoqQY/vennvFPnDxzDTqH27km/
         euwA==
X-Gm-Message-State: AOAM532Z845ZVf+RLaczbTfyzEIbuupAdczs8/zFy57cxM+KrhTUuXF4
        rX2e9I7BTEjALiF4rIFEdVI=
X-Google-Smtp-Source: ABdhPJzWWYFH9JS52iFHdZJ9xlqlQCpCY1hzofwkw862hENzMEfpGecC4lXM26OsahpOKBHAUeKHLw==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr5472780wml.135.1637318108493;
        Fri, 19 Nov 2021 02:35:08 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id l18sm2551048wrt.81.2021.11.19.02.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 02:35:08 -0800 (PST)
Message-ID: <e17a2927-3b81-6db8-6d8f-7147d673e977@gmail.com>
Date:   Fri, 19 Nov 2021 11:35:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt8173-elm: Move pwm pinctrl to
 pwm0 node
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20211102144224.457446-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211102144224.457446-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/11/2021 15:42, AngeloGioacchino Del Regno wrote:
> The PWM pinctrl belongs to the PWM0 node, as it's strictly pwm related.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

both patches applied to v5.16-next/dts64

thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index e666ebb28980..f292ca459a9a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -27,8 +27,6 @@ backlight: backlight {
>   		power-supply = <&bl_fixed_reg>;
>   		enable-gpios = <&pio 95 GPIO_ACTIVE_HIGH>;
>   
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&disp_pwm0_pins>;
>   		status = "okay";
>   	};
>   
> @@ -901,6 +899,8 @@ pins1 {
>   };
>   
>   &pwm0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&disp_pwm0_pins>;
>   	status = "okay";
>   };
>   
> 
