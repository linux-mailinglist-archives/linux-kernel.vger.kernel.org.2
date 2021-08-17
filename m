Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768063EF07B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhHQQwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhHQQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:52:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C39C061764;
        Tue, 17 Aug 2021 09:52:18 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w5so39938931ejq.2;
        Tue, 17 Aug 2021 09:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TRXsHZES2DVeAZffLo0g6CHeWjHSwwEsvSttTLF0opY=;
        b=Oj8TfBSw0nR1udwocmRMy5LTA1CO/ql0IygaS0l38S5R8yh0DHR1jycGSypIMVoIeU
         tknFTc/Dc0f9aD2t0glUsZpH5L4qYRqpjp3auZoQJ4wifdBliFa2mvXUYnGmHkR8x5zE
         NStJFeeMYKUxwTB2F6hJtJLAgRbYKhZe+OfCYOYVZUdO2PGTX1krRQi2j4QHV5EiFC5o
         gKQreD/LkhF2TNW/m17OMAOfnWMDQcIlqcV20ASNjpGkYdcv0PTg98dAIfJ9Tu7I0WmM
         X6Lr6jocf9OJl06OHcSyD8L5SCd952cENZcRkURhFm7kX08gU1u8KlPIXDGhQRl6g9BE
         9GKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TRXsHZES2DVeAZffLo0g6CHeWjHSwwEsvSttTLF0opY=;
        b=gWHeDPOntIFMmfhXaf8//EgBX56K69XqG551qOEyybhQBKTtzcVbfkiyUUaWymDHWn
         ORgoobK+0HtxFR6maMBqHYLD6AK3z2I189NRCXlbdUX5vSz3uAQIQNV879CidOps5V4R
         h1u94r9+vHU8KSOtm6djaZTgEjOmXe/s881q3s6X9CBek15Fb+vZz3bDEUen/ZH6xkJT
         4vzvACqryf3E7HpImDYERdSZEBiqr9b7ivkElduzb85MnQEzRD9a8HX1j5yd11lFwtYB
         KMR8NYC/EwZLO14r3kFdfFLdirJiBmmRlv/AybEMGmCzTvNnezNpWw9yowPy1uNeCgzW
         nHKQ==
X-Gm-Message-State: AOAM532ygRvdnZLNsSqmIcegVle2wGi79V3NCvfj1KNno9NPaipkIv3v
        ijuA+pmlHmgMxvJ2VYfbIOYGaLsbf+4=
X-Google-Smtp-Source: ABdhPJy2AwPrcJG4REFLp9EWRiEjPVB9uvY4PcqHVViQmKOeV3+aoosl/oui2Stx9Rm7JX5vpfz/4g==
X-Received: by 2002:a17:907:20b6:: with SMTP id pw22mr5083209ejb.512.1629219137363;
        Tue, 17 Aug 2021 09:52:17 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r6sm1330826edq.20.2021.08.17.09.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 09:52:17 -0700 (PDT)
Subject: Re: [PATCH v2 2/8] dt-bindings: phy: phy-rockchip-inno-usb2: add
 rk3568 documentation
To:     Peter Geis <pgwipeout@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210812204116.2303617-1-pgwipeout@gmail.com>
 <20210812204116.2303617-3-pgwipeout@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <c7ff9234-cc3b-3679-bc63-73c5eb825269@gmail.com>
Date:   Tue, 17 Aug 2021 18:52:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812204116.2303617-3-pgwipeout@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Some comments. Have a look if it's useful.

On 8/12/21 10:41 PM, Peter Geis wrote:
> The rk3568 usb2phy node is a standalone node with a single muxed
> interrupt.
> Add documentation for it to phy-rockchip-inno-usb2.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  .../bindings/phy/phy-rockchip-inno-usb2.yaml  | 31 ++++++++++++++++---
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> index 5bebd86bf8b6..d2a749c3f9a3 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> @@ -18,6 +18,7 @@ properties:
>        - rockchip,rk3328-usb2phy
>        - rockchip,rk3366-usb2phy
>        - rockchip,rk3399-usb2phy
> +      - rockchip,rk3568-usb2phy
>        - rockchip,rv1108-usb2phy
>  
>    reg:
> @@ -50,6 +51,9 @@ properties:
>      description:
>        Phandle to the extcon device providing the cable state for the otg phy.
>  

> +  interrupts:
> +    description: Muxed interrupt for both ports
> +

This allows every Rockchip SoC dtsi to add an interrupt here.
You have only restricted the requirements.
The goal is to restrict things and filter bogus properties.
If it was done because it doesn't compile, maybe could you try/test/use
something like the rockchip-io-domain.yaml $defs format.

===

unevaluatedProperties: false

allOf:
  - $ref: "#/$defs/rk3568"

$defs:
  rk3568:
    if:
      properties:
        compatible:
          contains:
            const: rockchip,rk3568-usb2phy

    then:
      properties:
        interrupts:
          maxItems: 1

      required:
        - interrupts

    else:
      properties:
        host-port:
          properties:
            interrupts:
              description: host linestate interrupt

            interrupt-names:
              const: linestate

          required:
            - interrupts
            - interrupt-names

        otg-port:
          properties:

           interrupts:
             minItems: 1
             maxItems: 3

           interrupt-names:
             oneOf:
               - const: linestate
               - const: otg-mux
               - items:
                   - const: otg-bvalid
                   - const: otg-id
                   - const: linestate

          required:
            - interrupts
            - interrupt-names

>    rockchip,usbgrf:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> @@ -78,8 +82,6 @@ properties:
>  
>      required:
>        - "#phy-cells"

> -      - interrupts
> -      - interrupt-names

Also remove them as properties in this part when a separate $defs is used.

>  
>    otg-port:
>      type: object
> @@ -109,8 +111,6 @@ properties:
>  
>      required:
>        - "#phy-cells"

> -      - interrupts
> -      - interrupt-names

dito

>  
>  required:
>    - compatible
> @@ -120,6 +120,29 @@ required:
>    - host-port
>    - otg-port
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3568-usb2phy

> +      then:

Test "if then else" alignment with yamllint

> +        properties:
> +          interrupts:
> +            maxItems: 1
> +        required:
> +          - interrupts

> +      else:

alignment

> +        properties:
> +          host-port:
> +            required:
> +              - interrupts
> +              - interrupt-names
> +          otg-port:
> +            required:
> +              - interrupts
> +              - interrupt-names
> +

>  additionalProperties: false

additionalProperties does workn't with allOf: - $ref. Use
unevaluatedProperties.

>  
>  examples:
> 
