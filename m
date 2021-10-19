Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79566433BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhJSQMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:12:37 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58976
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhJSQMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:12:33 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 085583FFF7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634659818;
        bh=vbtQkKJv01vIX5oUykdTEq0VFYquYD5Mv4xWeOReiYU=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=VvU1tur25tyA0fb1P7FDMc/1+BvEIw4AOX2wkrKsaSZh2ZFBHRJYJHDCBPH4VV2Yd
         bALuF0DpnLbUkqM/6uRbhgE7Uh9eBUqNsm4lKcTsoQuQEsmb8tIhJO18XttKcV3rco
         N/ROheHanlJdYH7tmzAxomljw+FdllW1DEutcC8ZNMYvoluievdrb/N1sPF6pjIIed
         MdPi39oobboow2bAXxgCGhjguz1WIk0XrEKBJeqWJAVKqR4ofpRhlr4wxTL4da+YpH
         yMP8OnGq7iBNyczfSdnqb/YFVm8EueV/VrWbod5Zl8VwrBEaPUViduVF+ZEGZ5sJYt
         oYiMssYCWBt4Q==
Received: by mail-lf1-f72.google.com with SMTP id b29-20020a0565120b9d00b003fdc9b2546dso1613070lfv.14
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 09:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vbtQkKJv01vIX5oUykdTEq0VFYquYD5Mv4xWeOReiYU=;
        b=Qty+D1rcB5h5wriBfnopax+VJmG1fq1nCnjqDiPttc8KSHv+vL+UOvEPD0PXa/HtbC
         Jn91Da2EfiaI5zVXp/+f/OkK26mvnq7IB9WxYXTbfSpXSF98wSHRLnH7kU5y/ZYX7VyE
         mO7PoKD88kPnCCKHEHVa389JwBIG+L5DEQb+0tVbQz/b9+sDLRr2T0LAhmKu8R4mivNH
         7gv4bvYhG8X5Gn8Sqx1TUue4NqTYktvSHbqVx3w/GIn2xuAIUdjSvy/QJUn4zZM2ccMm
         KQ6Zo3u9tGw6dAfWL342BTjb4mGa8KS3HSF/KUKxRidBSE0OcVIFO0GOkcmXN8NtJ5pW
         /Jig==
X-Gm-Message-State: AOAM531+dAlg/Bq5/yFJZmyq0xGJGBVIHGtF3mY7w5zeNaMGiZyr/IKq
        EQCew4WnTjt/PQGrduvu6rPF1hkQnlZjvjC0TwPWvkrzgLur2n1wkD+eYqmAiDYqfgyule6syv/
        ygjSRR+39H3bCoJrLKYl77alhGPT2r0FNINpx7AfLOg==
X-Received: by 2002:a2e:3c17:: with SMTP id j23mr7717432lja.161.1634659817313;
        Tue, 19 Oct 2021 09:10:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuvSDYjL+zmtZPegiXBuE33fgNyA22xger9D425lRjzwroeHAMmeFFBSfH1dCAVIsuIHEvXQ==
X-Received: by 2002:a2e:3c17:: with SMTP id j23mr7717413lja.161.1634659817111;
        Tue, 19 Oct 2021 09:10:17 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id x4sm2130401ljm.45.2021.10.19.09.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 09:10:16 -0700 (PDT)
Subject: Re: [PATCH 4/4] rtc: s3c: Fix RTC read on first boot
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211019131724.3109-1-semen.protsenko@linaro.org>
 <20211019131724.3109-5-semen.protsenko@linaro.org>
 <YW7o4iVhJNmv/ea6@piout.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <9206176d-2a79-a70d-9b2e-546385b42f3b@canonical.com>
Date:   Tue, 19 Oct 2021 18:10:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YW7o4iVhJNmv/ea6@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2021 17:48, Alexandre Belloni wrote:
> On 19/10/2021 16:17:24+0300, Sam Protsenko wrote:
>> On first RTC boot it has the month register value set to 0.
>> Unconditional subtracting of 1 subsequently in s3c_rtc_gettime() leads
>> to the next error message in kernel log:
>>
>>     hctosys: unable to read the hardware clock
>>
>> That happens in s3c_rtc_probe() when trying to register the RTC, which
>> in turn tries to read and validate the time. Initialize RTC date/time
>> registers to valid values in probe function on the first boot to prevent
>> such errors.
>>
> 
> No, never ever do that, the time is bogus and it has to stay this way,
> else userspace can't know whether the time on the RTC is the actual wall
> time or just some random value that you have set from the driver.
> 

Indeed. This looks basically like a revert of your commit 5c78cceeb2d8
("rtc: s3c: stop setting bogus time"). For the Samsung PMIC RTC, we
dropped time initialization in commit fe787a5b2297 ("rtc: s5m: remove
undocumented time init on first boot").

Best regards,
Krzysztof
