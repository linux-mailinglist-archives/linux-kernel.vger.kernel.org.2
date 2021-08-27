Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF59F3FA184
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 00:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhH0Wcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 18:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhH0Wcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 18:32:52 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252B4C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:32:03 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id n27so11909078oij.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ukwb/15l4siPzT6A1B+l6HNsnXM5tGN+HApNQXqBVe4=;
        b=dPVMZeYChir1+H7jmFc4fIo4leX5f1ft1HRGkFRtRWiXZYag5iN4I032WPaXhUtKvs
         9c35OXQXbyPZfb2SVHu8JYdWgbwGEbJ8E/2liKAEof+UhGtdE08iA+VO7jA88Re6tOtu
         hTsbqad8f5hAq6SU8LBigGMns4jUFKOI9rNSghXHhuZoakQuCceYYNiwFGHfYWxKwdUa
         lthzfIsCAzPPesb4zTFns3hLAvBcQ+90OVMIxIbmtNkDWCEvr4qo27XMktAWWJheTjGR
         kNgr6mAAbk5/C4+HGZHVGbHT4DQWiXTpe6cp++4A14j9E51AeL1+7IRtS0sUx4k4BCq7
         k4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ukwb/15l4siPzT6A1B+l6HNsnXM5tGN+HApNQXqBVe4=;
        b=rfoviO0yjUH69OLOV0Eeule5ECyDshCUIylDVk93QUk/B0XUxBbuW95TsXNFKo8Kis
         xCyp/bvDzV9uwuASF5zxDcMwvislS8NUGDaA60kTUCOsX06j6lcRGp6tHqzbRIy5NLQT
         Aw8FiewDbrgDJVxmfbx/iv4rmfsJ5+DKd8Un2eRPnlzw8wMa89OY6EKbJj4Nn2mBja/D
         +RZNr8JOiU5jrA8obFchurYXv19YTHn/XMnuF1NhBtYitBnUZtmrvwX6BAbjmyBqTKNU
         DwWLoWcFxCpCWaMjhB/ObWM8Ygtyi7CPxTevoWjsyJUFr2PpVqDcxdxG3wtcTcyesSJG
         Ms8A==
X-Gm-Message-State: AOAM533u8hOdGWdLqVam0OfMaKpJNth4qeDIMRb83eBFmPj/6yNVuE5A
        MyTwNbaLaTl7OCWsdIQtxYU=
X-Google-Smtp-Source: ABdhPJyhYy3FGLbZP/4cwJx9dK2yDf1O0MEpPxODxC7bCIMQQvwtkGvP4GKKXrXHMXhnrSWH2afLzw==
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr16075737oiw.2.1630103522556;
        Fri, 27 Aug 2021 15:32:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i5sm1494585oie.11.2021.08.27.15.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 15:32:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goate?= =?UTF-8?Q?r?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>
References: <20210724224424.2085404-1-linus.walleij@linaro.org>
 <20210724224424.2085404-2-linus.walleij@linaro.org>
 <20210821042010.GA1759866@roeck-us.net>
 <CACRpkdYObGTWni3sSa21iNsgikzj7t9MA6y4TNgkBTTYQt+coA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] clocksource/drivers/fttmr010: Be stricter on IRQs
Message-ID: <24366a2b-787d-960f-a7cb-99f3330ffb75@roeck-us.net>
Date:   Fri, 27 Aug 2021 15:31:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYObGTWni3sSa21iNsgikzj7t9MA6y4TNgkBTTYQt+coA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/21 3:01 PM, Linus Walleij wrote:
> On Sat, Aug 21, 2021 at 6:20 AM Guenter Roeck <linux@roeck-us.net> wrote:
>> On Sun, Jul 25, 2021 at 12:44:24AM +0200, Linus Walleij wrote:
> 
>>> Make sure we check that the right interrupt occurred before
>>> calling the event handler for timer 1. Report spurious IRQs
>>> as IRQ_NONE.
>>>
>>> Cc: Cédric Le Goater <clg@kaod.org>
>>> Cc: Joel Stanley <joel@jms.id.au>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> This patch results in boot stalls with several qemu aspeed emulations
>> (quanta-q71l-bmc, palmetto-bmc, witherspoon-bmc, ast2500-evb,
>> romulus-bmc, g220a-bmc). Reverting this patch together with
>> "clocksource/drivers/fttmr010: Clear also overflow bit on AST2600"
>> fixes the problem. Bisect log is attached.
> 
> Has it been tested on real hardware?
> 
> We are reading register 0x34 TIMER_INTR_STATE for this.
> So this should reflect the state of raw interrupts from the timers.
> 
> I looked in qemu/hw/timer/aspeed_timer.c
> and the aspeed_timer_read() looks dubious.
> It rather looks like this falls down to returning whatever
> was written to this register and not reflect which IRQ
> was fired at all.
> 

Interesting question. There is aspeed_timer_read(), which doesn't return
anything useful for register 0x34, and there is aspeed_{2400,2500,2600}_timer_read,
which does. No idea what is actually executed.

Guenter

> Andrew: have you tested this when developing the
> QEMU driver?
> 
> Yours,
> Linus Walleij
> 
