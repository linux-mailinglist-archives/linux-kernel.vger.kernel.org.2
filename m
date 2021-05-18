Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A526387961
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhERNAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhERNAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:00:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94BAC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:58:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso1686379pjx.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mv2uwTbL30jlJAM/eaiNlLKn6+rdPCA/0KtvmGZQeAA=;
        b=DNo0vG/Los+2xPXou0DmP/K7ITFwoVlcYcfGs3JPRFjshrw7yl0Kh/6NURDRr0GZM1
         BrSt4M6vRuTzXy5MC0slfCjxj2bzDBFYZ3bDpnayjvlsrNygJ02FOmPOdIAHb+HjIrd1
         NtLz7QZ2n7B8Ql62a/NR8mCNzr0bPF82QqbjZu2kNgwD7JV5N+Q9hvRwqB1/0Dm4W/Ox
         fAHMCtJkwQ1it3eGHd5KEI38XwQA+2uUh9WMb+X+UoFnniHOa0M84azWvZu5UBuKu/HU
         ZoCjFC77XPvi4D+yLfB67Q4t/OzhgSz6+xnQyCO01oreHsLZAsWNtnBdrN66kkmzWkl8
         Uwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mv2uwTbL30jlJAM/eaiNlLKn6+rdPCA/0KtvmGZQeAA=;
        b=QI52cKzAor14lkLP928QX/qEshI0LETsCv4pudo8JKGOqjfzZzzWX17QMYRVa2nmx3
         +EqHzCmKEDoc+sBBwPmxSIoWnRZegl7IR8DX+KgWukpracsVwUUUKqtXLOlECAG/jZNl
         rBFC8Y/yf7mTablZfgBgxyVKMFqQUcyiMDi1Mm2nLUWOyEV21AGX/CFsLGz+HT+P4RLE
         asho8rYEnSAyO8GQCjJYkOz5C3ThUHjY9ODcruR79qm0vF6wkNtnJk9MZVY6aj6FOJlV
         ok8qWqBpre9sN70fv5gqoR6vToL7JikbqItm8IstSScLUm4i1pszkRK+kk7Kzc5AIDIY
         Dk+A==
X-Gm-Message-State: AOAM530Luxyx9Ponf8T3LY9TMsrmhuSix5MjRuMA2DNyJm5GHZt9IzfI
        hm7Zu+GO4svz0BH2VylOTOMSXCK3rbl6KaAkQUCMLw==
X-Google-Smtp-Source: ABdhPJwvPJXAq1cWqigGtb0woH3Q8hJnCu15moqg/VmcFxxsKkoR0ESvlmq4tiTL1iWXCRqFKiC/UCsODLkpBrmayDQ=
X-Received: by 2002:a17:90a:e391:: with SMTP id b17mr606869pjz.75.1621342723427;
 Tue, 18 May 2021 05:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210517081601.1563193-1-yukuai3@huawei.com> <CAG3jFyvjD+Gf5C+sWA8Qi9Hp-tJHeCjqbWX5Fds3m41nCLreyA@mail.gmail.com>
 <YKNv5fsVaTrslJZw@hovoldconsulting.com>
In-Reply-To: <YKNv5fsVaTrslJZw@hovoldconsulting.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 18 May 2021 14:58:32 +0200
Message-ID: <CAG3jFyu9x0NERFQ78GAX_6TUimB_PmBXkcVJZ9i+HXbK=N0dmQ@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: cdns-mhdp8546: Fix PM reference leak in cdns_mhdp_probe()
To:     Johan Hovold <johan@kernel.org>
Cc:     Yu Kuai <yukuai3@huawei.com>, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 at 09:42, Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, May 17, 2021 at 11:27:38AM +0200, Robert Foss wrote:
> > Hey Yu,
> >
> > On Mon, 17 May 2021 at 10:08, Yu Kuai <yukuai3@huawei.com> wrote:
> > >
> > > pm_runtime_get_sync will increment pm usage counter even it failed.
> > > Forgetting to putting operation will result in reference leak here.
> > > Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> > > counter balanced.
> > >
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > ---
> > >  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> > > index 0cd8f40fb690..305489d48c16 100644
> > > --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> > > +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> > > @@ -2478,7 +2478,7 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
> > >         clk_prepare_enable(clk);
> > >
> > >         pm_runtime_enable(dev);
> > > -       ret = pm_runtime_get_sync(dev);
> > > +       ret = pm_runtime_resume_and_get(dev);
> > >         if (ret < 0) {
> > >                 dev_err(dev, "pm_runtime_get_sync failed\n");

This error message is a bit confusing now, could you update it.

> > >                 pm_runtime_disable(dev);
> >
> > The code is correct as it is. If pm_runtime_get_sync() fails and
> > increments[1] the pm.usage_count variable, that isn't a problem since
> > pm_runtime_disable() disables pm, and resets pm.usage_count variable
> > to zero[2].
>
> No it doesn't; pm_runtime_disable() does not reset the counter and you
> still need to decrement the usage count when pm_runtime_get_sync()
> fails.

Thanks for chiming in Johan, you're absolutely right and I must have
misread something.

With the above fix, feel free to add my r-b.

Reviewed-by: Robert Foss <robert.foss@linaro.org>
