Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F35367558
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 00:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343584AbhDUWwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 18:52:50 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:39792 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbhDUWwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 18:52:49 -0400
Received: by mail-oi1-f178.google.com with SMTP id i81so43992171oif.6;
        Wed, 21 Apr 2021 15:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZfP+v08fbXOyQGmlXgs34y9m62CQJ9d66rbECIK0MBw=;
        b=Dd0tQaJJBFhGob251JdzNdw0wZj2fT81LhNPTPSlIEYY31ATxH55JwJQ1v5+52qBlt
         yu0wgqO7EE3ycpSrtCHxtbF/77kOUX2xWW42W6/nD5prBiMg+IbEaF8aKATdS2fcvy7Q
         zxsJ0ZmvSv3rHedkTWF9MHhRuj8wWwrLj/rmiV6GIhiGAtXDPz00TDRK5nRXCNFvBno9
         9gG2mgw/fKJ60C3Zt2fhqFagu6B7EoHCOMCwh3oTpFTgK6ASPnNGUwdVjZ5oLNLzGPil
         UG92kUZMNb9PDhQQZ1UsQepMy1aHR/x0ZRjkdrIKN5AHAPrp7t8VcfNgzNfgBkBOuZlZ
         SDzQ==
X-Gm-Message-State: AOAM533z5uPGpPwCrzzLjVQ3BUPrc/oncgllu5MtttTSpy13cojgaKaF
        QvMhWqRJ1r5ls2fZp2hATA==
X-Google-Smtp-Source: ABdhPJxM2G9XHRqVP6I+dA7m+p0XdMvLC72ekhQnsH+Rh1qvuIPrfU3LUCdqIWAsIOh3/pRWmS17Pg==
X-Received: by 2002:aca:44b:: with SMTP id 72mr216449oie.68.1619045534389;
        Wed, 21 Apr 2021 15:52:14 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d17sm181223oth.19.2021.04.21.15.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 15:52:13 -0700 (PDT)
Received: (nullmailer pid 1761097 invoked by uid 1000);
        Wed, 21 Apr 2021 22:52:12 -0000
Date:   Wed, 21 Apr 2021 17:52:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: arm: firmware: Convert linaro,optee-tz to
 json schema
Message-ID: <20210421225212.GB1750844@robh.at.kernel.org>
References: <20210416222518.15801-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416222518.15801-1-nm@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 05:25:18PM -0500, Nishanth Menon wrote:
> Convert linaro,optee-tz to json schema format for better documentation
> and error checks.
> 
> NOTE:
> 1. This change does introduce a stricter naming convention for
>    optee nodes.
> 2. We do have false positive checkpatch warning with this patch:
>    "DT binding docs and includes should be a separate patch"

Not really something that needs to be in the commit msg. I'm aware of 
the issue, just haven't gotten around to fixing it.

> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  .../bindings/arm/firmware/linaro,optee-tz.txt | 31 ----------
>  .../arm/firmware/linaro,optee-tz.yaml         | 62 +++++++++++++++++++
>  2 files changed, 62 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
> deleted file mode 100644
> index d38834c67dff..000000000000
> --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -OP-TEE Device Tree Bindings
> -
> -OP-TEE is a piece of software using hardware features to provide a Trusted
> -Execution Environment. The security can be provided with ARM TrustZone, but
> -also by virtualization or a separate chip.
> -
> -We're using "linaro" as the first part of the compatible property for
> -the reference implementation maintained by Linaro.
> -
> -* OP-TEE based on ARM TrustZone required properties:
> -
> -- compatible     : should contain "linaro,optee-tz"
> -
> -- method         : The method of calling the OP-TEE Trusted OS. Permitted
> -                   values are:
> -
> -                   "smc" : SMC #0, with the register assignments specified
> -		           in drivers/tee/optee/optee_smc.h
> -
> -                   "hvc" : HVC #0, with the register assignments specified
> -		           in drivers/tee/optee/optee_smc.h
> -
> -
> -
> -Example:
> -	firmware {
> -		optee {
> -			compatible = "linaro,optee-tz";
> -			method = "smc";
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> new file mode 100644
> index 000000000000..6513b5ac8b2c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/firmware/linaro,optee-tz.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OP-TEE Device Tree Bindings
> +
> +maintainers:
> +  - Jens Wiklander <jens.wiklander@linaro.org>
> +
> +description: |
> +  OP-TEE is a piece of software using hardware features to provide a Trusted
> +  Execution Environment. The security can be provided with ARM TrustZone, but
> +  also by virtualization or a separate chip.
> +
> +  We're using "linaro" as the first part of the compatible property for
> +  the reference implementation maintained by Linaro.
> +
> +properties:
> +  $nodename:
> +    const: 'optee'

Don't need quotes.

> +
> +  compatible:
> +    const: linaro,optee-tz
> +
> +  method:
> +    description: The method of calling the OP-TEE Trusted OS.
> +    oneOf:
> +      - description: |
> +          SMC #0, with the register assignments specified
> +          in drivers/tee/optee/optee_smc.h
> +        items:
> +          - const: smc
> +      - description: |
> +          HVC #0, with the register assignments specified
> +          in drivers/tee/optee/optee_smc.h
> +        items:
> +          - const: hvc

Please just do 'enum: [ smc, hvc ]' and rework to a single description.

> +
> +required:
> +  - compatible
> +  - method
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware  {
> +        optee  {
> +            compatible = "linaro,optee-tz";
> +            method = "smc";
> +        };
> +    };
> +
> +  - |
> +    firmware  {
> +        optee  {
> +            compatible = "linaro,optee-tz";
> +            method = "hvc";
> +        };
> +    };
> -- 
> 2.31.0
> 
