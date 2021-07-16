Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB963CB622
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238546AbhGPKhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:37:31 -0400
Received: from mx.socionext.com ([202.248.49.38]:24038 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230287AbhGPKhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:37:22 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 16 Jul 2021 19:34:27 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 555CE208E6F5;
        Fri, 16 Jul 2021 19:34:27 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 16 Jul 2021 19:34:27 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 0966EB631E;
        Fri, 16 Jul 2021 19:34:27 +0900 (JST)
Received: from [10.212.246.227] (unknown [10.212.246.227])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id D6BD7B1D52;
        Fri, 16 Jul 2021 19:34:21 +0900 (JST)
Subject: Re: [PATCH] dt-bindings: nvmem: Convert UniPhier eFuse bindings to
 json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>
References: <1624413058-17338-1-git-send-email-hayashi.kunihiko@socionext.com>
 <20210714185922.GA2857803@robh.at.kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <f6b8adf4-b3bc-61e6-612e-2d662746afbf@socionext.com>
Date:   Fri, 16 Jul 2021 19:34:16 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714185922.GA2857803@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
Thank you for checking.

On 2021/07/15 3:59, Rob Herring wrote:
> On Wed, Jun 23, 2021 at 10:50:58AM +0900, Kunihiko Hayashi wrote:
>> Convert the UniPhier eFuse binding to DT schema format.
>>
>> Cc: Keiji Hayashibara <hayashibara.keiji@socionext.com>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../bindings/nvmem/socionext,uniphier-efuse.yaml   | 109 +++++++++++++++++++++
>>   .../devicetree/bindings/nvmem/uniphier-efuse.txt   |  49 ---------
>>   2 files changed, 109 insertions(+), 49 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
>> new file mode 100644
>> index 0000000..e03c1ed
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
>> @@ -0,0 +1,109 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/nvmem/socionext,uniphier-efuse.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Socionext UniPhier eFuse bindings
>> +
>> +maintainers:
>> +  - Keiji Hayashibara <hayashibara.keiji@socionext.com>
>> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> +
>> +allOf:
>> +  - $ref: "nvmem.yaml#"
>> +
>> +properties:
>> +  "#address-cells": true
>> +  "#size-cells": true
>> +
>> +  compatible:
>> +    const: socionext,uniphier-efuse
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +patternProperties:
>> +  "^.*@[0-9a-f]+,[0-9]+$":
> 
> nvmem.yaml has a different definition. Though it doesn't handle
> overlapping addresses. You should extend nvmem.yaml like you have here.
> The last part should be optional though.

I understand. I'll try to expand the optional pattern to nvmem.yaml.

>> +    type: object
>> +
>> +    properties:
>> +      reg:
>> +        maxItems: 1
>> +
>> +      bits:
>> +        maxItems: 1
>> +
>> +    required:
>> +      - reg
> 
> All this is already defined in nvmem.yaml.

I see. I'll remove them.

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
> 
> Use 'unevaluatedProperties: false' and then you don't need to redefine
> anything common here.

Okay, I'll use this keyword for that.

Thank you,

---
Best Regards
Kunihiko Hayashi
