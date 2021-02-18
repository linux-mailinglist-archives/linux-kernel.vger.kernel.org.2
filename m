Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C22431E7D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhBRJJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhBRH6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 02:58:13 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD7CC061756;
        Wed, 17 Feb 2021 23:57:23 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id g24so801718qts.2;
        Wed, 17 Feb 2021 23:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bg6ZSnruXgfVD4jOeLrAxIfhO0SIr3QdWxHbt31ZHm0=;
        b=TKJDEV3ZCzXyQLPo4690LhuK/JxxBLbOYIkTDeL9v/WmrZ48dcpJnUb1Ovx1uQE0hy
         LPtmgBNuzWw9zeoKLHom34zDiNUYZKD0RVU4j3HYBlkCv3gLyhSlLwfvEKT1P8uoOwcy
         ig25aPPybc0vdT1XjIiLbIxPrSC+43ktVqvC9ZzUJoRSCQ7cqUJ/RolVrhAJ+bkg3R9R
         6koZyw9QHe/TPDGAZzI+tUgkwylUpm2MJNW0oAoWnrLitCxvwFx0S1H0nfXE8lmI80ti
         0JhtKKrErv6pK1MZnit70/fgA8ULuIfSQamLqFHQ5Zx/lfn/GRQrc0xQdpcyGnTsHANh
         hDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bg6ZSnruXgfVD4jOeLrAxIfhO0SIr3QdWxHbt31ZHm0=;
        b=PSLOU/YIGMq6DzcWOvx8ywE32P/EV4oeVlWg5VwDyN5dPZBH2J+FlJqGM+OZW7FFDD
         tgQxt+nbXsE6fIE2TYMBFccRPviB4xPCfL27BPleXoq89Pxj7e4ebuJ54WTkK26li9yp
         k4mcA5VELSrhFlilaTbVd0FZWZth6dIs+PpTUjQsh1uDxAfye9eCz0Zp0UXHJ1zAdaIU
         1NaHl8XCzSstczzPm2ernCGyE1FlXD3zXGtU4RnT2g4sZNJM8KT9B8ZTqeOJeBnE1RQt
         H9LajW2iEbKOgMEYQNYZ9n+UF6Dgm398NY3GoT5MoVtUueAAUbmmv1pv0yDDdk6ZuqAZ
         uHnQ==
X-Gm-Message-State: AOAM530x+fdBMSLL2ecNaMjrtYqZduvaQ38lbXBWPxziXzBTS5mylFmf
        rhsrvUDAe7nPcjb5tp7tYdBOXLo6esfvVOr8kxI=
X-Google-Smtp-Source: ABdhPJwKbxgkU1n6Xn85QkkRx6zEyLGBxhFrkTp3vrGLKMttYXJc3yhMLn21PwynsFE8wZfmeCgV0p192sI9a5vlXCE=
X-Received: by 2002:ac8:7c98:: with SMTP id y24mr3007479qtv.292.1613635043036;
 Wed, 17 Feb 2021 23:57:23 -0800 (PST)
MIME-Version: 1.0
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-3-git-send-email-shengjiu.wang@nxp.com> <20210208115112.GD8645@sirena.org.uk>
 <CAA+D8AMRGRRk6FzdiqaHAP1=dPJngNgmdGmU59vrroXA9BMyXw@mail.gmail.com>
 <20210209222953.GF4916@sirena.org.uk> <CAA+D8AN=SDMLhuNbstzHL_H2p_L6cr+oCXbauNB0gGs2BW5tmA@mail.gmail.com>
 <20210210153808.GB4748@sirena.org.uk>
In-Reply-To: <20210210153808.GB4748@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 18 Feb 2021 15:57:11 +0800
Message-ID: <CAA+D8ANdqd2W6xvwFuuk=YqUGCfuXCFzwO7tkhuGwzPRgA_A4g@mail.gmail.com>
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

On Wed, Feb 10, 2021 at 11:39 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Feb 10, 2021 at 02:35:29PM +0800, Shengjiu Wang wrote:
> > On Wed, Feb 10, 2021 at 6:30 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > Like I say I'd actually recommend moving this control to DAPM.
>
> > I may understand your point, you suggest to use the .set_bias_level
> > interface. But in my case I need to enable the clock in earlier stage
> > and keep the clock on when system go to suspend.
>
> The device can be kept alive over system suspend if that's needed, or
> possibly it sounds like runtime PM is a better fit?  There's callbacks
> in the core to keep the device runtime PM enabled while it's open which
> is probably about the time range you're looking for.

Before enabling the clock, I need to reparent the clock according to
the sample rate,  Maybe the hw_params is the right place to do
these things.

Can I add a flag:
"rpmsg->mclk_streams & BIT(substream->stream)"
for avoiding multiple calls of hw_params function before enabling
clock?
