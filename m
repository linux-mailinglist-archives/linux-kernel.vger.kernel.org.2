Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883173F7573
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 14:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbhHYM5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 08:57:39 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33940
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240078AbhHYM5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:57:38 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8D2F540793
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 12:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629896212;
        bh=J/tSZXGbbVX7jq/a3ssqSdjqxH4DgxG+yQPijZgaVeg=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=qK2zxW07oVUKSM30tMetlfFFQwiZPNf97uO/7VTd0LhNpmwCFPcnc41KtXGAORyvF
         Y1m8423oIma0suhOOt7MisvPqmUuNOiwEOpKbfdeYUWPbMkJ5UcdUm1lAUvJ8vqOrV
         rgpztMO2/x5KFrKh3u3s41Whcrf+dVHhRCeSuspNWncgDlq7d5wnJ/M69r8NPNxA1W
         d268r00obI0K22jFuBp1I3SKUuBRLh5wpWnkbaJ3wrHIQ3yK+l6C/Rcy5UX0RaVrWC
         ikt6fu/YaMmHqdLX89P1VNjzm8lPnaZ7ovMgnxYcrKuyQ7NNnfp09YHntZYorIXn4W
         EumEt8LAXnanw==
Received: by mail-wr1-f72.google.com with SMTP id h14-20020a056000000e00b001575b00eb08so1981981wrx.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 05:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J/tSZXGbbVX7jq/a3ssqSdjqxH4DgxG+yQPijZgaVeg=;
        b=cdVNcirbYRT/ickadq4MHeU8WbCG8smWgFLCbdu+wFhcDDwgZfpsxPDNJHyysQn6hn
         hziyQ91ysfdpFigbxXAMx9MUNoDDh8IjqBCRT2diccP6buDT5nJxVVOpoLNLyuYc1Qj+
         Ir+7c/CWY0hAV7PIL2DDA023TXc3mNvoEg+EZ/CHtJizfvZuUXeQ7bCF9DAsPysifkCt
         OavDhCjqsaDo9yNJ4YD/JVHW9oOEmNR1Y3ACHhvnNnTk9o7GbTt2VbKyRy7tpZBUixYr
         RoKWMAyXdmuXmoCdFfo+pbdpcgQUMuSut4PHHflXhnLSAJOQyLISF3TsGg/M5vSlD9Y6
         rZ7w==
X-Gm-Message-State: AOAM530Qayr9ObtIbPKf/FfqCyvd1KckA/x+XvlAFFUS1+jou2IU/xhL
        Od0jZp+kVR6aEEVXx8ONoqv6w1NGnheSgAnWEu+LPBmUJtkGDvj+INcL0whTNDnOym1k4M1ED5t
        eh50REN59uaVtx0KRsuh2YB3XE2hgBSwUhrBnNVNPrg==
X-Received: by 2002:a1c:2702:: with SMTP id n2mr9151059wmn.78.1629896212258;
        Wed, 25 Aug 2021 05:56:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx19exlQXFyThlRhadSTOudioZ5LJmmgmFwb5+25rV2AcBZRK30aXzWxi2nBrwdS83mcw53+g==
X-Received: by 2002:a1c:2702:: with SMTP id n2mr9151037wmn.78.1629896212095;
        Wed, 25 Aug 2021 05:56:52 -0700 (PDT)
Received: from [192.168.0.103] ([79.98.113.15])
        by smtp.gmail.com with ESMTPSA id k18sm5294991wmi.25.2021.08.25.05.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 05:56:51 -0700 (PDT)
Subject: Re: [PATCH 1/5] dt-bindings: mtd: jedec,spi-nor: document
 issi,is25wp256
To:     Tudor.Ambarus@microchip.com, p.yadav@ti.com
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, atish.patra@wdc.com, sagar.kadam@sifive.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20210819165908.135591-1-krzysztof.kozlowski@canonical.com>
 <20210819172852.b26mybrdr33wso62@ti.com>
 <5bff5a0c-48e5-3721-5595-836ce0562c6f@canonical.com>
 <ae4c58fe-0af5-3f1d-cc16-27b78772cbb5@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <abd7496d-7aaa-7f23-bdae-441906277577@canonical.com>
Date:   Wed, 25 Aug 2021 14:56:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ae4c58fe-0af5-3f1d-cc16-27b78772cbb5@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2021 15:28, Tudor.Ambarus@microchip.com wrote:
> On 8/19/21 8:36 PM, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 19/08/2021 19:28, Pratyush Yadav wrote:
>>> + Tudor (you should be listed as a maintainer for this file IMO)
>>>
>>> On 19/08/21 06:59PM, Krzysztof Kozlowski wrote:
>>>> Document bindings for the issi,is25wp256 SPI NOR flash.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>>>> index ed590d7c6e37..0db64ac7dc33 100644
>>>> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>>>> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>>>> @@ -33,6 +33,7 @@ properties:
>>>>        - items:
>>>>            - enum:
>>>>                - issi,is25lp016d
>>>> +              - issi,is25wp256
>>>
>>> I don't think we want to add any new flash specific compatibles. Why is
>>> "jedec,spi-nor" not enough for you?
>>
>> It's fine for me. I had impression that specific compatibles are still
>> preferred and one of boards is using this one. The other way is to
>> remove this compatible from the board DTS.
>>
> 
> Pratyush is right, we prefer to bind just to the generic "jedec,spi-nor"
> compatible whenever possible.

Thanks for confirming this. I'll fixup the dts.


Best regards,
Krzysztof
