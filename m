Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B090230D568
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhBCIjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbhBCIis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:38:48 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1212C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 00:38:07 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id c4so20458937wru.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 00:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LRckNdFHMV8l5xE64bdXq2kwS/6XUZKnyLTXd9Rl/Xo=;
        b=LPrQGCD0n0sax7uqe9xZC1s1sdADE1M0XgmKQavcyhVkQ1mJDPa/qbDQfTGSEtnvNu
         p/jvRFR31hesPRm/VY2A2yYS5j7O6FB15k6Vc9QZrG6f++zQRRrONDyRveUhof2tJdW0
         1rNBY0PuCUjp/A5Pva4cYFhQ/Px9to0xMhnTexWuaGmECNE9DkJwg+xN0zdYMcIUKdEt
         /2l2jj+6DvEJB8gV6cLdlVLRIo0Pykug4g58uiNHvOHHzhj8u/qJOqueQTBYLM3emEuF
         z51slvXY6hsJb1XfDLm3BiBeXIXvoLwRM8i/tFqtIDyhEnjPHm0dvSi0pFz/fm0Vbp84
         sFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LRckNdFHMV8l5xE64bdXq2kwS/6XUZKnyLTXd9Rl/Xo=;
        b=r5Qe1jaIc4x7yvU0imbTHRddyuCUCu14bpqwP/McjD9Z4Txc00NHpyHsROmMQqf4w6
         rhkijIhKZY1A3kXaNaINIG/XShvaBdZCvlsKhp+z5rWCM01utvPGeiO2ZvG+SCm4gMbu
         pU10gFzWX7yScYs9fCXFuWO34BWqhURCZYDVNrv+Zv3BfMopMwJ1Wk/N8mPfKAU2jcWk
         XFYZwwtZc9BZUf07Sn5nq7zsyBIWqFhLpflk792J5E4L+0seY3RAjDL0XvR0F23QR/ht
         ToIRvEP2+oJYrs4gIFcGSyXiDLxk8W/84rrnAL+G32DSv+tfRFm4FLc9Odve0x/7LLp2
         li6g==
X-Gm-Message-State: AOAM533Wwj9M9iAeHvXSY2z7ONDbkVcJLYwfK5I41hDvaoFjLodhELvY
        oUFRbrBhSpjWkEWsnLhHJ0EDkJTJF1KUBg==
X-Google-Smtp-Source: ABdhPJw5sLxtpjQCCI4xyGPFSRylLvS0bwIjPcbZQIl6wHfE2JhoJYHeS390IwSi8pfmT/L4T3WxLg==
X-Received: by 2002:a5d:52c5:: with SMTP id r5mr2150710wrv.208.1612341486654;
        Wed, 03 Feb 2021 00:38:06 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:b982:c986:40fa:94a3? ([2a01:e34:ed2f:f020:b982:c986:40fa:94a3])
        by smtp.googlemail.com with ESMTPSA id p18sm1706891wmc.31.2021.02.03.00.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 00:38:06 -0800 (PST)
Subject: Re: [RESEND PATCH] clocksource/drivers/timer-microchip-pit64b: add
 clocksource suspend/resume
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
References: <1611061165-30180-1-git-send-email-claudiu.beznea@microchip.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4dec6c7e-15d7-bd49-83ea-818fc90d9b8f@linaro.org>
Date:   Wed, 3 Feb 2021 09:38:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1611061165-30180-1-git-send-email-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2021 13:59, Claudiu Beznea wrote:
> Add suspend/resume support for clocksource timer.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Applied, thanks




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
