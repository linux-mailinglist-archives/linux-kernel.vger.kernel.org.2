Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DE743A98D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 03:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbhJZBJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 21:09:22 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:26196 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbhJZBJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 21:09:20 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HdYXW3GdLz8tcK;
        Tue, 26 Oct 2021 09:05:31 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.125) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Tue, 26
 Oct 2021 09:06:51 +0800
Message-ID: <617754AB.60307@hisilicon.com>
Date:   Tue, 26 Oct 2021 09:06:51 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>
CC:     <linuxarm@huawei.com>, <mauro.chehab@huawei.com>,
        Yu Chen <chenyu56@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xuwei5@hisilicon.com>
Subject: Re: [PATCH v5] dt-bindings: misc: add schema for USB hub on Kirin
 devices
References: <f955e7dba47e2e96ca6bfe761a1f998e9b5a4c50.1632814787.git.mchehab+huawei@kernel.org>
In-Reply-To: <f955e7dba47e2e96ca6bfe761a1f998e9b5a4c50.1632814787.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On 2021/9/28 15:40, Mauro Carvalho Chehab wrote:
> From: Yu Chen <chenyu56@huawei.com>
> 
> This patch adds binding documentation to support USB HUB and
> USB data role switch of HiSilicon HiKey960 and HiKey970 boards.
> 
> [mchehab: updated OF schema and added HiKey970 example]
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Wei Xu <xuwei5@hisilicon.com>

Thanks!

Best Regards,
Wei

> ---
>  .../bindings/misc/hisilicon,hikey-usb.yaml    | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
> new file mode 100644
> index 000000000000..761ab686121a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 Linaro Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/hisilicon,hikey-usb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiKey960/970 onboard USB GPIO Hub
> +
> +maintainers:
> +  - John Stultz <john.stultz@linaro.org>
> +
> +description: |
> +  Supports the onboard USB GPIO hubs found on HiKey960/970.
> +  Such hubs require a power supply for the USB I/O. Depending on the
> +  exact hub model, after USB I/O is powered up, a reset should be needed.
> +
> +  It also acts as a role-switch intermediary to detect the state of
> +  the USB-C port, to switch the hub into dual-role USB-C or host mode,
> +  which enables and powers up the onboard USB-A host ports.
> +
> +  Schematics about such hubs can be found here:
> +    https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf
> +    https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-docs/files/hikey970-schematics.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - hisilicon,usbhub
> +
> +  typec-vbus-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: phandle to the typec-vbus gpio
> +
> +  otg-switch-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: phandle to the otg-switch gpio
> +
> +  hub-reset-en-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: phandle to the hub reset gpio
> +
> +  usb-role-switch:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Support role switch.
> +
> +  hub-vdd-supply:
> +    description: regulator for hub power
> +
> +  port:
> +    description: |
> +      describe hadware connections between USB endpoints.
> +      Two ports are supported: the first being the endpoint that will
> +      be notified by this driver, and the second being the endpoint
> +      that notifies this driver of a role switch.
> +
> +required:
> +  - compatible
> +  - hub-vdd-supply
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    usb-hub {
> +        compatible = "hisilicon,usbhub";
> +        typec-vbus-gpios = <&gpio25 2 GPIO_ACTIVE_HIGH>;
> +        otg-switch-gpios = <&gpio25 6 GPIO_ACTIVE_HIGH>;
> +        hub-reset-en-gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
> +        hub-vdd-supply = <&usb_hub_vdd>;
> +        usb-role-switch;
> +        port {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            usb_ep0: endpoint@0 {
> +                reg = <0>;
> +                remote-endpoint = <&dwc3_role_switch>;
> +            };
> +            usb_ep1: endpoint@1 {
> +                reg = <1>;
> +                remote-endpoint = <&rt1711h_ep>;
> +            };
> +        };
> +    };
> 

