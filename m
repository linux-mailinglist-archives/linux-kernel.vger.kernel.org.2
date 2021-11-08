Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9785A449BF9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 19:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbhKHSuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 13:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbhKHSt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 13:49:58 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219DFC061746
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 10:47:13 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id bf8so11145709oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 10:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0vw8s287M6V5tUEsTJntxMeh19bFdVrXBNKNoghHXao=;
        b=ywlYUfVasoalbTydcYohciaaAH8wfFvqWJ/gT+CCOCjU1tjYJY9d259VD/iG+WAxeX
         UzBNkbA2iiR9m8NWFAMtNtDcOwUzOKyw02Nz+HbwkU4xOvYN6WYbrTknog4XZgC1gU6N
         D6giWibXnftdvgv4qAuJRkcE14pOBcSCHyPlF9zx11QEMMaUohAOmZ6J/S0kBh+MWJxj
         SgEuTOs8PuLKfdynmN/2WLZPXkgMwXWOJW39pQfCeub5zfek+jztC7kuTbhXq5pKXzOn
         RFKgyqpnfnhXXmFJyWqAY2X+OMc/Pw/8yYj2Bz5hM+lwfTxbGv9N+/i3ZdYk51soUuGr
         fWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0vw8s287M6V5tUEsTJntxMeh19bFdVrXBNKNoghHXao=;
        b=ikwwVAsjLrPMZcosAkTW7N2wWmNNDLmce9UCsKot58BSP2Psmjcj5jIGky0WyvGbS6
         C+q+6xLzfqTpCLopdbdAttcqx9yiqj0yQ2swv9kM7DmrNlsR8fjSjcipna63ijGR6OiX
         55RQYxVY/vQIL8HNrfiJIq1qiVISgbCREIyVnquScskpfURhpTiPushnwG5mMPcvKauT
         m5v+RfizkFS9qCj/QK2iW2laqSKPq86/t62mOAc9gP8g3flbcfpE3L1r/kwKNPBaF/04
         cyGiqb178yvE9MJasc5RdkDONKirkhO8XLOakj4FYnqOLe7Xj8qvK5Gmf5qesf6ZQ5Ss
         G9yg==
X-Gm-Message-State: AOAM530xoVbGeusMF4z5w3HbPeaunv2ouSLEvv6oX6NdhTPSHwT6Kyn/
        fHy2JAywekIqFV2ZI7A3TtgAAw==
X-Google-Smtp-Source: ABdhPJwztpHYHCOdNId1sZbWWKDiOQRdMs7lgaadW6QKrlShBESNVaqndOmityyif7Tg18o9uOBktQ==
X-Received: by 2002:a54:4401:: with SMTP id k1mr349239oiw.143.1636397232392;
        Mon, 08 Nov 2021 10:47:12 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w29sm5245219ooe.25.2021.11.08.10.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 10:47:11 -0800 (PST)
Date:   Mon, 8 Nov 2021 10:48:47 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jarrett Schultz <jaschultzms@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: platform: microsoft: Document
 surface xbl
Message-ID: <YYlxD7TuNzFlWokq@ripper>
References: <20211108164449.3036210-1-jaschultz@microsoft.com>
 <20211108164449.3036210-2-jaschultz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108164449.3036210-2-jaschultz@microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08 Nov 08:44 PST 2021, Jarrett Schultz wrote:

> Introduce yaml for surface xbl driver.
> 
> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> 
> ---
> 
> Changes in v2:
>  - Removed json-schema dependence
>  - Elaborated on description of driver
>  - Updated example
> 
> ---
> 
>  .../platform/microsoft/surface-xbl.yaml       | 57 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml b/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
> new file mode 100644
> index 000000000000..09f806f373bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/platform/microsoft/surface-xbl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Surface Extensible Bootloader for Microsoft Surface Duo
> +
> +maintainers:
> +  - Jarrett Schultz <jaschultzMS@gmail.com>
> +
> +description: |
> +  Exposes the following device information to user space via sysfs -

The devicetree should describe the hardware, or in this case the imem
region. User space, sysfs etc are concepts of one possible consumer of
this information and should not be part of the binding.

It might make sense to update this description to still document what's
to be found in the memory region though.

> +    * board_id
> +    * battery_present
> +    * hw_init_retries
> +    * is_customer_mode
> +    * is_act_mode
> +    * pmic_reset_reason
> +    * touch_fw_version
> +    * ocp_error_location
> +  See sysfs documentation for more information.
> +
> +properties:
> +  compatible:
> +    const: microsoft,sm8150-surface-duo-xbl
> +
> +  reg:
> +    maxItems: 1
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

I believe interrupts is a leftover...

> +
> +examples:
> +  - |
> +    xbl@146bfa94 {
> +      compatible = "microsoft,sm8150-surface-duo-xbl";
> +      reg = <0x00 0x146bfa94 0x00 0x100>;

The example is compiled with #address-cells == #size-cells = <1>, so
you should omit the extra 0 in both address and size, in both examples.

Regards,
Bjorn

> +    };
> +  - |
> +    imem@146bf000 {
> +      compatible = "simple-mfd";
> +      reg = <0x0 0x146bf000 0x0 0x1000>;
> +      ranges = <0x0 0x0 0x146bf000 0x1000>;
> +
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      xbl@a94 {
> +        compatible = "microsoft,sm8150-surface-duo-xbl";
> +        reg = <0xa94 0x100>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eeb4c70b3d5b..8643546f8fab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12423,6 +12423,13 @@ F:	Documentation/driver-api/surface_aggregator/clients/dtx.rst
>  F:	drivers/platform/surface/surface_dtx.c
>  F:	include/uapi/linux/surface_aggregator/dtx.h
>  
> +MICROSOFT SURFACE DUO XBL DRIVER
> +M:	Jarrett Schultz <jaschultz@microsoft.com>
> +L:	linux-arm-msm@vger.kernel.org
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
> +
>  MICROSOFT SURFACE GPE LID SUPPORT DRIVER
>  M:	Maximilian Luz <luzmaximilian@gmail.com>
>  L:	platform-driver-x86@vger.kernel.org
> -- 
> 2.25.1
> 
