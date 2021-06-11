Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E1C3A3C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 08:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhFKGqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 02:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKGqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 02:46:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9312C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 23:44:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c9so4785669wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 23:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V8J2kKIIJJlnoKpbtxKXrz0z3Hf0aPtOx1h/2JVQKfc=;
        b=wIWadz0YAXxE4jt1Cq9N94gLHlr+IJo9KxploLqVh6GY+ZP26gDtPZLiJMyqz1aYeu
         wl514c/iCoj7/APxBwKqZEIMEkV/3hxogrleIZJ+ijA/eiTjDk+vG4gLBz4MbPmkrv2+
         IYiTxVQIpKZn0//ZXkX40wOIVLaNWF+PBBSgkHOh1iz07RuFf6KULqamJL80b7ngtS1G
         9XTDDzjWaTpU+wrBLbRmry/n3LhEjJNJrzmIMJh4LhNmneniPOyw9Rt5TpMnGjAl3j3q
         jwygHWV2EV49zidr/KUFYM+ciYBACURp2FgMXzy9Xx74wmLT5B2CtK2cnhKL3jA3qe9V
         DM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=V8J2kKIIJJlnoKpbtxKXrz0z3Hf0aPtOx1h/2JVQKfc=;
        b=mVn0zIpookAi+a8ov916oRCL8pfSsAbMT/V45HDSmkX32/CIbGxiNxpVJ8+hDxmVtP
         ZNTefcPjSXf7KHFhKgFX56EL/PSfdtkUNxx3tpl2b+6ShgAuLKbLO3WplFmp2rTmxuLp
         S7YJlK0LhrZGLawTJdhnB/vkDMgFfSzFXp8mhYaLpKe0zd/Qxi0RLaGYWJYYQHuRccp5
         2ycKZ3vj5tWh9FX7HMJQuvBBL4aYbUl8QIBbftUuurO8IpsDUx2Yki4yATu1bqqxlXkh
         UuBs5Kv6ZwBh6bpd5hQFK2WEnRmfKIO1Oaq7mhJ9Qm+N8UQye039UotXY6aDuQOTI2OU
         r9zQ==
X-Gm-Message-State: AOAM532YzluPA+a23W2K6Sk8N7qltuwia6NIiEqy5asiIr8dO01ewpQW
        8aKkCOS/VByDgsC5W0HLdZ8WmA==
X-Google-Smtp-Source: ABdhPJz1fQOM85JtTzpNkp/XZ79x6XkfY/t/ntDUPMR9DCwvEkAq9sNhdGEi57Jj+/zPb+vzYlgNyA==
X-Received: by 2002:a5d:6382:: with SMTP id p2mr2283590wru.338.1623393868296;
        Thu, 10 Jun 2021 23:44:28 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:bfd6:8f6:b84c:734f? ([2a01:e0a:90c:e290:bfd6:8f6:b84c:734f])
        by smtp.gmail.com with ESMTPSA id j131sm12193829wma.40.2021.06.10.23.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 23:44:27 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson: vim3: reduce cpu thermal fan trigger
 temperature
To:     xieqinick@gmail.com, robh+dt@kernel.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
References: <20210609012849.797576-1-xieqinick@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <11da3ae4-91d4-1e51-c652-e4ad518f13bd@baylibre.com>
Date:   Fri, 11 Jun 2021 08:44:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210609012849.797576-1-xieqinick@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 09/06/2021 03:28, xieqinick@gmail.com wrote:
> From: Nick Xie <nick@khadas.com>
> 
> Reduce the MCU FAN trigger temperature from
> 80 degree centigrade to 50 degree centigrade.

Can you add some more rationale to this change ?

> 
> Signed-off-by: Nick Xie <nick@khadas.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> index 66d67524b031..a9c34fee91f4 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> @@ -256,7 +256,7 @@ &cecb_AO {
>  &cpu_thermal {
>  	trips {
>  		cpu_active: cpu-active {
> -			temperature = <80000>; /* millicelsius */
> +			temperature = <50000>; /* millicelsius */
>  			hysteresis = <2000>; /* millicelsius */
>  			type = "active";
>  		};
> 

With that:
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
