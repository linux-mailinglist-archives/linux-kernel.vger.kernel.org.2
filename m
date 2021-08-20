Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBDD3F2E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 17:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbhHTPFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 11:05:16 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60588
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238805AbhHTPFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 11:05:15 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 649824075F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 15:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629471876;
        bh=+9RVHIO7GV1Om2KHgusO6/MXkZN0OfEQMTrFuagDZKI=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=NiAqpx/BHsRMliyv/ACW72HdBctzKXhU8wc6GSz5C71fXX0iRVWFqa+koZKE3awAl
         FTVtHkJ5jEdcNFtyFXhT8u7C8Vv2oOudbi1p9CcFIWqivU6yYYvTHIJm81hOhLr6S9
         ql0tP5vs8g2vlz2XqYJQAUDRYi5Y6RcMix498XQTaXttCDPCvfrVJvmpN2N0eqtayD
         ySfMzsWlsQU+fw+sOtVs1BNxhgGcQY1JayeYhqvJFoDK2jvvoF3dFwXi6aa+/AEhi0
         F1O+JeE9APlUk7rUuRr2arbcGl9wFKEX7Tz1qY71G8TSPen4J3pEPRzDhyZ5RIaeQ3
         xB9ImzyJEdxzA==
Received: by mail-ed1-f71.google.com with SMTP id z4-20020a05640240c4b02903be90a10a52so4684211edb.19
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+9RVHIO7GV1Om2KHgusO6/MXkZN0OfEQMTrFuagDZKI=;
        b=KKvYqETTyhd4PA5XWg8DBOl7I7su4kJuJ1JS9lCO9UL8WX+4dR/Qiqgb1fKYxStRCx
         CANpqr5ORf2g/3S43po7yceI/NwfN8ICWDYiLRj6+/D6AMu4t8wh5fu84VxegLgfgsKV
         lZ8oCrENO3//hBQMqIALWgB6YmzWzpNi6Q+wnpczRZPDao4VG/m9L9504G9U5y5NB4TN
         mgM9uwTz4fgYllpru7fUPYJA4FpIEoTfI+E+cLQ0ZcOGNYnpQpC3OwgF42WfVZZU7jPV
         LEjSy5pUxPZK/t7GPoN/roiNUfCUp8M+6nxG9hcwn+gwgQ8wUp+BtZHJ7F3u245+S8QC
         FlZg==
X-Gm-Message-State: AOAM532BoQohxFJ3Uf9GjqPFgkt3czMajTnTjmukjmxZ7QE285jg8GwU
        H0uVoeesc+6PygNtV4ewU0tfRzvxJdZCBTVVT2mEVlMLms6qaTht/W9Vgow634B9N3nekRkHrjs
        uekXlpD9VwrPvoKpQsnsDRZmUm4pT8/cRDrLEg2Ua+Q==
X-Received: by 2002:a05:6402:1157:: with SMTP id g23mr23183733edw.90.1629471875697;
        Fri, 20 Aug 2021 08:04:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgDiyfkZv84mpJkewwib7hgZF+c9z+OtbNAQMGJ7h7jHN43rWGybqDCjw2we1dlKuY6kNo0A==
X-Received: by 2002:a05:6402:1157:: with SMTP id g23mr23183722edw.90.1629471875595;
        Fri, 20 Aug 2021 08:04:35 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id q6sm2960038ejm.106.2021.08.20.08.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 08:04:35 -0700 (PDT)
Subject: Re: [PATCH 1/2] arm64: dts: exynos: align operating-points table name
 with dtschema in Exynos5433
To:     Alim Akhtar <alim.akhtar@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <20210820081458.83406-1-krzysztof.kozlowski@canonical.com>
 <CAGOxZ53oTWuSLupGKWd+XWPXJZQfZ28-Vo=wWT1exty0LpCfOA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ed2e81ce-97ac-be28-8db5-3f1242c64a91@canonical.com>
Date:   Fri, 20 Aug 2021 17:04:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAGOxZ53oTWuSLupGKWd+XWPXJZQfZ28-Vo=wWT1exty0LpCfOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2021 16:44, Alim Akhtar wrote:
> On Fri, Aug 20, 2021 at 1:51 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> Align the name of operating-points node to dtschema to fix warnings like:
>>
> Did you miss adding warnings here?

Yeah, I missed. I will add it when applying.

> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
> Rest looks good.
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

Thanks!


Best regards,
Krzysztof
