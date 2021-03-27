Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC6634B868
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 18:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhC0RJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 13:09:55 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:43698 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhC0RJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 13:09:25 -0400
Received: by mail-ot1-f42.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so8220191otn.10;
        Sat, 27 Mar 2021 10:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DLsxAGfchYkbO41PzHGYGbdXOVMJdMlwtMG5pFUqb58=;
        b=qRkGgZJ1cry1CoZ8g0XPNRIOiI4uDfled7IOoIx7jeEe542G6MjZTeM3miv6tJjApb
         eNp4kWjTcgdgcGdN0AQn96Boy9GPeb/0kBBduPxFCCbpS91PGMbl8lQv6unv51ky43jP
         aN6+nzt2PmAsOGKUk/hYAMFJmCvPUzYo19sfclTgFQW12Oc7w+cJFBnELhO7jYppXeFK
         tgNaOooLgJRNMD2jFzKx9Zj2daL2Z79yPtD4WyYTaplFfu+BmiXvr42dEiMnOi66KX4p
         Q68F+cf9cShG5lUuT5y0ge85DFxWRcN46+QMkAc7GEeJZ3WKeFuxb4SQ+8A3CB0oERvY
         DWcg==
X-Gm-Message-State: AOAM533A+Ne08WlEcamHOck9YuujRVSgiQ1lQAoAUFPZ4Kvn58uGeayC
        5OVKp5XRXf5MJ2+HUXpIlQ==
X-Google-Smtp-Source: ABdhPJwqScajK5wkMqNipsU3p55DSXqNUIRszZRRYrqAWCKJp0nD78s+3JcREu6E7E1wAohXMJzwYA==
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr16847757otu.138.1616864965285;
        Sat, 27 Mar 2021 10:09:25 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.107.88])
        by smtp.gmail.com with ESMTPSA id y31sm1141294ota.16.2021.03.27.10.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 10:09:24 -0700 (PDT)
Received: (nullmailer pid 255828 invoked by uid 1000);
        Sat, 27 Mar 2021 17:09:20 -0000
Date:   Sat, 27 Mar 2021 11:09:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [RFC PATCH 3/4] dt-bindings: mtd: add OTP bindings
Message-ID: <20210327170920.GA249312@robh.at.kernel.org>
References: <20210322181949.2805-1-michael@walle.cc>
 <20210322181949.2805-4-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322181949.2805-4-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 07:19:48PM +0100, Michael Walle wrote:
> Flash devices can have one-time-programmable regions. Add a nvmem
> binding so they can be used as a nvmem provider.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../devicetree/bindings/mtd/mtd.yaml          | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
> index 321259aab0f6..2b852f91a6a9 100644
> --- a/Documentation/devicetree/bindings/mtd/mtd.yaml
> +++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
> @@ -21,6 +21,25 @@ properties:
>        based name) in order to ease flash device identification and/or
>        describe what they are used for.
>  
> +patternProperties:
> +  "^otp(-[0-9]+)?":

Needs '$' on the end.

> +    type: object
> +    $ref: ../nvmem/nvmem.yaml#
> +
> +    description: |
> +      An OTP memory region. Some flashes provide a one-time-programmable
> +      memory whose content can either be programmed by a user or is already
> +      pre-programmed by the factory. Some flashes might provide both.
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - mtd-user-otp
> +          - mtd-factory-otp
> +
> +    required:
> +      - compatible
> +
>  additionalProperties: true
>  
>  examples:
> @@ -36,4 +55,56 @@ examples:
>          };
>      };
>  
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        flash@0 {
> +            reg = <0>;
> +            compatible = "some,flash";

Soon (in linux-next, but off by default) this will be a warning for 
undocumented compatible string. Use a real device.

> +
> +            otp {
> +                compatible = "mtd-user-otp";
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +
> +                serial-number@0 {
> +                    reg = <0 16>;
> +                };
> +            };
> +        };
> +    };
> +
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        flash@0 {
> +            reg = <0>;
> +            compatible = "some,flash";
> +
> +            otp-1 {
> +                compatible = "mtd-factory-otp";
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +
> +                electronic-serial-number@0 {
> +                    reg = <0 8>;
> +                };
> +            };
> +
> +            otp-2 {
> +                compatible = "mtd-user-otp";
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +
> +                mac-address@0 {
> +                    reg = <0 6>;
> +                };
> +            };
> +        };
> +    };

The 2nd example is a superset of the 1st, so drop the first one.

Rob
