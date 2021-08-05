Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD723E1198
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbhHEJpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:45:44 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:59520
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239282AbhHEJpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:45:43 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 0FAA840643
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 09:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628156699;
        bh=eq4sHLyLRo38xlokxNFSRX3L+vSvOngMzJAr9ypms3s=;
        h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=OPKb2DxC/36Hqa0MkE1nj1RXl9YQzIsTK48/BNLgvYFhypSrCTW2Jk6jhP/3ehfkK
         CK0D5JXDKPU6Anigkshgtma8B3RVLpAL7OXxUjFExJyZ12akG4hlY8WuX6XXF/kk5N
         YFD0PB4ByoVnqMCtpbhELiW8O/RVRb1jiHgv8zXQ0snrjcuI9/xc8PLIdaf3QztMAN
         miRBqL5v9/bg6HgldELq3983MEOd4ivl5HYX/AcAu+gua8W4tVa+s0lqWLeRzoAfpK
         aFsC9XAMBP6abes92WKWbG95mln32pOTlFo+2WPisHWRlpXSi0634c7agAAr5FwcWT
         9hDSm+dFkfj/Q==
Received: by mail-ed1-f71.google.com with SMTP id l3-20020aa7c3030000b02903bccf1897f9so2855517edq.19
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 02:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eq4sHLyLRo38xlokxNFSRX3L+vSvOngMzJAr9ypms3s=;
        b=azdaiJwZlDBAj9VM/8N3Oi3mLxEyTADALBZp7GqtBm82VVcEmgjVjDgFi0o+62yMTJ
         XQy+wLJrRBiVPK8Ije/ioC5Yg2W1bSLS1sHb2guVA5KpZf0Xg0e7ftqUW2grvjDI4mj+
         cVKERdQxSI6Qrf+770cusdjKMssNBXkrCXPw9IPZpmiVhGLxfbOJHVhPPI53NDymopQl
         l2mQ7GB+fHQWKOrVE0TanByGvGt6e6g9FPuTs+KwSyLhzLdQjAg4r/HwgLH71pxp+xE/
         r82V4QevaENcB6XY7T2Jlekmz9irGnXHc04GVxNYCGLH42vLvWDf4B/5VDYLBVKvGAnV
         VNhg==
X-Gm-Message-State: AOAM531pb5MKIOosmU59VP04oKu5gDuzF1qiUKqxdwNKf2bqDEyQwXHN
        O0SrlwJdoRR58xN2Qa8yzfGiUJeywZ3XO8REO7XwgbawGkoSHzYh33UMJ+G5c5cjwq3Hs2RBpsa
        fhy4JgHGdTMWfMWGoEuBZANDUKqHQYy0WRxdN3C0OWA==
X-Received: by 2002:a17:906:70a:: with SMTP id y10mr3852266ejb.381.1628156698746;
        Thu, 05 Aug 2021 02:44:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEo7uFha2cwn65X0bkEZr/Cg0CxuSlgPy6k3dOYxyK2z2ZGphK8vaAGNcJrVjcpVnwxnmwtA==
X-Received: by 2002:a17:906:70a:: with SMTP id y10mr3852248ejb.381.1628156698548;
        Thu, 05 Aug 2021 02:44:58 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id h15sm1506392ejg.31.2021.08.05.02.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 02:44:57 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: exynos: correct GIC CPU interfaces address
 range on Exynos7
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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
 <7c019443-6153-f059-418b-3b268750f7a8@canonical.com>
Message-ID: <4fc60199-44cd-41ea-9178-92b131d21b73@canonical.com>
Date:   Thu, 5 Aug 2021 11:44:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7c019443-6153-f059-418b-3b268750f7a8@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2021 11:43, Krzysztof Kozlowski wrote:
> On 05/08/2021 11:26, Alim Akhtar wrote:
>> Hi Krzysztof,
>>
>>> -----Original Message-----
>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>> Sent: 05 August 2021 13:07
>>> To: Rob Herring <robh+dt@kernel.org>; devicetree@vger.kernel.org; linux-
>>> arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>>> kernel@vger.kernel.org
>>> Cc: Alim Akhtar <alim.akhtar@samsung.com>; Chanwoo Choi
>>> <cw00.choi@samsung.com>; Pankaj Dubey <pankaj.dubey@samsung.com>;
>>> Sam Protsenko <semen.protsenko@linaro.org>; Marc Zyngier
>>> <maz@kernel.org>
>>> Subject: Re: [PATCH] arm64: dts: exynos: correct GIC CPU interfaces address
>>> range on Exynos7
>>>
>>> On 05/08/2021 09:21, Krzysztof Kozlowski wrote:
>>>> The GIC-400 CPU interfaces address range is defined as 0x2000-0x3FFF
>>>> (by ARM).
>>>>
>>>
>> Looking at DDI0471B_gic400_r0p1_trm.pdf, CPU interface range is 0x0000 ~ 0x10000
>>
>>> I underestimated the issue - this is actually bug as there is a GICC_DIR
>>> register at offset 0x1000. Therefore:
>>>
>> Looking at the exynos7 and exynos5433 UMs looks like GICC_DIR is at offset 0x2100 (from 0x1100_0000 GIC base)
>> It is possible for you to cross check once?
>>
> 
> That's a mistake in Exynos manual. GICC_DIR is at 0x1000:

0x1000 from CPU base offset, so 0x3000 from GIC base.

> https://developer.arm.com/documentation/ddi0471/b/programmers-model/cpu-interface-register-summary
> 
> We have discussion here:
> https://lore.kernel.org/linux-samsung-soc/0277c701-cc25-cdc5-d3b9-cf2cc2ba4de5@canonical.com/T/#m1ced9a28bed27f5cf74e281fb68efe1b57d5609e
> 
> Range of 0x10000 is definitely wrong as it overlaps with two other
> ranges.


Best regards,
Krzysztof
