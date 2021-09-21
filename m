Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E4F413BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 22:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbhIUU4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 16:56:43 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:46661 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbhIUU4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 16:56:42 -0400
Received: by mail-ot1-f52.google.com with SMTP id c8-20020a9d6c88000000b00517cd06302dso271541otr.13;
        Tue, 21 Sep 2021 13:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=69dm8BDLapl9P/t0rby4XK6gfWV2C5uadFSV7i1cYzM=;
        b=gl1zbi5+6vy4Z49Q3plYCHY0YqQxiHFpz3fwXc/MgBGzj1f6nrQkT9Zvtlk4qwJQvA
         TG67c//hZbnEfZpaNtJVztgMqHxzt6x91tMHJ0B2aPAWzPGweS86mAf74f+I8ZXO/FiW
         p++EbFfdD1Un5ENakzByN6Y2/dbqHzczglk4+z4wSzFU+VokfM37XCVfgdMDkw3c7dCS
         9QEWbyEPHlr3Fi/Vi/E2rMlBxtytPN9lbFP0KOCYo2D11XzCPor2uLJ1XFWSyr4yNhHf
         DmWFcps4/BMWM5ex61YeiTli3wpA3dItsH1T/DioibEMBHfNsVsWrE2BGF3MGofT0GE+
         IQcA==
X-Gm-Message-State: AOAM533QLz0CXN4MtCnsh+2gslRYlhtWKGeNxPPEG4F2XjsCmVEkTNQa
        B0wT6NQQXFBKF4wQDUSUUPbnwHujEQ==
X-Google-Smtp-Source: ABdhPJxDUL85FLbj7VkHCOCNR5mH4uhn9qUzkzT5Q/P35S6nWC2k5rO41Iy5pfGPKgpPhInUfiDDpQ==
X-Received: by 2002:a05:6830:90e:: with SMTP id v14mr27984641ott.222.1632257713368;
        Tue, 21 Sep 2021 13:55:13 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-192-154-179-36.sw.biz.rr.com. [192.154.179.36])
        by smtp.gmail.com with ESMTPSA id r3sm33191oia.4.2021.09.21.13.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 13:55:12 -0700 (PDT)
Received: (nullmailer pid 3310346 invoked by uid 1000);
        Tue, 21 Sep 2021 20:55:11 -0000
Date:   Tue, 21 Sep 2021 15:55:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/3] dt-bindings: phy: phy-stm32-usbphyc: add
 st,phy-tuning optional property
Message-ID: <YUpGr5riT3+YpWDv@robh.at.kernel.org>
References: <20210914145256.243869-1-amelie.delaunay@foss.st.com>
 <20210914145256.243869-3-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914145256.243869-3-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 04:52:55PM +0200, Amelie Delaunay wrote:
> This patch adds the description of a new optional property for usbphyc phy

Looks like a lot more than a property.

> sub nodes. st,phy-tuning contains all phy tuning parameters to apply on the
> phy.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  .../bindings/phy/phy-stm32-usbphyc.yaml       | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
> index 3329f1d33a4f..0fa184ea54db 100644
> --- a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
> @@ -81,6 +81,60 @@ patternProperties:
>          properties:
>            vbus-supply: true
>  
> +      st,phy-tuning:
> +        $ref: /schemas/types.yaml#/definitions/phandle

Looks like a node to me (type: object). But why is a node needed here?

> +        description:
> +          It can be necessary to adjust the PHY settings to compensate parasitics, which can be due
> +          to USB connector/receptacle, routing, ESD protection component,... Here is the list of
> +          all optional parameters to tune the interface of the PHY (HS for High-Speed, FS for Full-
> +          Speed, LS for Low-Speed)
> +            * st,current-boost, <1> current boosting of 1mA
> +                                <2> current boosting of 2mA

Use standard unit suffix.

All these need to be a schema, not free form text.

> +            * st,no-lsfs-fb-cap, disables the LS/FS feedback capacitor
> +            * st,hs-slew-ctrl, slows the HS driver slew rate by 10%

Name the property such that it is self describing. 'slew control' 
doesn't say what it does to slew rate.

