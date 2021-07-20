Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854E83CFC58
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbhGTNwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:52:18 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40254 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239498AbhGTNgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:36:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16KEG4Sl017139;
        Tue, 20 Jul 2021 09:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626790564;
        bh=1izAijwknd3Czt/bcb4ykqs+qHn6qPns0G130qgqFXA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PBLrDRvzn6uPsvvc+Z4pNLKr/glTXYbMRhClUC4If7NjKHKR+axy4VK4ImpwcIRKe
         iBaL79vTCZOQ5v2rvOQl4myYQjKT9YIf4GV9nF/5G4T1KtPSKIVOSLNdj/9cc2oc7D
         ixScLfosdIEv9xtU6CBGSM5JaUztpi8+cw5ZiiFA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16KEG4r3123199
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jul 2021 09:16:04 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 20
 Jul 2021 09:16:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 20 Jul 2021 09:16:03 -0500
Received: from [10.250.234.142] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16KEFxev072402;
        Tue, 20 Jul 2021 09:16:00 -0500
Subject: Re: [PATCH] dt-bindings: mtd: spi-nand: Convert to DT schema format
To:     Rob Herring <robh@kernel.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>
References: <20210718004125.733-1-a-nandan@ti.com>
 <20210719152413.GA1953551@robh.at.kernel.org>
From:   "Nandan, Apurva" <a-nandan@ti.com>
Message-ID: <8f51f347-54d9-d509-303c-d858b3d1896e@ti.com>
Date:   Tue, 20 Jul 2021 19:45:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210719152413.GA1953551@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19-Jul-21 8:54 PM, Rob Herring wrote:
> On Sun, Jul 18, 2021 at 12:41:25AM +0000, Apurva Nandan wrote:
>> Convert spi-nand.txt binding to YAML format with an added example.
>>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>  .../devicetree/bindings/mtd/spi-nand.txt      |  5 --
>>  .../devicetree/bindings/mtd/spi-nand.yaml     | 74 +++++++++++++++++++
>>  2 files changed, 74 insertions(+), 5 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
>>  create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.txt b/Documentation/devicetree/bindings/mtd/spi-nand.txt
>> deleted file mode 100644
>> index 8b51f3b6d55c..000000000000
>> --- a/Documentation/devicetree/bindings/mtd/spi-nand.txt
>> +++ /dev/null
>> @@ -1,5 +0,0 @@
>> -SPI NAND flash
>> -
>> -Required properties:
>> -- compatible: should be "spi-nand"
>> -- reg: should encode the chip-select line used to access the NAND chip
>> diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.yaml b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
>> new file mode 100644
>> index 000000000000..366b86e1b19c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
>> @@ -0,0 +1,74 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mtd/spi-nand.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SPI NAND flash
>> +
>> +maintainers:
>> +  - Apurva Nandan <a-nandan@ti.com>
>> +
>> +allOf:
>> +  - $ref: "mtd.yaml#"
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: spi-nand
> 
> Drop 'oneOf' as there is only one.
> 
>> +
>> +  reg:
>> +    items:
>> +      description:
>> +        should encode the chip-select line used to access the NAND chip
> 
> Just:
> 
> reg:
>   maxItems: 1
> 
>> +
>> +  spi-max-frequency: true
>> +  spi-rx-bus-width: true
>> +  spi-tx-bus-width: true
>> +
>> +  partitions:
>> +    type: object
>> +
>> +  '#address-cells': true
>> +  '#size-cells': true
>> +
>> +patternProperties:
>> +  # Note: use 'partitions' node for new users
>> +  '^partition@':
>> +    type: object
>> +
>> +  "^otp(-[0-9]+)?$":
>> +    type: object
>> +
>> +additionalProperties: false
> 
> Just do:
> 
> additionalProperties:
>   type: object
> 
> and then drop partitions, partition@, and ^otp(-[0-9]+)?$.
> 
>> +
>> +examples:
>> +  - |
>> +    spi {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        flash@6 {
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            compatible = "spi-nand";
>> +            reg = <0x6>;
>> +            spi-max-frequency = <42000000>;
>> +
>> +            partitions {
>> +                compatible = "fixed-partitions";
>> +                #address-cells = <1>;
>> +                #size-cells = <1>;
>> +
>> +                partition@0 {
>> +                    label = "boot";
>> +                    reg = <0 0x200000>;
>> +                };
>> +
>> +                partition@200000 {
>> +                    label = "rootfs";
>> +                    reg = <0x200000 0xce0000>;
>> +                };
>> +            };
>> +        };
>> +    };
>> -- 
>> 2.17.1
>>
>>

Agree with all the suggestions made, will correct and send v2.

Thanks,
Apurva Nandan
