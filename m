Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C3F387367
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347174AbhERHnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:43:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239746AbhERHnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:43:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7A3061209;
        Tue, 18 May 2021 07:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621323751;
        bh=Im/ud3QbEyXaW+C1E0XlGLo8OIyfrTetRhyjc6Lp02I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YW7zuKLwTYwrSMdjAUGilRpBP8EsMEqPj2w6VTgLRHgRmOlc6J+rhc0e39C84tNPC
         78aHx5aBElsmh8EuHDaWcPSfsk3A94r9rOWgUpgiKJgZkW+QakDwQk4GOyRZ2/nYQD
         LhJ9qKEQdfTv+lUH/aKqVTVu7UH1cql8/KOmKhSllAfY7045gkOFOQi8tasv+73EWF
         6CLeTd1+5Q5RTZ58jSnbHlfUX7fxOOBmSyqUhZ0FNhwEMVN0EczVchDV8ddnepLAt+
         678zNcytpYByfXgPzejHondjyHSvA31zuIXNWVv4E4EFEdyaoRv2hkm3uy6myUsC3i
         4jv5QwJT83oZQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1liuN3-0005tT-7f; Tue, 18 May 2021 09:42:29 +0200
Date:   Tue, 18 May 2021 09:42:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Yu Kuai <yukuai3@huawei.com>, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Subject: Re: [PATCH] drm: bridge: cdns-mhdp8546: Fix PM reference leak in
 cdns_mhdp_probe()
Message-ID: <YKNv5fsVaTrslJZw@hovoldconsulting.com>
References: <20210517081601.1563193-1-yukuai3@huawei.com>
 <CAG3jFyvjD+Gf5C+sWA8Qi9Hp-tJHeCjqbWX5Fds3m41nCLreyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG3jFyvjD+Gf5C+sWA8Qi9Hp-tJHeCjqbWX5Fds3m41nCLreyA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 11:27:38AM +0200, Robert Foss wrote:
> Hey Yu,
> 
> On Mon, 17 May 2021 at 10:08, Yu Kuai <yukuai3@huawei.com> wrote:
> >
> > pm_runtime_get_sync will increment pm usage counter even it failed.
> > Forgetting to putting operation will result in reference leak here.
> > Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> > counter balanced.
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > ---
> >  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> > index 0cd8f40fb690..305489d48c16 100644
> > --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> > +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> > @@ -2478,7 +2478,7 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
> >         clk_prepare_enable(clk);
> >
> >         pm_runtime_enable(dev);
> > -       ret = pm_runtime_get_sync(dev);
> > +       ret = pm_runtime_resume_and_get(dev);
> >         if (ret < 0) {
> >                 dev_err(dev, "pm_runtime_get_sync failed\n");
> >                 pm_runtime_disable(dev);
> 
> The code is correct as it is. If pm_runtime_get_sync() fails and
> increments[1] the pm.usage_count variable, that isn't a problem since
> pm_runtime_disable() disables pm, and resets pm.usage_count variable
> to zero[2].

No it doesn't; pm_runtime_disable() does not reset the counter and you
still need to decrement the usage count when pm_runtime_get_sync()
fails.

> [1] https://elixir.bootlin.com/linux/latest/source/include/linux/pm_runtime.h#L384
> [2] https://elixir.bootlin.com/linux/latest/source/drivers/base/power/runtime.c#L1383

Johan
