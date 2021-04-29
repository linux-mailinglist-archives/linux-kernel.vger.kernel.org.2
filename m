Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFEC36E7A3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhD2JLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhD2JK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:10:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72279C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:10:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h4so57009438wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jjn7ofrdjd1TnkYur2KtlSXqsC+58JHrPfTq02YwB5M=;
        b=su4cjFGi5+kn1HkDFEXCytoV9WXF2o51AZFXnN7J60XFatV7b0G480EAPDFoa0ljdx
         GTni/HiMLYx7p2q1HaVPXlCusW4oCh55p7p12ftlg5UYiGVDQT18qAtTvXMZ2GUzgpCD
         mTZOJK0F5SVWygJYXiaqq08TEGzcFpfDtDKsHj3dv8GqxV/wCT0dc6GpxXzSGKR+DvI0
         cXL3KNBzoMgVlOs7VcNqJF7xtBsxT2biXRH0fE10HAl3P0CPiAJuJbOjmAO9cTWJQOFZ
         gK70joRmwtU5UKgtSJ9QHPJ6HVi3rdTU3iL0kFGzt20ocp2nZtTA1GfOAVRcfO9GDcBF
         b+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jjn7ofrdjd1TnkYur2KtlSXqsC+58JHrPfTq02YwB5M=;
        b=i99h8sgOhUntNjRCE2IQRlq1G0/DMuoVqjRndrMK7A38pHnWXTp4aNnD+BxP0mHagT
         qvH+ndeo+8jdVZ5JlvtRRj8JpcxNt9lVr1Lt7nmvG2Bz/GHtreow82+rvvb9vgsNaTFB
         BK/aXzdNUMvxwyb5uemzus8+uKP6JdEEcYMEp7n7k6NvZ9/aLJyIzk0CPv9nUlbGrLQC
         yvSpN6/CbaJmNRWj76wk+vJ6osDvsow8kiHH/ibLycJBZU8tVxxoANv/9LpvRMBqyE2u
         FLA3xv0iftIpwjXx8zTp6Md+yrqS3/0GmFPbI3LnafbQPXNffZR6yevgDolsF3coVXM7
         fjRA==
X-Gm-Message-State: AOAM532G/FC8f1UgtdCV4ixrzDVo6PUXwJUZHgAVrRRXQ99YEdaEeVD4
        Lt7pANeNnjn12uPVPzlDTNhUGQ==
X-Google-Smtp-Source: ABdhPJxxe5ErG/v5x7LmLALpFiu8uZN2sGOtEQkXtdLvfxipLv3O+0/hat2t8+GWnA/F4dBqzzS54A==
X-Received: by 2002:a5d:568f:: with SMTP id f15mr42616599wrv.346.1619687402526;
        Thu, 29 Apr 2021 02:10:02 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:c304:4b2b:4a79:1da9? ([2a01:e0a:90c:e290:c304:4b2b:4a79:1da9])
        by smtp.gmail.com with ESMTPSA id a15sm4582835wrx.9.2021.04.29.02.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 02:10:01 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson: vim3: enable hdmi audio loopback
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20210429084253.59692-1-jbrunet@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <3f85bc7a-aebc-cac6-11f9-5e18528c5e7f@baylibre.com>
Date:   Thu, 29 Apr 2021 11:10:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210429084253.59692-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2021 10:42, Jerome Brunet wrote:
> Enable audio capture frontends and a tdm decoder.
> This makes it possible to loopback the audio played on the hdmi codec,
> which is the only output interface at the moment.
> 
> Of course, one TODDR device would be enough to do that but since
> the 3 FRDDRs are enabled on the playback side, let's do the same on the
> capture side.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 41 +++++++++++++++++--
>  .../dts/amlogic/meson-sm1-khadas-vim3l.dts    | 13 ++++++
>  2 files changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> index 66d67524b031..3cf4ecb6d52e 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> @@ -171,11 +171,16 @@ hdmi_connector_in: endpoint {
>  	sound {
>  		compatible = "amlogic,axg-sound-card";
>  		model = "KHADAS-VIM3";
> -		audio-aux-devs = <&tdmout_a>;
> +		audio-aux-devs = <&tdmin_a>, <&tdmout_a>;
>  		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
>  				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
>  				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
> -				"TDM_A Playback", "TDMOUT_A OUT";
> +				"TDM_A Playback", "TDMOUT_A OUT",
> +				"TDMIN_A IN 0", "TDM_A Capture",
> +				"TDMIN_A IN 3", "TDM_A Loopback",
> +				"TODDR_A IN 0", "TDMIN_A OUT",
> +				"TODDR_B IN 0", "TDMIN_A OUT",
> +				"TODDR_C IN 0", "TDMIN_A OUT";
>  
>  		assigned-clocks = <&clkc CLKID_MPLL2>,
>  				  <&clkc CLKID_MPLL0>,
> @@ -198,8 +203,20 @@ dai-link-2 {
>  			sound-dai = <&frddr_c>;
>  		};
>  
> -		/* 8ch hdmi interface */
>  		dai-link-3 {
> +			sound-dai = <&toddr_a>;
> +		};
> +
> +		dai-link-4 {
> +			sound-dai = <&toddr_b>;
> +		};
> +
> +		dai-link-5 {
> +			sound-dai = <&toddr_c>;
> +		};
> +
> +		/* 8ch hdmi interface */
> +		dai-link-6 {
>  			sound-dai = <&tdmif_a>;
>  			dai-format = "i2s";
>  			dai-tdm-slot-tx-mask-0 = <1 1>;
> @@ -214,7 +231,7 @@ codec {
>  		};
>  
>  		/* hdmi glue */
> -		dai-link-4 {
> +		dai-link-7 {
>  			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
>  
>  			codec {
> @@ -454,10 +471,26 @@ &tdmif_a {
>  	status = "okay";
>  };
>  
> +&tdmin_a {
> +	status = "okay";
> +};
> +
>  &tdmout_a {
>  	status = "okay";
>  };
>  
> +&toddr_a {
> +	status = "okay";
> +};
> +
> +&toddr_b {
> +	status = "okay";
> +};
> +
> +&toddr_c {
> +	status = "okay";
> +};
> +
>  &tohdmitx {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> index 06de0b1ce726..f2c098143594 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> @@ -32,6 +32,19 @@ vddcpu: regulator-vddcpu {
>  		regulator-boot-on;
>  		regulator-always-on;
>  	};
> +
> +	sound {
> +		model = "G12B-KHADAS-VIM3L";
> +		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
> +				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
> +				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
> +				"TDM_A Playback", "TDMOUT_A OUT",
> +				"TDMIN_A IN 0", "TDM_A Capture",
> +				"TDMIN_A IN 13", "TDM_A Loopback",
> +				"TODDR_A IN 0", "TDMIN_A OUT",
> +				"TODDR_B IN 0", "TDMIN_A OUT",
> +				"TODDR_C IN 0", "TDMIN_A OUT";
> +	};
>  };
>  
>  &cpu0 {
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

