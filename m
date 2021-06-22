Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1BF3AFC8E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 07:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhFVFYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 01:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhFVFYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 01:24:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1E8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 22:21:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n35-20020a05600c3ba3b02901cdecb6bda8so845539wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 22:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZxtHvdJquBtvw9qwLPW1CGpQr9+JDPT4pNmwWctcjk0=;
        b=d1u44rhkho2eCMB8z537zPYJrM5mrWUKjcRKUrkk5Gi9Z+HOeOy5DOFLvt9jsML4N6
         k4fWNOLi1wtuFRiPyuN5tGQPVdCn1nn1Lp/zUnLf3n1FwovUWHr/Gjks56sdcyX9l7l+
         E9q8gZJ5yp61fr3Ev1isKT7zRlJhM0vV+Xm6Z9YY5X28nx53Ip7pxdEEBSuYvCIh8qQk
         4l1V9TJ8XtS3+7e0pvUBTO7K1xbvAlkpUvypA5r9q7w8BjqRf3mKJAKUL/PmeNZ+F5rM
         uNujDknqteuXcj26IshjwiVLAdPuKcozW5JSiJX2+AY8UBDYspGvup0tR1IXaCRG2ieB
         YfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZxtHvdJquBtvw9qwLPW1CGpQr9+JDPT4pNmwWctcjk0=;
        b=ocDvUPQx30Sf+JoGrDw8TR2urbi6vgKmvnWSR27wzldf6IP09ZkljDS5F2yO9ZI1sn
         wxSIUY4zGBhn8eTvpR+4OEHGLtJFjlA6H2gteLSnAPyc0oRpbnYg97VcCSJZ+YG4KZ42
         Bl+8IkT1TfKtKc6nkTCH4WfQ+uMDTe1VxvLXh9tBLSb5E12uenk7jQWpDxBCfdsyU/hv
         nVLQriqDRcb4QYrvoYtDSMzIvUeu7YZyMIRFKbUh2DAQAW6rLkH4/hvup67y6XrbTad/
         T5xXP4Z0NLdDv+/Bfhj2USaqHLtjsJqZZP/vD5/4deRf4C76xfbzTOKXfSlfZFOjmON2
         TGcw==
X-Gm-Message-State: AOAM533amybcge5NW+CquR2qrTYtFrzWcJ2YHdUTQtJVV9zo51u7/krG
        /8HVNInDBUrT3+mb+XiEUQSsEsJ5b8MtsdiE
X-Google-Smtp-Source: ABdhPJxopLE4EBiYSySki6pS3E7KH6KeN3J8fVlMpknT+ivPTdzDk9U9J50TsC33ecbuZxFAhk51MQ==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr2216337wmf.0.1624339307965;
        Mon, 21 Jun 2021 22:21:47 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5ebd:8bd9:d549:4211? ([2a01:e34:ed2f:f020:5ebd:8bd9:d549:4211])
        by smtp.googlemail.com with ESMTPSA id z6sm16813115wrl.15.2021.06.21.22.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 22:21:47 -0700 (PDT)
Subject: Re: [PATCH 1/2] clocksource/drivers/exynos_mct: Prioritise Arm arch
 timer on arm64
To:     Chanwoo Choi <cw00.choi@samsung.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>
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
 <d3e55130-ccfc-4bbc-3c82-91db4ce5113f@samsung.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1f4d7943-c540-bafd-b372-0d0ed8172f33@linaro.org>
Date:   Tue, 22 Jun 2021 07:21:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d3e55130-ccfc-4bbc-3c82-91db4ce5113f@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2021 04:40, Chanwoo Choi wrote:
> On 6/21/21 7:18 PM, Daniel Lezcano wrote:
>> On 21/06/2021 12:10, Will Deacon wrote:
>>
>> [ ... ]
>>
>>>>> exynos4_mct_frc_start() is called unconditionally from probe via
>>>>> exynos4_clocksource_init() so as long as the mct probes first, then the
>>>>> arch timer should work, no? The rating shouldn't affect that.
>>>>
>>>> How do you ensure the exynos mct is probed before the arch timer ?
>>>>
>>>> The Makefile provides the right order, but the dependency is implicit.
>>>
>>> Currently, I think it's done by the order of the CPU hotplug notifiers (
>>> see the hunk of 6282edb72bed which touches cpuhotplug.h).
>>
>> Ah, right. Indeed whatever the DT order, the cpuhotplug order solves the
>> dependency.
>>
>> Chanwoo, are fine with this change ?
> 
> OK about the order.
> 
> Actually, I have not fully tested the arch timer on Exynos5433 64bit
> because of the dependency between arch timer and MCT as we knew.
> 
> If the Krzysztof and Marek have no any objection,
> I have no any objection anymore. Thanks.
> 

Shall I consider it as an Acked-by ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
