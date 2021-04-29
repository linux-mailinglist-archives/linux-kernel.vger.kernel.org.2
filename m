Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9863736E7AA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhD2JMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbhD2JMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:12:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F09C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:11:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x5so15794738wrv.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O+eVdTRCfCuqwWZ1A1ERDlsGqazfT8HhsrE+QM1WXMw=;
        b=SGRNGmZcelKkQMPndTgMCpvKt7Mi7S5M9k1PuMo5te3UagHs3j4vJZ6rBOW4JwoGu6
         eooXqCs8/8EXgVawS9B9jYxc8wZ7w/nppUC8CRqdEt+SBLJSOn1ab3K1FCzkK9WTUdnd
         NpImVrCvJ0w7IXtzNEZ3Ar+SUxQQEelE6PGSIDmhiVb9p3a/f8l5AmVJhfOeL+BKmujF
         iEfmQ3qNAeooDZl5OudcQH5CNBx90ysnin3c6acscLYCJ2H3MWjHEihxdbl9Z9E/iMw+
         I8tdmW5LycplqOxsOkKlJhhgxOP43G5h9rbVS9gvyhy+n7g1RX67gtiJJvnBGZ7YHaCP
         xRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=O+eVdTRCfCuqwWZ1A1ERDlsGqazfT8HhsrE+QM1WXMw=;
        b=lfhcouXkBTyyIlo55XKKUbJOHn6Zr76Y0ZaHDEOZ/nOCCIkW3ih1jWA7eTpYwBX0W/
         JLA7iUUhgGXmZnXUdHUH0kU7MUR+9xrIcWb0ZYiG3lE6qp5M3BewGaVhFz9QXcPVbdIq
         1iKtHJM9yRVbaFxNywMQae+8zF6nfZdiK4/sv8ESwGHhFUpsATTnY9kKCiHmL3AhabhZ
         74M2UzC+mDI5eIUR2i9YeVz7cK0gPal9Vnl3Yz9D7Yx5LzyGy9qyrFcDOol2681vNLuz
         qGlv1WmQV2e/MB6+jXY4auOfxB5v7LixCfhybrKqrvvU09N69iy0CJdAjEWO8zd6Tote
         vD0g==
X-Gm-Message-State: AOAM531h2oNm4rEf53d5s2gfC6ilNq4Pu93On/3UTH+AXrhEg1IOn7ni
        thIS83hdisA39mI2V1T/YYnEYQ==
X-Google-Smtp-Source: ABdhPJzPFcT3Hp+/PTaRjf3DjVp/UmR1/VZWw9gfXFGmCskwcG4X6iE03lY3aAvI/2Zzqj1SN2HTcA==
X-Received: by 2002:a5d:525c:: with SMTP id k28mr25681566wrc.158.1619687488930;
        Thu, 29 Apr 2021 02:11:28 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:c304:4b2b:4a79:1da9? ([2a01:e0a:90c:e290:c304:4b2b:4a79:1da9])
        by smtp.gmail.com with ESMTPSA id y14sm3678487wrs.64.2021.04.29.02.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 02:11:28 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson: vim2: enable highspeed on wifi sdio
To:     Art Nikpal <email2tema@gmail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20210429085413.60368-1-jbrunet@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <b5b797bb-852c-22ce-2b40-7f6dc0b37083@baylibre.com>
Date:   Thu, 29 Apr 2021 11:11:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210429085413.60368-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Art,

So you think you can test this patch to see if it breaks SDIO ?

Neil

On 29/04/2021 10:54, Jerome Brunet wrote:
> Enable highspeed mode for vim2 sdio. In theory, the vim2 SDIO bus is
> capable of handling SDR50 mode but this needs to thoroughly tested.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> index 18a4b7a6c5df..217f9d6d470e 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> @@ -307,6 +307,7 @@ &sd_emmc_a {
>  	#size-cells = <0>;
>  
>  	bus-width = <4>;
> +	cap-sd-highspeed;
>  	max-frequency = <60000000>;
>  
>  	non-removable;
> 

