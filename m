Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD0A34EC1D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhC3PXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhC3PWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:22:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852D6C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:22:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k8so16632355wrc.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w8V0w5GOQQHkISfgPJAfMdvO2kYy36iSMSCiKff1Avk=;
        b=UK1+56tkUkxiWzmRwystR96Cb2t9qheGXbUSyiN2dgeqKl5Hgl/wcbw7IfsGiBDN6a
         U/X2/vZNS1xLCZtaBdzuywfO6MS3gcIdI+NqD3jPhHlkc0ShXx/R6Bk3+Qi2tEZHXmMi
         pIyaaTYprHhpUG6PDxBTyGZn3RqSMEQ/uO5PCV2dgPMsToSNOiihQcQ33t25LjhK9gR9
         9CuqqUi6ddoINX/lxm6jpVa2CMUxoZkYKrh9zqh/fSd1qY/caYxdU/O/rg6p92bW5xe7
         quVMO5sraS/foEHHqu7cly5FmtbhWhQOA+XhrXcoxcE5laGESrX6+LDendnLlZ7twgLY
         pAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=w8V0w5GOQQHkISfgPJAfMdvO2kYy36iSMSCiKff1Avk=;
        b=l66zRIlQ9o2ZhEDgYY2JxKy3Ql6AOM8ehxWDuoca92HrsUPoMRnDDJomcLbQvmDAFw
         Qr3/t9O7kIE0gfPcb7kPFQo7V5vf3imkA6DG6GbB9I+f/jl+cm1ihSzcOjKQX+wtUXaN
         g0r/HgSbtFi+uitrTFpnReiu8snwESICMS37ALk1MR+JmE4EGjkTAgQsipOYSaMZjX6d
         WzZhEeUDDP9knyPQ3HHZGQ5WGukA5VFTAeSpo4aPI45e3aSZURBA/2uJ/4pYvpG/4Q91
         bbv3aUb9sILfvkbnnGSTux2ae7M7cRIcAaQzPWojHPrbNT2oMjbraXQtsezfQWUzeoWY
         7Iwg==
X-Gm-Message-State: AOAM531O0/CPqqOAama13WnCC1Ptu7yVpTYHJTQQ0uHYQAlMk/7+b7h2
        RQA0sOm9jmQTC7Q+T0nn3AvpUICL0zZ9Iokt
X-Google-Smtp-Source: ABdhPJxESZmSpSlE6klTTQAJEKlYJe9e6WfAFm2Og41KDME4F0sRQvY34G+x1BpznTP2tl29sfIHsg==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr34201127wrw.277.1617117772629;
        Tue, 30 Mar 2021 08:22:52 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:2d11:7929:c1dd:292? ([2a01:e0a:90c:e290:2d11:7929:c1dd:292])
        by smtp.gmail.com with ESMTPSA id r206sm4463718wma.46.2021.03.30.08.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 08:22:52 -0700 (PDT)
Subject: Re: [PATCH 1/3] arm64: dts: meson: remove extra tab from ODROID
 N2/N2+ ext_mdio node
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210329161256.31171-1-christianshewitt@gmail.com>
 <20210329161256.31171-2-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <257db59f-fca6-ece4-f8c9-a2f4e1d95c49@baylibre.com>
Date:   Tue, 30 Mar 2021 17:22:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210329161256.31171-2-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2021 18:12, Christian Hewitt wrote:
> Remove an extra tab from the ext_mdio node in the ODROID N2/N2+ common
> dtsi file.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> index 58ce569b2ace..2f8d574c30c0 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> @@ -410,7 +410,7 @@
>  
>  &ext_mdio {
>  	external_phy: ethernet-phy@0 {
> -		/* Realtek RTL8211F (0x001cc916) */	
> +		/* Realtek RTL8211F (0x001cc916) */
>  		reg = <0>;
>  		max-speed = <1000>;
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
