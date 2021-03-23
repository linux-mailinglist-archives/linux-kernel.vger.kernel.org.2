Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B70346D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhCWWpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:45:52 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:42904 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbhCWWpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:45:49 -0400
Received: by mail-io1-f50.google.com with SMTP id r193so19475288ior.9;
        Tue, 23 Mar 2021 15:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ab4o4vZ3Z9H6htd+vIWwUIBld84Fbz0WvCeZIZS5gUY=;
        b=cW3itOXB4kPWQycvPfdUmh+MzvUrz+BOyaDS9lOu9G9dAx/9GOeh9xz1u8T69m75pS
         7kI9cZk8EvA1lVAA9/O0kqG5+2mmU8oGstMacs1PCgre6ESnkWjMxMmBCcQ0DSxLnheA
         SNOEk1Xlp51wiMRE7/xzpce4PZRsHGPQM4KzP1ra4JxJJ9xYJDxkq80Al5zaD3gatytU
         fMfN6uXtO/LpVbrpDi0TixqcxJQNuWKjqC8Xbqp/PgrVJGdcOk3idUh0bnKzCECXa7Ww
         sH6LVkwGRWYAZ5oYLTHXdq3Ic7xccdi+ltOsX3Lr2O/Ri2PkzStTYz61iZaLQR2vt/qQ
         X58g==
X-Gm-Message-State: AOAM530/UeNRhQZ5B0b3Y6KgyHM3paDxjT56OPRY8YvfYrv+K2CQeZH/
        rGf/5BAKpj3SLKFJcrHyXiQItXQrVQ==
X-Google-Smtp-Source: ABdhPJwczXzVNl7B5zrDCuYGHxJJ00UYCjp7Y8H7wIQACyPGFHS/a8D4OsUfEtPeY1Q9yTMPTNnYoA==
X-Received: by 2002:a02:662b:: with SMTP id k43mr224183jac.139.1616539548932;
        Tue, 23 Mar 2021 15:45:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b15sm136066ilm.25.2021.03.23.15.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 15:45:47 -0700 (PDT)
Received: (nullmailer pid 1488135 invoked by uid 1000);
        Tue, 23 Mar 2021 22:45:46 -0000
Date:   Tue, 23 Mar 2021 16:45:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     robert.foss@linaro.org, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        a.hajda@samsung.com, narmstrong@baylibre.com, nikhil.nd@ti.com,
        kishon@ti.com, sjakhade@cadence.com, mparab@cadence.com
Subject: Re: [PATCH v5 1/2] dt-bindings: drm/bridge: MHDP8546 bridge binding
 changes for HDCP
Message-ID: <20210323224546.GA1485576@robh.at.kernel.org>
References: <1616146664-6941-1-git-send-email-pthombar@cadence.com>
 <1616146709-7227-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616146709-7227-1-git-send-email-pthombar@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:38:29AM +0100, Parshuram Thombare wrote:
> Add binding changes for HDCP in the MHDP8546 DPI/DP bridge binding.
> 
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  .../display/bridge/cdns,mhdp8546.yaml         | 34 ++++++++++++-------
>  1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> index 63427878715e..d571f4bb6b16 100644
> --- a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> @@ -17,8 +17,8 @@ properties:
>        - ti,j721e-mhdp8546
>  
>    reg:
> -    minItems: 1
> -    maxItems: 2
> +    minItems: 2
> +    maxItems: 3

1 entry was valid and now it is not? That's not a compatible change and 
needs an explanation at a minimum.

>      items:
>        - description:
>            Register block of mhdptx apb registers up to PHY mapped area (AUX_CONFIG_P).
> @@ -26,13 +26,20 @@ properties:
>            included in the associated PHY.
>        - description:
>            Register block for DSS_EDP0_INTG_CFG_VP registers in case of TI J7 SoCs.
> +      - description:
> +          Register block of mhdptx sapb registers.
>  
>    reg-names:
> -    minItems: 1
> -    maxItems: 2
> -    items:
> -      - const: mhdptx
> -      - const: j721e-intg
> +    minItems: 2
> +    maxItems: 3
> +    oneOf:
> +      - items:
> +          - const: mhdptx
> +          - const: j721e-intg
> +          - const: mhdptx-sapb
> +      - items:
> +          - const: mhdptx
> +          - const: mhdptx-sapb
>  
>    clocks:
>      maxItems: 1
> @@ -98,15 +105,15 @@ allOf:
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
> @@ -129,8 +136,9 @@ examples:
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
