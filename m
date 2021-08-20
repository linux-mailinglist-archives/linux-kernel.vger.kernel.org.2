Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B003F2DD2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240778AbhHTORb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbhHTORa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:17:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F07AC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 07:16:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h13so14575206wrp.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 07:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Don6hlP+1HWZCfXCubxmfxxvPUxcTHFmAha636flEXI=;
        b=luoWY6CBudSNSAv92mjPSsrIdh0e08gDnqv0Dt1bSh2DZ4nBByd0lTBs00fGH9RXPE
         qJxIx6Ley5Tes42oBTikKB3F1n0ubD9bujl9KxD9adGFKZb1k7F7Ty+r2SVkhrxdlHb9
         mwyiVpAz0biV4xSMo8ymoWAteqyMvCF/xSSyvnGHy6L5URJvpwlM6PnT5axoomEgzrUA
         kLAb28sSVEwR/M7UO8B5BFjPggbmTFb+cwIrPLbDaK908rayRUobrdJ4g7oNtNeB2d+P
         2PvzjWGtuh6P47nlo8bOyEhdCxgeXRp2qO7/I6fV9mJB8XWxdW+3Y6scprX83fdb7OF1
         +eeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Don6hlP+1HWZCfXCubxmfxxvPUxcTHFmAha636flEXI=;
        b=suBgn2jxrYpiRr0RBukp38PxZv5qLdNgQFa9RtUw6FWX9jc9Y6NZBjGdYOaDwGwF1C
         0JmrIbAfEoEouMWank5XUUbJmGLSHxBCl4P0H5Qm/D40Rh6Xwwk7vmsbDkH5r5omHf1B
         GJEC6l5zP+aUNlDrKFY50qd8z76LAl2HAFMsU0HgHYkESGfTaNXKHZkeuoGg9hsqe+fs
         HLIgHlzaHy0pElby27a8DEt3Td54U1kQ9AFOIJ7JYLi8UY1zk20FHm3V4ZLtMvFA+3q5
         McARimThEZdHKf/J8mAdWhHZnl1tpa+2pOtJ+xcnP954JLOwzZ/6z9bLsLPZ/2r+cBpd
         8pDw==
X-Gm-Message-State: AOAM531tUKF6WknAQl7HdeNyQpuoPPXDLngcI2B6VmcrvpCWEhe4kv+J
        V0b5Zs2USG5JriQhkMjHz/GQRaVRs5n0JHz3
X-Google-Smtp-Source: ABdhPJypjsM9kxm6wSvKvJYpInfYldZz3RpY94q4GjQj4/Y+mNFxsxEzxGQTNPaIyWVqn4AJpo3gTg==
X-Received: by 2002:a5d:618f:: with SMTP id j15mr10277255wru.80.1629469011080;
        Fri, 20 Aug 2021 07:16:51 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c378:b01b:5d2d:5223? ([2a01:e34:ed2f:f020:c378:b01b:5d2d:5223])
        by smtp.googlemail.com with ESMTPSA id c1sm4915918wml.33.2021.08.20.07.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 07:16:49 -0700 (PDT)
Subject: Re: [PATCH 2/2] clocksource/drivers/fttmr010: Be stricter on IRQs
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goate?= =?UTF-8?Q?r?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>
References: <20210724224424.2085404-1-linus.walleij@linaro.org>
 <20210724224424.2085404-2-linus.walleij@linaro.org>
 <e997cca5-e6d4-1aac-4e0c-de15d7664a1b@linaro.org>
 <CACRpkdYh6E+gCihouapFYX33U-ccJk7DF1oHax5vUS2CiqDOrg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fbe67d96-70dc-c8a4-106c-8bfced42c1ce@linaro.org>
Date:   Fri, 20 Aug 2021 16:16:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYh6E+gCihouapFYX33U-ccJk7DF1oHax5vUS2CiqDOrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2021 15:39, Linus Walleij wrote:
> On Fri, Aug 20, 2021 at 10:53 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 25/07/2021 00:44, Linus Walleij wrote:
>>> Make sure we check that the right interrupt occurred before
>>> calling the event handler for timer 1. Report spurious IRQs
>>> as IRQ_NONE.
>>
>> Does it not mean there is something wrong with the initial setup ?
> 
> No it is not occurring. This is just to protect against ordinary
> spurious interrupts (return from sleep glitches in electronics,
> quantum effects...)

I was not aware such problems can happen.

Thanks for the clarification.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