> +            * st,hs-dc-level, <0> = decreases the HS driver DC level by 5 to 7mV
> +                              <1> = increases the HS driver DC level by 5 to 7mV
> +                              <2> = increases the HS driver DC level by 10 to 14mV
> +            * st,fs-rftime-tuning, enables the FS rise/fall tuning option
> +            * st,hs-rftime-reduction, enables the HS rise/fall reduction feature
> +            * st,hs-current-trim, controls HS driver current trimming for choke
> +                                  <0> = 18.87 mA target current / nominal + 0%
> +                                  <1> = 19.165 mA target current / nominal + 1.56%
> +                                  <2> = 19.46 mA target current / nominal + 3.12%
> +                                  <3> = 19.755 mA target current / nominal + 4.68%
> +                                  <4> = 20.05 mA target current / nominal + 6.24%
> +                                  <5> = 20.345 mA target current / nominal + 7.8%
> +                                  <6> = 20.64 mA target current / nominal + 9.36%
> +                                  <7> = 20.935 mA target current / nominal + 10.92%
> +                                  <8> = 21.23 mA target current / nominal + 12.48%
> +                                  <9> = 21.525 mA target current / nominal + 14.04%
> +                                  <10> = 21.82 mA target current / nominal + 15.6%
> +                                  <11> = 22.115 mA target current / nominal + 17.16%
> +                                  <12> = 22.458 mA target current / nominal + 19.01%
> +                                  <13> = 22.755 mA target current / nominal + 20.58%
> +                                  <14> = 23.052 mA target current / nominal + 22.16%
> +                                  <15> = 23.348 mA target current / nominal + 23.73%
> +            * st,hs-impedance-trim, controls HS driver impedance tuning for choke
> +                                    <0> = no impedance offset
> +                                    <1> = reduces the impedance by 2 ohms
> +                                    <2> = reduces the impedance by 4 ohms
> +                                    <3> = reduces the impedance by 6 ohms
> +            * st,squelch-level, adjusts the squelch DC threshold value
> +                                <0> = no shift in threshold
> +                                <1> = threshold shift by +7 mV
> +                                <2> = threshold shift by -5 mV
> +                                <3> = threshold shift by +14 mV
> +            * st,hs-rx-gain-eq, enables the HS Rx gain equalizer
> +            * st,hs-rx-offset, adjusts the HS Rx offset
> +                               <0> = no offset
> +                               <1> = offset of +5 mV
> +                               <2> = offset of +10 mV
> +                               <3> = offset of -5 mV
> +            * st,no-hs-ftime-ctrl, disables the HS fall time control of single ended signals
> +                                   during pre-emphasis
> +            * st,no-lsfs-sc, disables the short circuit protection in LS/FS driver
> +            * st,hs-tx-staggering, enables the basic staggering in HS Tx mode
> +
>      allOf:
>        - if:
>            properties:
> @@ -122,6 +176,18 @@ examples:
>    - |
>      #include <dt-bindings/clock/stm32mp1-clks.h>
>      #include <dt-bindings/reset/stm32mp1-resets.h>
> +
> +    usb_phy_tuning: usb-phy-tuning {
> +        st,hs-dc-level = <2>;
> +        st,fs-rftime-tuning;
> +        st,hs-rftime-reduction;
> +        st,hs-current-trim = <15>;
> +        st,hs-impedance-trim = <1>;
> +        st,squelch-level = <3>;
> +        st,hs-rx-offset = <2>;
> +        st,no-lsfs-sc;
> +    };
> +
>      usbphyc: usbphyc@5a006000 {
>          compatible = "st,stm32mp1-usbphyc";
>          reg = <0x5a006000 0x1000>;
> @@ -137,6 +203,7 @@ examples:
>              reg = <0>;
>              phy-supply = <&vdd_usb>;
>              #phy-cells = <0>;
> +            st,phy-tuning = <&usb_phy_tuning>;

Just add all the properties here.

>              connector {
>                  compatible = "usb-a-connector";
>                  vbus-supply = <&vbus_sw>;
> @@ -147,6 +214,7 @@ examples:
>              reg = <1>;
>              phy-supply = <&vdd_usb>;
>              #phy-cells = <1>;
> +            st,phy-tuning = <&usb_phy_tuning>;
>          };
>      };
>  ...
> -- 
> 2.25.1
> 
> 
