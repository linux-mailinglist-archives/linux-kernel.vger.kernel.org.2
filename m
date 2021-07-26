Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11813D54B2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 09:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhGZHQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhGZHQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:16:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4DFC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 00:56:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q3so9999204wrx.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 00:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zeZqtxONqWWF1em7aYmF1Pe2r2Sx+MqyCamwwBYmG9Y=;
        b=mgtCpoRn4tE+jdrGVM133ESQwkInrmHEMxbAv0NgNy7z8nv2s6PXOb85P9bzlSd+TQ
         QnLFOPCU6RLq5cIkaN6dkAzIiDoCP2xckOGiR0qc9JDbmCZRORjBmsGw6Il8uOcNzbj9
         Htof2lkK57WMPLV7uUrr3pIjVBMUgxunp9uz/yNZo1zZZCrMMI+aQz6WnmuMSCVRplpV
         44QznKcMlI6ABe+nxwIVfFwgwDq3fN138Yz80LcseSR/YhYp8U8L2UcrtN0qALmd0QZy
         yBIsIDwR0kGFKfVhNBG7hhFqfBIw1cIEEUFJqIOx7phDp5pLB/u2acD+ibeZJ77R6M67
         CdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zeZqtxONqWWF1em7aYmF1Pe2r2Sx+MqyCamwwBYmG9Y=;
        b=AUvJ58UYUdkLl6BuZok92AthKVCUoEn1auCUiIkV75I5j5KkoDyR1M999527KBdXfa
         UE2rDhSfQ8oFVEI54pU4qViY8LqQcF1209IZfcp1L1JTsuVnbmdLPrGqFog/V0F6kjmK
         UlrqM+gMacVBkE2IvgaRd8PNOLbUoYbyWBRoti/413u1DSBFdqXbpwE/vrjzffMfs7Hr
         dBkj+7EGJRPzbDfZpO3OtWdOktYQV80pbw0UB6tIIxHfe3H5VEZVtdOWk80s14oj62cg
         zM2D11kqy9IqkJEgD1QRMBw9+Ebzectguh3PUWZt6TSc7/nR/fkPZbSU/r8koVwY1bwh
         BVAg==
X-Gm-Message-State: AOAM533aKUKTJReGsJAYWDZ/bqpem+dhg0Fve4qeG6TCTRMk34u3wk4Z
        MHPKJVpiG/40MhSDst+bEaonGQ==
X-Google-Smtp-Source: ABdhPJx4vPKU8tB4VmIQwzUhtb0brJd08GmTFGNU9uStJmtuVXkrueiibPYwiraRrfkl8+llS4x7PA==
X-Received: by 2002:a5d:5987:: with SMTP id n7mr17876210wri.263.1627286211271;
        Mon, 26 Jul 2021 00:56:51 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:32b6:aa71:d2df:4f1d? ([2001:861:44c0:66c0:32b6:aa71:d2df:4f1d])
        by smtp.gmail.com with ESMTPSA id 11sm12714511wmo.10.2021.07.26.00.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 00:56:50 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: meson8: Use a higher default GPU clock
 frequency
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Demetris Ierokipides <ierokipides.dem@gmail.com>
References: <20210711214023.2163565-1-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <a51c083e-52cc-f7d6-239a-1da3ed8ab3e1@baylibre.com>
Date:   Mon, 26 Jul 2021 09:56:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210711214023.2163565-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2021 23:40, Martin Blumenstingl wrote:
> We are seeing "imprecise external abort (0x1406)" errors during boot
> (which then cause the whole board to hang) on Meson8 (but not Meson8m2).
> These are observed while trying to access the GPU's registers when the
> MALI clock is running at it's default setting of 24MHz. The 3.10 vendor
> kernel uses 318.75MHz as "default" GPU frequency. Using that makes the
> "imprecise external aborts" go away.
> Add the assigned-clocks and assigned-clock-rates properties to also bump
> the MALI clock to 318.75MHz before accessing any of it's registers.
> 
> Fixes: 7d3f6b536e72c9 ("ARM: dts: meson8: add the Mali-450 MP6 GPU")
> Reported-by: Demetris Ierokipides <ierokipides.dem@gmail.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/arm/boot/dts/meson8.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
> index 157a950a55d3..686c7b7c79d5 100644
> --- a/arch/arm/boot/dts/meson8.dtsi
> +++ b/arch/arm/boot/dts/meson8.dtsi
> @@ -304,8 +304,13 @@ mali: gpu@c0000 {
>  					  "pp2", "ppmmu2", "pp4", "ppmmu4",
>  					  "pp5", "ppmmu5", "pp6", "ppmmu6";
>  			resets = <&reset RESET_MALI>;
> +
>  			clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_MALI>;
>  			clock-names = "bus", "core";
> +
> +			assigned-clocks = <&clkc CLKID_MALI>;
> +			assigned-clock-rates = <318750000>;
> +
>  			operating-points-v2 = <&gpu_opp_table>;
>  			#cooling-cells = <2>; /* min followed by max */
>  		};
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
