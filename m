Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F88338807
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhCLIzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbhCLIzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:55:10 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC5FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 00:55:10 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ci14so51721507ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 00:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XiqpDN6gJsaLMGdH3lPdKQnKDjjGC44fLRhvMJ+mVbU=;
        b=ovvO9TpA1X4QZtTZ3ljfUXW6N60WEEufch6qINAX3S++TInA2bhEPck2U9qpnX7Ahc
         Xn3+wJCHX+GLU0bK+tuETI5oDsfje+UQTb6vr4PVd7NCFZMx6mms+kaNfHuBuV7Fwie7
         LDQM4c/5xOylQxXH3FoMFhSzac8teO3Uf9QHhPaEZJc2LFJN+RaX/48ntmyAMy2O6ABN
         MxIgTkzBnttmKL1BHIUqkEvCcr/F7UVaqth6QRNmZrT5QR6fIrCfwH02iiTjnH0+StSc
         9UF7F9RXppfB+5yjwOAyZVJnKS5nOMVv8P18jlHLaWD13rKowgS7fog9/CXi6NyBFDjn
         uAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XiqpDN6gJsaLMGdH3lPdKQnKDjjGC44fLRhvMJ+mVbU=;
        b=PxOuPIvmXN0qTZ+07ATW2huI5lFofMBosTVA6RRkPTSqDIm3aN3TyO4o53ex2rcZC2
         mgIsycNg1fdKLceaRr45JrdVfRV/vF527nPAlcMZnctqD2rmX+4uhx0I+37S0vqX6tPY
         nT6VrMPYCK8jlj6YVTZYBeHZr7brRbxC6qV0DEMqSkXsyTLm0kzSvE6rda3j03xah2OB
         379iDLKXFUQNBKDpJBVm29dz9d8gb/U/bGCkMO5b2BMUHF9VMiZY8r8KLjEvVRndRi80
         k/iX2Z5QXK3RJg2EfPr7FI7KTdtzl7RX/Yl3ZP3bTXcD6yMVAjtAODveT9PqLycSrNZM
         f6jg==
X-Gm-Message-State: AOAM532IAQRh+erNYTVwnHbxOhzC+DgWUhxlzs047sZzWpdE+PQtFdZt
        Q4IcOHWvlyHaG7aRvLALSoxD+NG744T0n79/+9BDBw==
X-Google-Smtp-Source: ABdhPJzKfyaZhHFsjM187ZvFFxqGbDJOnoMDfvHw+sx5HKyjtlQ2/LFXSMwb9d2njOiS8uXdoFfl36yXLF/KoWdhDcw=
X-Received: by 2002:a17:906:3b48:: with SMTP id h8mr7360401ejf.261.1615539309187;
 Fri, 12 Mar 2021 00:55:09 -0800 (PST)
MIME-Version: 1.0
References: <20210309205921.15992-1-brgl@bgdev.pl> <20210309205921.15992-9-brgl@bgdev.pl>
 <YEi7fth6sZWgKd+q@smile.fi.intel.com>
In-Reply-To: <YEi7fth6sZWgKd+q@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 12 Mar 2021 09:54:58 +0100
Message-ID: <CAMRc=MfeCWNnXwqBBu3CcdHXQ5QnNPBh8EJRTCtyZau+RqE-0w@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] gpio: sim: new testing module
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 1:28 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>

[snip]

> > +
> > +static ssize_t gpio_sim_sysfs_line_show(struct device *dev,
> > +                                     struct device_attribute *attr,
> > +                                     char *buf)
> > +{
> > +     struct gpio_sim_attribute *line_attr = to_gpio_sim_attr(attr);
> > +     struct gpio_sim_chip *chip = dev_get_drvdata(dev);
> > +     int ret;
> > +
> > +     mutex_lock(&chip->lock);
> > +     ret = sprintf(buf, "%u\n", !!test_bit(line_attr->offset, chip->values));
>
> Shouldn't we use sysfs_emit() in a new code?
>

TIL it exists. :) I'll use it.

[snip]

> > +
> > +static ssize_t gpio_sim_config_dev_name_show(struct config_item *item,
> > +                                          char *page)
> > +{
> > +     struct gpio_sim_chip_config *config = to_gpio_sim_chip_config(item);
> > +     struct platform_device *pdev;
> > +     int ret;
> > +
> > +     mutex_lock(&config->lock);
> > +     pdev = config->pdev;
> > +     if (pdev)
> > +             ret = sprintf(page, "%s\n", dev_name(&pdev->dev));
> > +     else
> > +             ret = sprintf(page, "n/a\n");
>
> I dunno '/' (slash) is a good character to be handled in a shell.
> I would prefer 'none' or 'not available' (I think space is easier,
> because the rules to escape much simpler: need just to take it into
> quotes, while / needs to be escaped separately).
>

My test cases work fine with 'n/a' but I can change it to 'none' if
it's less controversial.

[snip]

>
> Also don't know what the rules about using s*printf() in the configfs.
> Maybe we have sysfs_emit() analogue or it doesn't applicable here at all.
> Greg?
>

There's no configfs_emit() or anything similar. Output for simple
attributes must simply not exceed 4096 bytes. It used to be PAGE_SIZE,
now it's defined in fs/configfs/file.c as SIMPLE_ATTR_SIZE. There's no
need to check the length of the string here though as we're only
showing what we received from the user-space anyway and configfs makes
sure we don't get more than SIMPLE_ATTR_SIZE in the store callback.

[snip]

> > +
> > +static int gpio_sim_config_commit_item(struct config_item *item)
> > +{
> > +     struct gpio_sim_chip_config *config = to_gpio_sim_chip_config(item);
> > +     struct property_entry properties[GPIO_SIM_MAX_PROP];
> > +     struct platform_device_info pdevinfo;
> > +     struct platform_device *pdev;
> > +     unsigned int prop_idx = 0;
> > +
> > +     memset(&pdevinfo, 0, sizeof(pdevinfo));
> > +     memset(properties, 0, sizeof(properties));
> > +
> > +     mutex_lock(&config->lock);
> > +
> > +     properties[prop_idx++] = PROPERTY_ENTRY_U32("gpio-sim,nr-gpios",
> > +                                                 config->num_lines);
>
> > +     if (config->label[0] != '\0')
>
> I'm wondering if we need this check. Isn't core taking care of it?
>
> > +             properties[prop_idx++] = PROPERTY_ENTRY_STRING("gpio-sim,label",
> > +                                                            config->label);
>
> > +     if (config->line_names)
>
> Ditto.
>
> > +             properties[prop_idx++] = PROPERTY_ENTRY_STRING_ARRAY_LEN(
> > +                                             "gpio-line-names",
> > +                                             config->line_names,
> > +                                             config->num_line_names);
> > +

But I would be creating empty properties for nothing. Better to just
not have them at all.

[snip]

Bartosz
