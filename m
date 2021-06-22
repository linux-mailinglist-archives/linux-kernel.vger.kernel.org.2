Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1903AFB04
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 04:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhFVCYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 22:24:04 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:24759 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhFVCYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 22:24:01 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210622022144epoutp01d94b9eee39bb988704013c0093fee44b~Kxis9nWNi2754127541epoutp01b
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:21:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210622022144epoutp01d94b9eee39bb988704013c0093fee44b~Kxis9nWNi2754127541epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624328504;
        bh=OufSI/cmAgUVLiWBpodEp8Btf9kgcVioiryEmA2vw2Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZmCOzMqDy2qTSQkeSi8GZId+qTTkJc3iRJiW4Z+buqQnu4a00w65aWl76Bic7HA3z
         zEfuVyZ/9o7SMdzX2EI+ep2YOZnSkgMcShX2Q46N3+lr1c4O1ck7i0NmmNkYOBLvxm
         lOqbvzMguNgYswTii6WyAaN80lW9+ytP7jD+pt+E=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210622022144epcas1p463c09e6b9b911a50de64e33350347f6e~Kxish8SBF2712727127epcas1p4Q;
        Tue, 22 Jun 2021 02:21:44 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4G89BX62SJz4x9Q1; Tue, 22 Jun
        2021 02:21:40 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.DA.10119.43941D06; Tue, 22 Jun 2021 11:21:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210622022138epcas1p121cfd8f377ebda53fceaeb99ceaf08cd~KxinrNoOR2010120101epcas1p1G;
        Tue, 22 Jun 2021 02:21:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210622022138epsmtrp240b9039f693949c0cfbb2e95f43c7bb7~KxinqfdbP0163501635epsmtrp2x;
        Tue, 22 Jun 2021 02:21:38 +0000 (GMT)
X-AuditID: b6c32a38-965ff70000002787-7f-60d14934af53
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.93.08289.23941D06; Tue, 22 Jun 2021 11:21:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210622022138epsmtip1ad5ee47b412ceeb52e34d3900f62d008~Kxineta_31343113431epsmtip1V;
        Tue, 22 Jun 2021 02:21:38 +0000 (GMT)
