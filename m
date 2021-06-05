Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7838A39C7E2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 13:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFELQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 07:16:52 -0400
Received: from relay06.th.seeweb.it ([5.144.164.167]:45663 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFELQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 07:16:50 -0400
Received: from [192.168.1.101] (83.6.168.161.neoplus.adsl.tpnet.pl [83.6.168.161])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 7191E3E913;
        Sat,  5 Jun 2021 13:15:00 +0200 (CEST)
Subject: Re: [PATCH 1/2] dt-bindings: Add SONY Synaptics JDI panel
To:     Rob Herring <robh@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210525113105.52990-1-konrad.dybcio@somainline.org>
 <20210604201841.GA3834184@robh.at.kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
Message-ID: <f68df9d6-7d17-12d0-5d4f-686482b9185e@somainline.org>
Date:   Sat, 5 Jun 2021 13:14:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210604201841.GA3834184@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +
>> +maintainers:
>> +  - Konrad Dybcio <konrad.dybcio@somainline.org>
>> +
>> +description: |+
> Do you need the formatting? If not, drop '|+'.

I'm not sure whether I do, so I guess dropping it is fine.


>> +  This panel seems to only be found in SONY Xperia
>> +  X, X Performance, X Compact, XZ and XZs
>> +  smartphones and we have no straightforward way of
>> +  actually getting the correct model number,
>> +  as no schematics are released publicly.
> Odd choice of line break length. 80 char please.

Right.


>> +
>> +  preset-gpio:
>> +    description: panel reset pin
> What's reset-gpios then?

reset-gpios is an overlook on my side :)


>> +
>> +  pvddio-gpio:
>> +    description: panel vddio pin
>> +
>> +  treset-gpio:
>> +    description: touch reset pin
> Use '-gpios'
>
> And need to define how many (maxItems: 1).

Right.



>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    dsi {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            panel: panel@0 {
>> +                    reg = <0>;
>> +
>> +                    pvddio-gpio = <&tlmm 51 GPIO_ACTIVE_HIGH>;
>> +                    preset-gpio = <&tlmm 8 GPIO_ACTIVE_HIGH>;
>> +                    treset-gpio = <&tlmm 89 GPIO_ACTIVE_HIGH>;
>> +
>> +                    vddio-supply = <&pm8994_s4>;
>> +                    avdd-supply = <&pm8994_l2>;
>> +                    tvdd-supply = <&panel_tvdd>;
>> +
>> +                    backlight = <&pmi8994_wled>;
>> +
>> +                    port {
>> +                      panel_in: endpoint {
>> +                        remote-endpoint = <&dsi0_out>;
>> +                      };
> Consistent indentation please. 4 spaces is good.

Another mistake, ack.


I'll send a v2 shortly.


Konrad

