Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8B7336C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 07:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhCKGhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 01:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhCKGhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 01:37:17 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED2AC061760;
        Wed, 10 Mar 2021 22:37:17 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id f16so711952ljm.1;
        Wed, 10 Mar 2021 22:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rkUl4bL4Z7DgHnZybct6/BLTh4ZxrA3lKivu8PK+2QI=;
        b=f3qcanvEF1LN1YKHY6H2vlT/q1YtVAag+kxo3N1KAuotT4GHI9TLZKew984mF7l5A3
         BEZChTCiQHcRpaTH3hWlBYx/Hmej5K3hhB5yP2cSHududRuoYcTrrssqSzBGWUtrP9Ha
         xo1B/ekaUr65Elf7PpIY3V+uj6nnSRwUIb7pu72J5JNUkA6q4wD5az5lwKZOua9t+XMH
         bDwGLurh1sj2YE2tveQqQPYkTfoJT4BrE3QKf2CEhvMtSYODACRqdZGnroSvLL9yzmVx
         +6+iAoR5IUc6Om/eDF3ee0fSj9mg1qie3PgaXnlMBhKiNRRnZkBTq9Gkd8xG+lrt8CXm
         c7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rkUl4bL4Z7DgHnZybct6/BLTh4ZxrA3lKivu8PK+2QI=;
        b=tsNNj3LAsH4KCYi9kkvNA2CBz4PoN80/GExpdg4clnuWsmcuYrVh51tJREQUNcNX3S
         fu5evvt4ZuEnHLfBhF2Kpm4HgiaQEYwGeM1c5GqA4WZ4AhbqZ80R8d1v15u5zKSX+4nF
         jIaWH5M8RmsKuBxA/9o5ruFo2OQZlEzfGzHpry51RILRttcimNwuoaa+NuM5VcsaU0fL
         gYlWgU1vRT+/cTI8Da3eOedJRTUuYeFN6ESUhuVSBPioqbMNAxt9NqEuzQ6nHtEkVvEa
         IBf2HV6jXR+zSbabK0ZjfGx6qimCBxmEsv7SVixPNm2zdLTDegpfnMwvICRQ/Oyv7B5W
         9w/w==
X-Gm-Message-State: AOAM5315JGx4HEDu3AgrsSq4MtdaSMJSIDz2yzLEsuB4iXuAe0fNFYA7
        xYYykywDs0ydmfpSp2Bjz2MxIXVsKxQ=
X-Google-Smtp-Source: ABdhPJxk/USnHIUP+u2UTxk3wmttgYIJ3fJuHFSR6FpVpEU6hXIIM/uYblSNQUv6rrw3ttxdf3BdTQ==
X-Received: by 2002:a2e:a487:: with SMTP id h7mr3803393lji.447.1615444635933;
        Wed, 10 Mar 2021 22:37:15 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id p3sm531674lfg.14.2021.03.10.22.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 22:37:15 -0800 (PST)
Subject: Re: [PATCH v4 2/3] dt-bindings: mtd: Document use of nvmem-cells
 compatible
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210310210812.8880-1-ansuelsmth@gmail.com>
 <20210310210812.8880-2-ansuelsmth@gmail.com>
 <5d798266-3a18-d50d-9c3e-f91bc2460fe5@gmail.com>
 <YElMjg/AspNSRe0A@Ansuel-xps.localdomain>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <1d2ad735-ad15-be6a-ad90-9c33f5845a15@gmail.com>
Date:   Thu, 11 Mar 2021 07:37:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YElMjg/AspNSRe0A@Ansuel-xps.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.2021 23:47, Ansuel Smith wrote:
> On Wed, Mar 10, 2021 at 11:41:24PM +0100, Rafał Miłecki wrote:
>> See inline
>>
>> On 10.03.2021 22:08, Ansuel Smith wrote:
>>> Document nvmem-cells compatible used to treat mtd partitions as a
>>> nvmem provider.
>>>
>>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
>>> ---
>>>    .../bindings/mtd/partitions/nvmem-cells.yaml  | 96 +++++++++++++++++++
>>>    1 file changed, 96 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
>>> new file mode 100644
>>> index 000000000000..f70d7597a6b0
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
>>> @@ -0,0 +1,96 @@
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
>>
>> I think that when Rob wrote:
>>
>> On 10.03.2021 03:58, Rob Herring wrote:
>>> I think this should reference nvmem.yaml.
>>
>> he meant you using:
>>
>> allOf:
>>    - $ref: "nvmem.yaml#"
>>
>> (you'll need to adjust binding path).
>>
>> Please check how it's done in Documentation/devicetree/bindings/nvmem/*.yaml files
>>
>>
> 
> Aside from that, should I readd the old properties or I can keep the
> compatible as the only one required?

What old properties do you mean?

You shouldn't need to add anything to the list of "required" I think.

Some NVMEM providers add "#address-cells" and "#size-cells". That makes
sense if NVMEM provider must provide at least 1 cell. I'm not sure if we
need that for MTD.

Even "compatible" is actually redundant but most YAML files list it for
convenience. Source:

On 10.12.2020 03:48, Rob Herring wrote:
 > And drop 'compatible' as required. It's redundant anyways because the
 > schema will only be applied if compatible matches.

http://lists.infradead.org/pipermail/linux-mtd/2020-December/084574.html
https://patchwork.ozlabs.org/comment/2597326/
