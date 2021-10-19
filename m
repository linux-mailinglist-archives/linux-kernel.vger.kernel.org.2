Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749D4432DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 08:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhJSGNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 02:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhJSGNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:13:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84D0060F25;
        Tue, 19 Oct 2021 06:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634623850;
        bh=Owmwksox9NtzQPLSYGWk+fB46QPT15T+JUlZ6m1mps0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L7btO8NhBH/y/NCDfgm1eBMaQsJFhDEPKM4zDiP1Cwi6gMu5138k1BTGyEO4qVd7s
         kZeA6UBb5lVaKKjK0fx1SwxLgRW9w9K0YWLnGk0iTVwVw/B4Y7+MOkJIYe844ltpvG
         Ifah+x0unL2gFTravdU5EJReOAKecU/yHtEJA1NqdY1cSg4XOalyDuGia0wfB0AMK5
         Kcwyuahzm1wsIetN9DAQFQVrAZZeP6GcjsCN8nqAVktVA3OpKdRu13gCQPKLjc8Qw9
         NgV2lFMS8pkndmXALVF/QEi3qEne00QDr9HgHgx0dHnEPNPxuTRpcMSVNqVMZxlwke
         PsyQoTX55RxUQ==
Date:   Tue, 19 Oct 2021 07:10:45 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Yu Chen <chenyu56@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: misc: add schema for USB hub on Kirin
 devices
Message-ID: <20211019071045.2bd410ab@sal.lan>
In-Reply-To: <f955e7dba47e2e96ca6bfe761a1f998e9b5a4c50.1632814787.git.mchehab+huawei@kernel.org>
References: <f955e7dba47e2e96ca6bfe761a1f998e9b5a4c50.1632814787.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Em Tue, 28 Sep 2021 09:40:06 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> From: Yu Chen <chenyu56@huawei.com>
> 
> This patch adds binding documentation to support USB HUB and
> USB data role switch of HiSilicon HiKey960 and HiKey970 boards.
> 
> [mchehab: updated OF schema and added HiKey970 example]
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Could you please review and apply this patch on your tree? It is the
only missing piece for USB to start working on HiKey 960/970.

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
