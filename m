Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63D640ED07
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240624AbhIPWBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240317AbhIPWBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:01:40 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2E6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:00:19 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t10so18582825lfd.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYxeJw3YeroKM6/An6mAzn8eNYhfCfCV9PLV4I2gARI=;
        b=t7YII+ZhPDFrUSuyjj/fygY3MZuzQ0NBeg5Jm+cGpkkAxKRk6mz+oZBoYdLMxrGD8f
         bce8gYPfEo2LLAfWW/NbYCCAT4Hh951rBha3l6ooqSOwIDl/piwRyOTVTwg4bid5UXhI
         vs6z1Js41owlA8Q3UKEtCQs9OKjHn0yySjG45s+2KYrZGVH+XRgpFJAfOk0WKu9Wiu3A
         JwpnZnYRXL4QsBUklB2PMTUoHaYQB5XbuQZ9fWmAAW0oE+59iXGWQh3tnxPDavT+WV0h
         0wDfoyYf/FyBquJKGvwT5lEYJKL7KtGgcgdJU/bKtEYVgORcs/UvQF3fkyKymAmuhlQu
         oExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYxeJw3YeroKM6/An6mAzn8eNYhfCfCV9PLV4I2gARI=;
        b=M0+B/EMlLOfsikfCo8gb/3b0nl20K9aNUvjqaDqqA+ZVY2CNZbPqitzcbm46G4etZK
         HW+jPkaY+6mRct03KLSYJJkoHtq0ZpDw6HSG4zFSTE8GrtKzA2yHzYXyyScZ9zDktxCb
         S8bIvEIn5eSGyZv88qtfaHw6vs75sDqlc+JsE4Kgsz1k8JkKci8gkPuBmZ00xQMH+57u
         OxtsAKDvw27eVQfeWBQOJVUACnocBTHrkLgtyBNqHQKwp7HQVjc+ChyrVyDrQEkx6urD
         wOTv5PTpqxz6zeV2Ji3nv0PAC7n9D4ilE/hZWeXfJe6cr1HVwduupopma4itwLsAEk+5
         U0ag==
X-Gm-Message-State: AOAM530ct1dkj8fP8WTi26UggTI3OsAggT2SSzd78IHwZgZ7QeycIcvL
        fKf0nuu+AS/uyDbcT/umpeea65tv+srdRF/XjSvNyA==
X-Google-Smtp-Source: ABdhPJzpONGnnlfySn0Wq3vjyZScc6QDgbkxwu3qxwx30S2fEwr5dHP7q6ZqOwWRWGZRMQ3XxGlvvIWmJ/n/OKlOGFc=
X-Received: by 2002:a19:f249:: with SMTP id d9mr5716153lfk.229.1631829616694;
 Thu, 16 Sep 2021 15:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210824164801.28896-1-lakshmi.sowjanya.d@intel.com> <20210824164801.28896-16-lakshmi.sowjanya.d@intel.com>
In-Reply-To: <20210824164801.28896-16-lakshmi.sowjanya.d@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Sep 2021 00:00:05 +0200
Message-ID: <CACRpkdYZpQqYPYLaMrqQxOzvaU2DqaxWOwhfq4=2EK6hMP8oHQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 15/20] pwm: Add capability for PWM Driver managed state
To:     "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>, bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 6:48 PM <lakshmi.sowjanya.d@intel.com> wrote:

> From: Christopher Hall <christopher.s.hall@intel.com>
>
> Add additional flag that can be set by drivers to indicate that the
> driver will manage its own PWM state. When calling pwm_ops.apply the
> driver applies the requested state change to the pwm_device reconciling,
> if possible, any conflicting requests.
>
> Intel(R) Timed I/O devices support very limited PWM capabilities. The
> duty cycle must always be 50% of the period. When changing one parameter
> at a time through the sysfs interface, it isn't possible for the user or
> the PWM subsystem to maintain this relation.
>
> Signed-off-by: Christopher Hall <christopher.s.hall@intel.com>
> Signed-off-by: Tamal Saha <tamal.saha@intel.com>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> Reviewed-by: Mark Gross <mgross@linux.intel.com>

These PWM changes clearly need to be reviewed by the PWM
subsystem maintainers, and I think all of the output generation
portions of this really need to go into the PWM subsystem.

Yours,
Linus Walleij
