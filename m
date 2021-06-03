Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E9D3998B9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 05:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFCDxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 23:53:07 -0400
Received: from phobos.denx.de ([85.214.62.61]:34552 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbhFCDxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 23:53:06 -0400
Received: from [192.168.1.107] (89-186-114-252.pool.digikabel.hu [89.186.114.252])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hs@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4738E82EF0;
        Thu,  3 Jun 2021 05:51:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1622692281;
        bh=4S9DeOsSgwurt2vIIEPZv87f5Sw8LTYLBFnrrwtmmDM=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oZ/VbwbAk/VL4P9sL/k3wxmJhSAm8lQ4OOtqc30hujze/iYXWP9h8Iwz1CDIq8VPl
         MLCTEJMpg3qxVGdP3tuqww6SawMrpFil1LiDn8af1zs+ibdrND7fKwD7Rxl4MoRAc0
         prOkUcfqQVIsRnLdCbFIEDjlB6HyRClPjFxFjQLdY/LVITQW2ECHwukQOV3xhXW9+H
         6yRXQ0z9fhJtQJW8QGggGCH26uyqxlGzSXS3numNwHv2w0YeoVgFe4fzjDVIHme9S+
         h1FcERx6W/xO0e4u2Dvblt4CpuJaOGfqsc8I8kFTPqa2sGUKmrCqg9e6WvJW82Upq6
         X59SDVn62P2kg==
Reply-To: hs@denx.de
Subject: Re: [PATCH v3 1/2] mtd: devices: add devicetree documentation for
 microchip 48l640
To:     Rob Herring <robh@kernel.org>
Cc:     linux-mtd@lists.infradead.org, Fabio Estevam <festevam@denx.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210601043546.1345704-1-hs@denx.de>
 <20210601043546.1345704-2-hs@denx.de>
 <20210602192950.GA3827845@robh.at.kernel.org>
From:   Heiko Schocher <hs@denx.de>
Message-ID: <452d7f47-9272-9b93-7eb1-394242ca6ad7@denx.de>
Date:   Thu, 3 Jun 2021 05:51:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210602192950.GA3827845@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.102.4 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On 02.06.21 21:29, Rob Herring wrote:
> On Tue, Jun 01, 2021 at 06:35:45AM +0200, Heiko Schocher wrote:
>> The Microchip 48l640 is a 8KByte EERAM connected via SPI.
>> Add devicetree bindings documentation.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>>
>> Changes in v3:
>> Add Fabio to cc
>>
>> Changes in v2:
>> as Rob helped, fix warnings from running command
>> 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>
>>  .../bindings/mtd/microchip,mchp48l640.yaml    | 45 +++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml b/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
>> new file mode 100644
>> index 0000000000000..08089f2db0761
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/mtd/microchip,mchp48l640.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: MTD SPI driver for Microchip 48l640 (and similar) serial EERAM
> 
> This is not the driver.

Ok, I would change to:

title: Microchip 48l640 (and similar) serial EERAM bindings

ok?

>> +
>> +maintainers:
>> +  - Heiko Schocher <hs@denx.de>
>> +
>> +description: |
>> +  The Microchip 48l640 is a 8KByte EERAM connected via SPI.
>> +
>> +  datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/20006055B.pdf
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: microchip,48l640
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  spi-max-frequency: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    spi {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      spi-eeram@0 {
> 
> eeram@0

changed.

> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for your time!

I would wait with a v4 if I get comments for the driver
(or wait some time...)

>> +        compatible = "microchip,48l640";
>> +        reg = <0>;
>> +        spi-max-frequency = <20000000>;
>> +      };
>> +    };
>> +...
>> -- 
>> 2.31.1

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
