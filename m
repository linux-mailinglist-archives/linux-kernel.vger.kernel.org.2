Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10503E1194
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239831AbhHEJn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:43:57 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:60084
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239045AbhHEJn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:43:56 -0400
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id D9D263F345
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 09:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628156621;
        bh=PlH+VlKUMlcX80piFT0gda5UUaZVZ2zU1R5Uqd41yvE=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=LmZehnVippZhk2SPYUljupAbaYK/eUjcu+Mkriyce/ICUlSqsZdgUv6Z+azPiQFeM
         z9Z/EtUQeAyDG/HnXiupfETEIBCpcwGNgYtoroHQbXmsqIitN4YfMSdoq+fStS4FEJ
         npbNUYPhT3vshj5D0b4WqG83wnkTKh/nG5NKtu1eGD3cHcdB6CvwoQH8cqlrytpQkv
         ZmxIFEnBAVe9fYlu0ID23oXU1Qbi90nQRHA76F0pLxwt5G2dsZGG7m42tFg4Tm3smj
         JhheomOdkogmMU/Tx8d9a7owPE1rKx+IUgOnC68wIESEcfL6ZlxGj7x8mgdSQN7GmT
         CtBCS0xOsPFXg==
Received: by mail-ej1-f69.google.com with SMTP id nb40-20020a1709071ca8b02905992266c319so1820845ejc.21
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 02:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PlH+VlKUMlcX80piFT0gda5UUaZVZ2zU1R5Uqd41yvE=;
        b=UOfAbWQviFL1sGqZFjUH7cZEAHS38cboyUAH+MBoUSgDaj7Cckc0/iTRPg5pALwSh8
         gbqp0itVPha7aL0C7aI09FOk/e4p7n+T8S50KwbnBmigUjW9zfmUUHoHI0cuanBfL44t
         fng3hKsbctnxEEpp8XW5ZE4Lwqk2hldBbG18y9GXMEXCzHxfq6CuuCoK6+5xfJ1oKc3F
         4pXh9PwV82lyHMikpMFoLKe5WQJd5iFutYy5lgoAppF9YxZtIK/Bs9wdhlhoqj2SleSW
         N+sWN2r4aFrFr031ZL9PYEWnKa/gG+3MXziah5W60tN+u5AdDnvkOBp9lnaSQxBYqv43
         LHlg==
X-Gm-Message-State: AOAM532GLNyRKSrxgWOy9gYBrWilaHPalbwf6p2ZpMWPn6Nn3DN3BQZd
        ufJiw85aQnUb81u2IglHdGkAQaN97Fszfn0iKeW5ZTJc4M3SsXLj0VQBaBEaG9LBbn2VBrH/GMB
        LJ7vGqn8laCTfthtoNCrox83Cx1x402U3Wo3IXz7rEg==
X-Received: by 2002:a17:906:c7c2:: with SMTP id dc2mr3972976ejb.472.1628156621383;
        Thu, 05 Aug 2021 02:43:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGoPDPK+MWVCmOjwAsROGmWLcIrk5p+yD4K34PJk7bXHMYE41l71FAk8Cu0oD/JmROctGTdA==
X-Received: by 2002:a17:906:c7c2:: with SMTP id dc2mr3972967ejb.472.1628156621254;
        Thu, 05 Aug 2021 02:43:41 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id o5sm1998626edc.16.2021.08.05.02.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 02:43:40 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: exynos: correct GIC CPU interfaces address
 range on Exynos7
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        'Rob Herring' <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     'Chanwoo Choi' <cw00.choi@samsung.com>,
        'Pankaj Dubey' <pankaj.dubey@samsung.com>,
        'Sam Protsenko' <semen.protsenko@linaro.org>,
        'Marc Zyngier' <maz@kernel.org>
References: <20210805072110.4730-1-krzysztof.kozlowski@canonical.com>
 <CGME20210805073653epcas5p21b4c2358b7de2b3c21dbc357af957137@epcas5p2.samsung.com>
 <b0d6ff2a-24af-96c1-62a1-8b920c63e05a@canonical.com>
 <03d701d789db$f275d290$d76177b0$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <7c019443-6153-f059-418b-3b268750f7a8@canonical.com>
Date:   Thu, 5 Aug 2021 11:43:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <03d701d789db$f275d290$d76177b0$@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2021 11:26, Alim Akhtar wrote:
> Hi Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> Sent: 05 August 2021 13:07
>> To: Rob Herring <robh+dt@kernel.org>; devicetree@vger.kernel.org; linux-
>> arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Cc: Alim Akhtar <alim.akhtar@samsung.com>; Chanwoo Choi
>> <cw00.choi@samsung.com>; Pankaj Dubey <pankaj.dubey@samsung.com>;
>> Sam Protsenko <semen.protsenko@linaro.org>; Marc Zyngier
>> <maz@kernel.org>
>> Subject: Re: [PATCH] arm64: dts: exynos: correct GIC CPU interfaces address
>> range on Exynos7
>>
>> On 05/08/2021 09:21, Krzysztof Kozlowski wrote:
>>> The GIC-400 CPU interfaces address range is defined as 0x2000-0x3FFF
>>> (by ARM).
>>>
>>
> Looking at DDI0471B_gic400_r0p1_trm.pdf, CPU interface range is 0x0000 ~ 0x10000
> 
>> I underestimated the issue - this is actually bug as there is a GICC_DIR
>> register at offset 0x1000. Therefore:
>>
> Looking at the exynos7 and exynos5433 UMs looks like GICC_DIR is at offset 0x2100 (from 0x1100_0000 GIC base)
> It is possible for you to cross check once?
> 

That's a mistake in Exynos manual. GICC_DIR is at 0x1000:
https://developer.arm.com/documentation/ddi0471/b/programmers-model/cpu-interface-register-summary

We have discussion here:
https://lore.kernel.org/linux-samsung-soc/0277c701-cc25-cdc5-d3b9-cf2cc2ba4de5@canonical.com/T/#m1ced9a28bed27f5cf74e281fb68efe1b57d5609e

Range of 0x10000 is definitely wrong as it overlaps with two other
ranges.


Best regards,
Krzysztof
