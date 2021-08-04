Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DB53E04CF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbhHDPuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbhHDPuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:50:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CD4C0613D5;
        Wed,  4 Aug 2021 08:49:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c9so2772218wri.8;
        Wed, 04 Aug 2021 08:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2dt+JCnDhzMuvuUcJendmagePQt2OmpjWjxGl2h2eSw=;
        b=c+4bics3U0UyT9sOlYaoXB+Pv3we0STUZJ96Sao884tADmnBNmKO9LVGYn8MvoQa04
         w3Af502+mK5R9QgrJbTZmFhBVrmlv7GITRIxJ/xzzblwCuni+XHcgAiQ3jGS4F0rhFSQ
         SQh4pgib2aqu2ffw3UJ1iTpJT51FXzFwvUFC59vmBg2aG25kSwJa7y0yz0NSkqyp8t8m
         dVoKBkS4IC8zBFlg+dDITrkS4tkk8ALo+5ve/nuWBBkjlaFGXAfp5kcCfUwGOYYLOjN6
         28ZoVYpWWf6i1ptdJFug79mufViICWN/2d0MlkTu6ZWf4H860KxaYgoc0BGzS1+VoH9m
         KaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2dt+JCnDhzMuvuUcJendmagePQt2OmpjWjxGl2h2eSw=;
        b=ibGODSqOdY3Jd0qR94bOs/JsEZEAti53OOdtV8A/BiWIEoCPiKLebykGyj0Zz6T3we
         YSVV0EDvPliQaV5oaa1ad+ksNjzWI7qwAQ9DUYAXCmiVM9RUlzU5DWz7Wo+i4+AAUEVK
         N/ed3JnVbhucEpDjp2cwApUAXB9HlybYmLESTT6HAq5zY29YSwj0VizAhScxP6ISFo5Q
         KwXE3Lsu2EUvq5oo/q0lmUV3KIdhs507wLyDTAAIoKFE+ZQZKQnEr1kQohjrh7jIhSgX
         GbReIFCoUDHf4tN7s+0tKrDEk5DJ9YrL87T5deWY9NPFuHpPqZBbwxfbsyLebWWU+Hqn
         HveA==
X-Gm-Message-State: AOAM530KrHgmWZnD4Sg48kO/5dRg9MhIIxXdrLmquFWtRLNH3kiQM/OB
        lHBCH60WDkdYx//c5zh28NCnLeVz8a6LEQ==
X-Google-Smtp-Source: ABdhPJz2JH+ovTO5JfiQX9w31dumlvMTh5VUOzWQL1sCXN8YrmLj1q6dGX5Kfvt7/GyAAOB4oBrZMA==
X-Received: by 2002:a05:6000:18cc:: with SMTP id w12mr54693wrq.96.1628092184912;
        Wed, 04 Aug 2021 08:49:44 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id c15sm3117662wrw.93.2021.08.04.08.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 08:49:44 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: dts: mt8173: elm: Use aliases to mmc nodes
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        eizan@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210726102442.2119877-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <7feeeae7-2d79-cd3f-18f2-ef0adfe3adeb@gmail.com>
Date:   Wed, 4 Aug 2021 17:49:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210726102442.2119877-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/07/2021 12:24, Hsin-Yi Wang wrote:
> Use aliases to mmc nodes so the partition name for eMMC and SD card will
> be consistent across boots.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

applied to v5.14-next/dts64

Thanks

> ---
> v1->v2: skip unused mmc2.
> ---
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index 21452c51a20a8..d5a2cad39c9c7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -10,6 +10,12 @@
>  #include "mt8173.dtsi"
>  
>  / {
> +	aliases {
> +		mmc0 = &mmc0;
> +		mmc1 = &mmc1;
> +		mmc2 = &mmc3;
> +	};
> +
>  	memory@40000000 {
>  		device_type = "memory";
>  		reg = <0 0x40000000 0 0x80000000>;
> 
