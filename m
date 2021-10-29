Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4095443FF94
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 17:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhJ2PcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 11:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhJ2PcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 11:32:02 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333BBC06120A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 08:29:33 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bu18so4591240lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 08:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zb5to8IVmbXLcOuzy5HbR2D8SvYMJeBSxxm0t+10yes=;
        b=jJdFEoGn8EIaT8Neu3EZWdJ0T5kC3jtTFduArBVtuDx6mWscceXNrcx8A7PEO5SBFt
         VxxBXXtewNAOyGL9NISwbn8uqUJ5agsj+UemHZbI2/6GXh0Tr7GVCB0sMxna8iiURDvP
         v9RHYsHtNaNk3Z5iFWB2866iTaQva51DvN9TpWrWrCbscBsIE0cO9GtkiubMAwsrOnIj
         yM8X/+Go+hn6MacM8IB9wZCUBNon7GCbqfRHOQnFdCG8KGX3ZiGnYkm2SdJYeEhRuB4s
         y7d2vyxzyYm6MajX8LroWwZMrNJxTMCADiRhF8UTkbgJfaP60pk1oD6GF5HsVYx/WHnM
         NnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zb5to8IVmbXLcOuzy5HbR2D8SvYMJeBSxxm0t+10yes=;
        b=79VNPj80IliKRPVZgExSGF0QndQUxNvL1Oxs0/BE2iIvb4/V7/ovnIeAPGKg5dTpHZ
         1//C2J/eMlYOHTOeISAISUHeTvVKw7fV1MX9tgN6ZnRMSKAOhrMrEHOu9iTdsSokloCB
         +oATkNQ83/SOyIhfjkT0goDQVHuQ8gjchkHbUfSJIR4NBj44fjBIMvvqrszrTFJes/Ha
         TzfXVToIu8lMqJ1G5jL1K6goCz30eXeGknGVPmhpK5u6uWYAf91HLSiohO+Ug5numPWw
         3SjRwF1eX/PxjSL48+XjEb+/LmJnkIu5wytiduh5so8+dxqHtdpVd3j/wRJ4q6Rylpao
         3wXQ==
X-Gm-Message-State: AOAM5319ZtJpp/UpyOHmDi4vSXHB1DEUd+P1h5un+BvrJaYeQQnwasQg
        tcgRXc9RfiyIsQ75kMDz9sRrVNT4ik8j1JGTO0oMTQ==
X-Google-Smtp-Source: ABdhPJz3Gt3DD4ggJlW5a/iffQ9H3If6jJ5fMxiXKNlpkM72XuoMKE2zri1Er8kmZWdw04yhv5F2a0V1Eko88RxRgy4=
X-Received: by 2002:ac2:5328:: with SMTP id f8mr11555895lfh.233.1635521371526;
 Fri, 29 Oct 2021 08:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211025224032.21012-1-digetx@gmail.com> <20211025224032.21012-21-digetx@gmail.com>
 <09c05206-c0e5-9a25-8ffa-b9291f6ea5ae@gmail.com>
In-Reply-To: <09c05206-c0e5-9a25-8ffa-b9291f6ea5ae@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 29 Oct 2021 17:28:55 +0200
Message-ID: <CAPDyKFoa5eQTrNxyiFevUCWitUecX=hi=y7qv1dC2mqk0+0XBA@mail.gmail.com>
Subject: Re: [PATCH v14 20/39] pwm: tegra: Add runtime PM and OPP support
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 at 17:20, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 26.10.2021 01:40, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > +     ret =3D devm_pm_runtime_enable(&pdev->dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D pm_runtime_resume_and_get(&pdev->dev);
> > +     if (ret)
> > +             return ret;
> > +
> >       /* Set maximum frequency of the IP */
> > -     ret =3D clk_set_rate(pwm->clk, pwm->soc->max_frequency);
> > +     ret =3D dev_pm_opp_set_rate(pwm->dev, pwm->soc->max_frequency);
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "Failed to set max frequency: %d\n", =
ret);
> > -             return ret;
> > +             goto put_pm;
> >       }
> >
> >       /*
> > @@ -278,7 +294,7 @@ static int tegra_pwm_probe(struct platform_device *=
pdev)
> >       if (IS_ERR(pwm->rst)) {
> >               ret =3D PTR_ERR(pwm->rst);
> >               dev_err(&pdev->dev, "Reset control is not found: %d\n", r=
et);
> > -             return ret;
> > +             goto put_pm;
> >       }
> >
> >       reset_control_deassert(pwm->rst);
> > @@ -291,10 +307,15 @@ static int tegra_pwm_probe(struct platform_device=
 *pdev)
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> >               reset_control_assert(pwm->rst);
> > -             return ret;
> > +             goto put_pm;
> >       }
> >
> > +     pm_runtime_put(&pdev->dev);
> > +
> >       return 0;
> > +put_pm:
> > +     pm_runtime_put_sync_suspend(&pdev->dev);
> > +     return ret;
> >  }
> >
> >  static int tegra_pwm_remove(struct platform_device *pdev)
> > @@ -305,20 +326,44 @@ static int tegra_pwm_remove(struct platform_devic=
e *pdev)
> >
> >       reset_control_assert(pc->rst);
> >
> > +     pm_runtime_force_suspend(&pdev->dev);
>
> I just noticed that RPM core doesn't reset RPM-enable count of a device
> on driver's unbind (pm_runtime_reinit). It was a bad idea to use
> devm_pm_runtime_enable() + pm_runtime_force_suspend() here, since RPM is
> disabled twice on driver's removal, and thus, RPM will never be enabled
> again.
>
> I'll fix it for PWM and other drivers in this series, in v15.

Good catch - and sorry for not spotting it while reviewing!

Maybe devm_pm_runtime_enable() isn't that useful after all? Should we
suggest to remove it so others don't fall into the same trap?

Kind regards
Uffe