Subject: Re: [PATCH 1/2] clocksource/drivers/exynos_mct: Prioritise Arm arch
 timer on arm64
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d3e55130-ccfc-4bbc-3c82-91db4ce5113f@samsung.com>
Date:   Tue, 22 Jun 2021 11:40:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <3ba202d9-a679-834a-685f-12c6f9eb9c38@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmga6J58UEg/f/9CzmfZa1OH9+A7vF
        xrc/mCw2Pb7GanF51xw2i7VH7rJbbN40ldmi5Y6pA4fHrIZeNo9NqzrZPO5c28Pm8e7cOXaP
        zUvqPfq2rGL0+LxJLoA9KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
        1VbJxSdA1y0zB+gkJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWle
        ul5yfq6VoYGBkSlQYUJ2xuLToQWbOSr+LF/N1sB4ha2LkZNDQsBEYurlpSxdjFwcQgI7GCUO
        nLgG5XxilHh27js7hPOZUeLhuncsMC0fzx+GqtrFKPFz1XIo5z2jxLHzL5m7GDk4hAViJa4v
        VQZpEBHwl5jddhBsErPAf0aJj68/s4Mk2AS0JPa/uAF2CL+AosTVH48ZQWxeATuJFUvvMIPY
        LAKqEttW3QSrFxUIkzi5rQWqRlDi5MwnYBdxAtWfmN4OVsMsIC5x68l8JghbXmL72znMIIsl
        BNZySDRueMAK8YKLRNeCRiYIW1ji1fEt7BC2lMTnd3uhIVMtsfLkETaI5g5GiS37L0A1G0vs
        XzqZCeRLZgFNifW79CHCihI7f89lhFjMJ/Huaw8rSImEAK9ER5sQRImyxOUHd6HWSkosbu9k
        m8CoNAvJO7OQvDALyQuzEJYtYGRZxSiWWlCcm55abFhgghzbmxjByVXLYgfj3Lcf9A4xMnEw
        HmKU4GBWEuG9mXIhQYg3JbGyKrUoP76oNCe1+BCjKTCAJzJLiSbnA9N7Xkm8oamRsbGxhYmh
        mamhoZI47062QwlCAumJJanZqakFqUUwfUwcnFINTJPuL1gx48Zc742rX/9/JBckLPFI5mp4
        uEjDle6TZy6+LQytzmiRuWbVYJTW3LvY1MAx5sDvwKYJLZlMa8V6Cp5Y7okT6MlfwFF8j+Ws
        4a9Tf1UvnF7F8S/VpmZ/Qeruw59YD+1/e29/mn2ZxHa/f5tvOi/78cWFUe6lQk7pQocFexVv
        fIyzmdLP+fZ8vGjfsQ9ZUtIrHp0U/LbQcy5H8T5D6/jFixU+G4h07V0ewjtLpe6KLp/1tr+F
        ay83rfMx+KseIbjBS3nv39Dvk5+tUeR9/0juaN2zZTZTPH5oCGg9OylksLMngWtGQojqh96J
        rRO2ik1wrzkj9eDpnEux72On+h0qEc/8nXbncPUzrz9KLMUZiYZazEXFiQDou4JWNwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTtfI82KCwaHpZhbzPstanD+/gd1i
        49sfTBabHl9jtbi8aw6bxdojd9ktNm+aymzRcsfUgcNjVkMvm8emVZ1sHneu7WHzeHfuHLvH
        5iX1Hn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJWx+HRowWaOij/LV7M1MF5h62Lk5JAQMJH4
        eP4wSxcjF4eQwA5Gia8TjzFDJCQlpl08CmRzANnCEocPF0PUvGWUuHD5JwtIXFggVuL6UmWQ
        chEBX4n/D66xg9QwCzQySTxfOIEdomEii8SuS89ZQKrYBLQk9r+4AbaZX0BR4uqPx4wgNq+A
        ncSKpXfAFrMIqEpsW3WTHcQWFQiT2LnkMRNEjaDEyZlPwOZwAtWfmN4OVsMsoC7xZ94lZghb
        XOLWk/lMELa8xPa3c5gnMArPQtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJSXWq5XnJhb
        XJqXrpecn7uJERxlWlo7GPes+qB3iJGJg/EQowQHs5II782UCwlCvCmJlVWpRfnxRaU5qcWH
        GKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MAWnGMYXtIQHWx5rvLE3o+TptT9WG7a7
        1VhMybfeyxpzPmdXYdlew3uf97pceO1+pVvZ5a3i0ZPuHJJ8P/Z9mGus86R45UYJFqkdPKLS
        sUl7Dhw54a3D5vc9vmLDzT06q5Jr3ZxcboUv23HB6UaWtB7j80WZMm21qpdWXPe6kKz12rPP
        JezvOsfLfKunqh3wqz/lp96lvnsn4/KzO+c4aLS+WXvJ1KNtPV/y3bsbWe40zJY7dnTTs5WW
        XacX9K57tr/b50iVTc7C7nvedatv3pvRs63NdYGXs4nZ2h/CTZlJkvcu+AneD17tOWvH/JrP
        B653aWXv+71BnF9lYVbeVYfdhxdt/ruvNk7XeHbfnVlKLMUZiYZazEXFiQBTgXOsIQMAAA==
X-CMS-MailID: 20210622022138epcas1p121cfd8f377ebda53fceaeb99ceaf08cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210608154400epcas1p1b22fd50629611a9475cb4d2b8dd9442d
References: <20210608154341.10794-1-will@kernel.org>
        <CGME20210608154400epcas1p1b22fd50629611a9475cb4d2b8dd9442d@epcas1p1.samsung.com>
        <20210608154341.10794-2-will@kernel.org>
        <466bfc19-2260-87c6-c458-b43cf23617e3@samsung.com>
        <2a0181ea-a26e-65e9-16f6-cc233b6b296f@linaro.org>
        <fbcd234d-3ea0-d609-1f1d-b557ea329c37@samsung.com>
        <20210617214748.GC25403@willie-the-truck>
        <d79ebd58-1c4e-834c-fc06-482f25f6f3de@linaro.org>
        <20210621101058.GB28788@willie-the-truck>
        <3ba202d9-a679-834a-685f-12c6f9eb9c38@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/21 7:18 PM, Daniel Lezcano wrote:
> On 21/06/2021 12:10, Will Deacon wrote:
> 
> [ ... ]
> 
>>>> exynos4_mct_frc_start() is called unconditionally from probe via
>>>> exynos4_clocksource_init() so as long as the mct probes first, then the
>>>> arch timer should work, no? The rating shouldn't affect that.
>>>
>>> How do you ensure the exynos mct is probed before the arch timer ?
>>>
>>> The Makefile provides the right order, but the dependency is implicit.
>>
>> Currently, I think it's done by the order of the CPU hotplug notifiers (
>> see the hunk of 6282edb72bed which touches cpuhotplug.h).
> 
> Ah, right. Indeed whatever the DT order, the cpuhotplug order solves the
> dependency.
> 
> Chanwoo, are fine with this change ?

OK about the order.

Actually, I have not fully tested the arch timer on Exynos5433 64bit
because of the dependency between arch timer and MCT as we knew.

If the Krzysztof and Marek have no any objection,
I have no any objection anymore. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
