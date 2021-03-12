Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA12338EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhCLNla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhCLNlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:41:00 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF61EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 05:40:59 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ox4so37818000ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 05:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SlkfLw8Neaaz5YToNxw3zyE/AeBfKZ9Au+54DNTf9Hg=;
        b=GRlQoI0IO2icO5oP/pQqgiELU7s2k4QaUbN89SPnVCX4EFGKK/xS7bHZaBeSCtYn+x
         LB7rIUXyM9eUVBqyooCCqKlDe/oplETynuBc0/gZgDMYZ1Auq+yxGJEvEYuh/VdpivN4
         S3S+I8544E7KYIw1/57UnsGPUWq+R9A+bCfFB0tDS5oDSs9CMgr+HvmSjPLUsCPEgiAc
         ccSBLkzKfpv6+QhsRnaQnGDC367d7tJSPtlj5CR26TjytMmSI4wOY9+vNb7SImAG/QOm
         sZzgP284Dz1oWV/RyGldeAWdCRYeO1TjFHhhps295Xss4Hzht8XMMuNjABIsGkrchzql
         fA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SlkfLw8Neaaz5YToNxw3zyE/AeBfKZ9Au+54DNTf9Hg=;
        b=k0QqoGP8Ro9zgvlOWojWlawO+Esi+Up3BHBhCXxhShxa1i3+o/wJkceNeh7j7yCoM4
         TLi11bhEi5rPC7PI7cK0Kjihpi+Ygb9+DfR7U6bgKeu72Tcq9yM/FphanRR7wvgSFiwP
         LvuX73BHpyzLC9sX0faJYO0tkPG8c8ZaKpOT4o3GVpn/ULsWata5K/F9KFfla+sJ5mtY
         iqoFfOPUNqBixkpZ3MHMSe1HWhJ2lagMryQOuOuUWQXTstEqpaqF2O+DJXsLxQfVJ3Ll
         lLD/xL3PTcfjIUrn/BZg8nfJvnI4zxiDun2EMvS6DWAMedbzVcGacO+QCMaU0QEGflGz
         Oflg==
X-Gm-Message-State: AOAM530+jPL32qfRXa2yv9NBF9+MkwMNxek8QbNenMGNYvAWVGqKemql
        QfwWFPmCzPc/bj7Bi+49oETg4987xYEiPQMzcx0AUw==
X-Google-Smtp-Source: ABdhPJwtm4v97kPrzdnQxf0mV2PkLS8sJs5nBVfE1CL3gYBJyAzifajJbvTYVgx2t203x80Jo1LjyBsd0Q/Fgg/CuYk=
X-Received: by 2002:a17:906:c0c8:: with SMTP id bn8mr8450077ejb.445.1615556458708;
 Fri, 12 Mar 2021 05:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20210309093736.67925-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210309093736.67925-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 12 Mar 2021 14:40:47 +0100
Message-ID: <CAMpxmJW=z+jX3grh+KuikEo0hwPNqz0JQDEyfGLsFzF8A8+f2w@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] gpiolib: switch to fwnode in the core
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 10:37 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> GPIO library uses of_node and fwnode in the core in non-unified way.
> The series cleans this up and improves IRQ domain creation for non-OF cases
> where currently the names of the domain are 'unknown'.
>
> This has been tested on Intel Galileo Gen 2.
>
> It touches GPIO core parts and it's expected that the series is routed via
> GPIO tree.
>
> In v6:
> - added tag to the patch 5 (Rafael)
> - dropped ops temporary variable (Rafael)
>
> In v5:
> - same as v4 + v3 (patches 1-4/5) in order to route via GPIO tree (Bart)
>
> In v4:
> - based on Rafael's bleeding-edge
> - split the rest to two patches (Rafael)
> - elaborate WARN() deduplication in the commit message (Rafael)
>
> In v3:
> - fixed subtle bug in gpiod_count
> - made irq_domain_add_simple() static inline (Marc)
>
> In v2:
> - added a new patch due to functionality in irq_comain_add_simple() (Linus)
> - tagged patches 2-4 (Linus)
> - Cc'ed to Rafael
>
> Andy Shevchenko (6):
>   irqdomain: Introduce irq_domain_create_simple() API
>   gpiolib: Unify the checks on fwnode type
>   gpiolib: Move of_node operations to gpiolib-of and correct fwnode use
>   gpiolib: Introduce acpi_gpio_dev_init() and call it from core
>   gpiolib: Reuse device's fwnode to create IRQ domain
>   gpiolib: Fold conditionals into a simple ternary operator
>
>  Documentation/core-api/irq/irq-domain.rst | 22 ++++----
>  drivers/gpio/gpiolib-acpi.c               |  7 +++
>  drivers/gpio/gpiolib-acpi.h               |  4 ++
>  drivers/gpio/gpiolib-of.c                 |  6 ++-
>  drivers/gpio/gpiolib.c                    | 62 +++++++++--------------
>  include/linux/irqdomain.h                 | 19 +++++--
>  kernel/irq/irqdomain.c                    | 20 ++++----
>  7 files changed, 75 insertions(+), 65 deletions(-)
>
> --
> 2.30.1
>

Series applied, thanks!

Bartosz
