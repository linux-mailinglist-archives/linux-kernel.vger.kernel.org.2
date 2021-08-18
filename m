Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1BA3F0CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 22:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhHRUXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 16:23:44 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:50160
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230440AbhHRUXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 16:23:38 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id D512D40CCD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629318173;
        bh=fE7NLDipCnHNgaG7hgiU3VPpSuI2qMlYUF+GP5Dz8aM=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Tn2oDTLo9SvgY0dM9ykOSyXouMip6ojPhIBaehBMWUqnIvXDkod7Lnj3mxBFytOly
         zzEykJFDTGo5aUn4v3J7Sco24ViHM81Gaqq5AURUSiM7cM78LcpfP2edC9K0JbpTy6
         7MNd58fAogXieCie/XkT462Dw09bjU5w6Nywty3/ODn4kNre2svwCQ8MDFd9dDjxkl
         TyZwO3TVuzXeCsanMvn1dIFT/M+ZiFElSumd7BEduysIpM83i+NR1bFDrtOjxyqrDJ
         ObM6nKcQCioF0RfVTQHlVOJs4a+yjcQzu4De0lE9bMdw/NfDAPp8jBHqAUYOv5VPqz
         yz8B8nNUvsArQ==
Received: by mail-ej1-f71.google.com with SMTP id gb24-20020a170907961800b005c158d37301so298230ejc.17
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fE7NLDipCnHNgaG7hgiU3VPpSuI2qMlYUF+GP5Dz8aM=;
        b=ByFsREsoabfjYO0iahlhhYgtZXOqQjQEa/zdT5daOUjMud/ugP0o5xWug7n69+09SA
         SmvyOXbHDiagcYoVrXt3eqF2qn4vzMBY46kIVqlOCn9s+sCD0/89Efcmn0mQ3uEHaVsp
         SPeiFT/TJlLFobQkg9P5bZ5WOL0Rqr5s+u7uSwRUCGwfB4z7Ii05lHG/a3Mo6P3lY5wM
         ox5kchA7yj5ojPgkUaj9Ub4EVoD2MxCDMn8N9brQMr13NVtDOvujYatudam5CDQ+/ICk
         RYDB5cGxIzDWYMN+YCfdczkD/1hT39PE85bnWDGqRTa0b4186GBe4XHIX8GHuggob9T5
         7mCA==
X-Gm-Message-State: AOAM532SfsvdWMCoNip3uFMf29QbN8oriSUIXp7HXvIjsmn5hP1N4JtS
        VhG5weqCoFRH2xx4mKleUmp6n5nd7kwlBvD5Zttg8BuE37C/an+35ctrzSbkpFaAmNbtio+sp1I
        /fZKhM9fpnrGLQnPigkgQneXMGxpWuYlpkiy9zokpSw==
X-Received: by 2002:a17:906:410c:: with SMTP id j12mr11637779ejk.553.1629318173628;
        Wed, 18 Aug 2021 13:22:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeJzuMBqB7b9sIqDqFEqhBOuU1yBEb6TlSYNFdqGQ37BSNUKlANPlxbbqLVCAkjErlStBHMQ==
X-Received: by 2002:a17:906:410c:: with SMTP id j12mr11637766ejk.553.1629318173441;
        Wed, 18 Aug 2021 13:22:53 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id kz15sm329349ejc.103.2021.08.18.13.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 13:22:52 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: memory: convert H8/300 bus controller to
 dtschema
To:     Rob Herring <robh@kernel.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210818113325.85216-1-krzysztof.kozlowski@canonical.com>
 <YR1XvR50rcUBafts@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <16727dc7-7e8d-d070-fe46-895fb5c0f098@canonical.com>
Date:   Wed, 18 Aug 2021 22:22:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR1XvR50rcUBafts@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2021 20:55, Rob Herring wrote:
> On Wed, Aug 18, 2021 at 01:33:25PM +0200, Krzysztof Kozlowski wrote:
>> Convert H8/300 bus controller bindings to DT schema format using
>> json-schema.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../memory-controllers/renesas,h8300-bsc.txt  | 12 -------
>>  .../memory-controllers/renesas,h8300-bsc.yaml | 35 +++++++++++++++++++
>>  2 files changed, 35 insertions(+), 12 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.txt
>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.txt b/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.txt
>> deleted file mode 100644
>> index cdf406c902e2..000000000000
>> --- a/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.txt
>> +++ /dev/null
>> @@ -1,12 +0,0 @@
>> -* H8/300 bus controller
>> -
>> -Required properties:
>> -  - compatible: Must be "renesas,h8300-bsc".
>> -  - reg: Base address and length of BSC registers.
>> -
>> -Example.
>> -	bsc: memory-controller@fee01e {
>> -		compatible = "renesas,h8300h-bsc", "renesas,h8300-bsc";
>> -		reg = <0xfee01e 8>;
>> -	};
>> -
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.yaml
>> new file mode 100644
>> index 000000000000..70487bb685cb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.yaml
>> @@ -0,0 +1,35 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/memory-controllers/renesas,h8300-bsc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: H8/300 bus controller
>> +
>> +maintainers:
>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> +  - Yoshinori Sato <ysato@users.sourceforge.jp>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: renesas,h8300-bsc
>> +      - items:
>> +          - const: renesas,h8300h-bsc
>> +          - const: renesas,h8300-bsc
> 
> Seems what's actually in use is:
> 
> items:
>   - enum: 
>       - renesas,h8300h-bsc
>       - renesas,h8s-bsc
>   - const: renesas,h8300-bsc
> 

Indeed, I missed that one more compatible. I will send a v2, thanks for
feedback.


Best regards,
Krzysztof
