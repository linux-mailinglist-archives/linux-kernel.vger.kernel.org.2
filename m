Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A983FEEB2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345217AbhIBNcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345213AbhIBNcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:32:15 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6456EC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 06:31:16 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso1369104wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4gxi9Kqsy6vY5Br0x3Qy9vxSPyyM/MBtQ+2co26fvBU=;
        b=u07MnjYoJd4ToW6TOOtZFuPbDUsGKC4+4IPtShXatLOI3i5McO2C+LlhGVohAgrIUb
         sBlD8DOLsfn5/OZFiFvhoGWfdatEdpgKJUhpzGb6Hq24UMq1BgPVs46LRZ8bCPnJIkG8
         3RS7211MWbG2LoMDnSt5PZwTcsz1TNPfVlRfVUvnBfZ6WJDIDKEn+YlKI9N4KzL9/BBr
         Fua7rGtjPAbuMnzITzI/ycqeFNC78t7tr8JPqoVuGqKdaYdBtAMDJeQtVZyeDfi902uz
         qEq/grvgQlXaFS5+dbQwMc8vutwe3b5FFhmjx9g7iYd3WuweNM7q3wrmhfIh/0EHByB5
         ZQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4gxi9Kqsy6vY5Br0x3Qy9vxSPyyM/MBtQ+2co26fvBU=;
        b=eR3+nnP8+UqH4bwW0CMOgESMKfZvOcKz1Uf1z+ge1O+fqsaWWeyvT4ruXeLmenGHP1
         sDiOdmgu4Q3TIDk3w2W7AFhiePKzF99pyVtFPpx6lrZQPc+jLFt/r2I173p1z+1d3so6
         67VVQIkChTBO28LSfy2hp+cdu+DHkWkLCcXUmBYPGSqd87EwfpfraTPipF0ClwvlsZl3
         rVYsfr0oi89k8IxBLcTUHkCuR49kOqWybEqKZ/9a/mWwf5fb0KiHc8WWGoeUsUH8AZ3T
         L7rwIlBYhN1ocnxo/sfNPnu3IPDcSrf2tbx9WythJlmExMEsie2ZQI9O4UWAwB2C93rl
         6XDg==
X-Gm-Message-State: AOAM532j3XfNQkjAA13EouTm+/3D3iH7B2kfmCyq0tGpYE28XnH95qCM
        8gzkpKz6U3snXy/r41hTrRAtmg==
X-Google-Smtp-Source: ABdhPJyVTIrOykcHm9Tz+zCbl+Dt+2flbbXghMcfXjE9o2eBFlm7cHCvOunhVb9EF0jaSVbGs0i5UA==
X-Received: by 2002:a7b:ce87:: with SMTP id q7mr3244799wmj.126.1630589474811;
        Thu, 02 Sep 2021 06:31:14 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:98:6312:3c8:6531? ([2001:861:44c0:66c0:98:6312:3c8:6531])
        by smtp.gmail.com with ESMTPSA id u23sm1660340wmc.24.2021.09.02.06.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 06:31:14 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson: sm1-khadas-vim3l use one sound node
 configuration with VIM3
To:     jbrunet@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com, art@khadas.com, nick@khadas.com,
        gouwa@khadas.com, Artem Lapkin <email2tema@gmail.com>
References: <20210812051059.1103641-1-art@khadas.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <247c746b-621c-5db0-25c0-1ef0d0a0d77e@baylibre.com>
Date:   Thu, 2 Sep 2021 15:31:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210812051059.1103641-1-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/08/2021 07:10, Artem Lapkin wrote:
> Khadas VIM3L board sound configuration same as Khadas VIM3, its already
> defined in meson-khadas-vim3.dtsi and no need overwrite it with different
> card names and routing configurations.
> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  .../boot/dts/amlogic/meson-sm1-khadas-vim3l.dts     | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> index f2c098143..06de0b1ce 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> @@ -32,19 +32,6 @@ vddcpu: regulator-vddcpu {
>  		regulator-boot-on;
>  		regulator-always-on;
>  	};
> -
> -	sound {
> -		model = "G12B-KHADAS-VIM3L";
> -		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
> -				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
> -				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
> -				"TDM_A Playback", "TDMOUT_A OUT",
> -				"TDMIN_A IN 0", "TDM_A Capture",
> -				"TDMIN_A IN 13", "TDM_A Loopback",
> -				"TODDR_A IN 0", "TDMIN_A OUT",
> -				"TODDR_B IN 0", "TDMIN_A OUT",
> -				"TODDR_C IN 0", "TDMIN_A OUT";
> -	};
>  };
>  
>  &cpu0 {
> 

Jerome could you quickly review this ?

Thanks,
Neil
