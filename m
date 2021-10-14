Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1998242E00B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 19:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhJNR2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 13:28:54 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:47003 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhJNR2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 13:28:52 -0400
Received: by mail-oi1-f170.google.com with SMTP id o204so9353687oih.13;
        Thu, 14 Oct 2021 10:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aZhMJFR7qEIO7M61CFkCjB5kHmujnbdK6yv9W6S7EmM=;
        b=d2OQcKOCTFa3RsVoBf7T2NUXCKwa7JY9UcfMrGr2TNAFbeg7OZTes11XlshD/1FuO9
         EBnqvjfKUwQXs/0bCHf48ivjkFoAk/EZms0sqqEz7OJ4ZLl9DPjr0AEgcUYu03GqLgnf
         lOVHuj1mvxYsWhuF2kyW41vHw0NMF2Sas3wE8/HlH2jeyJgjw614BeDXEDTk1HYRTuu2
         BszL7GJKGzqdWfKD6aTu+byL8rJP+Y0sFbPbAWhXm9nHMzPYs3QdR5dgr99kLKVxRHft
         JYNyeVHem7wefeClSiyFwRHZP076fZLkC69V8qEuQu95hr84X+FbTz3gv5la6gScd5ur
         4t8w==
X-Gm-Message-State: AOAM531oFq/7Ol6bEPIL+qWp7A+ULxomTaJZv6toBtizCSgkCStN7XLp
        ELKYsPqtusKownfnJes6PA==
X-Google-Smtp-Source: ABdhPJzpW374h0wPKAjFh+UaJiw4S6Qg9dmeEbajDJXoaNMqM0XlLBMT14ZlD69a1wFChgOc8hrx3A==
X-Received: by 2002:aca:3656:: with SMTP id d83mr13912263oia.176.1634232407099;
        Thu, 14 Oct 2021 10:26:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bp21sm420799oib.31.2021.10.14.10.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:26:46 -0700 (PDT)
Received: (nullmailer pid 3584071 invoked by uid 1000);
        Thu, 14 Oct 2021 17:26:45 -0000
Date:   Thu, 14 Oct 2021 12:26:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 2/3] dt-bindings: phy: phy-stm32-usbphyc: add optional
 phy tuning properties
Message-ID: <YWhoVd/XR2SdAbXV@robh.at.kernel.org>
References: <20211005152453.89330-1-amelie.delaunay@foss.st.com>
 <20211005152453.89330-3-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005152453.89330-3-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 05:24:52PM +0200, Amelie Delaunay wrote:
> This patch adds the description of new optional phy tuning properties
> for usbphyc phy sub nodes.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
> Changes in v2:
> - st,phy-tuning property removed
> - tuning properties are now put directly in each child node
> - tuning properties are no more free form text and their name reworked
> ---
>  .../bindings/phy/phy-stm32-usbphyc.yaml       | 126 ++++++++++++++++++
>  1 file changed, 126 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
> index 3329f1d33a4f..c0f4dff2b8cb 100644
> --- a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
> @@ -81,6 +81,116 @@ patternProperties:
>          properties:
>            vbus-supply: true
>  
> +      # It can be necessary to adjust the PHY settings to compensate parasitics, which can be due
> +      # to USB connector/receptacle, routing, ESD protection component,... Here is the list of
> +      # all optional parameters to tune the interface of the PHY (HS for High-Speed, FS for Full-
> +      # Speed, LS for Low-Speed)
> +
> +      st,current-boost-milliamp:

Not a documented unit. Use '-microamp'.

> +        description: Current boosting in mA
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 1
> +        maximum: 2
> +
> +      st,no-lsfs-fb-cap:
> +        description: Disables the LS/FS feedback capacitor
> +        type: boolean
> +
> +      st,decrease-hs-slew-rate:
> +        description: Decreases the HS driver slew rate by 10%
> +        type: boolean
> +
> +      st,tune-hs-dc-level:
> +        description: Tunes the HS driver DC level

You need '|' after 'description:' to retain the formatting you have 
here.

