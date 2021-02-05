Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399923107A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhBEJUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhBEJRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:17:01 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33F2C0613D6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 01:16:15 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f1so8894868lfu.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 01:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=scWNY9mupmRzt/F1WVqAch2cVF+bwZLRya1VRYsbSF8=;
        b=HELDII5QXEgvve0+Ea15WZqlVtYjKBVb1Wffuzma3JTqaracJcVSfMUlFFoNzeJ8Ly
         SNPu6fgkijE1KkC1unmBOB520/0z47eO+XXo+lZTREROgPA4SUf4baljsDoi1WEFQSy2
         2oDpLUBGthL4SgLXzivvcIpSUKHQzBZNF/ESZvDNSAGch5JPNIjGbMvxeWwUCvnxi+DX
         kPoY9DH5Vk5cfq0ytHA7iLZyqBR6BwYhT0a8JYzoogQF2kKdPPvN8f2ZdZqMBuvQl6HI
         /me2wmAbqyH2d/vvJnBGJOP3iumHbFdmsks7Q+7GIOFFNxuPRpOjNvwxjlvq1iVPB6Rd
         XORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scWNY9mupmRzt/F1WVqAch2cVF+bwZLRya1VRYsbSF8=;
        b=GOY+Np9rvounVv6+aIZWjdnquoRAhRctK8+T+BCdzromgoIdmXbiNrbaq102mynZKA
         MqYmaFRcN22lQtJ0y+cUvfdad4PYqFUjMeH4v/n72o96wjU5ztFc993zzrVvYYf/6xjy
         MiDd7Cg60dEJKESQM87elZY6PzTgjPlkgBHUKIhlQdbGw2tVj2kN8ZOKw5MlJZswVbBN
         rBW+gISPu3MGQjh0P/wOPzMYN3mdnkI0obWLhuYSQ7bQpCHQPeYj+/FT6IsYrQ8Jta54
         MoqA50+s7viqTdCunYoYY/sO13Lq+6WFtu8skfmTGyKO8gafBt9Udl6Uix2mn3JeINh4
         kHCA==
X-Gm-Message-State: AOAM530qnC2op+kpqhJ2httHqSolKWUdxP7anUMVETUO1cAEdtAe0b0G
        gbc9RKyZSM1cffLKaCGZXSuOqIQJ1ezzz5vZxJfzTQ==
X-Google-Smtp-Source: ABdhPJw9ENT8CgP1jlyYs3IM91+VlZiYS2/7C4boQs2yEj+K21U3g4Xj6GxYdUHH4CVF4QYJ9kPmaoV3lAj6RTN2sTA=
X-Received: by 2002:a05:6512:214a:: with SMTP id s10mr1949477lfr.225.1612516574117;
 Fri, 05 Feb 2021 01:16:14 -0800 (PST)
MIME-Version: 1.0
References: <20210204153951.1551156-1-arnd@kernel.org>
In-Reply-To: <20210204153951.1551156-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 Feb 2021 10:16:02 +0100
Message-ID: <CACRpkdYpHAN5XYLxRj4Rktzj+LbGRFYwtUU72gqUwE=AEt0j6g@mail.gmail.com>
Subject: Re: [PATCH] leds: rt8515: add V4L2_FLASH_LED_CLASS dependency
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Dan Murphy <dmurphy@ti.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 4:39 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The leds-rt8515 driver can optionall use the v4l2 flash led class,
> but it causes a link error when that class is in a loadable module
> and the rt8515 driver itself is built-in:
>
> ld.lld: error: undefined symbol: v4l2_flash_init
> >>> referenced by leds-rt8515.c
> >>>               leds/flash/leds-rt8515.o:(rt8515_probe) in archive
> drivers/built-in.a
>
> Adding 'depends on V4L2_FLASH_LED_CLASS' in Kconfig would avoid that,
> but it would make it impossible to use the driver without the
> v4l2 support.
>
> Add the same dependency that the other users of this class have
> instead, which just prevents the broken configuration.
>
> Fixes: e1c6edcbea13 ("leds: rt8515: Add Richtek RT8515 LED driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> +       depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS

This kind of thing that looks like a truism but isn't is one of the
most unintuitive
things about KConfig :/ no idea what to do about it though.

I remember making a program for the C64 in early 1990ies with joke input
such as y/n/m (yes/no/maybe), sadly in Kconfig this is no joke.

Yours,
Linus Walleij
