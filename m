Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1013A1640
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbhFIN7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:59:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43791 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbhFIN7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:59:02 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lqyhf-0001jr-C0
        for linux-kernel@vger.kernel.org; Wed, 09 Jun 2021 13:57:07 +0000
Received: by mail-wr1-f72.google.com with SMTP id s8-20020adff8080000b0290114e1eeb8c6so10801097wrp.23
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 06:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=94MTmrJjy+QuCQp+H85bF1V9qIA+ZZgrzOcpkBB5S9M=;
        b=SldcgeZNKNjjJf/Nb4l8Rr7fyqMN2+4Qki9nxCBbW0qYGhHwipQ1z2w/xIzEMixRNg
         uXbf9PXPG00TSvOnA/EwPOny1Il/FmBmIdXPFZwDP6b2kAexSsgqV9bRWSy5vZ02xgCu
         w91GBjrsa4c4b/PHZIpLmFwbGEtKfWjYGAwFOBH7Xa/5IjYGSP7DP+GeLn2ImLLQlEGn
         uDK/uHKJEaAQ8ZtQkdSpF433GxsK0ph1Y9jDDJouTgaAuQNHzGsd8+782jqnBAp5ZZnT
         PITDFfcbL6r273YKNogRjrxomfL+hcaLENRQVSyfYTQJhsH52OQCXDUsTDHI056wHdSx
         zaug==
X-Gm-Message-State: AOAM532GGFT4+8nwrTTHp2RuF5fmwkg4IiwF5Ad8ixh4BUsAPbYkiPvb
        GhDoGr1QnmJKV2TQtpacz1Fodb/if5ZuPrznO1k5g2ThUQOmbZ9e3olA7jeY8j6ARgDAoqUzvRM
        KUjfLot0bquxAoWkNKj9HZ665qa8Ot8ChMhrjhPFenA==
X-Received: by 2002:a05:600c:22cf:: with SMTP id 15mr28210711wmg.144.1623247026700;
        Wed, 09 Jun 2021 06:57:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnMkKQ1aeaiRBj9+JK4EwMsgwWT/6OvveUSFlZdu8TfcqICkeqyGjLL1rEQa6Dgw064GW83g==
X-Received: by 2002:a05:600c:22cf:: with SMTP id 15mr28210682wmg.144.1623247026518;
        Wed, 09 Jun 2021 06:57:06 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id q11sm23273791wrx.80.2021.06.09.06.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 06:57:06 -0700 (PDT)
Subject: Re: [PATCH v22 17/18] dt-bindings: mtd: pl353-nand: Describe this
 hardware controller
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        helmut.grohne@intenta.de, Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
 <20210609080112.1753221-18-miquel.raynal@bootlin.com>
 <57ef16cd-33e7-6c16-3a24-9634f47831b3@canonical.com>
 <20210609153621.1303bc4d@xps13>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <6fb9c0e4-43cb-d224-0ebe-568f62ac35b1@canonical.com>
Date:   Wed, 9 Jun 2021 15:57:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210609153621.1303bc4d@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2021 15:36, Miquel Raynal wrote:
> Hi Krzysztof,
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote on Wed, 9
> Jun 2021 14:01:10 +0200:
> 
>> On 09/06/2021 10:01, Miquel Raynal wrote:
>>> Add a yaml description of this NAND controller which is described as a
>>> subnode of the SMC bus.
>>>
>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>> ---
>>>  .../bindings/mtd/arm,pl353-nand-r2p1.yaml     | 57 +++++++++++++++++++
>>>  1 file changed, 57 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
>>> new file mode 100644
>>> index 000000000000..e72fa14b4385
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
>>> @@ -0,0 +1,57 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mtd/arm,pl353-nand-r2p1.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: PL353 NAND Controller device tree bindings
>>> +
>>> +allOf:
>>> +  - $ref: "nand-controller.yaml"
>>> +
>>> +maintainers:
>>> +  - Miquel Raynal <miquel.raynal@bootlin.com>
>>> +  - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:  
>>
>> That's not an enum, but simple const without items.
> 
> Ok.
> 
>>
>>> +          - arm,pl353-nand-r2p1
>>> +
>>> +  reg:
>>> +    items:
>>> +      - items:
>>> +          - description: CS with regard to the parent ranges property
>>> +          - description: Offset of the memory region requested by the device
>>> +          - description: Length of the memory region requested by the device  
>>
>> Doesn't it depend on parent's address/size cells?
> 
> Yes, but as the child nodes are not defined in the parent's binding
> (ie. the SMC) I think it's interesting to have them defined here, no?

The trouble is if parent decides to have different address/size cells.
The schema will stop matching. I am actually not that sure if such case
is real since the pl353 NAND part will usually be connected to pl353
SMC. However the schema now hard-codes specific dependency against
parent schema/node.

Rob,
Maybe you have here some thoughts?

Best regards,
Krzysztof
