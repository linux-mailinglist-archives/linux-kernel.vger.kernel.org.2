Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082AD3D4C7B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 08:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhGYGPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 02:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGYGPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 02:15:06 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE97C061760
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 23:55:37 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so6608522oth.7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 23:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BGn+EjMqq99Bj04hcp2WO+QUSqyG5NK9Xv1j68OtcH0=;
        b=BcLvcUE6Fwt13XrkUHN/uz/j8woPZS1aYLDsNjLOmdnms6EFWkIR7tihdK7Cgu+W4f
         CtRNrqXqCFzAiJg/Hqw/gw/88rA9P3SZn8N+aa9UMAtwRO7XBB+lfQo19TTuEnIVm/HW
         ql28wyYFMjwuDLG3zxczw8JfDhu/B2hIQzKh7E4jxu4lr5GQBlLXaESVfCYGg65NDNdM
         FigSk0gsyw2IsCg8l6mMZd2DvGanx4Iwc+tBg3lzMXprgIUTJHWMR70btuO12b04QUFP
         mYdlaAcP9/TOZUy6e45RKfClfSv/qL7a94Dt37dx3Iq4k/o0BU3xLfpYOSUN0CmISJN7
         o46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BGn+EjMqq99Bj04hcp2WO+QUSqyG5NK9Xv1j68OtcH0=;
        b=e/HEgDNxDKegnLaD7Rmc0NTMwqj32TclOak6dXMGVkJx5CjeAsXcWn13Xw2a/i60K5
         jdtnDL7AuwjeazglSdYSjueu1K6dJJmNkiEn7N9+f/w/ADRtnsUmnXM9M6hVwNvaipYv
         hivkDWlbeEMRHr52ZH4ta7BUJUhJJwIOC+xYcnS4abhLBtHSYJictirpyttIKPSMGYgS
         QjOOugHpwngwXhTLXyZmthB6y1xpseXML2Z6e9aHRqMbhII+KNEBv/UWkiJbBVoJQsVq
         VH46J1U6sEsSw+Afpr2DkHBECuhSJGmlxCVKC0VVeW430bl+PylhN9nKUeshNAg9L94h
         Z+dQ==
X-Gm-Message-State: AOAM533DnoAdDu53/ILSS7PHoBTjyUL4Chnws2S39Pp3rJhDF4M+79cY
        yFl7aQ05lNTjFNkOtbVYOP70Kol+34uTwDrq
X-Google-Smtp-Source: ABdhPJynVQWZnbcHqSx6DNemrpNukJu/Vnj0fuSC7MDxJlHlvE364cXzRFvZwCEOS69yYR8t0McbnQ==
X-Received: by 2002:a9d:7f98:: with SMTP id t24mr8484242otp.366.1627196136433;
        Sat, 24 Jul 2021 23:55:36 -0700 (PDT)
Received: from MacBook-Pro.hackershack.net (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id r26sm4288163ooh.32.2021.07.24.23.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 23:55:35 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: qcom: sdm850-yoga: Enable IPA
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210615232816.835325-1-bjorn.andersson@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <fd2222e9-e3ba-b54d-43ac-e52a04ad82c5@kali.org>
Date:   Sun, 25 Jul 2021 01:55:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210615232816.835325-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/15/21 6:28 PM, Bjorn Andersson wrote:
> Shuffle memory regions to make firmware loading succeed and then enable
> the ipa device.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 21 +++++++------------
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  5 +++++
>  2 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 1796ae8372be..49624eadce84 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -128,28 +128,23 @@ camera_mem: memory@8bf00000 {
>  			no-map;
>  		};
>  
> -		ipa_fw_mem: memory@8c400000 {
> -			reg = <0 0x8c400000 0 0x10000>;
> +		wlan_msa_mem: memory@8c400000 {
> +			reg = <0 0x8c400000 0 0x100000>;
>  			no-map;
>  		};
>  
> -		ipa_gsi_mem: memory@8c410000 {
> -			reg = <0 0x8c410000 0 0x5000>;
> +		gpu_mem: memory@8c515000 {
> +			reg = <0 0x8c515000 0 0x2000>;
>  			no-map;
>  		};
>  
> -		gpu_mem: memory@8c415000 {
> -			reg = <0 0x8c415000 0 0x2000>;
> +		ipa_fw_mem: memory@8c517000 {
> +			reg = <0 0x8c517000 0 0x5a000>;
>  			no-map;
>  		};
>  
> -		adsp_mem: memory@8c500000 {
> -			reg = <0 0x8c500000 0 0x1a00000>;
> -			no-map;
> -		};
> -
> -		wlan_msa_mem: memory@8df00000 {
> -			reg = <0 0x8df00000 0 0x100000>;
> +		adsp_mem: memory@8c600000 {
> +			reg = <0 0x8c600000 0 0x1a00000>;
>  			no-map;
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index c2a709a384e9..3eaa42dc3794 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -415,6 +415,11 @@ ecsh: hid@5c {
>  	};
>  };
>  
> +&ipa {
> +	status = "okay";
> +	memory-region = <&ipa_fw_mem>;
> +};
> +
>  &mdss {
>  	status = "okay";
>  };


Hi,

Thank you for this!

Tested - one thing that end users/distro packagers may need to be aware
of, if the module is loaded in an initramfs, the firmware file also
needs to be loaded in the initramfs.  If the module is in an initramfs
and the firmware is not, the module will need to be removed and
re-inserted for the device to come up.

Tested-by: Steev Klimaszewski <steev@kali.org>

