Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A4343D2D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 22:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240874AbhJ0UbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 16:31:20 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:46679 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240852AbhJ0UbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:31:17 -0400
Received: by mail-ot1-f48.google.com with SMTP id x27-20020a9d459b000000b0055303520cc4so5318358ote.13;
        Wed, 27 Oct 2021 13:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Gt7yecOdAu4EbIT5+gTrHUMc9b48g82wGEBF8mjpDQ=;
        b=RG3XHZviQGX3vIFKDYwTHmjDRqzfk0ILhcHoyyahloVDFaKnIPgrBDeiWut0D8RNH3
         4lajx8AsT/hFfgvc1n06CnFW7JtwDXdSUWsa887UrQOszXeTRBkgobuf7BIgYAkChWcr
         zWXAAxnc2O770mMWHuMAr+O8ETS+ABwP7TKgA1z0i+/0iyV544sgv97W/YZG7r+MfRUv
         K1eu7l++3V83fKbYhh4lgGaZ5gPEweo94lnltKLT91wvtXzcikjfCyLiyT77bVNawQ7R
         gMWZYWd7CbyWLm/qdkO8ej4LNLBeztLMAV6JluCVhWs71cK8kKPFWl8XSpcZWUdcsxfN
         zjyA==
X-Gm-Message-State: AOAM533sXUM7NkmDQsyaz4yra3WhFnN3mGiA3UKfN6SXAnkonM8B8MSX
        zIXTopX3iJCpP/pcmYdN9g==
X-Google-Smtp-Source: ABdhPJxI0okT+tWwLZSJQkZ2bNESj5RO9j1ClK0XZe9EiCGZ3rwINTKkL792OhnRkHUQmV7CNHDEMw==
X-Received: by 2002:a9d:7987:: with SMTP id h7mr5341884otm.82.1635366531369;
        Wed, 27 Oct 2021 13:28:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m34sm332238ooi.16.2021.10.27.13.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 13:28:50 -0700 (PDT)
Received: (nullmailer pid 2096909 invoked by uid 1000);
        Wed, 27 Oct 2021 20:28:50 -0000
Date:   Wed, 27 Oct 2021 15:28:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
Message-ID: <YXm2gVDJLORPSAfl@robh.at.kernel.org>
References: <20211026152128.5834-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026152128.5834-1-etienne.carriere@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 05:21:27PM +0200, Etienne Carriere wrote:
> Introduce compatible "linaro,scmi-optee" for SCMI transport channel
> based on an OP-TEE service invocation. The compatible mandates a
> channel ID defined with property "linaro,optee-channel-id".
> 
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> No change since v5
> 
> Changes since v4:
>  - Fix sram node name in DTS example: s/-shm-/-sram-/
> 
> Changes since v3:
>  - Add description for linaro,optee-channel-id in patternProperties
>    specifying protocol can optionaly define a dedicated channel id.
>  - Fix DTS example (duplicated phandles issue, subnodes ordering)
>  - Fix typo in DTS example and description comments.
> 
> Changes since v2:
>  - Define mandatory property linaro,optee-channel-id
>  - Rebased on yaml description file
> 
> Changes since v1:
>  - Removed modification regarding mboxes property description.
> ---
>  .../bindings/firmware/arm,scmi.yaml           | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 5c4c6782e052..d09ebc80e713 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -38,6 +38,9 @@ properties:
>                       The virtio transport only supports a single device.
>          items:
>            - const: arm,scmi-virtio
> +      - description: SCMI compliant firmware with OP-TEE transport
> +        items:
> +          - const: linaro,scmi-optee
>  
>    interrupts:
>      description:
> @@ -83,6 +86,11 @@ properties:
>      description:
>        SMC id required when using smc or hvc transports
>  
> +  linaro,optee-channel-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Channel specifier required when using OP-TEE transport.
> +
>    protocol@11:
>      type: object
>      properties:
> @@ -195,6 +203,13 @@ patternProperties:
>          minItems: 1
>          maxItems: 2
>  
> +      linaro,optee-channel-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Channel specifier required when using OP-TEE transport and
> +          protocol has a dedicated communication channel.
> +        maxItems: 1

Don't need maxItems.

> +
>      required:
>        - reg
>  
> @@ -226,6 +241,16 @@ else:
>        - arm,smc-id
>        - shmem
>  
> +  else:
> +    if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: linaro,scmi-optee
> +    then:
> +      required:
> +        - linaro,optee-channel-id
> +
>  examples:
>    - |
>      firmware {
> @@ -340,7 +365,48 @@ examples:
>                  reg = <0x11>;
>                  #power-domain-cells = <1>;
>              };
> +        };
> +    };
>  
> +  - |
> +    firmware {
> +        scmi {
> +            compatible = "linaro,scmi-optee";
> +            linaro,optee-channel-id = <0>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            scmi_dvfs1: protocol@13 {
> +                reg = <0x13>;
> +                linaro,optee-channel-id = <1>;
> +                shmem = <&cpu_optee_lpri0>;
> +                #clock-cells = <1>;
> +            };
> +
> +            scmi_clk0: protocol@14 {
> +                reg = <0x14>;
> +                #clock-cells = <1>;
> +            };
> +        };
> +    };
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        sram@51000000 {
> +            compatible = "mmio-sram";
> +            reg = <0x0 0x51000000 0x0 0x10000>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges = <0 0x0 0x51000000 0x10000>;
> +
> +            cpu_optee_lpri0: optee-sram-section@0 {
> +                compatible = "arm,scmi-shmem";
> +                reg = <0x0 0x80>;
> +            };
>          };
>      };
>  
> -- 
> 2.17.1
> 
> 
