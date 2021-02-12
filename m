Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E73319F43
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 13:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhBLM4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 07:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhBLMkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:01 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471AEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 04:39:11 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id h26so12885873lfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 04:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GbdleSJdC5sxhIjInjPeBKytNLAK4lW/uYJX+QcIxuY=;
        b=E3AwVJIJb0emzwQ9P0X/+qC9mp5j9CmtZInRpQabutsYl4eBYpG5L1uC4edYMlcsif
         dptpvCPGdDJ2YGHJhviKreu2eIksat4aY+2YR1gat9mc5ae8PX4t60gAJwPfIZU3Quex
         Qplnkd0gPXnAZst6vXcxTiAT7PTNxS/Jsr7Tlz6EUjSGJIYkrIPFd5QkuZjnDnMFP9Za
         NvaJBsPddiIIBpo289eHPy5pTdWSWLPui/KFAGV3BSiNaRgJ/FrWlJUiJfJLe+EYI+2i
         1sNk2/D3vzbD7uS1rTdMkiBmkqQYjx4SL8dWOB4A7trjjsclPk/W1Qpun8Pa+XGtxi35
         5KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbdleSJdC5sxhIjInjPeBKytNLAK4lW/uYJX+QcIxuY=;
        b=amaJKDpEEYZashIeJwttuNNCCSc4NvoSMUOq+oNO6IOOXV2YBFSARZjUiYlKD+pwxN
         H53mFfVLghSBPhIWPY9IKktqTYQdRN2lfWGmpDGPIvurIs6pmyUkz0sNQO+5Jji/P+QO
         PBc9p6wt8ALGSNC016oEWzwoLN5Ya5iJPm+kWLJZzdEsvbUWYQdCOTiJfDDNGO1cQaO8
         5WaZjhBhP3NiG5Qq9nZwilSY9WOYsSaiNIB+/5eI6HCT9WpMwoAP6f1rp4juzbO8AW6w
         8gPaqD5IRQ0r/+ZYP5XSPg9Wk0OKOZEZdCGzsPXSYyPMTgf1jdIXy3/MbznHICYw1Gya
         lD8g==
X-Gm-Message-State: AOAM5335ZBDraR8vvVZ161POjitu6rale6+DH4I8msRkZPDeUPbqtTei
        lK38Ews36nWVeoOyaFsgIfBuNrXZbAQBjSD1IdXFig==
X-Google-Smtp-Source: ABdhPJx9U5h3Tq56lc0kJylHa7Kr0AslGEOc90maPfzN54oNpqWzs05TCnHCbdi+q2Xdv77hIChspe3FcU2veOdXfJQ=
X-Received: by 2002:a05:6512:310d:: with SMTP id n13mr1525892lfb.586.1613133549786;
 Fri, 12 Feb 2021 04:39:09 -0800 (PST)
MIME-Version: 1.0
References: <202102120714.JSuT94C8-lkp@intel.com>
In-Reply-To: <202102120714.JSuT94C8-lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Feb 2021 13:38:58 +0100
Message-ID: <CACRpkdbEecZZ8UUtmBY3tiK51zv-Y7S=4wjHqqzubz4odzMt+w@mail.gmail.com>
Subject: Re: drivers/leds/flash/leds-rt8515.c:216: undefined reference to `v4l2_flash_release'
To:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I need Arnds help with this...

On Fri, Feb 12, 2021 at 12:05 AM kernel test robot <lkp@intel.com> wrote:

>    ld: drivers/leds/flash/leds-rt8515.o: in function `rt8515_v4l2_flash_release':
> >> drivers/leds/flash/leds-rt8515.c:216: undefined reference to `v4l2_flash_release'
>    ld: drivers/leds/flash/leds-rt8515.o: in function `rt8515_probe':
>    drivers/leds/flash/leds-rt8515.c:354: undefined reference to `v4l2_flash_init'

So the problem is that this is compiled in, so CONFIG_LEDS_RT8515=y
(it is tristate so can also be a module)
but it depends on symbols from a module:
CONFIG_V4L2_FLASH_LED_CLASS=m.

In the code I try to only support the V4L2 interface when using V4L2:
#if IS_ENABLED(CONFIG_V4L2_FLASH_LED_CLASS)
(... V4L2 code...)

Is there a way to define in Kconfig that if and only if you enable
this other module it has to follow the y or m that we use for this
driver?

Or do I simply have to bite the bullet, make it bool and
depend on CONFIG_V4L2_FLASH_LED_CLASS || !CONFIG_V4L2_FLASH_LED_CLASS
?

Yours,
Linus Walleij
