Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043AD3C6022
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhGLQLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhGLQLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:11:51 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8487EC0613DD;
        Mon, 12 Jul 2021 09:09:03 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id k20so11765817pgg.7;
        Mon, 12 Jul 2021 09:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLWwArdw3WJ78Jh1viBr73LCB/P7OLCQZa0RIq5R7bA=;
        b=FX+FDFs4CpB2lqn39HrlK+3mIySS0wpd8KwkvXWmUFXlwoFWEmiQ3ti+V4EJ7+ChvI
         N5LeknNX06pjr7sLBL9emtd0h4YxZ2SbHkOPqxMHNGClNhthRDGNu2xCVimJLeLXqmdE
         dX68G8g/ix4xNWmmGl4klagfCRrbFYXKILCLI49iJO/py3wUd7eN/jXai0He5oEXq+N6
         Az6t4GqMZYllTkpS3wP2GeeJ2qOoIWC7neyrp41SqEbFPNoNHUvgbJwFGZrF7Pi4G5ab
         8uJ2Jii2bvlHS9Kn7LhhTkucSX/a+h7A5L6AQHTmsYk2jVHMIQJtPwv4S9/MXG9/FiiX
         3Vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLWwArdw3WJ78Jh1viBr73LCB/P7OLCQZa0RIq5R7bA=;
        b=qaqPiqs83UOVEszzA0MiZxB7tB7Z1POISZbTSWHIHpDMH2SjQN+ZerzVJsfNedQXjq
         wmA+kf7uzWTfbncs7t6hIpCfrvBUfZDG4iwrnIAb1TJjlZQaX4E6BXsbJioJpmAcAjLb
         8/isu2Kgt/g+1N0a3YNi6e/i2OPUVh6ZnHMpi1iIZf5aDTMX4ZvXUWMEUdf0E3pgjaR2
         PWbft1ZR+kWEwoA/2SBQjg5g/9XAwpfyr/Arc4t5FaJH3uJjzQkLY8BibYMMFHVZeYjc
         D6hC/MCBMq6MeWZD5Saf5iSi4MWJE8lEo+EC8jlmrHRZg9YNxmoFt70IX3mzSowcyE6c
         dsLw==
X-Gm-Message-State: AOAM532GzRXYtpuuECvqYfQdMZZCeAk1gGhCjke4oAZefGfkylRfmYqj
        5+O/JqKR0XCeh8Z2kryAxkTkqCeWGDUNQpBoqMo=
X-Google-Smtp-Source: ABdhPJxCF21a8BjCJ3aoG+5ZrAAswsoye7CQYhZVQ/l/or1h1pLBMlNHf4f2oqSXRptfEbsgmE6wNN6ibOdkNykMplA=
X-Received: by 2002:a65:434a:: with SMTP id k10mr44360501pgq.4.1626106143006;
 Mon, 12 Jul 2021 09:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210708224226.457224-1-djrscally@gmail.com> <20210709170426.GC4112@sirena.org.uk>
 <CAHp75VeugcuwWAq5p_rx+8J2FsX7igV+UJ3QKw3XG6BiDqTtNQ@mail.gmail.com>
 <20210712124223.GB4435@sirena.org.uk> <CAHp75VeyNyYSbTMgS+5tXxOZehfxt6Wws9jScKYRKQhRRGDwsg@mail.gmail.com>
 <20210712133428.GD4435@sirena.org.uk>
In-Reply-To: <20210712133428.GD4435@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Jul 2021 19:08:23 +0300
Message-ID: <CAHp75VcQUUDdLYbpvTXSMPvjBzbHtBxywVBPS_xfY5JXyo9XxA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kieran.bingham@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 4:35 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jul 12, 2021 at 04:01:05PM +0300, Andy Shevchenko wrote:
>
> > The software nodes shouldn't appear on its own in the generic code.
> > When we use software nodes API in it, it means that we have tried
> > other providers _explicitly_ and haven't found what we are looking for
> > and hence we have to check if software nodes are providing the same.
> > For example, here it's done that way:
> > https://elixir.bootlin.com/linux/v5.14-rc1/source/kernel/irq/irqdomain.c#L178.
>
> > In all other cases it shouldn't be called explicitly.
>
> But why?  I'm not seeing the advantage over providing platform data
> based on DMI quirks here, it seems like a bunch of work for no reason.

What do you mean by additional work? It's exactly opposite since most
of the drivers in the kernel are using the fwnode interface rather
than platform data. Why should we _add_ the specific platform data
handling code in the certain drivers instead of not touching them at
all?

-- 
With Best Regards,
Andy Shevchenko
