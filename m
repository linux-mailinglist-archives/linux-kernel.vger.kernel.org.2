Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0643738BB7B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbhEUBXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:23:48 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:43684 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbhEUBXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:23:47 -0400
Received: by mail-oi1-f174.google.com with SMTP id j75so18175507oih.10;
        Thu, 20 May 2021 18:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k4KWGlvK3qGaxYX6Np3iLLA0ulq4Lc64J8obvuCRFos=;
        b=jWAVLfBmhX6ThekBj9xd7TMnxW4eStR8T0RI4CsDJbeeiS6zEeGNInMmiRKMIvCCHx
         67j1fd/Q0sFRVzJupf6fpbH21ECwREqWkEmMToMNnj8uaQwfTsyVrbwgGa3wnlbVuNva
         VDcUOVe31Xt2DMo/F581sed3doUi7nJMi/hl7v6bKr6vl7vK3YaCChSuTJaqgGc6UgOi
         VFg6liVDzxo4w8/YBS/c4dGvXUyuGP3jMn5yZeJWIHxyn5GReh9egsPI1YCVJNHEL8le
         URTwvgYsYnRpDRS+EW6HtN5Av34bn2xsyGz2caAX259BdqxTPDrLa7mjmIiZMGvJ5Bsg
         Gd0Q==
X-Gm-Message-State: AOAM532VNkJjriL0CbZ6B+Iq73xj9zhxO3wX81FzX7E9RXYR+DMkIhMx
        1fGFJsp3+VaKfXbj0sy91g==
X-Google-Smtp-Source: ABdhPJyzqzC2yzSopZN40GRzbx7jDSy385pnzcAhmj1QfM9zVNed5J3r2LqLiVNYyYjjCim8ELXLVQ==
X-Received: by 2002:aca:dd86:: with SMTP id u128mr214796oig.155.1621560144175;
        Thu, 20 May 2021 18:22:24 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f2sm960015otp.77.2021.05.20.18.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 18:22:23 -0700 (PDT)
Received: (nullmailer pid 2428345 invoked by uid 1000);
        Fri, 21 May 2021 01:22:22 -0000
Date:   Thu, 20 May 2021 20:22:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, mkorpershoek@baylibre.com,
        Matthias Brugger <mbrugger@suse.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: power: Add MT8365 power domains
Message-ID: <20210521012222.GA2426808@robh.at.kernel.org>
References: <20210518194008.2921469-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518194008.2921469-1-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 09:40:07PM +0200, Fabien Parent wrote:
> Add power domains dt-bindings for MT8365.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../power/mediatek,power-controller.yaml      |  2 ++
>  include/dt-bindings/power/mt8365-power.h      | 20 +++++++++++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt8365-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index f234a756c193..9a26a2cee7fb 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -27,6 +27,7 @@ properties:
>        - mediatek,mt8173-power-controller
>        - mediatek,mt8183-power-controller
>        - mediatek,mt8192-power-controller
> +      - mediatek,mt8365-power-controller
>  
>    '#power-domain-cells':
>      const: 1
> @@ -64,6 +65,7 @@ patternProperties:
>                "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
>                "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
>                "include/dt-bindings/power/mt8192-power.h" - for MT8192 type power domain.
> +              "include/dt-bindings/power/mt8365-power.h" - for MT8365 type power domain.
>          maxItems: 1
>  
>        clocks:
> diff --git a/include/dt-bindings/power/mt8365-power.h b/include/dt-bindings/power/mt8365-power.h
> new file mode 100644
> index 000000000000..352440c4b5dd
> --- /dev/null
> +++ b/include/dt-bindings/power/mt8365-power.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

What about non-GPL users of DT? Dual license please.

> +/*
> + * Copyright (c) 2021 MediaTek Inc.
> + */
> +
> +#ifndef _DT_BINDINGS_POWER_MT8365_POWER_H
> +#define _DT_BINDINGS_POWER_MT8365_POWER_H
> +
> +#define MT8365_POWER_DOMAIN_DISP	0
> +#define MT8365_POWER_DOMAIN_CONN	1
> +#define MT8365_POWER_DOMAIN_MFG		2
> +#define MT8365_POWER_DOMAIN_AUDIO	3
> +#define MT8365_POWER_DOMAIN_CAM		4
> +#define MT8365_POWER_DOMAIN_DSP		5
> +#define MT8365_POWER_DOMAIN_VDEC	6
> +#define MT8365_POWER_DOMAIN_VENC	7
> +#define MT8365_POWER_DOMAIN_APU		8
> +
> +#endif /* _DT_BINDINGS_POWER_MT8365_POWER_H */
> +
> -- 
> 2.31.1
> 
