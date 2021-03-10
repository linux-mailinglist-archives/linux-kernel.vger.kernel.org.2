Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64A3333F45
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 14:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhCJNbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 08:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbhCJN0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:26:38 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22709C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 05:26:38 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b18so23313649wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 05:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PzfPm+w26Ng95PqF8ezRrd/ZWZzUpBQCq21z09FX/OU=;
        b=i4qER+U4lT2XX//cpE22Cauq2tu2nMYGZ0idHRHbX4jN08AYCG7hC0ZCuHYdReBct4
         cMkwTFG+l69tYBwmzxrvjWHg6/01jC/kuoaGhmB0uagyS2VJ3ksvH8IEypbqRB4B0ngK
         ZQPn820XdVjzEhjh2EJ2LwuGzFCXg/VVpTf8vkxdlOtRV5d9Z0BMh/9hVZUS/ipxYJXz
         naLdhTOFX0ckIe7/dQymSlzDtmUbT9v0jvncLIA2lPAKy9y+pqnXNFfcD/RYfxkEwWLn
         nr0CRn9FTreX6cCbkl9kzLz5K7L5f0Wq+R8Ol8UPPbsfMnhk2534kOuzO8yOKjWqtLUt
         Jq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PzfPm+w26Ng95PqF8ezRrd/ZWZzUpBQCq21z09FX/OU=;
        b=tgq4g0plokW67HVW1D/IrMWB2fneQyotzMHX7RcwDbRpHZE37I2RSe0+T2/VBy9/7r
         h31iqyRtSOVS6PvAYs1hj2cSGW/sYKcRreJgJKfsEi4ErveO+vunOYu3TeTysb0qZ7ig
         YgV8XToubO8w2bXlF2DPjHrP3xD/jXeNBTG+GQbLFxhKIwqw/tqRQBt+ANACSrowoUiX
         2Etdg3hmp3ueJ6M9ZqzDhSRilafak3DB79auNOja4onId/9gT63ZNCNIxvFufVVApROj
         2duHBwBna8wdNbDTcmluvjugdcu/6d1CfT3BiCKQrU6Pm8NgJIoRy/8MKOYTSVadI0xk
         MApQ==
X-Gm-Message-State: AOAM5310lqms8YD85E8QCwB1mTUH07c/uHTTqRowAQevFoLpcMXh5t/l
        Yb2AXOYK8+dCNnyt7rTPNJGfFg==
X-Google-Smtp-Source: ABdhPJyy5rioJ6pa6EL+Uu6iqufjUlD3vEQy8dR3EU/KW9/0ur9EZqVZ79sjKBWolS6TiwuCqcqGYw==
X-Received: by 2002:adf:e391:: with SMTP id e17mr3510408wrm.285.1615382796809;
        Wed, 10 Mar 2021 05:26:36 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8018:efa9:4421:9140? ([2a01:e34:ed2f:f020:8018:efa9:4421:9140])
        by smtp.googlemail.com with ESMTPSA id j30sm35145821wrj.62.2021.03.10.05.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 05:26:36 -0800 (PST)
Subject: Re: [PATCH v2 1/3] dt-bindings/timer: ingenic: Add compatible strings
 for JZ4760(B)
To:     Paul Cercueil <paul@crapouillou.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20210308212302.10288-1-paul@crapouillou.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <50797d7d-ddf6-cf79-698e-efa69a4ae7aa@linaro.org>
Date:   Wed, 10 Mar 2021 14:26:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210308212302.10288-1-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2021 22:23, Paul Cercueil wrote:
> Add compatible strings to support the system timer, clocksource, OST,
> watchdog and PWM blocks of the JZ4760 and JZ4760B SoCs.
> 
> Newer SoCs which behave like the JZ4760 or JZ4760B now see their
> compatible string require a fallback compatible string that corresponds
> to one of these two SoCs.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
