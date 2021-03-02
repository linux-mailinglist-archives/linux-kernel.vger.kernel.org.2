Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2592432AA38
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581673AbhCBTQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347933AbhCBQc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:32:26 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B6BC0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 08:21:36 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id u18so11044324ljd.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 08:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDtVuAUG8eYI5Eln5QS/TclUSCWz1TjGe2OhWQ2Hzok=;
        b=if3nP/oZALnybjJAUkUtzqsvs3YK7lJTKnmGNAKAtkwkVzIB8mFHuhnw39Age4qxUS
         UXw4iYbDW54LVkGsJpSlpCufhFpXSXWrspZnZVQvzvmbL4hoMK6k1yEd5RN5BV+l0zKp
         tXtWk5HPWV2fweqJVtX8sHIWvuZWbxVoSpCFOUKgPtdFaCV2kH7EuRSveUN20qcFG1og
         wyrqlkSN21mX7hX7xxtgzoot8V4HzSFxwkYFb/OJ+vf7aE1D4NJTbKYunNSiNEI9kP9y
         s+wCBi42PEGQZkVQoauPMQTxxO1r/MHtP+jvcnpmfUsTbIdbT4RlvrpKFT5uBgM18SPw
         Mw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDtVuAUG8eYI5Eln5QS/TclUSCWz1TjGe2OhWQ2Hzok=;
        b=LN7+2Ug1gYGjuAMNkf7jOIwvyGleOnc4t5AIQJRMM+r2OtpDg2jYuagiW0xz77fN1h
         4OeXlzQdJwKn+/bMf70QuwklP593Xcc1tIQsoViOBrZWOdcW29qh4TdvFqKSSkk5ogiN
         6Urfpj4Xk6YwI6csI8UXOpieamBUZnZQJDl/it2Zn/afA+NyApDfzOe44EOvGspd9nAU
         d7KAWbE9DTAj0beiYeePe3ZFOJhYaotwK8qaD0e2QWS35cHQs+etNJy3zVkDdaXyJUBr
         lLbLs7gW1Rxm5n07xmOBAlDAjZFbs/zD0S+u9bqJXhOEx22BVtVABXZ0XD/WWteVGxsm
         7t9A==
X-Gm-Message-State: AOAM533MaWD28h3qdRYqzNtKIVJGjOowkmg91qhcn79F6//75x4zXvMQ
        6vxyxveBw2XdumsemwrQtigdgM/kFpS7mQxbD4xqAA==
X-Google-Smtp-Source: ABdhPJzXqrYBkkHlZel98Kbs7UOBikTi+iuddAEEWTpHvvJw+VnT+XciCztoznAVqXpZN+sKledBjpv4CVaTd6nqOkQ=
X-Received: by 2002:a2e:9041:: with SMTP id n1mr12550220ljg.273.1614702094699;
 Tue, 02 Mar 2021 08:21:34 -0800 (PST)
MIME-Version: 1.0
References: <20210302011813.2331879-1-alexander.sverdlin@gmail.com>
In-Reply-To: <20210302011813.2331879-1-alexander.sverdlin@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 17:21:23 +0100
Message-ID: <CACRpkdYErJH5RUjL+jPC5vnaqGiOqBwHsr0E42wOWrpBGrpS3w@mail.gmail.com>
Subject: Re: [PATCH] gpio: omap: Honor "aliases" node
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 2:18 AM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:

> Currently the naming of the GPIO chips depends on their order in the DT,
> but also on the kernel version (I've noticed the change from v5.10.x to
> v5.11). Honor the persistent enumeration in the "aliases" node like other
> GPIO drivers do.
>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
> Yes, I noticed checkpatch "WARNING: DT binding docs and includes should be
> a separate patch."
> However, the parts below are tiny and barely make sense separately.

I've shut it down in the past because the instance ordering is a
linuxism and the needs are in the Linux userspace somehow.
It is different from a UART for example, which always need to
be at the same place on any operating system, hence it has an
alias.

For kernelspace the instance order should not matter, since
all resources are obtained from the device tree anyway
by phandle.

For userspace:
The way to determine topology in Linux userspace is to use sysfs,
and combined with the GPIO character device this provides a
unique ID for each GPIO chip and line on the system.

/sys/bus/gpio/devices/gpiochip0/
/sys/bus/gpio/devices/gpiochip1/

etc can change, but these appear as PCI, I2C, SPI, platform
etc nodes as well. On my PC:

/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.5/1-1.5:1.0/gpiochip0

It's pretty clear where that gpiochip sits.

Yours,
Linus Walleij
