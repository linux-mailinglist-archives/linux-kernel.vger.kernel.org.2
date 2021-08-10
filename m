Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9D83E54A5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbhHJHzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbhHJHzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:55:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C993C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:55:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k38-20020a05600c1ca6b029025af5e0f38bso1253394wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UEIC6vC085t9n2FyShdhmhsgyOLA36QxIjvXMeHquq0=;
        b=lQU3LBLFbHdd5zE7+32px5brS1X6XEO+rld3svvmZwIwOoZ/oDQ6uS3P3af4N96XPH
         k8a+6YuTwt7GTkC1MSXsrdCXaWMKoqjluzwxzTQg8qM91yRHDI97/oHYT442BOE/Oifs
         e/jD24flWz+Z/qCLmG+l+sDss2NlCnhk6E0OZtlILOABpvkHoJRlSvBn8nYesS/SOTJ9
         hus3gH8Wb7ReHaFf+Q43/51vrR2ywjowggaNnnlLLKo/csNoTAUKA+fJkxwpraylqe6N
         6G6rfw55XQ41XJ9xN8WY99g3cNuS+xkfadqo02c7/BtbmukYFyP1YLyi/bm/0I+odB+w
         smtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UEIC6vC085t9n2FyShdhmhsgyOLA36QxIjvXMeHquq0=;
        b=Dddi7WtpWgcsRzkG6EjiQDpyzIQAb5FlR3VjRaC4+Buz415B+GlGxGI/6opePFvsKC
         k8ATdG1iHvA2WZkhgseRkwkfz3h0howxNrFNTpOUDgoA3veJwec6aq6ARDWkJVtn90tV
         yTYWMuG9uxe1ZnFC++bf6uppMkkx3cRyo5yWFZTaTw2YP+pKttdTcqJ5svsvsGp85Miy
         lTqeap8WMbCXjqaZIy1jsfIixY6PRxNpxr/vCRxZ8Kt6GHS9HVSBKvNsXzaZsNRxX4jU
         nWgJ1+PPju7qGZZiL0B2TEJMMDApqjv4ZoaWBoKIy4jOpNY+NcNoKvyXHcGqerqCyts2
         s0RA==
X-Gm-Message-State: AOAM530JeweGq6/LkYtSRSPMU9w79aFVezIr5HC9w/SDmi9qDIsxmDyK
        p2wwtTeyqeO9KiZJGHjH0vnlpYiTm/2FeX+C
X-Google-Smtp-Source: ABdhPJxshFcI3Wz1ZgfsUyujpG2l2zEiOyoWmR2VYFq6qGOGebeVxmBsvqD41bot25hKF3x60nKJfg==
X-Received: by 2002:a05:600c:a49:: with SMTP id c9mr2237873wmq.159.1628582120078;
        Tue, 10 Aug 2021 00:55:20 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:b710:2b6e:27aa:f0a0? ([2001:861:44c0:66c0:b710:2b6e:27aa:f0a0])
        by smtp.gmail.com with ESMTPSA id u5sm5233357wrr.94.2021.08.10.00.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 00:55:19 -0700 (PDT)
Subject: Re: [PATCH 1/2] arm64: dts: meson: add spdif out to khadas-vim
To:     Artem Lapkin <email2tema@gmail.com>
Cc:     jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com, art@khadas.com, nick@khadas.com,
        gouwa@khadas.com
References: <20210810041630.3673406-1-art@khadas.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <7dbba936-e8ab-4d47-1af8-0d3d1adb8c30@baylibre.com>
Date:   Tue, 10 Aug 2021 09:55:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810041630.3673406-1-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/08/2021 06:16, Artem Lapkin wrote:
> Add spdif output audio support to khadas-vim
> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts  | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> index 60feac0179c0..01f13822a616 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> @@ -64,6 +64,13 @@ hdmi_connector_in: endpoint {
>  		};
>  	};
>  
> +	spdif_dit: audio-codec-0 {
> +		#sound-dai-cells = <0>;
> +		compatible = "linux,spdif-dit";
> +		status = "okay";
> +		sound-name-prefix = "DIT";
> +	};
> +
>  	sound {
>  		compatible = "amlogic,gx-sound-card";
>  		model = "KHADAS-VIM";
> @@ -97,11 +104,21 @@ codec-0 {
>  				sound-dai = <&hdmi_tx>;
>  			};
>  		};
> +
> +		dai-link-3 {
> +			sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
> +
> +			codec-0 {
> +				sound-dai = <&spdif_dit>;
> +			};
> +		};
>  	};
>  };
>  
>  &aiu {
>  	status = "okay";
> +	pinctrl-0 = <&spdif_out_h_pins>;
> +	pinctrl-names = "default";
>  };
>  
>  &cec_AO {
> 

AFAIK the board doesn't have a physical SPDIF output, but one of the 40pin header can output SPDIF, right ?

In this case, following the other boards mainline definitions, we do not enable any function by default
for pins on the 40pin (or other programmable) headers.

There is still ongoing discussions on how to handle that on a more generic level, but you should write a bunch
of DT overlays for the VIM boards to enable optional functions like SPDIF and store then in a public git
tree for everybody to use (like armbian or LibreELEC for example) from the U-Boot stage.

Neil
