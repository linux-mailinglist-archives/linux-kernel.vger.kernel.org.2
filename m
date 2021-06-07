Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169FD39E0AD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 17:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhFGPkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 11:40:02 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:41635 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFGPkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 11:40:00 -0400
Received: by mail-ej1-f52.google.com with SMTP id ho18so16432400ejc.8;
        Mon, 07 Jun 2021 08:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u47dRLH9oeOyhtJ8OMrgpRaWizdSf0mAyz6JZPVlC5o=;
        b=u6xHF44T3sMIdmajR+irHU47dlOz5jNo0MMBPBgHJfLsfubbc3wX4jS+d8hv74/qS1
         PtIN6857oiMtm2+Xn7t/JYs3utVKJ73UaVtRDy88dZLCP+DPQioSVlOAcRwo5ZvmHQad
         6cPvmPLm8muB3nEyoANi+fBk3XsQ635WzcZngMkP4rR3Y+/BdQNIsOCJMijHEZMDN0M2
         lQqrKPSlO26etEeAYbzxQeFxoqW03Md3OHQFcdhsm8TtpRPO2HdvDviICvei35cXq+ev
         YN8vNlUUY7TbKcZU1j3/rSQWfv7XVG0KdRzW9hOU/O0/+cjViNJ8gTaq9umeRD56i/+Y
         grWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u47dRLH9oeOyhtJ8OMrgpRaWizdSf0mAyz6JZPVlC5o=;
        b=WMa4rKVEdIyE8I7c/H8FHalg4QXL+AJ2Yt4zR/09VMiXJNjDFgHyRghv13TJIIQq4t
         +7Vs7NiaGwu9aE4auin0pTQxSVLSireWjFrvJZDEEVCcEeQnTjMQLVgZIqIxMuC19Jyx
         uMBLwQpIDO4CaviOUyDvSuTMbQnE+vDjRMdZfzGDkCDHUKXa1lqTj4u/tomsi24eZWur
         d+7tAgaXXWNiT6MR+87hv2S0wHHvoDArhKqa1yYKSosT17lLrORi3de6icOSgJs2KE7E
         TLg8ku63sDJJZvkAYodE0U3nm6Vx1bex9WV3Hg73xKKPw9qYJEWFniV3Is+z1YTrcVJV
         G73w==
X-Gm-Message-State: AOAM530H4qOe2xrbgunKjZdzvkzjduzTKnbwP6bFKdHJWpxPZ3XqcvyY
        fEaGnJ1/hAcILzZFKqIe5LwH2GjfHiERdw==
X-Google-Smtp-Source: ABdhPJx1ogxNiLcSdGIOUtVV3gUcBzzR83F5bN7m4FcxjGP78JjmVNXmmF0UAeUgUsZXJLtYqovNNA==
X-Received: by 2002:a17:906:68c1:: with SMTP id y1mr18460242ejr.32.1623080228600;
        Mon, 07 Jun 2021 08:37:08 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v23sm7977384eds.25.2021.06.07.08.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 08:37:08 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: soc: rockchip: drop unnecessary #phy-cells
 from grf.yaml
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     robh+dt@kernel.org, vkoul@kernel.org, kishon@ti.com,
        t.schramm@manjaro.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <e7e09072-9cac-413e-dca2-e2a668c1807e@gmail.com>
 <20210607141845.3331910-1-heiko@sntech.de>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <46289b3c-f804-624b-3c74-1989e57d0a7c@gmail.com>
Date:   Mon, 7 Jun 2021 17:37:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210607141845.3331910-1-heiko@sntech.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/21 4:18 PM, Heiko Stuebner wrote:
> The recent yaml conversion of the grf and inno-usb2-phy bindings
> left the #phy-cells in place in the main usb2phy node inside the
> example in grf.yaml, causing new warnings.
> 
> Drop it to make the bindingcheck happy.
> 
> Fixes: e71ccdff376b ("dt-bindings: phy: rename phy nodename in phy-rockchip-inno-usb2.yaml")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

> Like this I guess?

Hi Heiko,

When I apply this patch locally and give the command below the
notifications are gone.

make ARCH=arm dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/soc/rockchip/grf.yaml

Thanks,

Johan

> 
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> index 8c1c46fef157..62fa72cfea34 100644
> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> @@ -242,7 +242,6 @@ examples:
>          clock-names = "phyclk";
>          #clock-cells = <0>;
>          clock-output-names = "clk_usbphy0_480m";
> -        #phy-cells = <0>;
>  
>          u2phy0_host: host-port {
>            #phy-cells = <0>;
> 
