Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D004332AD5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhCIPoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhCIPnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:43:49 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9694C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 07:43:48 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id l12so21111154edt.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 07:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sZr9r6fI7r4+t4w17yKTJjfVekLAeORM+vM+wv9vwU=;
        b=ZVk5GJ9ljaUFantUykH3qadtsuXKnzsjhxhzViQ149UuzK5WHNMaxPsrjjbNnwmf9S
         zuBz02Aq2oNeT6hKvKbpxfPix0vcmxgqRfYjVh/otXkG0EeVa4p5S1dNF2Sjltirq2SZ
         1nzc0TuWgYUJxh4EXVbNbHcnPFFU/CefnIGBOBaSB7JVHlm6BDF9x2d+ApKdkleabR5C
         k6UoNnDE74gzBdIqNI+yqGxyld4AUHntx0Yatg9v7qVdh4cHQjaj7JFvm7VLf38uxrAQ
         PmgNmc/OsH4tKvqigO6ZfC964cGbyMjRxDPgtZiYIWzPXW5yRXR0TZyLDec1DCgrdvE5
         Mj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sZr9r6fI7r4+t4w17yKTJjfVekLAeORM+vM+wv9vwU=;
        b=jhWIu90YrKPqhCQ8Az5S1RBk67+p1smMcyK6EZj1QM3CYe+9Ms671/vxanRF51fXlJ
         Yh0cJxtrx27wtb+NDdpzv6oMW9bq0rbOMrvMKOGVwry2+UZE9GuQCUR6Z7oG+OQm38Uf
         oSa8UZohQCDdKcogswVKNRL9h7nzI1yHGH5I/vnWDR7PSbWWVEp3imvD5Kkbqu5OoggB
         +7bzx6T/45uUWE9GlcE1tbuGAFlwobGvYlEgIoLu5FjoWnG2yrMIyFiFBeEaFXlCgC2x
         jlJ65+V5JBuGsk/9hTaq+qlUwKZnE652WnpCZ1C2VH5taTWLA1t2zXd76Qocr3LsxT1W
         9Uew==
X-Gm-Message-State: AOAM532mU0HJ/9zAc7wxkwk/oE49khta29QFn1pnhrNnBigGIOd52/Z3
        GoracF5mo7GnCy/Oe//rzpuU4kyLpcSx9BvHuFpQEb2oHnFXIw==
X-Google-Smtp-Source: ABdhPJwd1S0e8S8cg6kxwZDXa4+nwPtDxLSrDLyYs0ScEQWrKwV7nO2uPlIbZRFHivU8iMFcoWUa+jK/zA/bZWBbukU=
X-Received: by 2002:aa7:dc0b:: with SMTP id b11mr4218153edu.124.1615304627413;
 Tue, 09 Mar 2021 07:43:47 -0800 (PST)
MIME-Version: 1.0
References: <20210309153443.16647-1-brgl@bgdev.pl>
In-Reply-To: <20210309153443.16647-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 9 Mar 2021 16:43:36 +0100
Message-ID: <CAMRc=MfO7J1z8oGy+OiRR000dJAYg1LTynz33Kh6BMb1hUrg5g@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: fixes for v5.12-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 4:34 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> Linus,
>
> Here's a bunch of fixes for the GPIO subsystem. We have two regressions in the
> core code spotted right after the merge window, a series of fixes for ACPI GPIO
> and a subsequent fix for a related regression in gpio-pca953x + a minor tweak
> in .gitignore and a rework of handling of the gpio-line-names to remedy a
> regression in stm32mp151.
>
> Please pull!
>
> Best Regards,
> Bartosz Golaszewski
>
> The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:
>
>   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.12-rc3
>
> for you to fetch changes up to b41ba2ec54a70908067034f139aa23d0dd2985ce:
>
>   gpiolib: Read "gpio-line-names" from a firmware node (2021-03-08 11:59:17 +0100)
>
> ----------------------------------------------------------------
> gpio fixes for v5.12-rc3
>
> - fix two regressions in core GPIO subsystem code: one NULL-pointer dereference
>   and one list corruption
> - read GPIO line names from fwnode instead of using the generic device
>   properties to fix a regression on stm32mp151
> - fixes to ACPI GPIO and gpio-pca953x to handle a regression in IRQ handling
>   on Intel Galileo
> - update .gitignore in GPIO selftests
>
> ----------------------------------------------------------------
> Andy Shevchenko (4):
>       gpiolib: acpi: Add ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER quirk
>       gpiolib: acpi: Allow to find GpioInt() resource by name and index
>       gpio: pca953x: Set IRQ type when handle Intel Galileo Gen 2
>       gpiolib: Read "gpio-line-names" from a firmware node
>
> Bartosz Golaszewski (1):
>       selftests: gpio: update .gitignore
>
> Johan Hovold (2):
>       gpio: fix NULL-deref-on-deregistration regression
>       gpio: fix gpio-device list corruption
>
> Yang Li (1):
>       gpiolib: acpi: Add missing IRQF_ONESHOT
>
>  drivers/gpio/gpio-pca953x.c             | 78 ++++++++++-----------------------
>  drivers/gpio/gpiolib-acpi.c             | 21 ++++++---
>  drivers/gpio/gpiolib.c                  | 19 ++++----
>  include/linux/acpi.h                    | 10 ++++-
>  include/linux/gpio/consumer.h           |  2 +
>  tools/testing/selftests/gpio/.gitignore |  2 +-
>  6 files changed, 58 insertions(+), 74 deletions(-)

Hi Linus,

I realized only after I sent out this PR that I had rebased the branch
on top of v5.12-rc2 (because of the v5.12-rc1 situation) without
--rebase-merges and this caused git to drop the merge commit for
Andy's pull-request. Please let me know if you can pull this as is or
if I should rebuild my branch and resend.

Best Regards,
Bartosz Golaszewski
