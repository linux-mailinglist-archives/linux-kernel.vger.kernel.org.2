Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC0E427E16
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 01:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhJIXsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 19:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhJIXsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 19:48:50 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE47C061570;
        Sat,  9 Oct 2021 16:46:53 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u69so6510554oie.3;
        Sat, 09 Oct 2021 16:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2wILuR247BAv3G9ZPIDL5c69UUwA6KLYz7TDBC2qPfE=;
        b=dBdaPv84AeKfKclXk2dA8+okXP9/NZcf+C6fqbIbWBgtVxgMGWBqRXoCDDd495uLyP
         5CZzkfHkzQ9lZmxynQDrNKY7njbeCsjgIBmNBZ48kzCWWESd5bUaLkJd7wBfNaPmdNNn
         LmrKowqa67wrOtva0bLchp/S+fyvcjLTpR5E+6I2roumeTLih6FNKZnZbkqkmVQWsEoY
         JDKysC8+uo6SLfVNXc4FLFI6WbDWj+0nv3Cmyb9hBjLxViDDXluSQQOdaPBobRwqVRon
         JG3XO63vtqs9BZwJo4jWPJgbvasEpzXDiW74Gl20V+NijTKWxlcokT6by5J3bPMWe3Ff
         ed2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2wILuR247BAv3G9ZPIDL5c69UUwA6KLYz7TDBC2qPfE=;
        b=I3eFzZi6QNodKu/ngzncPc8Z9t0Rs4KRFbVL7jugu8WctmyDTBXmS2ugF8VlFCU2uZ
         8zm3re9N+gSXmi2l9olPxtdq8adbzos3X68U2aCOqe597DS81Vk55/5uhMUZPZ2X7+uB
         9GbPeB4zlrz6KDkmL6I4veikH0OpsS+bG+naWWOfwLWVNzanJfH3k9zA7/i3fxmIOJ9Q
         DFWeTsNm865kZYXwHTBDoPXGkxUCd+KmjtSuJ9XJjlUkq2zCltXM5D99PH22pAokk74C
         fBdaxkJbVWi4z8dhSva8vMA2q7BWfj2Vm63MzWPeobFQuaS1/gO0u5alRU7jbOQtIjo/
         PTpQ==
X-Gm-Message-State: AOAM532Z+sVIO2VzxZ4xP1sTLSoUogFEMBk3NWZcO6V8fNBjq/6Jkixw
        G0P1rZfCgp5YbfMnlY1nuQVc4JWivxQ=
X-Google-Smtp-Source: ABdhPJx2hblAO4GbttJx9Yx5FiYOgbMWllPBe64aI38GmM/um12VznMhYmKSu89UZBF+QPUvPlR4Uw==
X-Received: by 2002:aca:c087:: with SMTP id q129mr22257958oif.135.1633823212421;
        Sat, 09 Oct 2021 16:46:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d18sm125098ook.14.2021.10.09.16.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 16:46:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add nct7802 bindings
To:     Oskar Senft <osk@google.com>, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20211009185257.2230013-1-osk@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b73b638e-5a24-4960-354d-c8ab5d61c387@roeck-us.net>
Date:   Sat, 9 Oct 2021 16:46:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211009185257.2230013-1-osk@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/21 11:52 AM, Oskar Senft wrote:
> This change documents the device tree bindings for the Nuvoton
> NCT7802Y driver.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> ---

change log goes here.

>   .../bindings/hwmon/nuvoton,nct7802.yaml       | 142 ++++++++++++++++++
>   1 file changed, 142 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> new file mode 100644
> index 000000000000..ff99f40034f2
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

Just noticed: 5 remote temperature sensors ? Shouldn't that be 3 ?

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
> +  channel@0:
> +    type: object
> +    description: Local Temperature Sensor ("LTD")
> +    properties:
> +      reg:
> +        const: 0
> +    required:
> +      - reg
> +
> +  channel@1:
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

If I understand correctly, "temperature-mode" is implemented as mandatory
for channels 1 and 2 if sensor-type is "temperature" (which makes sense).
No idea though if it is possible to express that in yaml.
If not, can it be mentioned as comment ?

> +
> +  channel@2:
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
> +  channel@3:
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
> +            channel@0 { /* LTD */
> +              reg = <0>;
> +              status = "okay";
> +            };
> +
> +            channel@1 { /* RTD1 */
> +              reg = <1>;
> +              status = "okay";
> +              sensor-type = "temperature";
> +              temperature-mode = "thermistor";
> +            };
> +
> +            channel@2 { /* RTD2 */
> +              reg = <2>;
> +              status = "okay";
> +              sensor-type = "temperature";
> +              temperature-mode = "thermal-diode";
> +            };
> +
> +            channel@3 { /* RTD3 */
> +              reg = <3>;
> +              status = "okay";
> +              sensor-type = "voltage";
> +            };
> +        };
> +    };
> 

