Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEA13410FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 00:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhCRXYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 19:24:46 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:47858 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhCRXYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 19:24:44 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 427494FD;
        Fri, 19 Mar 2021 00:24:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1616109878;
        bh=dAnfYr7tXXzuRPZNp1s80gcvNi2mEDtK9FDU/VnCAbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/SOGoo8Sja2C+GOBFy6C3JGF5vgD4c8LaFErZI+HSQL/XsKeO4eTg6bP7ZhOjyYo
         qS044cGLNVKrhm0nm3ZnkrRcORgexRU5YRQZ3gb2fuBVGIn+03VKvKhRSGB2IkBgYm
         bV/hHj3pk8uXtfWF7+l0rslnAWd7IgiJcQ7nAKS4=
Date:   Fri, 19 Mar 2021 01:24:00 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     robert.foss@linaro.org, robh+dt@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        a.hajda@samsung.com, narmstrong@baylibre.com, nikhil.nd@ti.com,
        kishon@ti.com, sjakhade@cadence.com, mparab@cadence.com
Subject: Re: [PATCH v4 1/2] dt-bindings: drm/bridge: MHDP8546 bridge binding
 changes for HDCP
Message-ID: <YFPhEKQkFpiXKcSb@pendragon.ideasonboard.com>
References: <1616049882-29712-1-git-send-email-pthombar@cadence.com>
 <1616049930-31457-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1616049930-31457-1-git-send-email-pthombar@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Parshuram,

Thank you for the patch.

On Thu, Mar 18, 2021 at 07:45:30AM +0100, Parshuram Thombare wrote:
> Add binding changes for HDCP in the MHDP8546 DPI/DP bridge binding.
> 
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  .../display/bridge/cdns,mhdp8546.yaml         | 24 +++++++++++--------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> index 63427878715e..8a85768f6202 100644
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
>      items:
>        - description:
>            Register block of mhdptx apb registers up to PHY mapped area (AUX_CONFIG_P).
> @@ -26,13 +26,16 @@ properties:
>            included in the associated PHY.
>        - description:
>            Register block for DSS_EDP0_INTG_CFG_VP registers in case of TI J7 SoCs.
> +      - description:
> +          Register block of mhdptx sapb registers.
>  
>    reg-names:
> -    minItems: 1
> -    maxItems: 2
> +    minItems: 2
> +    maxItems: 3
>      items:
>        - const: mhdptx
>        - const: j721e-intg
> +      - const: mhdptx-sapb
>  
>    clocks:
>      maxItems: 1
> @@ -98,15 +101,15 @@ allOf:
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
> @@ -129,8 +132,9 @@ examples:
>  
>          mhdp: dp-bridge@f0fb000000 {
>              compatible = "cdns,mhdp8546";
> -            reg = <0xf0 0xfb000000 0x0 0x1000000>;
> -            reg-names = "mhdptx";
> +            reg = <0xf0 0xfb000000 0x0 0x1000000>,
> +                  <0x0 0x4f48000 0x0 0x74>;
> +            reg-names = "mhdptx", "mhdptx-sapb";

Running

make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml

produces

  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
  DTEX    Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.example.dts
  DTC     Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.example.dt.yaml
Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.example.dt.yaml: dp-bridge@f0fb000000: reg-names:1: 'j721e-intg' was expected
        From schema: Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml

This is caused by the fact that reg-names is correctly limited to two
elements, but then expects the second element to be "j721e-intg". The
example is good, so it's the bindings that need to be fixed.

>              clocks = <&mhdp_clock>;
>              phys = <&dp_phy>;
>              phy-names = "dpphy";

-- 
Regards,

Laurent Pinchart
