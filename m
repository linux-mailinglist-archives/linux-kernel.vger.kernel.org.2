Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977B63F5964
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbhHXHvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbhHXHvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:51:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCADC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:50:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id o10so43518605lfr.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QO1D4em1C1nHhx4CrZWdcZbA0xiY6t0RyCdsuKnSIc=;
        b=J+teq1gJxTGcdDdovG62/xyX0zhT90ekovliPz6FUvv+cDrIGlMWqeec3K5DhZKc9b
         sKzRTQMDvL7dFH9FPd5CtBuQJg+Yl4y2aHt19H1ZJaWGBeM6vKMdd16e3XeygeCCjpwz
         NZiY7+ewI6hasOprk90Ru4OtMSeauYeCE98rWJRp1keD1ZA9nOf0sBR2SfnGSQWWzcaj
         R9KJMY2CwAl6NH5DniF+cYgkyI8g7cQ3kPTvSyUA1+NWay+IXQ63Aovfs1ejma4xWtu/
         gezld7YZjfEnqsbWHNjvm7FZyx1xsix2sDbJjPRzLGU0RwB0mzKXgXdKc0C05/kRKjdc
         Vxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QO1D4em1C1nHhx4CrZWdcZbA0xiY6t0RyCdsuKnSIc=;
        b=SAjDPGENJwDwHXfXQmjmLlc9tSx9IJpJg9kyzVvag96i+o51zURLAgpP5ip9pXfO0O
         d3yXrErdBix3jOTV+9yI+3t3l1ylK2byDdAdtbeescPGFX6jbMjsIupNvdkW2pcKMR9O
         dH78MSDvftC2vTm4Lcpy3hRE6YF8aOnj2rvPz12r8b+Plh+wPgwV/OtVWoDPBhUmcDcZ
         KTlhYz0H9LzuaT/OC1mCN1PNSifMLrwCaNwCuaoUYn6z320rW4rurNul8UwF0/GhEBPM
         h6ZAT3iyOIUU4O8HLLA8rA8B0Jsi5scBPCGgpiaRkuPLNb+wBPvTGTXxzTeZSoT6mmNW
         jhhQ==
X-Gm-Message-State: AOAM530Ov1Ch8o7bkETbEljWHw13iyfTBzEEJe50qwofygbgg7OJNwh/
        B4kCD6kRddPHlb9VyzLBgge4PyLfr/WQ5JSl9DygSg==
X-Google-Smtp-Source: ABdhPJwx4dKcJvjHiOTt9/eKDcemiVgAnjhvJZRoh7bVIfSjwhVemY3ea6OxjbXR0eqxvl8sAu2ZYiMgikuVkG90MF0=
X-Received: by 2002:ac2:4d1c:: with SMTP id r28mr287872lfi.584.1629791424267;
 Tue, 24 Aug 2021 00:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210823202412.25716-1-digetx@gmail.com>
In-Reply-To: <20210823202412.25716-1-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 09:49:47 +0200
Message-ID: <CAPDyKFpsEMmuF4XzUX=ko4H3iBSu_77_+vozETg9njC94x8goA@mail.gmail.com>
Subject: Re: [PATCH v1] PM: domains: Improve runtime PM performance state handling
To:     Dmitry Osipenko <digetx@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 at 22:25, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> GENPD core doesn't support handling performance state changes while
> consumer device is runtime-suspended or when runtime PM is disabled.
> GENPD core may override performance state that was configured by device
> driver while RPM of the device was disabled or device was RPM-suspended.
> Let's close that gap by allowing drivers to control performance state
> while RPM of a consumer device is disabled and to set up performance
> state of RPM-suspended device that will be applied by GENPD core on
> RPM-resume of the device.
>
> Fixes: 5937c3ce2122 ("PM: domains: Drop/restore performance state votes for devices at runtime PM")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Rafael, if not too late, can you please queue this as a fix for v5.14?
I haven't heard about any regression, but the error is there.

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index e1c8994ae225..3a13a942d012 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -435,7 +435,7 @@ static void genpd_restore_performance_state(struct device *dev,
>  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>  {
>         struct generic_pm_domain *genpd;
> -       int ret;
> +       int ret = 0;
>
>         genpd = dev_to_genpd_safe(dev);
>         if (!genpd)
> @@ -446,7 +446,13 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>                 return -EINVAL;
>
>         genpd_lock(genpd);
> -       ret = genpd_set_performance_state(dev, state);
> +       if (pm_runtime_suspended(dev)) {
> +               dev_gpd_data(dev)->rpm_pstate = state;
> +       } else {
> +               ret = genpd_set_performance_state(dev, state);
> +               if (!ret)
> +                       dev_gpd_data(dev)->rpm_pstate = 0;
> +       }
>         genpd_unlock(genpd);
>
>         return ret;
> --
> 2.32.0
>
