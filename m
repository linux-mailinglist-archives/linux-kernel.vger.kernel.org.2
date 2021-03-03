Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08D932BC82
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359224AbhCCOEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842915AbhCCKW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:29 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2102BC0698CD
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 01:11:21 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id q23so27677482lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 01:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pvXRasKDNnUplGKqzHk62n6lD6KnrrKXY+1eJIPLqe0=;
        b=WiFl8QOb5leynrCtKe3zMsV9KlbTPbHg35wYGEgWIxoqyPP0cCLWwEGVii8/y/twcB
         xR1RwxlK5Ohll6CJ6xQDjX73wl4MGPtZsVJrMT6WEVZTUsf6n3loIcl7zfYWiBS/FYyC
         FfvTzQfpQU6W2eZ59V7XtFzQlNcoSsRa1+wTpwAP4J/UV3EH4YU7psNWmHTvall9bZHH
         WLRxgQKcPwQUUe2DSABPa2aSWFOYGh4b1Hjs/YSPAkMMXM4NXlQTyXa5iiDPZtQ87RxJ
         vgcFpekosl3g2vts8OT3rCEYp6yZLhNts8p7pM3oHGR5d37Q8qEVdw/HHTEclmNxjhCx
         NIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pvXRasKDNnUplGKqzHk62n6lD6KnrrKXY+1eJIPLqe0=;
        b=NSMhfyZrRyIza12bVW9stAbZ7EnALinlEltOxbdXsCGeoJxBG3mf3NqvTH3R1SVbjA
         iCJ/jP8mkb7as/1jdPJtLu791PLpXGsO1aI9JGsiPfeof5+W4jqK9JFl8H4gSDQLzAYU
         cOVxn72e6VuB3bo6XvNSJgDdztq4AM7NiWi8l46ygGh2SD2cJ3Np+eCROKshzZRe3vx0
         dF+B4r1QioUDMpUe5Rj1yIujLFtz2Mms5drRu+CbPQQpQ4RxiKRUZK0tflJH9tULuhNL
         wvEw6h0EeoxnrGrhty09ZxZys/3OAoajiSR1tvDNgBmPPn0YIn7AIIBZkib7SrEONa8Z
         gHGg==
X-Gm-Message-State: AOAM5338e7pBJUJobe/PiqV3MjOPQzCteoLnnY8TW2gvYIwVhWl8UAk7
        0xNiGvwqKh55DBnK3m2tq4e0c7AbrhpjzMxl2zWuzcQGe//0Rw==
X-Google-Smtp-Source: ABdhPJwRAdGtZseF4AGCcWugqL080PWu2zQkl7W3itQgLw4vUj76ghMl0LRAP1ir1rNQSyMXtIt2o5cPqOPa3q+AHYs=
X-Received: by 2002:a2e:9004:: with SMTP id h4mr11225796ljg.326.1614762679638;
 Wed, 03 Mar 2021 01:11:19 -0800 (PST)
MIME-Version: 1.0
References: <20210302153451.50593-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210302153451.50593-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Mar 2021 10:11:08 +0100
Message-ID: <CACRpkdZX=kipnYukV6Y5GZmmB_GEB6htM5HP4fJbPOOhiLBtHQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] gpiolib: Unify the checks on fwnode type
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 4:35 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> We have (historically) different approaches how we identify the type
> of a given fwnode. Let's standardize them across the library code.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks way better like this, with your follow-up fix folded in:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
