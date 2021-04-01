Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51B4351A63
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhDASA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbhDARoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:44:20 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A61C0319C1;
        Thu,  1 Apr 2021 10:16:09 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so2726723otn.10;
        Thu, 01 Apr 2021 10:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pBHNevxyUCCPbFPV2Zb7KUDNOhpcn/AKmNJD00Mb8Us=;
        b=pHRqoUUn2yHtI6TXAo3BT4Zo/1ZUyAFKfF9fQpbiQVgJQmy2YCfAnNKnS8MsfYNFWi
         K09YlE2Y7XjxodJ6jYsduUXP9vMT+dK8AyTMovvnE9ftsfxQzStCM+kdLUb+sw1rngJx
         pqKswVRKG/nRxzTrEUqPEybeyb9U7FtDJsBbM6ziiiqbHmMmltIzr0Xi/RaaokdNsS3i
         4px6N/0JF3p44YnIEt08VCn1oSBtNmfDN43kZdJ0mRCiM35xhV7sdfQwteZzEFhECwIc
         WWwpR4JHIcX5MUPdJV93EDZJf7gh22ixAq7ryc3rgPCzRG6xOh+niFy+Ec/EPp3zzMCy
         AKdQ==
X-Gm-Message-State: AOAM530i9e4nr28vXY1VyljhhyMPWvdy1swaUd1gIuP+sdpRNUkzNEqo
        H7p4i05chikB64tveTQI0oIWDQr76g==
X-Google-Smtp-Source: ABdhPJybojyAep+/VfygtSasYn99v6AUw/im0YiAc5/r+Eqp0JZa+gc5R2fnimEZw/nSblOKAzbZow==
X-Received: by 2002:a9d:7481:: with SMTP id t1mr7796126otk.208.1617297366044;
        Thu, 01 Apr 2021 10:16:06 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f8sm1241470otp.71.2021.04.01.10.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 10:16:04 -0700 (PDT)
Received: (nullmailer pid 633945 invoked by uid 1000);
        Thu, 01 Apr 2021 17:16:03 -0000
Date:   Thu, 1 Apr 2021 12:16:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     cristian.birsan@microchip.com
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: usb: Add DT bindings for
 Microchip sama7g5 tcpc
Message-ID: <20210401171603.GA624021@robh.at.kernel.org>
References: <20210330205442.981649-1-cristian.birsan@microchip.com>
 <20210330205442.981649-2-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330205442.981649-2-cristian.birsan@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 11:54:41PM +0300, cristian.birsan@microchip.com wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> This patch adds DT bindings for the new Microchip USB Type-C Port
> Controller (TCPC) embedded in sama7g5 SoC.
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> ---
>  .../bindings/usb/microchip,sama7g5-tcpc.yaml  | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/microchip,sama7g5-tcpc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/microchip,sama7g5-tcpc.yaml b/Documentation/devicetree/bindings/usb/microchip,sama7g5-tcpc.yaml
> new file mode 100644
> index 000000000000..2d3289dd9ac9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/microchip,sama7g5-tcpc.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/microchip,sama7g5-tcpc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Microchip SAMA7G5 Type-C port controller bindings
> +
> +maintainers:
> +  - Cristian Birsan <cristian.birsan@microchip.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,sama7g5-tcpc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Peripheral Bus Clock
> +      - description: Generic Clock
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: gclk
> +
> +  vbus-supply:
> +    description: vbus power supply (5V) phandle

This belongs in the connector node unless this chip uses Vbus as a 
supply.

> +
> +  microchip,vbus-gpio:
> +    description: vbus detect gpio

We have standard property for this in the connector node.

> +
> +  connector:
> +    type: object
> +
> +    allOf:
> +      - $ref: ../connector/usb-connector.yaml

You can drop 'allOf'. And add:

       unevaluatedProperties: false

> +
> +    properties:
> +      compatible:
> +        const: usb-c-connector
> +
> +      power-role: true
> +
> +    required:
> +      - compatible
> +
> +required:
> +  - compatible
> +  - reg
> +  - connector
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/at91.h>
> +    #include <dt-bindings/usb/pd.h>
> +    tcpcb: tcpcb@e0844000 {
> +      compatible = "microchip,sama7g5-tcpc";
> +      reg = <0xe0844000 0x3fff>;
> +      clocks = <&pmc PMC_TYPE_PERIPHERAL 95>, <&pmc PMC_TYPE_GCK 95>;
> +      clock-names = "pclk", "gclk";
> +
> +      usb_con: connector {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        compatible = "usb-c-connector";
> +        label = "USB-C";
> +        data-role = "device";
> +        power-role = "sink";
> +        try-power-role = "sink";
> +        source-pdos = <PDO_FIXED(5000, 500,
> +            PDO_FIXED_USB_COMM)>;
> +        sink-pdos = <PDO_FIXED(5000, 500,
> +            PDO_FIXED_USB_COMM)>;
> +        op-sink-microwatt = <2500000>;
> +
> +        port@1 {
> +          reg = <1>;
> +          usb_con_hs: endpoint {
> +            remote-endpoint = <&usb_phy1>;
> +          };
> +        };
> +      };
> +    };
> +...
> -- 
> 2.25.1
> 
