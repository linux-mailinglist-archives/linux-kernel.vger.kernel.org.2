Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CDD3FB09B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhH3E7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhH3E7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:59:32 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C820C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 21:58:39 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso16904176otv.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 21:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5pizk+/RHOyjwMdFuAoagsgfMzLs9LZCimmF/YW9Z50=;
        b=uqA+8HdNddSWNsX/JFIPW5tJWN2C/WbnMuVONAYnD30i4c2aztz/r9LCscHP44EcCV
         R/jfiwdph9P5MXUWPEmAdyPEScTZ3LPgWP31EXoGQNLUKf4oRqI9AxQT549lRoGTcB0S
         By/jXL6zUgTxJZgEBzJPOGAjprzlFMX5W52TNAF+kUWriv6JgGAQ+VYW+QGRN3MEnYoe
         ys/9YNX4NM1g7Yjp8whu6Q4vazNAuEO1MDE8JIhXGwj4ddpkqX9Drp2vhZ2CD2l5nWX4
         /gEv1rq7Jni92f9Vw5VtuYDH1qP2yXm3mhuzON5Njyoh5xxpWyFUme/1Bx6XTMMnZVow
         EYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5pizk+/RHOyjwMdFuAoagsgfMzLs9LZCimmF/YW9Z50=;
        b=KJZfWg//ukiFO54mNTLJ3AzYfs0dG1KtRS57Als4xmDei/HNbH0HI/tfX1DRKBpm66
         Nz4nn12RRSY4kz+k42Yohcp2lwnUshyGCv5nmqWO8qG9A78sGga/KhwWs7tTVo3S9QaO
         DYUHe+4vD/d89tSqkOhL3BHIUN9XxvIKCzQ7JT3UMl67wC28p7/CmYzlwyOXb6uT/fnk
         UVjoxvUMA7KcCPflp5G1LpkC1o1NHxTxrprrGPdLMMDAs0Ti6GP0BdF5CIBDiKk6DT+6
         7qehDcsNReQ5k3t23SJB6784XxacLlORQQuPZHyi2Hr0QP/XJvbZVzbJtMFdfO5u+rpg
         8l8w==
X-Gm-Message-State: AOAM532pQvMH/VXWy1GBpmnfhFU/ljRdd7/yMhv6r5iNK9S42Tl4Q/da
        05R6CyUarZ7CVPNaZMGFmjDKpxFMxcE=
X-Google-Smtp-Source: ABdhPJxD6P0oTAGM1qYoavU1CkMD2Cul3zSlLuPWmHGMuqfl9uOv5X7VeP8wsZPBNGK37N+ETZCfJg==
X-Received: by 2002:a9d:4b86:: with SMTP id k6mr14000473otf.198.1630299518871;
        Sun, 29 Aug 2021 21:58:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v11sm3048450oto.22.2021.08.29.21.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 21:58:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
References: <20210724224424.2085404-1-linus.walleij@linaro.org>
 <20210724224424.2085404-2-linus.walleij@linaro.org>
 <20210821042010.GA1759866@roeck-us.net>
 <CACRpkdYObGTWni3sSa21iNsgikzj7t9MA6y4TNgkBTTYQt+coA@mail.gmail.com>
 <4d87c7af-d2e3-9456-130a-b35b507ff3a2@roeck-us.net>
 <567a65a8-077b-7394-c8e2-dbd9f063e02c@kaod.org>
 <4c87cee3-2dfb-41e7-a18b-5ed4687a6f7a@www.fastmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2]: Be stric clocksource/drivers/fttmr010ter on IRQs
Message-ID: <f71cbfb9-b72c-39d2-6acb-dc83b6a496f8@roeck-us.net>
Date:   Sun, 29 Aug 2021 21:58:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4c87cee3-2dfb-41e7-a18b-5ed4687a6f7a@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/21 9:16 PM, Andrew Jeffery wrote:
[ ... ]
>>
>>> I don't have the manuals, so I can't say what the correct behavior is,
>>> but at least there is some evidence that TIMER_INTR_STATE may not exist
>>> on ast2400 and ast2500 SOCs.
>>
>> On Aspeed SoCs AST2400 and AST2500, the TMC[34] register is a
>> "control register #2" whereas on the AST2600 it is an "interruptarch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi:#include
>> status register" with bits [0-7] holding the timers status.
>>
>> I would say that the patch simply should handle the "is_aspeed" case.
> 
> Well, is_aspeed is set true in the driver for all of the 2400, 2500 and
> 2600. 0x34 behaves the way this patch expects on the 2600. So I think
> we need something less coarse than is_aspeed?
> 

If I understand the code correctly, ast2400 and ast2500 execute
fttmr010_timer_interrupt(), while ast2600 has its own interrupt handler.
To make this work, it would probably be necessary to check for is_aspeed
in fttmr010_timer_interrupt(), and only execute the new code if the flag
is false. The existing flag in struct fttmr010 should be good enough
for that.

Guenter
