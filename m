Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6827038ACCE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243103AbhETLtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbhETLZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:25:57 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2B0C035430
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 03:06:43 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id x1so4858004uau.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 03:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QyAz/Y7sojLhm4WGgiSHyG7ZKRB6TQwfwV5kBelVWI=;
        b=HM0C/fxgCgP9PqpIBs5RDFfOToJmqVddEeDOSQdQiFAZ0XmNj8tPrwEkz+wAzTxKbL
         9wM1LXUkA4xetjxn3/1N8FZgv060Y/XtU52d2O98mkHuJi93Je4nJXZ5KvaglO3xm1L3
         OC2mdYuBizLnhryJnABFdzoaW3hXnWa/gyCyeW/FZp19piowNWF+9FgaGN65jrsK5TkF
         dwougd3a+a7hBIcQHMjLDVR2Q4uhQlsPwAgVhHLjrCw+zP9fj/3oZyCfD2y457RhS0CR
         5bv3I1jYwawTDKdpiI4d7rjBQc1JtfDQZUKdKEgzgZqgmQlGi8PlX1uE8aovFyL0HzLo
         4zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QyAz/Y7sojLhm4WGgiSHyG7ZKRB6TQwfwV5kBelVWI=;
        b=YEOq6gQc9JZ0arxJgMQ3OIwma0xtMk7O6u/TBMvoed39XL3jEmWBpOOA88o/cb8Jdh
         iF/kEA1cWSv2vdbox1t/23ZDD1/3ZcHn1LBiWbTZazLHtcUq9mc8T9EBbzgUW5VDEXch
         VmYmWFCig38DkK4iryfTxsqQkKShfSXIckpZCsvy34WvmquopXfHifLwqbxXQxW6HhIJ
         jH1QFVAPxxzbow0bUDrD3HV59LzTrneLFtuB0xHvs85toMRWCxhmcba6H2J18cS4zRVr
         JssL0hsLGG++zP2bzsu88EaBAGUx05XcGfR1HejoIRJcGbkqcJYxEK6YIv26/Ofhhv51
         sUbQ==
X-Gm-Message-State: AOAM530RLLxDmDDDvyS3gat3eOPutfajwq0NoNYaO+Yd6LolH7CEWezI
        IPDkKiN3vpIU6gNV62aRoflxBVecXmrm9uav1uJFcQ==
X-Google-Smtp-Source: ABdhPJzy3ITiPckKdlsOzI9fCyc0onwPpPpVy562GHjplX8ZWe+S0MCOuc5oXcO1rwAgcmmS4rg2e6wmWmzJOhzxX68=
X-Received: by 2002:ab0:14ce:: with SMTP id f14mr3285015uae.50.1621505202313;
 Thu, 20 May 2021 03:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210516061425.8757-1-aardelean@deviqon.com> <CAHp75VcesNFXCMoWbdBR2mFCt89p8aycWbheMhv9DnU8TBqNSA@mail.gmail.com>
In-Reply-To: <CAHp75VcesNFXCMoWbdBR2mFCt89p8aycWbheMhv9DnU8TBqNSA@mail.gmail.com>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Thu, 20 May 2021 13:06:30 +0300
Message-ID: <CAASAkoa6btmLCj-XouKVj=hCG2euhT2MnNWWQAS7jorJBEoQEA@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-stmpe: fully use convert probe to device-managed
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 at 09:40, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
>
>
> On Sunday, May 16, 2021, Alexandru Ardelean <aardelean@deviqon.com> wrote:
>>
>> The driver doesn't look like it can be built as a kmod, so leaks cannot
>> happen via a rmmod mechanism.
>> The remove hook was removed via commit 3b52bb960ec6 ("gpio: stmpe: make
>> it explicitly non-modular").
>>
>> The IRQ is registered via devm_request_threaded_irq(), making the driver
>> only partially device-managed.
>>
>> In any case all resources should be made device-managed, mostly as a good
>> practice. That way at least the unwinding on error is happening in reverse
>> order (as the probe).
>>
>> This change also removes platform_set_drvdata() since the information is
>> never retrieved to be used in the driver.
>
>
> Any driver can be unbind from device thru sysfs. The exception is when they (device drivers) specifically disable that.

Oh, I see.
Thanks for the info :)

