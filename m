Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CF343252C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhJRRmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:42:36 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:37434 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbhJRRme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:42:34 -0400
Received: by mail-oi1-f181.google.com with SMTP id o83so838879oif.4;
        Mon, 18 Oct 2021 10:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WjCdoPbhUwOU2BPjJvdVK3b+6xDTrV2zEbWC1uYUtaY=;
        b=lZJzB20kNN7+prG1bD/2a9Fp0cqVWXkKw2De2C6d4wPJ2RwRqrIrIkY47c8EIPirJu
         Dq4RMaKL4/VQRozDX9yJbI5qAsZp23vFEXLMk+5GGFjBXYK7WlIfvGzBzQ7tK+BMXuLU
         XoA8Gd1zZEhp5cfn2OXbrNhlzJJYEmHyHdVADxAzd5zNIkuqMY1afl+0hnZ6YItB6bE6
         U01rlbr4cZf3YmuEKK+12onoEpSmg5ncb1aLfKsHP5Eh935QG2dZyskY5ixrbJyBYejD
         8B/vNM49jYXIa7PL19qVCN7UFMYRUhMCWX3Gfzf63V50r2Cq0mz13P81i89imxRblydY
         72Ow==
X-Gm-Message-State: AOAM530hPGNSuJN+gHHhcPdOQWvlOulz2aTA403O9UasziTPbGZgn5tu
        Za9/EHiWDrb1yUkK+le7Ew==
X-Google-Smtp-Source: ABdhPJwoJ4rchmQWhDHqPkxTSK7hUZqnNUE76P6zsjk0M22Dwy50hrUbpkkDsR3nSNZfVB6NrdZXcA==
X-Received: by 2002:a05:6808:5d5:: with SMTP id d21mr227760oij.104.1634578823296;
        Mon, 18 Oct 2021 10:40:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c3sm3189302otr.42.2021.10.18.10.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:40:22 -0700 (PDT)
Received: (nullmailer pid 2625572 invoked by uid 1000);
        Mon, 18 Oct 2021 17:40:21 -0000
Date:   Mon, 18 Oct 2021 12:40:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
Message-ID: <YW2xhRXQ+MA/Cxm1@robh.at.kernel.org>
References: <20211018114046.25571-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018114046.25571-1-etienne.carriere@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 01:40:45PM +0200, Etienne Carriere wrote:
> Introduce compatible "linaro,scmi-optee" for SCMI transport channel
> based on an OP-TEE service invocation. The compatible mandates a
> channel ID defined with property "linaro,optee-channel-id".
> 
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v2:
>  - Define mandatory property linaro,optee-channel-id
>  - Rebased on yaml description file
> 
> Changes since v1:
>  - Removed modification regarding mboxes property description.
> ---
>  .../bindings/firmware/arm,scmi.yaml           | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 5c4c6782e052..12154ecc081b 100644
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
> +      Channel id required when using OP-TEE transports
> +
>    protocol@11:
>      type: object
>      properties:
> @@ -195,6 +203,9 @@ patternProperties:
>          minItems: 1
>          maxItems: 2
>  
> +      linaro,optee-channel-id:
> +        maxItems: 1

Why is the same property in 2 different spots? That doesn't seem ideal.

Unfortunately, you have to duplicate the definition.

> +
>      required:
>        - reg
>  
> @@ -226,6 +237,16 @@ else:
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
> @@ -340,7 +361,30 @@ examples:
>                  reg = <0x11>;
>                  #power-domain-cells = <1>;
>              };
> +        };
> +    };
> +
> +  - |
> +    firmware {
> +        scmi {
> +            compatible = "linaro,scmi-optee";
> +            linaro,optee-channel = <0>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            scmi_clk: protocol@14 {
> +                reg = <0x14>;
> +                #clock-cells = <1>;
> +            };
> +
> +            scmi_dvfs: protocol@13 {
> +                reg = <0x13>;
>  
> +                #clock-cells = <1>;
> +                linaro,optee-channel = <1>;
> +                shmem = <&cpu_scp_hpri0>;
> +            };
>          };
>      };
>  
> -- 
> 2.17.1
> 
> 
