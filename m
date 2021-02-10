Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78592315F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 07:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhBJGgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 01:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbhBJGgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:36:21 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5103EC061574;
        Tue,  9 Feb 2021 22:35:41 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id w20so859696qta.0;
        Tue, 09 Feb 2021 22:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OXavdBpvyb1Dd4oqB+h0ECTg4yI3fOv5ICocqflKLWs=;
        b=U3TeKQmh4y3CaWmZxGHT2aKYLXNMmaTMhX74o7qey2Zqpli88QlRz1Xs6iuoUXdHpp
         vrDeFbsUwEWi9FKGrl/Vq8lyG/053P0M7F+3caw1kPcsncgM7m+SOqRxTLW369Uj/FFq
         A9qAxPNoHSKxxAxQ4h6PCTAT6kKIn8aoSohjxh7M15EiZ2Qlcez9KGqofJ+nPPNs1QUx
         9wUhYhnS7JNDZoy+WNsipI0nlpIZKUnH+4QuClQMepS8wOkv61BhtZ57FjpYx+xCISVn
         TLP+LLYgiCtBirVf4LfoqCjegiT3D+R7lUdUz6OYnOoczhRPL11mVNSvXNcSxevXYVoh
         +NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OXavdBpvyb1Dd4oqB+h0ECTg4yI3fOv5ICocqflKLWs=;
        b=IBPyk6Txk53zbQ7VvJdSfrFz8TR7Y3E3m/l8VVxzjuPqGlP6PJHjqNFQzK3VyLMc4C
         w4RSLFjAnLkVsXIdeKj+nqyCi1pzSkCBF0U91AIP1EjcNhnBiu37JjoYWC7UqBXysjEQ
         5I1AbuovSY6/YeGPByi+rLW8m3mLGiSs8E5bYOwh5jyVaVfZiQEUfRnWN5dx9AgMwk9/
         SVkai3y5PeVO29jYOde7mT1jzb04YBstGxPWHfR5lRGuwQzE/mMc3DYi8CL27D0K0qbc
         j1lA8bOEty0iy/s0xCb1o95oXuG7gYUYVy9a+9zyyCFr86USWYVS3PVXkbRI8Y/F3AUo
         OjYw==
X-Gm-Message-State: AOAM531NDFnNUCOCnSqWyKcZFQpeIiyFg9aVPDAHqO90Ddj2JngpL2s3
        jl7GGwWI3HlOOIgz/832vaNJz9I2nO8HKs5gqMTZ6qe5Uwhrhg==
X-Google-Smtp-Source: ABdhPJxAa/ZPqVfua2S148lPQM0vsrXWY7jYa5ufize6XE/GEpwPCHJc4pF60zzqGbSqwjyqF2HO1qXRtmfQ24UTEcw=
X-Received: by 2002:ac8:6f06:: with SMTP id g6mr1460808qtv.360.1612938940598;
 Tue, 09 Feb 2021 22:35:40 -0800 (PST)
MIME-Version: 1.0
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-3-git-send-email-shengjiu.wang@nxp.com> <20210208115112.GD8645@sirena.org.uk>
 <CAA+D8AMRGRRk6FzdiqaHAP1=dPJngNgmdGmU59vrroXA9BMyXw@mail.gmail.com> <20210209222953.GF4916@sirena.org.uk>
In-Reply-To: <20210209222953.GF4916@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 10 Feb 2021 14:35:29 +0800
Message-ID: <CAA+D8AN=SDMLhuNbstzHL_H2p_L6cr+oCXbauNB0gGs2BW5tmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] ASoC: fsl_rpmsg: Add CPU DAI driver for audio base
 on rpmsg
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 6:30 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Feb 09, 2021 at 05:16:16PM +0800, Shengjiu Wang wrote:
> > On Mon, Feb 8, 2021 at 7:53 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > hw_params() can be called multiple times and there's no need for it to
> > > be balanced with hw_free(), I'd move this to a different callback (DAPM
> > > should work well).
>
> > Which callback should I use? Is there an example?
>
> Like I say I'd actually recommend moving this control to DAPM.

I may understand your point, you suggest to use the .set_bias_level
interface. But in my case I need to enable the clock in earlier stage
and keep the clock on when system go to suspend.

I am not sure .set_bias_level can met my requirement. we start
the Chinese new year holiday now, so currently I can't do test for this
recommendation.

Maybe we can keep current implementation, can we?
Later after I do the test, I can submit another patch for it.

Best regards
Wang Shengjiu
