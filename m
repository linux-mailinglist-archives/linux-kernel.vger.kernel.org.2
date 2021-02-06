Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34F2311CE9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 12:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBFLgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 06:36:10 -0500
Received: from mout.gmx.net ([212.227.17.21]:55059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhBFLgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 06:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612611259;
        bh=ZpgyLYmJaOE4lTDMQrVq9fNXCFhqyLDJONuM91srMtc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EhmuStoO5VcTztUWujyvt6jWLh7iDlwOo91/9aXm4zWU2j92gXBQOsQ6KM9EXFzLp
         hJn7JRKQBEU3mrP+yBblOoyTXt9m27fD7ckcNas7ICzAKH2IRTod0bHxqH8bIfQhXM
         tGRwj9fyOBvjYip4G0gdKoamStgjgLPXuYdAn+hM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.167] ([37.4.249.89]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Hdq-1l5ahF0t0k-002oPI; Sat, 06
 Feb 2021 12:34:19 +0100
Subject: Re: [RFC/PATCH 01/11] dt-bindings: soc: bcm: bcm2835-pm: Convert
 bindings to DT schema
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     phil@raspberrypi.com, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210205135249.2924-1-nsaenzjulienne@suse.de>
 <20210205135249.2924-2-nsaenzjulienne@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <9544381f-5741-ec5a-4169-15155b59aa57@gmx.net>
Date:   Sat, 6 Feb 2021 12:34:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205135249.2924-2-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:IeH+7DV3+7mHJnRl4VYd0ZTY0OsrnSBfkKv7F5d/0JCfA1w1fbg
 j+kkAzCFCFWMJD4/Jjw0DSmyP3rHNEvB0ZEc2IESRtL8E0gV0b37QuJk2jSBx3+ViNTFOtZ
 JgW1j2O8vw0IVuspHvIgpVsrgemg+iqnD1AkZtt1vU6CZ7fIBCcC+0xuu3RcRcvBA49S5Zy
 hrmBzVz398exQ7kqKmYsw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AAq40AOQCXA=:UoLjt60LTQpctOEgvmX+bF
 byi3JuaHZgStaZU17DcaUQAi/XFVvm1rpx3MRkZIG4n49O1Xg2GAvDg7fosJxqodF5glQK85l
 noaeRma7MdbgSZTfxAcUx75ziD8FRlQKlwzkst7w5vxwNvnp2tC3kXphfRF/hbFhzzjM1v3q9
 NIZmgRMffAJsiyDUSxljwaQW5NHrbbCQIqsp936omTdUm7+V4/lpniFvbyz5/BS1yLYWjG8C+
 3GK24MRtWD71H0RTEeMGrcegGej5TDTbt+4dV5sf2T/FZe6eCSEiSgdbPjsrwSbYbQgDbV5tI
 9IXoasP4ehfWHse3n7aCGIYbxB/uNqv+9GyBtfEP2JgTTS9SXCErdo64+OZhqTBxqR9ro6uTk
 uuFZHl+NFAMg36zy8ZDdtm/3QJpIxYmmFzBu9Osd/+b2JSYuf6GJJc97xGZvu+fcvLzIU3Pon
 eEADo9taN8QRsmp7nak4zYOb9TVJV5T55bSZgA0/T64SDz+yJUVgBYQ3+TlOrtOdAwDKS6j/+
 WOfg3Y85G64I2JGs/xhBr36x2Cu+eQMZVcTgxnitdb97Zy5SkZxO+KR1SKC2AboFn4P+a9MNW
 fBDDtc0KdpYS7Hlp/gDLvS0NzYPXbd2lCzPMED22eNksHGvxFT9VPuQwRpUTIJpXasTtj2C0J
 N/A3DQ23cSvGqG1Rv9odBV4jsVzr1iiLL77Bz8vSTKV07wbKtfr+ZJubvcq3wqmsrVS2k5gLL
 fG3n/i9JQsWc8Ly3hljnDjfNZ3poMUpYokV3Ezg27JUUaPCrtA1JKW25wJa82+5VDjLORhAP1
 oqBDKQwJfLsQ0qfMnSFC7O6K41IyNLQcQVBgbAz0Cb2kcasE5JqvmgKD5tOU34qQKT104dBt3
 hP73qke1DHT7C1FX8L+Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 05.02.21 um 14:52 schrieb Nicolas Saenz Julienne:
> This converts the brcm,bcm2835-pc bindings from text to proper schema.

s/bcm2835-pc/bcm2835-pm/

>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  .../bindings/soc/bcm/brcm,bcm2835-pm.txt      | 46 -----------
>  .../bindings/soc/bcm/brcm,bcm2835-pm.yaml     | 79 +++++++++++++++++++
>  2 files changed, 79 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
>
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
> deleted file mode 100644
> index 72ff033565e5..000000000000
> --- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -BCM2835 PM (Power domains, watchdog)
> -
> -The PM block controls power domains and some reset lines, and includes
> -a watchdog timer.  This binding supersedes the brcm,bcm2835-pm-wdt
> -binding which covered some of PM's register range and functionality.
> -
> -Required properties:
> -
> -- compatible:		Should be "brcm,bcm2835-pm"
> -- reg:			Specifies base physical address and size of the two
> -			  register ranges ("PM" and "ASYNC_BRIDGE" in that
> -			  order)
> -- clocks:		a) v3d: The V3D clock from CPRMAN
> -			b) peri_image: The PERI_IMAGE clock from CPRMAN
> -			c) h264: The H264 clock from CPRMAN
> -			d) isp: The ISP clock from CPRMAN
> -- #reset-cells: 	Should be 1.  This property follows the reset controller
> -			  bindings[1].
> -- #power-domain-cells:	Should be 1.  This property follows the power domain
> -			  bindings[2].
> -
> -Optional properties:
> -
> -- timeout-sec:		Contains the watchdog timeout in seconds
> -- system-power-controller: Whether the watchdog is controlling the
> -    system power.  This node follows the power controller bindings[3].
> -
> -[1] Documentation/devicetree/bindings/reset/reset.txt
> -[2] Documentation/devicetree/bindings/power/power-domain.yaml
> -[3] Documentation/devicetree/bindings/power/power-controller.txt
> -
> -Example:
> -
> -pm {
> -	compatible = "brcm,bcm2835-pm", "brcm,bcm2835-pm-wdt";
> -	#power-domain-cells = <1>;
> -	#reset-cells = <1>;
> -	reg = <0x7e100000 0x114>,
> -	      <0x7e00a000 0x24>;
> -	clocks = <&clocks BCM2835_CLOCK_V3D>,
> -		 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
> -		 <&clocks BCM2835_CLOCK_H264>,
> -		 <&clocks BCM2835_CLOCK_ISP>;
> -	clock-names = "v3d", "peri_image", "h264", "isp";
> -	system-power-controller;
> -};
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
> new file mode 100644
> index 000000000000..5e0555fc0666
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/bcm/brcm,bcm2835-pm.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: BCM2835 PM (Power domains, watchdog)
> +
> +description: |
> +  The PM block controls power domains and some reset lines, and includes a
> +  watchdog timer.
> +
> +maintainers:
> +  - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> +
> +allOf:
> +  - $ref: ../../watchdog/watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - brcm,bcm2835-pm
> +      - const: brcm,bcm2835-pm-wdt
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    description: Specifies base physical address and size of the two register
> +                 ranges, "PM" and "ASYNC_BRIDGE" in that order.
> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  clocks:
> +    minItems: 4
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: v3d
> +      - const: peri_image
> +      - const: h264
> +      - const: isp
> +
> +  system-power-controller:
> +    type: boolean
> +
> +  timeout-sec: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#power-domain-cells"
> +  - "#reset-cells"
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/bcm2835.h>
> +
> +    watchdog@0 {
Shouldn't the 0 been replaced by a register?
> +        compatible = "brcm,bcm2835-pm", "brcm,bcm2835-pm-wdt";
> +        #power-domain-cells = <1>;
> +        #reset-cells = <1>;
> +        reg = <0x7e100000 0x114>,
> +              <0x7e00a000 0x24>;
> +        clocks = <&clocks BCM2835_CLOCK_V3D>,
> +        	 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
> +        	 <&clocks BCM2835_CLOCK_H264>,
> +        	 <&clocks BCM2835_CLOCK_ISP>;
> +        clock-names = "v3d", "peri_image", "h264", "isp";
> +        system-power-controller;
> +    };
