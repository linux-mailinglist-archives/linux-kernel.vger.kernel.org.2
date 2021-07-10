Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62333C3402
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 11:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhGJJpt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 10 Jul 2021 05:45:49 -0400
Received: from aposti.net ([89.234.176.197]:56276 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhGJJps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 05:45:48 -0400
Date:   Sat, 10 Jul 2021 10:42:53 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] dt-bindings: display/panel: Add Innolux EJ030NA
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net,
        Christophe Branchereau <cbranchereau@gmail.com>
Message-Id: <HBW0WQ.NHPOJDIT9XWR1@crapouillou.net>
In-Reply-To: <YOk60yTP9L1gT3+W@ravnborg.org>
References: <20210625121045.81711-1-paul@crapouillou.net>
        <YOk60yTP9L1gT3+W@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam, thanks for the review.

Le sam., juil. 10 2021 at 08:14:43 +0200, Sam Ravnborg 
<sam@ravnborg.org> a écrit :
> Hi Paul,
> 
> On Fri, Jun 25, 2021 at 01:10:44PM +0100, Paul Cercueil wrote:
>>  Add binding for the Innolux EJ030NA panel, which is a 320x480 3.0" 
>> 4:3
>>  24-bit TFT LCD panel with non-square pixels and a delta-RGB 8-bit
>>  interface.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   .../display/panel/innolux,ej030na.yaml        | 62 
>> +++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/display/panel/innolux,ej030na.yaml
>> 
>>  diff --git 
>> a/Documentation/devicetree/bindings/display/panel/innolux,ej030na.yaml 
>> b/Documentation/devicetree/bindings/display/panel/innolux,ej030na.yaml
>>  new file mode 100644
>>  index 000000000000..cda36c04e85c
>>  --- /dev/null
>>  +++ 
>> b/Documentation/devicetree/bindings/display/panel/innolux,ej030na.yaml
>>  @@ -0,0 +1,62 @@
>>  +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>  +%YAML 1.2
>>  +---
>>  +$id: 
>> http://devicetree.org/schemas/display/panel/innolux,ej030na.yaml#
>>  +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>  +
>>  +title: Innolux EJ030NA 3.0" (320x480 pixels) 24-bit TFT LCD panel
>>  +
>>  +description: |
>>  +  The panel must obey the rules for a SPI slave device as 
>> specified in
>>  +  spi/spi-controller.yaml
>>  +
>>  +maintainers:
>>  +  - Paul Cercueil <paul@crapouillou.net>
>>  +
>>  +allOf:
>>  +  - $ref: panel-common.yaml#
>>  +
>>  +properties:
>>  +  compatible:
>>  +    const: innolux,ej030na
>>  +
>>  +  backlight: true
>>  +  port: true
>>  +  power-supply: true
>>  +  reg: true
>>  +  reset-gpios: true
>>  +
>>  +required:
>>  +  - compatible
>>  +  - reg
>>  +  - power-supply
>>  +  - reset-gpios
>>  +
>>  +unevaluatedProperties: false
> I had expected:
> additionalProperties: false
> 
> With this fixed:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

I am not sure; the doc states that this (additionalProperties: false) 
"can't be used in case where another schema is referenced", which is 
the case here, as we include "panel-common.yaml".

Cheers,
-Paul

>>  +
>>  +examples:
>>  +  - |
>>  +    #include <dt-bindings/gpio/gpio.h>
>>  +
>>  +    spi {
>>  +        #address-cells = <1>;
>>  +        #size-cells = <0>;
>>  +
>>  +        panel@0 {
>>  +            compatible = "innolux,ej030na";
>>  +            reg = <0>;
>>  +
>>  +            spi-max-frequency = <10000000>;
>>  +
>>  +            reset-gpios = <&gpe 4 GPIO_ACTIVE_LOW>;
>>  +            power-supply = <&lcd_power>;
>>  +
>>  +            backlight = <&backlight>;
>>  +
>>  +            port {
>>  +                panel_input: endpoint {
>>  +                    remote-endpoint = <&panel_output>;
>>  +                };
>>  +            };
>>  +        };
>>  +    };
>>  --
>>  2.30.2


