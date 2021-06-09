Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2396B3A1313
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhFILoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:44:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40235 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239429AbhFILno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:43:44 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lqwaj-0005jO-AR
        for linux-kernel@vger.kernel.org; Wed, 09 Jun 2021 11:41:49 +0000
Received: by mail-wr1-f70.google.com with SMTP id x9-20020a5d49090000b0290118d8746e06so10696345wrq.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hDauiLgbuiDsYYxQ82NvgthP7BUgotDarOmEF1J7zsw=;
        b=SyATxXxK0JJjC8I+acYmX36vW2b/iOWOeOFPoRUyjsHbtrSU2iHcUR3/SPzSFdvroI
         nbjxPeEROVjTBA5CjwWFwt3kwxEU9Q9Xj4w+QvDD3nz8apB0jqYAQacvpeUDdmIxQ/ne
         WjmWfBGHRw/+ZxKc/Bkf59tR7Op6eZsI8XDoApEmOGdAx2ug+FR+0KTcwBFQ/gPdk8Qx
         UheaJDfHeDYeamXSzUdqmS7ABpRJ21MOxcMESWt1/Fhsfjwok9V5/Ome6gMPItE6/jQe
         kT0JTjejseYWrN2zgZL/Rqm1euLM02IExav6uHknMXJsHY+EB8WGTzuRWkxlQMn1wAJ7
         vMrw==
X-Gm-Message-State: AOAM531cGL+2YtjgDfxpZ3NEAIfzJ3mtzcJYCg5uPYMHr00Qs7pKBhsn
        biBIfHayADqv1OKGUsfjHzlYj63XkjRbgtiZ1itW2aIW7fStb6y4VZuxJao5z6AHMAxSctyQrhD
        xHaoWg/h0luJL7/rCIqk0NsDF8iJSYsXale4uFTSxaw==
X-Received: by 2002:a05:600c:4f94:: with SMTP id n20mr9308868wmq.121.1623238908582;
        Wed, 09 Jun 2021 04:41:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwt9/KX8QUiC+PEqz/sKCRPfhT68J79pjyItQDgV3mWuBPUCfspNQ5CPsB+IQq95TQYwejhQ==
X-Received: by 2002:a05:600c:4f94:: with SMTP id n20mr9308856wmq.121.1623238908465;
        Wed, 09 Jun 2021 04:41:48 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id v17sm16079633wrp.36.2021.06.09.04.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 04:41:48 -0700 (PDT)
Subject: Re: [PATCH 2/2] clocksource/drivers/exynos_mct: Mark MCT device as
 CLOCK_EVT_FEAT_PERCPU
To:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20210608154341.10794-1-will@kernel.org>
 <20210608154341.10794-3-will@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d137ba37-a983-e361-8cea-abae4068668a@canonical.com>
Date:   Wed, 9 Jun 2021 13:41:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608154341.10794-3-will@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2021 17:43, Will Deacon wrote:
> The "mct_tick" is a per-cpu clockevents device. Set the
> CLOCK_EVT_FEAT_PERCPU feature to prevent e.g. mct_tick0 being unsafely
> designated as the global broadcast timer and instead treat the device as
> a per-cpu wakeup timer.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/clocksource/exynos_mct.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)



Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
