Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C96E3F0224
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 12:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbhHRLAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 07:00:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46784 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbhHRLAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 07:00:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17IAxCIo042549;
        Wed, 18 Aug 2021 05:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629284352;
        bh=zRdAjQFc8xrX9lMKppj7hduCAeHr51rMHVKsMC2OOAg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RU8QMRQJYL2IX+ST0MZImvxCGZBBFvnOJDAvh8Aqq4/xSrDRlhMCY5nv9dAPbmr7U
         S8a6bzrCV9xVIH048iKWMnX+bLqW48v/Hqi+Ye8nXDSYfSUQ1hhwI2im4GEx6xt66E
         jtN3SyP4Z0wJPMjMkBMI2iO74bEDB4qwhEwZ2QJs=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17IAxCfB127295
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Aug 2021 05:59:12 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 18
 Aug 2021 05:59:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 18 Aug 2021 05:59:11 -0500
Received: from [10.250.232.51] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17IAx9Pk115844;
        Wed, 18 Aug 2021 05:59:09 -0500
Subject: Re: [PATCH] dt-bindings: eeprom-93xx46: Convert to json schema\
To:     Rob Herring <robh@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210810064904.10846-1-a-govindraju@ti.com>
 <YRwSFdhUb9RT0wOZ@robh.at.kernel.org>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <4d57ab09-8091-bbb2-b455-3653a160fcd4@ti.com>
Date:   Wed, 18 Aug 2021 16:29:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRwSFdhUb9RT0wOZ@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 18/08/21 1:16 am, Rob Herring wrote:
> On Tue, Aug 10, 2021 at 12:18:59PM +0530, Aswath Govindraju wrote:
>> Convert eeprom-93xx46 binding documentation from txt to yaml format
> 
> Drop the trailing '\' in the subject.
> 
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>
>> Device tree fixes required are posted in the following patch,
>> https://lore.kernel.org/patchwork/project/lkml/list/?series=511477
>>

Thank you for review comments. I have made the required corrections and
posted v2[1] for this patch.

[1] - https://lore.kernel.org/patchwork/project/lkml/list/?series=512773

Thanks,
Aswath

>>
>>  .../bindings/misc/eeprom-93xx46.txt           | 29 --------
>>  .../bindings/misc/eeprom-93xx46.yaml          | 72 +++++++++++++++++++
>>  2 files changed, 72 insertions(+), 29 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
>>  create mode 100644 Documentation/devicetree/bindings/misc/eeprom-93xx46.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt b/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
>> deleted file mode 100644
>> index 72ea0af368d4..000000000000
>> --- a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
>> +++ /dev/null
>> @@ -1,29 +0,0 @@
>> -EEPROMs (SPI) compatible with Microchip Technology 93xx46 family.
>> -
>> -Required properties:
>> -- compatible : shall be one of:
>> -    "atmel,at93c46"
>> -    "atmel,at93c46d"
>> -    "atmel,at93c56"
>> -    "atmel,at93c66"
>> -    "eeprom-93xx46"
>> -    "microchip,93lc46b"
>> -- data-size : number of data bits per word (either 8 or 16)
>> -
>> -Optional properties:
>> -- read-only : parameter-less property which disables writes to the EEPROM
>> -- select-gpios : if present, specifies the GPIO that will be asserted prior to
>> -  each access to the EEPROM (e.g. for SPI bus multiplexing)
>> -
>> -Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
>> -apply.  In particular, "reg" and "spi-max-frequency" properties must be given.
>> -
>> -Example:
>> -	eeprom@0 {
>> -		compatible = "eeprom-93xx46";
>> -		reg = <0>;
>> -		spi-max-frequency = <1000000>;
>> -		spi-cs-high;
>> -		data-size = <8>;
>> -		select-gpios = <&gpio4 4 GPIO_ACTIVE_HIGH>;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/misc/eeprom-93xx46.yaml b/Documentation/devicetree/bindings/misc/eeprom-93xx46.yaml
>> new file mode 100644
>> index 000000000000..4254a7be5a70
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/eeprom-93xx46.yaml
>> @@ -0,0 +1,72 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/misc/eeprom-93xx46.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Microchip 93xx46 SPI compatible EEPROM family dt bindings
>> +
>> +maintainers:
>> +  - Cory Tusar <cory.tusar@pid1solutions.com>
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "@[0-9]+$"
> 
> Unless you want to define 'eeprom' as the correct node name, there's no 
> point in this. The unit address is checked by the spi bus schema and 
> it's also wrong here being decimal.
> 
>> +
>> +  compatible:
>> +    enum:
>> +      - atmel,at93c46
>> +      - atmel,at93c46d
>> +      - atmel,at93c56
>> +      - atmel,at93c66
>> +      - eeprom-93xx46
>> +      - microchip,93lc46b
>> +
>> +  data-size:
>> +    description: number of data bits per word
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [8, 16]
>> +
>> +  reg:
>> +    description: chip select of EEPROM
>> +    maxItems: 1
>> +
>> +  spi-max-frequency: true
>> +  spi-cs-high: true
>> +
>> +  read-only:
>> +    description:
>> +      parameter-less property which disables writes to the EEPROM
> 
> type: boolean.
> 
> 
>> +
>> +  select-gpios:
>> +    description:
>> +      specifies the GPIO that needs to be asserted prior to each access
>> +      of EEPROM (e.g. for SPI bus multiplexing)
>> +    maxItems: 1
>> +
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - data-size
>> +  - spi-max-frequency
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    spi0 {
> 
> spi {
> 
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      eeprom@0 {
>> +        compatible = "eeprom-93xx46";
>> +        reg = <0>;
>> +        spi-max-frequency = <1000000>;
>> +        spi-cs-high;
>> +        data-size = <8>;
>> +        select-gpios = <&gpio4 4 GPIO_ACTIVE_HIGH>;
>> +      };
>> +    };
>> -- 
>> 2.17.1
>>
>>