> +          - <0> normal level
> +          - <1> increases the level by 5 to 7 mV
> +          - <2> increases the level by 10 to 14 mV
> +          - <3> decreases the level by 5 to 7 mV
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 3
> +        default: 0
> +
> +      st,enable-fs-rftime-tuning:
> +        description: Enables the FS rise/fall tuning option
> +        type: boolean
> +
> +      st,enable-hs-rftime-reduction:
> +        description: Enables the HS rise/fall reduction feature
> +        type: boolean
> +
> +      st,trim-hs-current:
> +        description: Controls HS driver current trimming for choke compensation
> +          - <0> = 18.87 mA target current / nominal + 0%
> +          - <1> = 19.165 mA target current / nominal + 1.56%
> +          - <2> = 19.46 mA target current / nominal + 3.12%
> +          - <3> = 19.755 mA target current / nominal + 4.68%
> +          - <4> = 20.05 mA target current / nominal + 6.24%
> +          - <5> = 20.345 mA target current / nominal + 7.8%
> +          - <6> = 20.64 mA target current / nominal + 9.36%
> +          - <7> = 20.935 mA target current / nominal + 10.92%
> +          - <8> = 21.23 mA target current / nominal + 12.48%
> +          - <9> = 21.525 mA target current / nominal + 14.04%
> +          - <10> = 21.82 mA target current / nominal + 15.6%
> +          - <11> = 22.115 mA target current / nominal + 17.16%
> +          - <12> = 22.458 mA target current / nominal + 19.01%
> +          - <13> = 22.755 mA target current / nominal + 20.58%
> +          - <14> = 23.052 mA target current / nominal + 22.16%
> +          - <15> = 23.348 mA target current / nominal + 23.73%
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 15
> +        default: 0
> +
> +      st,trim-hs-impedance:
> +        description: Controls HS driver impedance tuning for choke compensation
> +          - <0> = no impedance offset
> +          - <1> = reduce the impedance by 2 ohms
> +          - <2> = reduce the impedance by 4 ohms
> +          - <3> = reduce the impedance by 6 ohms
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 3
> +        default: 0
> +
> +      st,tune-squelch-level:
> +        description: Tunes the squelch DC threshold value
> +          - <0> = no shift in threshold
> +          - <1> = threshold shift by +7 mV
> +          - <2> = threshold shift by -5 mV
> +          - <3> = threshold shift by +14 mV
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 3
> +        default: 0
> +
> +      st,enable-hs-rx-gain-eq:
> +        description: Enables the HS Rx gain equalizer
> +        type: boolean
> +
> +      st,tune-hs-rx-offset:
> +        description: Adjusts the HS Rx offset
> +          - <0> = no offset
> +          - <1> = offset of +5 mV
> +          - <2> = offset of +10 mV
> +          - <3> = offset of -5 mV
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 3
> +        default: 0
> +
> +      st,no-hs-ftime-ctrl:
> +        description: Disables the HS fall time control of single ended signals during pre-emphasis
> +        type: boolean
> +
> +      st,no-lsfs-sc:
> +        description: Disables the short circuit protection in LS/FS driver
> +        type: boolean
> +
> +      st,enable-hs-tx-staggering:
> +        description: Enables the basic staggering in HS Tx mode
> +        type: boolean
> +
>      allOf:
>        - if:
>            properties:
> @@ -137,6 +247,14 @@ examples:
>              reg = <0>;
>              phy-supply = <&vdd_usb>;
>              #phy-cells = <0>;
> +            st,tune-hs-dc-level = <2>;
> +            st,enable-fs-rftime-tuning;
> +            st,enable-hs-rftime-reduction;
> +            st,trim-hs-current = <15>;
> +            st,trim-hs-impedance = <1>;
> +            st,tune-squelch-level = <3>;
> +            st,tune-hs-rx-offset = <2>;
> +            st,no-lsfs-sc;
>              connector {
>                  compatible = "usb-a-connector";
>                  vbus-supply = <&vbus_sw>;
> @@ -147,6 +265,14 @@ examples:
>              reg = <1>;
>              phy-supply = <&vdd_usb>;
>              #phy-cells = <1>;
> +            st,tune-hs-dc-level = <2>;
> +            st,enable-fs-rftime-tuning;
> +            st,enable-hs-rftime-reduction;
> +            st,trim-hs-current = <15>;
> +            st,trim-hs-impedance = <1>;
> +            st,tune-squelch-level = <3>;
> +            st,tune-hs-rx-offset = <2>;
> +            st,no-lsfs-sc;
>          };
>      };
>  ...
> -- 
> 2.25.1
> 
> 
