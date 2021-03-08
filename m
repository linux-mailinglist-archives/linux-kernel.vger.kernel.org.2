Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232FB3314FA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCHRgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:36:55 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:44118 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCHRgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:36:18 -0500
Received: by mail-io1-f46.google.com with SMTP id 81so10785482iou.11;
        Mon, 08 Mar 2021 09:36:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JBA6up/vPaAHWMxjZYEnP/CnL1gFfsdNRmBXWfPosnI=;
        b=AFQ+LRpaxQXCV4wBUJbiribmlFkG9en2yPL0jyK5fKGQDARrIc++DYg8/fTL85OFEU
         FcMmNB36YOKmzHn+gbjwooZ42kpnpTo/rJ/LTMlDnDCH011dK3jNycE/QYU/dU2WOYYZ
         itv6RtQOo6E0KnS9pH/BWhtrjxqRXYomJSM0lF2ZlWKagroi2E7OIbTMW1A8j7Uwt0A2
         G9KKe04Foylz5IXX8QSsDh6DBC0XA1AHaC/0sr4TE7gFGk44FlvkMWmFjTc3dFvl/OgI
         2wHx2A11wRZi67dD2QIe9PYHlQR9ebrFWaWlL9YEORIH51PC3qJws0fJKndgqifkCsc7
         dVXA==
X-Gm-Message-State: AOAM530fj2LF73Fok4Q7YaYIaWXpB5s5wjhpMtHDFPNau5znh03pu+wz
        e3MzWS25Sa57r5LdRSL0Tg==
X-Google-Smtp-Source: ABdhPJyJaGJBruRnAkdq1spRqZqtn2RV1GOv+7vhvyAfJFtvmSgGafdf13MYdJGctj/hpQjFitOtMg==
X-Received: by 2002:a6b:5c0d:: with SMTP id z13mr19258278ioh.6.1615224977961;
        Mon, 08 Mar 2021 09:36:17 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y18sm6506926ili.16.2021.03.08.09.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:36:17 -0800 (PST)
Received: (nullmailer pid 2674975 invoked by uid 1000);
        Mon, 08 Mar 2021 17:36:15 -0000
Date:   Mon, 8 Mar 2021 10:36:15 -0700
From:   Rob Herring <robh@kernel.org>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     robert.foss@linaro.org, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        a.hajda@samsung.com, narmstrong@baylibre.com, nikhil.nd@ti.com,
        kishon@ti.com, sjakhade@cadence.com, mparab@cadence.com
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/bridge: MHDP8546 bridge binding
 changes for HDCP
Message-ID: <20210308173615.GA2668115@robh.at.kernel.org>
References: <1614597685-4192-1-git-send-email-pthombar@cadence.com>
 <1614597746-4563-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614597746-4563-1-git-send-email-pthombar@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 12:22:26PM +0100, Parshuram Thombare wrote:
> Add binding changes for HDCP in the MHDP8546 DPI/DP bridge binding.
> This binding is not used in any upstreamed DTS yet, so changing
> index of property 'j721e-intg' should not affect anything.

TI folks might disagree, but weren't Cc'ed.

> 
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  .../display/bridge/cdns,mhdp8546.yaml         | 29 ++++++++++++-------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> index 63427878715e..5fdadadaac16 100644
> --- a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> @@ -17,21 +17,24 @@ properties:
>        - ti,j721e-mhdp8546
>  
>    reg:
> -    minItems: 1
> -    maxItems: 2
> +    minItems: 2
> +    maxItems: 3
>      items:
>        - description:
>            Register block of mhdptx apb registers up to PHY mapped area (AUX_CONFIG_P).
>            The AUX and PMA registers are not part of this range, they are instead
>            included in the associated PHY.
> +      - description:
> +          Register block of mhdptx sapb registers.
>        - description:
>            Register block for DSS_EDP0_INTG_CFG_VP registers in case of TI J7 SoCs.
>  
>    reg-names:
> -    minItems: 1
> -    maxItems: 2
> +    minItems: 2
> +    maxItems: 3
>      items:
>        - const: mhdptx
> +      - const: mhdptx-sapb
>        - const: j721e-intg
>  
>    clocks:
> @@ -53,6 +56,11 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  hdcp-config:
> +    maxItems: 1
> +    description:
> +      HDCP version supported. Bit [0]:HDCP2.2 [1]:HDCP1.4.

2.2 is not backwards compatible with 1.4? What's the setting if not 
present? Maybe just a 'disable 2.2 boolean' if that's the non-common 
case.

In any case, it needs a type and constraints on the values.


> +
>    interrupts:
>      maxItems: 1
>  
> @@ -98,15 +106,15 @@ allOf:
>      then:
>        properties:
>          reg:
> -          minItems: 2
> +          minItems: 3
>          reg-names:
> -          minItems: 2
> +          minItems: 3
>      else:
>        properties:
>          reg:
> -          maxItems: 1
> +          maxItems: 2
>          reg-names:
> -          maxItems: 1
> +          maxItems: 2
>  
>  required:
>    - compatible
> @@ -129,8 +137,9 @@ examples:
>  
>          mhdp: dp-bridge@f0fb000000 {
>              compatible = "cdns,mhdp8546";
> -            reg = <0xf0 0xfb000000 0x0 0x1000000>;
> -            reg-names = "mhdptx";
> +            reg = <0xf0 0xfb000000 0x0 0x1000000>,
> +                  <0x0 0x4f48000 0x0 0x74>;
> +            reg-names = "mhdptx", "mhdptx-sapb";
>              clocks = <&mhdp_clock>;
>              phys = <&dp_phy>;
>              phy-names = "dpphy";
> -- 
> 2.25.1
> 
