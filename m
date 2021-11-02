Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7B74434CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 18:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhKBRtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 13:49:41 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:45757 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhKBRtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 13:49:39 -0400
Received: by mail-oi1-f177.google.com with SMTP id u2so11940981oiu.12;
        Tue, 02 Nov 2021 10:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uW9s2FSdm9CorVCeI1XNZOx+Rhacrk0vCMIgqByVKQ0=;
        b=B+wzAZahNvPvBhq9WOlbjmK/pkHeVgQdPd8wFyisZeD7VhFoqGk5bPfFcYFZPFIqLx
         spb+5wH0ENDFx1+Fy9s6qqmJszmkqTVZruBStLURXwOG6pR6sDF1oD1jWMma/keJUvEt
         6CamV5JYrcrvMn1YG0JuaADgnK7GIoMUIe7/0Qf6T1Xm8aQaA5J801Mz//evvNizgKIH
         bWZd+C7hBTX49apbJSp0c48Bk+h5Rk7bKqEV0d44CDUoZJHqFbOW1s6+qq7g0fd6jgz3
         F1odTiA79TVHCoctEgUOHutzMtbvtnoshCoZbQz3QHDGDzR+Z4Z0MIE6wtYogbveeWtR
         NLOA==
X-Gm-Message-State: AOAM531tkXh6x/NDyZEmMdSLyxAAfY75aeTqSWN5FYfvFKSpy6wVTjgo
        CMdrfVStR4sN5JvIK5xPFCNm/qxbFg==
X-Google-Smtp-Source: ABdhPJwCznAlRoiYCLgrvFkfFfkWOGPtCK1+qcFeceWeh1S10J0DgEb9lt9cj9AHwEeGJkqHs/ztHA==
X-Received: by 2002:a05:6808:2097:: with SMTP id s23mr6210784oiw.43.1635875224449;
        Tue, 02 Nov 2021 10:47:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a20sm4592639oie.58.2021.11.02.10.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 10:47:03 -0700 (PDT)
Received: (nullmailer pid 3147705 invoked by uid 1000);
        Tue, 02 Nov 2021 17:47:03 -0000
Date:   Tue, 2 Nov 2021 12:47:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, kavyasree.kotagiri@microchip.com,
        eugen.hristev@microchip.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/4] dt-bindings: clock: lan966x: Extend for clock
 gate support
Message-ID: <YYF5l0bFw+P/rsDx@robh.at.kernel.org>
References: <20211101080845.3343836-1-horatiu.vultur@microchip.com>
 <20211101080845.3343836-3-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101080845.3343836-3-horatiu.vultur@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 09:08:43AM +0100, Horatiu Vultur wrote:
> Allow to add an optional resource to be able to access the clock gate
> registers.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  .../devicetree/bindings/clock/microchip,lan966x-gck.yaml       | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> index fca83bd68e26..a53c889629da 100644
> --- a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> +++ b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> @@ -19,7 +19,8 @@ properties:
>      const: microchip,lan966x-gck
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2

When there is more than 1 entry, you need to describe each entry:

minItems: 1
items:
  - description: ...
  - description: ...

>  
>    clocks:
>      items:
> -- 
> 2.33.0
> 
> 
