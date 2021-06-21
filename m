Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075773AE6E4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhFUKU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhFUKU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:20:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814A2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 03:18:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso10311346wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ya2YRW/nzED56MCRGi5j1lR+lJWddJvApZ/VO+dqQDA=;
        b=E61Mdusml5vmCTP2n/NtNR4w6PRNEe0rEsdApHOUWO0Z1sogDFC4OtfDOKXscttLeq
         2afPRcUIxbZGodQhzaNNT7EZCMfRE6i1q7KrbXVYH/9ls6Gls5v2b54NUmOCzd00i08f
         j5hQGc9S4YQKMRDHGBShBsvjWYmsD5gSNs04FmoRTzcutalYsXckcqdCH5mbXxR+ff+h
         gd/rL1OAYiiFDMf0qdPXHZPS2NxJdP6j6xDWT1efBSyCaabLzPDLUEs2U/ETNRF+jVpO
         8Ftwd/ZMUhjA0DrDdUv4bXin/Z6+e9b5U+Yz3ddbYsm2NfOoa4ou/56jP4Iw39hxDddF
         OhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ya2YRW/nzED56MCRGi5j1lR+lJWddJvApZ/VO+dqQDA=;
        b=eKou2SUwhp6gDykKFYTWAP+xqXSqwYYjrAOiCIhGv6pXKbaQkB9Gpnq/75JFceDBLL
         x25kfegm73TFnGkAijcqPUiBOeOLR8afCq1Zef2PYA/vk3GEaLMeXJMT+H7hlp88HxpA
         ZaBRr/tOCWxnN4duuB1QyAZBurf33arnNIuCODW3pzUvWx9p+++ZOk5BA5lB1GkXufDQ
         oJYpWkOLEbkAm0eQ4jAbZFwe0XLQd/1HMlxC3JV+MPGbchlL4I8sPeHSOQo5yxfgn+uc
         8Q1gYji2o76ZkikpG0V879OZ3mffNV9GRIzxO1mpXqSYWkSIpxR50uN7m7KQGivhEKhJ
         ztCg==
X-Gm-Message-State: AOAM530fjug7U8lNjvsQtOFB8aLEbHrct7vfJvIdgo/8udrKMJD0H2mB
        CB6HYKy00ZcEg2hPK41HIS0VTmYkBnUTCioQ
X-Google-Smtp-Source: ABdhPJz5ZSW9GtnJopMpgRsUnAq/O51IS5MFfDEonOmcmUx68Ae8ZRmOS2m0xluboNswJK+T+eXXZw==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr7973182wmi.69.1624270720037;
        Mon, 21 Jun 2021 03:18:40 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5ebd:8bd9:d549:4211? ([2a01:e34:ed2f:f020:5ebd:8bd9:d549:4211])
        by smtp.googlemail.com with ESMTPSA id l12sm17306282wro.32.2021.06.21.03.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 03:18:39 -0700 (PDT)
Subject: Re: [PATCH 1/2] clocksource/drivers/exynos_mct: Prioritise Arm arch
 timer on arm64
To:     Will Deacon <will@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3ba202d9-a679-834a-685f-12c6f9eb9c38@linaro.org>
Date:   Mon, 21 Jun 2021 12:18:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210621101058.GB28788@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2021 12:10, Will Deacon wrote:

[ ... ]

>>> exynos4_mct_frc_start() is called unconditionally from probe via
>>> exynos4_clocksource_init() so as long as the mct probes first, then the
>>> arch timer should work, no? The rating shouldn't affect that.
>>
>> How do you ensure the exynos mct is probed before the arch timer ?
>>
>> The Makefile provides the right order, but the dependency is implicit.
> 
> Currently, I think it's done by the order of the CPU hotplug notifiers (
> see the hunk of 6282edb72bed which touches cpuhotplug.h).

Ah, right. Indeed whatever the DT order, the cpuhotplug order solves the
dependency.

Chanwoo, are fine with this change ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
