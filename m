Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7333A3D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 09:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhFKHrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhFKHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:47:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4896C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 00:45:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id y7so4958065wrh.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 00:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jyVLRP1QkA2IL6a5f5yksm2l9IPiad2Lfrho8JCrB80=;
        b=tnUXwEtIxNsUkR3juOymwq8NsDACLFO4UY9stNt8nf4fnyEfeLnMLJRCJ4WQrBSTVo
         YXthzzdbMkbartaX3GNqDiGY4Gz7qS9h7XO2LM1KW0jgywjEjW8YmTfPj6o9v5fL/yxE
         b9mjgp5A6ZiodETFvTQAp9m5YaYuipu2JP+jI5qYapY0Qf+qqvtB3sunq5gEnCh9WtkM
         R//r15ndCwJfRN6O4LT1G4c1oQ9pBNogvUVYa7pZeYik7xN9OVlPoL5dpPlCSGuCReOI
         RjsU/AFnUKF2BOQnHb+fLoueJveCWv+LFh4UewSsRxnBpkIIyGQq7bq1QNw6Bg7hqn9i
         gDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jyVLRP1QkA2IL6a5f5yksm2l9IPiad2Lfrho8JCrB80=;
        b=WFujiM/hIByD9uz7pWSHcPwSNz6WoGngu+q+UNtjK3mTi3MpV1TpKCsFg+fTbgQFFa
         OxZiN3nw8Ndv3bhQT3eLcYXf7bTjLkm16KipeISaeP/TfuEz9YTulMvN2282cJ40vDEu
         A5SXU+o4PrEG0Hkg32AXZ0RNFUxJqd3/p1Lkxl2MgCMpj2gQ5uGKolnMIRB95btfm4ST
         BRnkKs7GZoxJojRQ0IlUeH5t1QVqcc8T3EtzLioNHR3y2iMzAAjDx4dNIkAz4B5jO8Ca
         du/+XsXcoY9Vx2rkMq/7YZx1VZWAazwGn8O1iWXF90dXO51NuVd6RPYnWRW+/OPJIwIN
         2NVw==
X-Gm-Message-State: AOAM533HdfNULHFHv48CS0mImQTTwI+RrrxWlD5CnwMvcaSXH1YKs1xZ
        r5T4Ml/E13MnHIPGhR4gZ/XJ5Q==
X-Google-Smtp-Source: ABdhPJzdpXeCEBaZqW+gbgn/Y7fTCnLbcAraMgni6bIzcHxjI8moZxc8QRHIancTbR/BoSfZr7KBAw==
X-Received: by 2002:adf:f1ca:: with SMTP id z10mr2557658wro.396.1623397553262;
        Fri, 11 Jun 2021 00:45:53 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e537:d458:d3c4:18e1? ([2a01:e34:ed2f:f020:e537:d458:d3c4:18e1])
        by smtp.googlemail.com with ESMTPSA id v15sm5701683wrw.24.2021.06.11.00.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 00:45:52 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson: vim3: reduce cpu thermal fan trigger
 temperature
To:     Nick Xie <xieqinick@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     robh+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick <nick@khadas.com>, artem@khadas.com
References: <20210609012849.797576-1-xieqinick@gmail.com>
 <11da3ae4-91d4-1e51-c652-e4ad518f13bd@baylibre.com>
 <CAP4nuTVMZV7pz8NrM2MHcZzBdueRXjS+KYsU4=cQ1CB67gr_Hg@mail.gmail.com>
 <ee3341d9-350e-a84d-6836-3401be679b2a@baylibre.com>
 <CAP4nuTUt1vQjVP=3_NYaeu+m47f78ru6-MgGBiAqLeU9fJAsNg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <09c65310-9441-9b97-d9ae-4695f0dd16af@linaro.org>
Date:   Fri, 11 Jun 2021 09:45:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAP4nuTUt1vQjVP=3_NYaeu+m47f78ru6-MgGBiAqLeU9fJAsNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2021 09:30, Nick Xie wrote:
> Hello Neil,
> 
> 
> Neil Armstrong <narmstrong@baylibre.com> 于2021年6月11日周五 下午3:15写道：
>>
>> Hi,
>>
>> On 11/06/2021 08:54, Nick Xie wrote:
>>> Hello Neil,
>>>
>>> The MCU FAN won't work until the temperature reach to 80 degree centigrade,
>>> Do you think the temperature is too high?
>>
>> I think 80 is tool high, but I fear 50 is way too low, but if you think 50 is OK after you ran some tests, just add it to the commit log and it's ok for me.
> 
> I think it is OK, we use it for a long time.

50°C sounds like normal temperature with regular load. That means the
fan will be switched on most of the time when the board is used.

And this change may be put in regard with the other trip points in the
common DT. For instance, enable the fan when reaching 80°C but set the
passive trip point to 75°C instead of 85°C.

All that depends on the hardware characteristics and TDP which are in
the TRM normally.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
