Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3F6424407
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbhJFRZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:25:53 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50518
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231942AbhJFRZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:25:52 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 360A73F499
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 17:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633541039;
        bh=ICT93CHM4YPSa4dfM/nU1XdIOc5abKxFtl1Tbs0hlVE=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=C9W6d+M9xIkRGivvW+VO9kzbdy28DyKEoLlqjXUXbWgkJM9WdIFC17OBOPFX2RbTS
         X5UxM1zl7g94z31LCrBbb78qBQRopZaB5KyYAkLT4Ky5OjNfsmnStY0+UJYqlvSNpV
         uwDcgR0cDGu/waRs8brKiiGqgcqbdjOz2j9OqbAW/zHpJcfo5nmLswOQ7iFF0qUC31
         Ux4wg1vwYpalB+mV7a388H0hdGCR6jLwWY8Xf5ItKjyXHX+nmts6dBe0WghRKEo0m9
         N8nrxbVzc+z6WCcDfOCyw48hRkSLu2pSBjqKBaTg94adiq7kYBIBENdHBSspzCHIrb
         tyoAD1yBPhRjA==
Received: by mail-lf1-f72.google.com with SMTP id n22-20020a0565120ad600b003fcc09af59fso2501798lfu.21
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 10:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ICT93CHM4YPSa4dfM/nU1XdIOc5abKxFtl1Tbs0hlVE=;
        b=oh2fVA8Rk14qdp0KbM0J6XJ+ds9QRoCp0C7o4HJQeTpLiwLII6ooe/5T/HiUkxlXL9
         +D4mwFvlTTBNNjlZQJg/SAYCPbgOv7SyZsZ60jZCGcxYITmK5TNrIpEW6vxHMQtr0z/L
         KAwojy67CqSb+VbDxenmJZcMO0iDf4QXTA0RwgCmvBV/xKvg9txU47imf5pe5zPYdtNO
         CuKXoSVP5USMFx0PGc9h/in5eEuvTJA+6CFlsyEufkhliyNotNfnOrHsm0M5nk94Fdrs
         r+9qIYf2LoWdJRLQ0RdMxxsCM6ysenXeQsF3Ah9svO2CKdDSamMme1oDeQHqjdIFlws9
         kmng==
X-Gm-Message-State: AOAM530+bzziv2GTnFWCESusmXqEGPva1m+srDMHpgfz8dFHacPOtrBo
        PB3q8G9E035qP/9qPzfXsrZbl4AQ6r2eqmp6mNkK+8Na/qU+8evk6p5703vFXenP9jaHSikZjmw
        MNMc4BTrPj9IAz61BUloPJsESYTzOC4QLxkOvOkS2yA==
X-Received: by 2002:ac2:5c1e:: with SMTP id r30mr3613809lfp.306.1633541038723;
        Wed, 06 Oct 2021 10:23:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9tnjMN8NMgO63kiGucWDBQWrLlf8ucveUKEd5MASJoJz9ZDt7SSD9R4YseNHT7AoxbOYK3Q==
X-Received: by 2002:ac2:5c1e:: with SMTP id r30mr3613785lfp.306.1633541038525;
        Wed, 06 Oct 2021 10:23:58 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e28sm2500262ljo.63.2021.10.06.10.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 10:23:58 -0700 (PDT)
Subject: Re: [PATCH v4 2/7] dt-bindings: memory: lpddr2: Convert to schema
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20211005230009.3635-1-digetx@gmail.com>
 <20211005230009.3635-3-digetx@gmail.com>
 <6b8f6ef7-cfc5-3a8b-d44d-f4080a85ecf3@canonical.com>
 <7047ad7b-52d6-0c91-b7d2-b115ea69506f@gmail.com>
 <481f4d90-638f-b64f-83a2-b882d9bf194a@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <5b24cc4c-3091-a044-612e-43024bc512a5@canonical.com>
Date:   Wed, 6 Oct 2021 19:23:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <481f4d90-638f-b64f-83a2-b882d9bf194a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2021 17:44, Dmitry Osipenko wrote:
> 06.10.2021 18:41, Dmitry Osipenko пишет:
>> 06.10.2021 13:57, Krzysztof Kozlowski пишет:
>>>> +  density:
>>>> +    description: |
>>>> +      Density in megabits of SDRAM chip. Obtained from device datasheet.
>>> You need here a type/ref, so uint32.
>>>
>>
>> The type is uint32 by default. I can add it, but it's not really necessary.
>>
> 
> You may grep bindings for 'enum: [' to see that nobody is specifying the
> type.
> 

Just because everyone makes a mistake, is not a proof it should be done
like that. Please see example schema and vendor,int-property.

AFAIR, only properties defined by schema (directly or by unit suffix,
e.g. microvolt) do not need types.

Best regards,
Krzysztof
