Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27403AE700
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhFUK1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhFUK1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:27:02 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8572BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 03:24:47 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso10323708wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 03:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CDiXxvYtfyxE5nFB19grFf8yJhbwkKeNX1uoZe/8Uvc=;
        b=iYhp2WQffqmJU3YQ3FdHYngsgmsFop0nY+fE0oobBV8Y+pTXI4LS43Evyzld6i9Qj9
         dbQmB2+1HVtUSvGgSHdDxkPfiCQLhgYb5SVmzuImES+rZEmyeg/kEHInqko67OkZK1kR
         8lDW7EmzIVdsEASl0OA3pMhBMaomQE1vs0h8M+r5pruTxOdq/eh9zrzYOYDObTvf+isg
         QM+Ssn7aK6vSs+ot5Eo4iNWPX5rqO5S5y2rIN301g9WkMbm8cfr9QXSRJSIg2ocBKI/K
         aXn7aiSkDvXCfLea8TfsU204ORV6dr2Cif+f4Al5ZYT+24XrcGB9vadALSUDw3p850hp
         1b5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CDiXxvYtfyxE5nFB19grFf8yJhbwkKeNX1uoZe/8Uvc=;
        b=Yp9IrqTdUWd6t7ITm1IQfwGXusbmgmTLyQA3kx32IqeJdi/qcEl2aGGaGYyFEqgHY+
         nqfaUVpUKEPRST8O3G8EtzSmbWGcvohbNd95bEST6MY/C8V8HQB/04WJ/3L2HovU9msn
         LAyM2QtjfsXMP6g6QZkzRvHZyFL872o8i/hEWaj9qpHfNL5MLUlH09I6pgcJMJbFyGpe
         /hCeMwjxrX4dynV/RFlIaxRpGqKz5Z9zsgg5dcmqo43C8Zgo+LH72IbcI5QXXJaJ5Qc2
         hCL10DF9bH+UhtgAX/oKsXLNMrkLpEHN1CzLUcfMD55LS475J8lEA9YaEu+0aF7eLDyK
         F0Gg==
X-Gm-Message-State: AOAM533+nfjakuOPhaLQwOjQBznbS3R6QhNWN7xfgml/PmhUJd4S7DMl
        1LPCDhVRUwDh2HpBPS7cncPoKQ==
X-Google-Smtp-Source: ABdhPJyZQ3CPhDv7pPIktHohGygVyJpoofZEJT9P7K2Hx2D0J427cfLpLmA6fyca61BcLiClNbY5Zg==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr8003996wmi.69.1624271085972;
        Mon, 21 Jun 2021 03:24:45 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5ebd:8bd9:d549:4211? ([2a01:e34:ed2f:f020:5ebd:8bd9:d549:4211])
        by smtp.googlemail.com with ESMTPSA id u18sm15538371wmj.15.2021.06.21.03.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 03:24:45 -0700 (PDT)
Subject: Re: [PATCH 1/2] clocksource/drivers/exynos_mct: Prioritise Arm arch
 timer on arm64
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Will Deacon <will@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
 <95fb8ea3-f409-55ee-6b5c-f19858dd0fab@samsung.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6847bb2f-02ac-35a4-bb7a-491a52325a60@linaro.org>
Date:   Mon, 21 Jun 2021 12:24:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <95fb8ea3-f409-55ee-6b5c-f19858dd0fab@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2021 12:17, Marek Szyprowski wrote:

[ ... ]

>>>>>> I'm not sure that exynos mct is working without problem
>>>>>> such as the case of 6282edb72bed.
>>>>>> As described on On ,6282edb72bed the arch timer on exynos SoC
>>>>>> depends on Exynos MCT device. the arch timer is not able to work
>>>>>> without Exynos MCT because of using the common module.
>>>>> Is it possible to change the DT to have a phandle to the exynos_mct, so
>>>>> it will be probed before the arch_arm_timer ?
>>>> I think that DT changes is not proper way to keep the order between
>>>> exynos_mct and arch timer.
>>> exynos4_mct_frc_start() is called unconditionally from probe via
>>> exynos4_clocksource_init() so as long as the mct probes first, then the
>>> arch timer should work, no? The rating shouldn't affect that.
>> How do you ensure the exynos mct is probed before the arch timer ?
>>
>> The Makefile provides the right order, but the dependency is implicit.
> 
> In my test systems based on Exynos5433, the bootloader enabled MCT, so 
> kernel can also start with arch_timer then switch to MCT. The probe 
> order also depend on the order of DT nodes, so with the current dts MCT 
> is probed first. This is not the best approach, but so far it works.

Right, generally assuming the firmware is doing the right thing from an
initialization POV is not a good idea :/

But in our case, as pointed by Will, the cpuhotplug ordering gives the
right sequence. So it should be fine.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
