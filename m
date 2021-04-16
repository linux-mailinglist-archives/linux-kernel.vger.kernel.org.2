Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D720362307
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244959AbhDPOmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:42:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40399 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236105AbhDPOmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:42:31 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lXPfZ-0000Cg-F3
        for linux-kernel@vger.kernel.org; Fri, 16 Apr 2021 14:42:05 +0000
Received: by mail-ed1-f72.google.com with SMTP id v5-20020a0564023485b029037ff13253bcso7111901edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H3orKY1/6E7It9couZQFwgWHB9x2xfiTMv49UiHX33I=;
        b=Z82r+thQLP8R3Fc0YrZisFiM5rNh3iuSzjm9760OenKhMY2UQ8udF8aPoiuxCYuilK
         pPsvpGQLGUUzAZtkDxwXm7K1QWbJ1DxFeD2AV2pywpVqGc1OA9y6la54B79nsLszt+1K
         SUgiSt5PDHPo5POle2pEGCoEnxl8cYV8lfRUsUtNp3zuyQUrmX7UlXO0XdxTQAxlBgZP
         t1CmSw5Q6FkhCcVznL8PD6NgRDryIjgM+4TPFNWo/Hjcy0DcOnu+PB6CouP6WxnwPuyd
         JnyKnDh13FgYwuTc19H7wQxzT8Vg8u012qoFNPL1YcbjT0LwpKPa5Ts1wOd7JOywwHhW
         TM1Q==
X-Gm-Message-State: AOAM530PchV1MyVnhopAHH/Cf7lhVHvJ2Dac/ABFHbA0yYnZx+zP7WzU
        d4gB0x94UebsjLJSwRGoU0ZBSV0hSv517ZPAWydQqf/HAicQMgLX0hNhbTxqUgodCAf2lakuMxj
        1cAGocZr9+v4/YXQi0CarjkARZbHN1ufKldnwzjVPug==
X-Received: by 2002:a17:906:3153:: with SMTP id e19mr8808151eje.351.1618584125253;
        Fri, 16 Apr 2021 07:42:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLYgDmRYOx7mlmnqWjHmwHF8mTlbAilqonRblj7lGIBqxozRBPiD2hV0hjFdS3yuqciMmEQw==
X-Received: by 2002:a17:906:3153:: with SMTP id e19mr8808134eje.351.1618584125122;
        Fri, 16 Apr 2021 07:42:05 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id t7sm5532707edq.42.2021.04.16.07.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 07:42:04 -0700 (PDT)
Subject: Re: [PATCH 38/40] drm/exynos/exynos_drm_ipp: Fix some function name
 disparity issues
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20210416143725.2769053-1-lee.jones@linaro.org>
 <20210416143725.2769053-39-lee.jones@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <81a27ab8-9e2e-8f29-c1dd-19ec54ec3d28@canonical.com>
Date:   Fri, 16 Apr 2021 16:42:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210416143725.2769053-39-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2021 16:37, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/exynos/exynos_drm_ipp.c:105: warning: expecting prototype for exynos_drm_ipp_ioctl_get_res_ioctl(). Prototype was for exynos_drm_ipp_get_res_ioctl() instead
>  drivers/gpu/drm/exynos/exynos_drm_ipp.c:153: warning: expecting prototype for exynos_drm_ipp_ioctl_get_caps(). Prototype was for exynos_drm_ipp_get_caps_ioctl() instead
> 
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_ipp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
