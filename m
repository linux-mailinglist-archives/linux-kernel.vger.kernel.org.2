Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BC5357E24
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhDHIdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHIdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:33:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4CDC061762
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 01:33:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u21so1570625ejo.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 01:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5yCCjiWkAwqATqPSjIjQNyLbmG/huiKlevGSmwkEyR8=;
        b=IILPK87co6cRB30SBUD84s8jNEWHphYGfXu/trBxCn+HYZUD6LJxbIvbuvoFnHEIkJ
         8pT9+YwIxsWGPJRTvxmuhYnpdDMWE7ehCgXLZT0USf+os5lIdDr2/icw83jnnqMaPnDJ
         xXGMlpCnW+2Bu77aPYpaluIWMrDqKvl0b4qJ+jfLyt0aqMRftlIA69uuWYb5OSO+DKwb
         4bGlRcnt0chwis+3AaomfayoRZ6xkjTia6ZhRGhXeGDRVC2/knn8LJ4eYbjKQEIthRZr
         ela4zkCP9xWbLI0gWkQc5AW86VMw5RLYQeftE2A7cyrwz4VxXYWsVzKjDOPL7iBUiTGz
         7W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yCCjiWkAwqATqPSjIjQNyLbmG/huiKlevGSmwkEyR8=;
        b=S1cwc34gMD8S+A88Q48LU9VVHxp5o/UofU0NCLx/Wx7qfggVkgu7BvgLUeZUwd+jP+
         w/bfB7KOnbloVg8v0O0B3gH831e5YjaRtpEUWbIkjZpqWiQPhGF5gQ6LXybE7/wvo7zV
         h6wCgL2+/ovGclQ9ch/V8Kbw2L4iSXPxb/0kU1r4niXynZmPtM+apepqLBg4slYSXWWQ
         HvBJOHrvsKtI+Z1yi85eTLDd6XpwX6EmHwtYIHbYduHaVdXl9J+XhFRiBs+ZsJ4zOXq2
         stBUaVWzgC8HpN5JXNE8GEd3sVZmugE0hUhv2kQ94LVG4OcdeqoSDlcvwVp3fvZZfLs1
         GRAw==
X-Gm-Message-State: AOAM532Kqs6FJCTqPDuOwzBXDFoWihIVC9dCfboXV9sn/huB/A4w9WRH
        wH3mBH9gVMolShgkE3dBk1OchaSq05RgLWtQy4AlKf36BcccKqb9
X-Google-Smtp-Source: ABdhPJyu6/8vxWkUZcupdWZS44/FuHmo3e72vR0EqZhptpOKA0zGOzhX+uQpSlk8g3+BrTRTBir+tAGqYdWiAxlxXLk=
X-Received: by 2002:a17:906:9605:: with SMTP id s5mr8993580ejx.287.1617870811400;
 Thu, 08 Apr 2021 01:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsiRYaE+y44ApDkvPvbDCdiJ+nnCMhiiaPVsg6p8m4+1Q@mail.gmail.com>
 <CAHp75VdJ7kGXN6sk8HTeSfAKQtHDGSmtdVPn7CSkK5=yfDizuA@mail.gmail.com>
In-Reply-To: <CAHp75VdJ7kGXN6sk8HTeSfAKQtHDGSmtdVPn7CSkK5=yfDizuA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 8 Apr 2021 14:03:20 +0530
Message-ID: <CA+G9fYuG12WaC6QAdx1k80v8-As7a7oVVkhaUDxqgV=BaunfxQ@mail.gmail.com>
Subject: Re: [next] [arm64] [gpio] BUG: key has not been registered! DEBUG_LOCKS_WARN_ON:
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Colin King <colin.king@canonical.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 at 04:21, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Thu, Apr 8, 2021 at 12:38 AM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > While running kselftest recently added gpio gpio-sim.sh test case the following
> > warning was triggered on Linux next tag 20210330 tag running on arm64 juno
> > and hikey devices.
> >
> > GOOD: next-20210326
> > BAD: next-20210330
> >
> > This is still happening today on Linux next tag 20210407.
>
> Can you add the following
>
>   sysfs_attr_init(attrs[i]);
>
> to the end of the loop in gpio_sim_setup_sysfs()?

Do you mean like this,

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index ea17289a869c..5fe67ccf45f7 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -296,6 +296,7 @@ static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
                dev_attr->store = gpio_sim_sysfs_line_store;

                attrs[i] = &dev_attr->attr;
+               sysfs_attr_init(attrs[i]);
        }

        chip->attr_group.name = "line-ctrl";


>
> If it fixes an issue I'll send a formal patch.

I will build and test this and report here.

- Naresh
