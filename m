Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B19427AC1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 16:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhJIOOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 10:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbhJIOOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 10:14:24 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44783C061570;
        Sat,  9 Oct 2021 07:12:27 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id o4so17616508oia.10;
        Sat, 09 Oct 2021 07:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fYxvGux+YIH/Aqub7pVrD9hRMD1Jk0m9PUG/ERO3fQw=;
        b=Scw32G50T/215mJ0Id/LyJJ+TsK4os9pgw78ZKo1JVA6sQy1wTfZE7xkzzSC4a38qH
         gvcjqAr9rMxqTiPo9wN4/N8wMm2Dgw/MiEZ4N/9Jzm6KRxV+Le2II98yhZWrJRL910z6
         6ub8xXzlQDQIF2pqnpp2vzVNmBaNkRDylnaptMYdiM7hpWkMnOdsAEY7NXfAKesZ3via
         8Sm/ve32a0U8uJj16EZnqRDKQeYOXZdxLwbutidy2nGvLcg0a/PdpXx6XtRXWI7GHDWO
         XzlWKssQIO5cpmX3fE2FF/FV6QReuCzF3oWJDaEZUFQhSTpUT5IoefXrJXVOKVmjXbxT
         q89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fYxvGux+YIH/Aqub7pVrD9hRMD1Jk0m9PUG/ERO3fQw=;
        b=X8GMOjnaGzCYAsvp99OIgbXNZRhjcpHlPdQFAWkv4Xfc2Pe+Jp/c4vQT6tcgc5sNi/
         diA4F3PcheRDs3FqcV5nDTlSWno0zfnTVE0RsqG6dppsDjNYdaJKmq1wo/P7kymxX5fv
         ClWUYVMKH4OvB4m/ccjOTu8ADKwwqs56lGV3Q8VDGZk/bqpltrzrMjXQK5M2mAubQT7R
         fpu2M7SzX3qr+6eB2pOk9pcKjbvmV6GlqsTzrI/VB/oA3FnZK9x7wjQRE8eS2FNEr/WR
         XBLNOuu6mrVhZ4cNpRpXi6bwWsjX+zdE1TSTrjMlqVHzbiOnvhIqElBsfJgt73lUuRR4
         Yhng==
X-Gm-Message-State: AOAM532CIo5ZRTzysK2GtKHQSZdoM7aTJvJXGj4gP4aslLdMTLPOlUVm
        gk0Lrc4Md7tgpksn6x9zDJI3e+2UBnQ=
X-Google-Smtp-Source: ABdhPJwf+YwpDm7Q1ZqZCgWMWFve342OJkBptOMs3NoNNY2ok6Xpq0U66Cr0xizp2UZcegSic0mTLA==
X-Received: by 2002:aca:de83:: with SMTP id v125mr17299344oig.71.1633788746222;
        Sat, 09 Oct 2021 07:12:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f10sm455814ooh.42.2021.10.09.07.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 07:12:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: hwmon: Add nct7802 bindings
To:     Oskar Senft <osk@google.com>, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20211009025858.3326725-1-osk@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e22787cc-e3f0-39ae-df68-f222d74f081a@roeck-us.net>
Date:   Sat, 9 Oct 2021 07:12:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211009025858.3326725-1-osk@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/21 7:58 PM, Oskar Senft wrote:
> Document bindings for the Nuvoton NCT7802Y driver.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
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

Please use "channel".

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

