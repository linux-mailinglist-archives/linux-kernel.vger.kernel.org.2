Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8F936CB00
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbhD0STX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbhD0STW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:19:22 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09D1C061574;
        Tue, 27 Apr 2021 11:18:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o16so69256853ljp.3;
        Tue, 27 Apr 2021 11:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e37rDx7ngrrX1XPOlWKvyTs3z4dJ4MqXCHjL33sYDUA=;
        b=WEfVwlO1yAJjRfPz4Xqle/vpvHa0ZX9wuLtXBZ8lic2yvIPlmRtyaAFrVtztcawhsr
         8VdCOSAkWdzZHXLXVuiysajrnnt4o5qvSGi2BY5vqE3bx5jusysvfU27+1RYP3jCEh5t
         9HAQcBct0VyxhqwoVIC8Ah1eARLuRJocJtubrtVxYqXSzscfV/hwWIR7DUj/uNWSMjDw
         3hPOWO4SUnbpPkKt1ASG3WbDNtuljf/95s9h5ZO/srursBteV2WSuDo/CT/q5Njo+Hm+
         usy/1p7TCWQ3ncKGBcrq/ZJYAMrBy6lcPPnWug47/nv9v8Yzia+yq0P6N55J92UO78l6
         1x2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e37rDx7ngrrX1XPOlWKvyTs3z4dJ4MqXCHjL33sYDUA=;
        b=f+TmdHXbOCr95v/uQEJRcRDzoHsMobqECIDuDYCTjwI+h5pRUeBVvpo0M5KCo2TRj0
         yT0osiNeUwG2FNYhNFbhw1XSolLTvcV1w80U38jZxSlq/LlBBDOXf2o2QoF4UjVRmN81
         0w/QKQ3YOSGBR4HTPr1lsSPgXh7m13SlJHFZibP0G48os/IC0/IM4TsexMkhlxdAvdvF
         v385tfGroveQ7yCQ76v+KkpfuYtp0nT6OynKMW8LC79q0NNUf0KmYEJjPYzvqYde8zPY
         VzbS9FFvPoCRoLsQUT89W1TIy+eWzXmwLJ04ehPG6non1FLPv4zQxDqbCkgO4QzAiKIX
         WQ4Q==
X-Gm-Message-State: AOAM531iGRKt3bWn6U61ydBxGVa4GdoaB/gUfxaWhQSk10hBscALcoVZ
        0nfUbpRtjOPwg0aFDAJ2hqg+QTL2qksWPbCY
X-Google-Smtp-Source: ABdhPJwtRB7eR6JvGQeJoEsu5oYccpzwjVSVv3xW1f36oyUfQNiZmOHemOZqB1KcQda60Xv9SohMSQ==
X-Received: by 2002:a2e:6a05:: with SMTP id f5mr17264434ljc.23.1619547515667;
        Tue, 27 Apr 2021 11:18:35 -0700 (PDT)
Received: from [10.0.0.42] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id m4sm133279lfc.127.2021.04.27.11.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 11:18:34 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: ti: j7200-main: Mark Main NAVSS as
 dma-coherent
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210427175130.29451-1-vigneshr@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <d36f0be0-3358-971c-e385-f920cfa333cd@gmail.com>
Date:   Tue, 27 Apr 2021 21:19:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210427175130.29451-1-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/21 8:51 PM, Vignesh Raghavendra wrote:
> Traffic through main NAVSS interconnect is coherent wrt ARM caches on
> J7200 SoC.  Add missing dma-coherent property to main_navss node.
> 
> Also add dma-ranges to be consistent with mcu_navss node.

and with am65, j721e main and mcu navss...

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Fixes: d361ed88455fe ("arm64: dts: ti: Add support for J7200 SoC")
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index f86c493a44f1c..a6826f1888ef0 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -85,6 +85,8 @@ main_navss: bus@30000000 {
>  		#size-cells = <2>;
>  		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
>  		ti,sci-dev-id = <199>;
> +		dma-coherent;
> +		dma-ranges;
>  
>  		main_navss_intr: interrupt-controller1 {
>  			compatible = "ti,sci-intr";
> 

-- 
Péter
