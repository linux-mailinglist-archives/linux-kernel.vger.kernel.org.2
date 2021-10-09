Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E647D4277C8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 08:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhJIGkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 02:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhJIGkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 02:40:07 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0B2C061570;
        Fri,  8 Oct 2021 23:38:11 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id u20-20020a9d7214000000b0054e170300adso14229012otj.13;
        Fri, 08 Oct 2021 23:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yKoplyR7afwfmQLpDG7G94oI4vcD4x6/t29Mo4g9I5k=;
        b=CXtIaXqbe0r+I5WRQc3DTriZM/14KqOPCAZ/KxIPWQQCV7Ztntc9rR2lCwaQNC2kT1
         VyKVOXWOjxGjPZhMjhq/AaPPG/4MxXnQmsJuIvTnJQP/IS8I9cug5yhtqAMW8sph0T3O
         priq0DKBo3JLYRcfl7Wt3cOLqyVqEa3jmjLE+tLRgvHXyJSZFdnVrqK45n5O/8hKMDjz
         x1RmmMCM2QGtB8XQKzlFd0xtJRe6paKdWPiGhsfQ6i3qKQkXAiPOBfE5g/4piX0LEja6
         L7D4bg27QNg3rVQXpU1bLOb9/mShSFifDBgRWW6fVIdNZuYyi30wIL4ZEt5R31pTEBAU
         gDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yKoplyR7afwfmQLpDG7G94oI4vcD4x6/t29Mo4g9I5k=;
        b=H+71fnq/v33RlDUPN40l2TgUvffG3IQ7jce6iztBJZTV7H2dHNvgUart/4Ks6Wmiml
         FMXZq4vtRGblxVjJom6SZXxdSo8qk0qFls8iIaV6fg9o0vxuz1VFCmsgzEM386QMDu/n
         cm/mmhVm1xzde+i+ImUEfGI6uAaRCkWGWs8MEkwD5fh7nTZiHpVzfRim97g1wzbHRS1U
         ldGWTWa3Isz2Ty3VBhXNErfZfUomoKGciIEsU8eyw+nVbt5PPUT2J/hP/JMtSRbSHOw7
         JULcY75VdlfIk2dsz6ZOmFBbbrmb/TbbwTvAMiZniihVyeY7V4MvHa9wQqv+7K/aHjAK
         xSVQ==
X-Gm-Message-State: AOAM53396tL+k8CscE/szpcWjvu2KdeUwTBer57fNYE0IlkuVK8syxat
        UuG44va+KKcCAvWu5+9m5fyzfhSR6nk=
X-Google-Smtp-Source: ABdhPJxpVWFUMkEBwmuyrlGI5xvsqeIia2XIh4LAOUrlIwX3nAgfG5qExvYCQT3we6w997mQQ5nO0w==
X-Received: by 2002:a9d:1b41:: with SMTP id l59mr12351768otl.283.1633761490393;
        Fri, 08 Oct 2021 23:38:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u26sm378384oic.51.2021.10.08.23.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 23:38:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add nct7802 bindings
To:     Oskar Senft <osk@google.com>, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20211009024430.3322230-1-osk@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <089c590f-5b35-8a2a-6132-d8d3e2695c15@roeck-us.net>
Date:   Fri, 8 Oct 2021 23:38:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211009024430.3322230-1-osk@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oskar,

On 10/8/21 7:44 PM, Oskar Senft wrote:
> Document bindings for the Nuvoton NCT7802Y driver.
> 
> Signed-off-by: Oskar Senft <osk@google.com>

Please pdon't expect from reviewers to figure out what changed
between versions and provide change logs.

Thanks,
Guenter

> ---
>   .../bindings/hwmon/nuvoton,nct7802.yaml       | 142 ++++++++++++++++++
>   1 file changed, 142 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> new file mode 100644
> index 000000000000..a97b89d0d197
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> @@ -0,0 +1,142 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/nuvoton,nct7802.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NCT7802Y Hardware Monitoring IC
> +
> +maintainers:
> +  - Guenter Roeck <linux@roeck-us.net>
> +
> +description: |
> +  The NCT7802Y is a hardware monitor IC which supports one on-die and up to
> +  5 remote temperature sensors with SMBus interface.
> +
> +  Datasheets:
> +    https://www.nuvoton.com/export/resource-files/Nuvoton_NCT7802Y_Datasheet_V12.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,nct7802
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  input@0:
> +    type: object
> +    description: Local Temperature Sensor ("LTD")
> +    properties:
> +      reg:
> +        const: 0
> +    required:
> +      - reg
> +
> +  input@1:
> +    type: object
> +    description: Remote Temperature Sensor or Voltage Sensor ("RTD1")
> +    properties:
> +      reg:
> +        const: 1
> +      sensor-type:
> +        items:
> +          - enum:
> +              - temperature
> +              - voltage
> +      temperature-mode:
> +        items:
> +          - enum:
> +              - thermistor
> +              - thermal-diode
> +    required:
> +      - reg
> +      - sensor-type
> +
> +  input@2:
> +    type: object
> +    description: Remote Temperature Sensor or Voltage Sensor ("RTD2")
> +    properties:
> +      reg:
> +        const: 2
> +      sensor-type:
> +        items:
> +          - enum:
> +              - temperature
> +              - voltage
> +      temperature-mode:
> +        items:
> +          - enum:
> +              - thermistor
> +              - thermal-diode
> +    required:
> +      - reg
> +      - sensor-type
> +
> +  input@3:
> +    type: object
> +    description: Remote Temperature Sensor or Voltage Sensor ("RTD3")
> +    properties:
> +      reg:
> +        const: 3
> +      sensor-type:
> +        items:
> +          - enum:
> +              - temperature
> +              - voltage
> +    required:
> +      - reg
> +      - sensor-type
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        nct7802@28 {
> +            compatible = "nuvoton,nct7802";
> +            reg = <0x28>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            input@0 { /* LTD */
> +              reg = <0>;
> +              status = "okay";
> +            };
> +
> +            input@1 { /* RTD1 */
> +              reg = <1>;
> +              status = "okay";
> +              sensor-type = "temperature";
> +              temperature-mode = "thermistor";
> +            };
> +
> +            input@2 { /* RTD2 */
> +              reg = <2>;
> +              status = "okay";
> +              sensor-type = "temperature";
> +              temperature-mode = "thermal-diode";
> +            };
> +
> +            input@3 { /* RTD3 */
> +              reg = <3>;
> +              status = "okay";
> +              sensor-type = "voltage";
> +            };
> +        };
> +    };
> 

