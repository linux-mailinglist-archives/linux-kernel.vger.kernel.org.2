Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285A53504C4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhCaQhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbhCaQhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:37:07 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09B9C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:37:06 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so2728572wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TnvnZxOACqCq+A8twXUOuSk4g7qmxy4JPsXlvzDSCsc=;
        b=rVpz048TIOhPnZDI0bFHdGqg55LctDMZMTVOT50l44L5oV4G7tLmigNzUYIXcdhhpd
         Oyz//g08P72Um05QQaR18j89EZ11DwdlpvhfuZRQXC8BofyTZjos8+s4a0fds6WCfKu3
         wGxpnvsF1hHt/yJ2vz6haC53ujxLVDfC7iif46SeiDVhbcUdO0gOGKb6KMs6ln3EQSZk
         DV2RzlGaguhQ+Y3irWAffBKKphz1FiPRMdsK0muP8RwChE/EsZPA+JL+S6YPua6hvhSR
         viCRJJlsG9OkYuTObmyLtCUv3lh6V0pVmG7fpk9gNkpSGICsZTGhwwqfF0dpiRVb+ktm
         Tblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TnvnZxOACqCq+A8twXUOuSk4g7qmxy4JPsXlvzDSCsc=;
        b=K8bucz4RY9Euid+kDPUxsDvrnXG7KUfap2vY7DhwH2NDkwPG3W3KvbzOoeZxmGW/g2
         i2fU9XFVKTL5qOe1nbZ40+DFlxtK2UI647zB54+Cje2szOjMAUJtkTvlHmqPRi0E2eWj
         o61mokiAzRs7dU9no8bdefnN1mo3kgNInT2rBFN/7ACwdPQiakqZN1sYxaV0OUffgiOK
         siTo5ZjrfrzegjCCM1Cewqn3IcKnlEAzvLsjEKFAQGc8Ve8y6uvRwurZBVIInnBpnEXX
         qzIKouC36zv/sC6iSTD/1jTMHJ0oSklAeAgnLwtW34StvIfDCuCQuLJgyoTR1d3QnpLM
         SVRg==
X-Gm-Message-State: AOAM533a/pQxHDAzeW/RoyFU46O2f9qpw/u+OQStKorqbdE5Qpbh2Nn8
        ev2sb/iOMt+JmqNwKoYlS6J2gA==
X-Google-Smtp-Source: ABdhPJz10HL+5/BOj1Bk7HPn6MnV8AJUkitxTA4JqmwUj3KT9mJHDIeqkbfrMVp0zqjv6uSNDkz5Wg==
X-Received: by 2002:a1c:3c8a:: with SMTP id j132mr3861932wma.127.1617208625431;
        Wed, 31 Mar 2021 09:37:05 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1573:1dd5:899d:6362? ([2a01:e34:ed2f:f020:1573:1dd5:899d:6362])
        by smtp.googlemail.com with ESMTPSA id q207sm6798719wme.36.2021.03.31.09.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 09:37:04 -0700 (PDT)
Subject: Re: [PATCH] thermal: ti-soc-thermal: of_device.h is included twice
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
References: <20210323021430.141218-1-wanjiabing@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9d835b9f-e687-ff6a-89d3-3e15f95b0f83@linaro.org>
Date:   Wed, 31 Mar 2021 18:37:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210323021430.141218-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2021 03:14, Wan Jiabing wrote:
> linux/of_device.h has been included at line 25, so remove 
> the duplicate one at line 35.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---

Thanks for your patch.

It was actually already fixed [1].

   -- D.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?h=thermal/next&id=7440e912b0fe755d80b958a65859ebabb5338cf8


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
