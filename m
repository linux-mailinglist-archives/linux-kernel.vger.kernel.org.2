Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2374C311CE3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 12:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhBFL2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 06:28:11 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:40287 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhBFL2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 06:28:08 -0500
Received: by mail-wm1-f50.google.com with SMTP id o24so374324wmh.5;
        Sat, 06 Feb 2021 03:27:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XcXJGM0kwz/A+LLJn3fSvAukZQQd0FRTmmT0NH0TzLk=;
        b=HcHFZUfmeUgdpLOyuUpXhB9XlFlBkObQPVqCusvYaRRjpLCDvkPF3bHvzGtIJUG5G9
         USRRUCZwnn5Xm9FBnUZXRiX2g/FwgUfDd0+GayLkFSzghLNBppFSH93p1lOdJaHJnEpY
         sSJ+SwsvhxqgGGudA8yXts+PxpCw1lbC5fw4FXYVKyygPF012KSltDay5JP8VI5SeQUV
         8/Y9uhTuxmdsWT1bcn2TtUq+MBVs3vu4QsBT2nmOxSsR8Pdph8IvrpaP4+fygcuPFtQO
         ZtwlUkjWz77KWleJLlXeONnZDwz7V1jiMOkqzst92PX18rHevrR8j5N8LUKVn+0Mqduy
         TVwg==
X-Gm-Message-State: AOAM530T4vFq55YUf0xFaSJrcgGKqw52Lh/4bDsgqX02auX45bR3iKZy
        uVZ6FF2DdThrAZLWMaOhTnQ=
X-Google-Smtp-Source: ABdhPJxLRvEAmib95xNiRyWkyAzcIv9y2f+CrABiiX9yxmJBrYK3J0rlMhjpBAR6HZx4t/Ud2ZVPHw==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr7147307wmh.47.1612610846393;
        Sat, 06 Feb 2021 03:27:26 -0800 (PST)
Received: from kozik-lap (194-95-143-94.dyn.cable.fcom.ch. [94.143.95.194])
        by smtp.googlemail.com with ESMTPSA id m24sm11124427wmi.24.2021.02.06.03.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 03:27:25 -0800 (PST)
Date:   Sat, 6 Feb 2021 12:27:23 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/15] dt-bindings: i2c: imx: update schema to align with
 original binding
Message-ID: <20210206112723.zmpdxaqlgu6vzmm2@kozik-lap>
References: <20210205234734.3397-1-leoyang.li@nxp.com>
 <20210205234734.3397-3-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210205234734.3397-3-leoyang.li@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 05:47:21PM -0600, Li Yang wrote:
> Layerscape SoCs doesn't use ipg as clock name.  Remove the clock name
> requirement in the schema.  Also the original binding doesn't enforce
> the order of "tx" and "rx" in dma-names.  Both orders are used
> extensively in existing dtses, update the schema to allow both.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-imx.yaml | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.yaml b/Documentation/devicetree/bindings/i2c/i2c-imx.yaml
> index f23966b0d6c6..57237b0b7d89 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-imx.yaml
> +++ b/Documentation/devicetree/bindings/i2c/i2c-imx.yaml
> @@ -54,20 +54,19 @@ properties:
>      maxItems: 1
>  
>    clock-names:
> -    const: ipg
> +    maxItems: 1

No, for other SoCs the clock is I think required, so it should be there.
Add an allof-if statements to require it on specific compatibles and
skip on others.

>  
>    clock-frequency:
>      enum: [ 100000, 400000 ]
>  
>    dmas:
> -    items:
> -      - description: DMA controller phandle and request line for RX
> -      - description: DMA controller phandle and request line for TX
> +    minItems: 2
> +    maxItems: 2
>  
>    dma-names:
>      items:
> -      - const: rx
> -      - const: tx
> +      - enum: [ "rx", "tx" ]
> +      - enum: [ "tx", "rx" ]

No, the order should be enforced. That was a generic recommendation from
Rob.

Also, I don't get the what does it mean "the original binding" in commit
msg. This is the original binding. Upstream. Mainline.

If your DTSes have different order, please adjust them, not the binding.

Best regards,
Krzysztof
