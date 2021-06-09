Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758263A1631
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhFIN4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:56:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43712 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbhFIN4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:56:17 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lqyez-0001S8-Fj
        for linux-kernel@vger.kernel.org; Wed, 09 Jun 2021 13:54:21 +0000
Received: by mail-wm1-f72.google.com with SMTP id n2-20020a05600c3b82b02901aeb7a4ac06so2575584wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 06:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L3rkvmwfjekUneRXRJ0aT40FD356LXKwvvVxwz5Hwvk=;
        b=nx437aaMauqGtgfJd2JeOubDD+ivqQ/AlcaCyQoM4BG8DEMnofPTXGHOkMHLDI+MYQ
         sSqiJTfm5ZnntZcm+qoc2FAFkzsiT8MdhZMlyG9yyzBLB+4APKki0WjEr9d/qWF32adN
         pgSQimF9mvnuFseObZZZF8T0AgC51AtpREHdhx7ddVu+b68Q2yismbVddf6L4vsn8CxM
         3tXtXSv66cqzd7IG1CxTybZ1au9sNwS94EPBgjb/ZbLQEQvNz5vc5CIxErK6hpXGSPld
         O/dfHQLw7AFcy4nlH33GwXYVW2wTEBhXHDTDN56jzxnW8cXbAHwIT/aPnUDmWIRpuGIU
         8GBQ==
X-Gm-Message-State: AOAM532dJLj7hN9zD+WRcmVPgCV3L2j0mmzF0iR/MJBUa3l60stwWuQQ
        h4ZU51i/IlyAUQdsMuo/C8Z3LP3X1qq8pSmWads6ywU5GrDKpRMDv3eDhkfNRxrpa1jDAwy02NX
        6Mr8PMgOULJDNHIK+ywWM7Xw5Pv9QJbaJl6K1ClTmmA==
X-Received: by 2002:a5d:414e:: with SMTP id c14mr27402369wrq.81.1623246861233;
        Wed, 09 Jun 2021 06:54:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlqcTaglLFNTCB9cqtEDwTG5hLmt3Tt8ieHLTfWxVwsWTke/amqvrV4zq/JlmWDecShdF3mQ==
X-Received: by 2002:a5d:414e:: with SMTP id c14mr27402352wrq.81.1623246861068;
        Wed, 09 Jun 2021 06:54:21 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id z19sm6151400wmf.31.2021.06.09.06.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 06:54:20 -0700 (PDT)
Subject: Re: [PATCH v22 09/18] dt-binding: memory: pl353-smc: Convert to yaml
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        helmut.grohne@intenta.de, Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
 <20210609080112.1753221-10-miquel.raynal@bootlin.com>
 <e431d594-05cd-27b8-fcbe-11c310b99cd3@canonical.com>
 <20210609153410.53eadf8e@xps13>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <77db74d3-c44a-6aa3-1b61-f6bed565fa04@canonical.com>
Date:   Wed, 9 Jun 2021 15:54:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210609153410.53eadf8e@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2021 15:34, Miquel Raynal wrote:
> Hi Krzysztof,
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote on Wed, 9
> Jun 2021 14:12:40 +0200:
> 
>> On 09/06/2021 10:01, Miquel Raynal wrote:
>>> Convert this binding file to yaml schema.
>>>
>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>> ---
>>>  .../memory-controllers/arm,pl353-smc.yaml     | 133 ++++++++++++++++++
>>>  .../bindings/memory-controllers/pl353-smc.txt |  45 ------
>>>  2 files changed, 133 insertions(+), 45 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml b/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
>>> new file mode 100644
>>> index 000000000000..1de6f87d4986
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
>>> @@ -0,0 +1,133 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/memory-controllers/arm,pl353-smc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: ARM PL353 Static Memory Controller (SMC) device-tree bindings
>>> +
>>> +maintainers:
>>> +  - Miquel Raynal <miquel.raynal@bootlin.com>
>>> +  - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
>>> +
>>> +description:
>>> +  The PL353 Static Memory Controller is a bus where you can connect two kinds
>>> +  of memory interfaces, which are NAND and memory mapped interfaces (such as
>>> +  SRAM or NOR).
>>> +
>>> +# We need a select here so we don't match all nodes with 'arm,primecell'
>>> +select:
>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        enum:
>>> +          - arm,pl353-smc-r2p1  
>>
>> That's a const... but also I don't get the need for select.
> 
> I think this is needed to ensure this binding is not enforced against
> arm,primecell compatible nodes which are not featuring the
> arm,pl353-smc-r2p1 compatible.

Which seems to be result of unusual compatible match, so once you
convert to regular match, this select is not needed.

> 
>>
>>> +  required:
>>> +    - compatible
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    pattern: "^memory-controller@[0-9a-f]+$"
>>> +
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - arm,pl353-smc-r2p1
>>> +          - enum:
>>> +              - arm,primecell  
>>
>> This looks unusual. Basically you change the bindings, because before
>> they required "arm,pl353-smc-r2p1", "arm,primecell".
> 
> That is precisely what I try to match and I think it works. Perhaps
> this version is easier to extend when a new compatible comes in.
> However, I am fine using an alternative formula, like below if you
> think it's better:
> 
> compatible:
>   items:
>     - const: arm,pl353-smc-r2p1
>     - const: arm,primecell

That's the common, easiest and actually expected.

> 
>> Don't you want here items:
>>  - const: ...
>>  - const: ...
>> ?
>>
>>> +
>>> +  "#address-cells":
>>> +    const: 2
>>> +
>>> +  "#size-cells":
>>> +    const: 1
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: configuration registers for the host and sub-controllers  
>>
>> Just maxItems. Description is obvious.
> 
> I don't think it is that obvious because there are actually 4 areas
> and, because of the yaml language, we only describe one in the reg
> property while the others and defined in the ranges property, but
> that's fine by me, I'll drop the description and stick to a
> maxItems entry.

The explanation of all four areas could have sense, but now it states
the obvious - these are configuration registers :)

> 
>>
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: the clock for the memory device bus
>>> +      - description: the main clock of the controller  
>>
>> Isn't apb_pclk the bus clock (so second item below)?
> 
> The SMC has two clock domains referred as aclk and mclk. In the TRM,
> aclk is described as "Clock for the AXI domain". The AXI interface is
> used to trigger CMD/ADDR/DATA cycles on the memory bus. There is also
> an APB interface used to reach the SMC registers. I *think* that
> both APB and AXI domains are fed by the same apb_pclk source but I
> might be wrong. Hence memclk would just feed the memory bus that bonds
> the memory device (eg. the NAND flash) to the host controller.
> 
> This is my current understanding but if you think it works differently
> I'm all ears because this part is not 100% clear to me.

I was just wondering... your explanation is fine to me, thanks!


Best regards,
Krzysztof