>
>>
>> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
>> ---
>>
>> I'm not sure if this should be marked with a Fixes tag.
>> But if so, it should probably be for commit 3b52bb960ec6 (also mentioned in
>> the comment above).
>>
>>  drivers/gpio/gpio-stmpe.c | 32 +++++++++++++-------------------
>>  1 file changed, 13 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
>> index b94ef8181428..dd4d58b4ae49 100644
>> --- a/drivers/gpio/gpio-stmpe.c
>> +++ b/drivers/gpio/gpio-stmpe.c
>> @@ -449,6 +449,11 @@ static void stmpe_init_irq_valid_mask(struct gpio_chip *gc,
>>         }
>>  }
>>
>> +static void stmpe_gpio_disable(void *stmpe)
>> +{
>> +       stmpe_disable(stmpe, STMPE_BLOCK_GPIO);
>> +}
>> +
>>  static int stmpe_gpio_probe(struct platform_device *pdev)
>>  {
>>         struct stmpe *stmpe = dev_get_drvdata(pdev->dev.parent);
>> @@ -461,7 +466,7 @@ static int stmpe_gpio_probe(struct platform_device *pdev)
>>                 return -EINVAL;
>>         }
>>
>> -       stmpe_gpio = kzalloc(sizeof(*stmpe_gpio), GFP_KERNEL);
>> +       stmpe_gpio = devm_kzalloc(&pdev->dev, sizeof(*stmpe_gpio), GFP_KERNEL);
>>         if (!stmpe_gpio)
>>                 return -ENOMEM;
>>
>> @@ -489,7 +494,11 @@ static int stmpe_gpio_probe(struct platform_device *pdev)
>>
>>         ret = stmpe_enable(stmpe, STMPE_BLOCK_GPIO);
>>         if (ret)
>> -               goto out_free;
>> +               return ret;
>> +
>> +       ret = devm_add_action_or_reset(&pdev->dev, stmpe_gpio_disable, stmpe);
>> +       if (ret)
>> +               return ret;
>>
>>         if (irq > 0) {
>>                 struct gpio_irq_chip *girq;
>> @@ -499,7 +508,7 @@ static int stmpe_gpio_probe(struct platform_device *pdev)
>>                                 "stmpe-gpio", stmpe_gpio);
>>                 if (ret) {
>>                         dev_err(&pdev->dev, "unable to get irq: %d\n", ret);
>> -                       goto out_disable;
>> +                       return ret;
>>                 }
>>
>>                 girq = &stmpe_gpio->chip.irq;
>> @@ -514,22 +523,7 @@ static int stmpe_gpio_probe(struct platform_device *pdev)
>>                 girq->init_valid_mask = stmpe_init_irq_valid_mask;
>>         }
>>
>> -       ret = gpiochip_add_data(&stmpe_gpio->chip, stmpe_gpio);
>> -       if (ret) {
>> -               dev_err(&pdev->dev, "unable to add gpiochip: %d\n", ret);
>> -               goto out_disable;
>> -       }
>> -
>> -       platform_set_drvdata(pdev, stmpe_gpio);
>> -
>> -       return 0;
>> -
>> -out_disable:
>> -       stmpe_disable(stmpe, STMPE_BLOCK_GPIO);
>> -       gpiochip_remove(&stmpe_gpio->chip);
>> -out_free:
>> -       kfree(stmpe_gpio);
>> -       return ret;
>> +       return devm_gpiochip_add_data(&pdev->dev, &stmpe_gpio->chip, stmpe_gpio);
>>  }
>>
>>  static struct platform_driver stmpe_gpio_driver = {
>> --
>> 2.31.1
>>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
