Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955ED3385AC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhCLGPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCLGP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:15:27 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52648C061574;
        Thu, 11 Mar 2021 22:15:26 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id r3so35716117lfc.13;
        Thu, 11 Mar 2021 22:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EZVWmwhX2pG+tDiCjTNSv6TN+QB8CeRqfB+asPGPHpI=;
        b=FS1kweP/WxtwR2yRIB6sIRz98PuNHYJzq8betUFzi2IJhZLgiA34Vc3I19Pl2xlSR0
         NRglMIRmu9r1XIZ1httHY881Lz63AvFB43yBaC6P3f9lrNUozSD6AZw7s00fAnkIQL5g
         ZKzYJf2oQF5JRDk60Seoovgp8YLkyiMo7ty/5mc+bNZrfjwTFQdKL5iwKNz7aZPf56Ht
         Fdz8XTwNcGT1p263hmPR7yy/oZVyRGJZ4hKxsDFE3FbT/Pfhv8Ak7hZRq84x8q1nPMjT
         2L+hz5EeQ0gxGKosRrYAkb4PcKFn5VqjHPSvqSFze0aRZoGo6GaDgxaHXoRupDOY71fh
         pm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EZVWmwhX2pG+tDiCjTNSv6TN+QB8CeRqfB+asPGPHpI=;
        b=tUCUsiDc7d3NjWPonnL7znCRQBGXXOsItuGGEcpMW2rHrEoaoLhk0YXIh8BHzwMxJc
         2dbyIRXO7Y8IPHi9p+X2/Gc4JsUKSzJNNqVqeecJ23UwYo//mK6rK0y0oqrMtSWkeWjC
         gBWjz/CsRSDcUmzNuA6zG0EvehHHXui28Cq0bL+3g9VljpxMtwjU5VzDE0xXhGc48UYr
         F17AFY7gnyUcAGEWcoQ+8Nrfp0hYL3knFCPIfUgpGxAdE6RA6hDH/2LGimEEoZKHMylt
         4caP2c4X1XEMSr6xSW/UtzXAFNJH+f2rcNucUSVQKmqqpVqCbyNHlcuQ9R4l69CnbSTK
         wmBg==
X-Gm-Message-State: AOAM533g/wATbBGTyoOALYMS98r8iIJR3HsytG8WdscLxqs5mZGWHLUa
        nKs8iG5FVf5AvJH6omTEpKCKJ0FBWfo=
X-Google-Smtp-Source: ABdhPJyLShGezzluEkyC5PoAcMfkzzEGVbIGxtXQ8xZ079G3DlAHzbk5sjy6bmxfbR7MVeaOUjkTUQ==
X-Received: by 2002:a19:c217:: with SMTP id l23mr4401836lfc.506.1615529724892;
        Thu, 11 Mar 2021 22:15:24 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id m24sm1545384lfq.184.2021.03.11.22.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 22:15:24 -0800 (PST)
Subject: Re: [PATCH v5 2/3] dt-bindings: mtd: Document use of nvmem-cells
 compatible
To:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210311051309.16789-1-ansuelsmth@gmail.com>
 <20210311051309.16789-2-ansuelsmth@gmail.com>
 <20210311173221.GB866234@robh.at.kernel.org>
 <YEn18b9m5mHX8eO7@Ansuel-xps.localdomain>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <734a5493-5d79-1b51-1f17-ad9f35cc50ca@gmail.com>
Date:   Fri, 12 Mar 2021 07:15:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YEn18b9m5mHX8eO7@Ansuel-xps.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.2021 11:50, Ansuel Smith wrote:
> On Thu, Mar 11, 2021 at 10:32:21AM -0700, Rob Herring wrote:
>> On Thu, Mar 11, 2021 at 06:12:48AM +0100, Ansuel Smith wrote:
>>> Document nvmem-cells compatible used to treat mtd partitions as a
>>> nvmem provider.
>>>
>>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
>>> ---
>>>   .../bindings/mtd/partitions/nvmem-cells.yaml  | 99 +++++++++++++++++++
>>>   1 file changed, 99 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
>>> new file mode 100644
>>> index 000000000000..b53faf87d4e4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
>>> @@ -0,0 +1,99 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mtd/partitions/nvmem-cells.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Nvmem cells
>>> +
>>> +description: |
>>> +  Any partition containing the compatible "nvmem-cells" will register as a
>>> +  nvmem provider.
>>> +  Each direct subnodes represents a nvmem cell following the nvmem binding.
>>> +  Nvmem binding to declare nvmem-cells can be found in:
>>> +  Documentation/devicetree/bindings/nvmem/nvmem.yaml
>>> +
>>> +maintainers:
>>> +  - Ansuel Smith <ansuelsmth@gmail.com>
>>> +
>>> +allOf:
>>> +  - $ref: "../../nvmem/nvmem.yaml#"
>>
>> I'd rather have the 'absolute' path:
>>
>> /schemas/nvmem/nvmem.yaml
>>
>> Otherwise,
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>>
> 
> Should I send a v7?

Yes, please, let's make it the right way :)


When sending V7 please:

1. Include above "Reviewed-by" in the "dt-bindings: mtd: Document use of nvmem-cells compatible"

2. Include my "Tested-by" in the "mtd: core: add nvmem-cells compatible to parse mtd as nvmem cells"
Reference:
[PATCH v2 2/3] mtd: core: add nvmem-partitions compatible to parse mtd as nvmem cells
https://patchwork.ozlabs.org/project/linux-mtd/patch/20210216212638.28382-3-ansuelsmth@gmail.com/
