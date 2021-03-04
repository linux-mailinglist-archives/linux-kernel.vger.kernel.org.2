Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7BB32DB09
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 21:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbhCDUQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 15:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238428AbhCDUQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 15:16:22 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E39C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 12:15:41 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id p1so32168378edy.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 12:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5jLuTPwmQtRh5LkNxQ0rgOEhjoPWcJ+o8G/ZVzu4EU=;
        b=RY7ZjM39neNt3ha6ii8uWFcQxr80X5YMwMUA0Ejq7ZGnIXSjRA/JXlAOahRjyCQBIH
         8XD714pj5JMyrz/3SxcmOxxe6Uy6Q+a0m0782DT4l2BUxpWGRaglT2myg3EU/TnsVVES
         3MejCu+RDHyUXgOCFczHYp3vNzDaLnEakeyOlGHx17JsOjPkBY1hcwD4acqJVhIapfpJ
         r2XEV0fGZu284sk++Ba93oXDdnWTXKlvEcInRkMoIKA13kE1jvsewnVdsA+MOQzE6LQM
         3/lMiG4vUpZ88UWLKA5VQyF4pBMzeR9SgJeMxZPDtdEA9gcSVY3NFf5tHUqORB2IlJR3
         axBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5jLuTPwmQtRh5LkNxQ0rgOEhjoPWcJ+o8G/ZVzu4EU=;
        b=MG2bNA++Ti/4/8uGwPbYBBBnANqhI54Wk2nfg4Odlh8xJ/4zRHv4iGuZvLR0f80Tcv
         DgFDoV4YDz3bp5vZIIGjsZCWTJG8u3TalQv3tpfdncaHrM5PnVvYaZztRwQye4eUuJaj
         K+UhmoM+gNFQXHqdwuIRFahsPBEIhY5CbgsL73VKSGZ4Ax973wHm6SV3tubCj40V2WJ7
         2QLGCkN6Ohj0S+/oRYC2VJH8tdSjIUO62DPYoPBuwQuwoTx9d7e3+SapHDQaRaYv4qaK
         HNe5f25R+KmodqSGWIjcVxLMGNLsvsO6uOZtynR1atZqdpSQGYv4NUaMc+I8djZI/euU
         cYXQ==
X-Gm-Message-State: AOAM53126wTtInCTQNloaqhfuWV3j7oB2Ze42Xag6hC2rdeY9jw5sc/V
        4DDtmQFJPeduc1TIq5AYQWsjUC4POkjcCS85f3xCDA==
X-Google-Smtp-Source: ABdhPJx2PyGszUmMp+TYoXheeUf4o74MJoSxZjKQywmWIz4lq6/KuKp5DkM8GrPix6AlM3A1T3fpATVU0q+wlP/HQAU=
X-Received: by 2002:a50:ee05:: with SMTP id g5mr6420181eds.164.1614888940442;
 Thu, 04 Mar 2021 12:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20210304102452.21726-1-brgl@bgdev.pl> <20210304102452.21726-10-brgl@bgdev.pl>
 <YEDdbfbM9abHJpIO@smile.fi.intel.com>
In-Reply-To: <YEDdbfbM9abHJpIO@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 4 Mar 2021 21:15:29 +0100
Message-ID: <CAMRc=MdRxXzoZuyLs-24dXfOft=OQqDneTHa4-ZKqFE1kMBWcg@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] gpio: sim: new testing module
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 2:15 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Mar 04, 2021 at 11:24:49AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Implement a new, modern GPIO testing module controlled by configfs
> > attributes instead of module parameters. The goal of this driver is
> > to provide a replacement for gpio-mockup that will be easily extensible
> > with new features and doesn't require reloading the module to change
> > the setup.
>
> Shall we put a reference to this in the gpio-mockup documentation and mark the
> latter deprecated?
>

I don't think it's necessary right away. Let's phase out gpio-mockup
once this one gets some attention (for example: after libgpiod
switches to using it).

[snip]

>
> > +             dev_attr->attr.name = devm_kasprintf(dev, GFP_KERNEL,
> > +                                                  "gpio%u", i);
>
> Reads better as one line.
>

Yeah, so the removal of the 80 characters limit should not be abused
when there's no need for it - this doesn't look that bad really with a
broken line. Same elsewhere where the limit is exceeded.

[snip]

>
> > +             ret = sprintf(page + written,
> > +                     i < config->num_line_names - 1 ?
> > +                             "\"%s\", " : "\"%s\"\n",
> > +                     config->line_names[i] ?: "");
>
> Indentation here looks not the best...
>

So this is the place where it may make sense to go over 80 chars.

[snip]

> > +
> > +     /*
> > +      * FIXME If anyone knows a better way to parse that - please let me
> > +      * know.
> > +      */
>
> If comma can be replaced with ' ' (space) then why not to use next_arg() from
> cmdline.c? I.o.w. do you have strong opinion why should we use comma here?
>

My opinion is not very strong but I wanted to make the list of names
resemble what we pass to the gpio-line-names property in device tree.
Doesn't next_arg() react differently to string of the form: "foo=bar"?

[snip]

> > +
> > +static int gpio_sim_config_uncommit_item(struct config_item *item)
> > +{
> > +     struct gpio_sim_chip_config *config = to_gpio_sim_chip_config(item);
> > +     int id;
> > +
> > +     mutex_lock(&config->lock);
> > +     id = config->pdev->id;
> > +     platform_device_unregister(config->pdev);
> > +     config->pdev = NULL;
>
> > +     ida_free(&gpio_sim_ida, id);
>
> Isn't it atomic per se? I mean that IDA won't give the same ID until you free
> it. I.o.w. why is it under the mutex?
>

You're right but if we rapidly create and destroy chips we'll be left
with holes in the numbering (because new devices would be created
before the IDA numbers are freed, so the driver would take a larger
number that's currently free). It doesn't hurt but it would look worse
IMO. Do you have a strong opinion on this?

[snip]

I'll address issues I didn't comment on.

Thanks for the review!
Bart
