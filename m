Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF74932DAD1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 21:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbhCDUGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 15:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231616AbhCDUFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 15:05:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7379E64F76;
        Thu,  4 Mar 2021 20:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614888300;
        bh=RUOa+jhAmK+h73T8EOU9DsvhCI2E8Dn8FH/Ia3vJc3g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z/ZCNH1ifsYXMOqxSS+vwP879iLQBcDXyn1H/7QusIM5zsOkA7artXq5whqVPK460
         7A8gdRsO3HwpoqhfpDCn9iGRqzvTMilw5fXHzT0b3HmP24fJAfw30dabM/sqJQvBs1
         fFLMfhAu/Y34199XaYjzJcW8aJAwpR2Br+UMtU0KVQC0ZEQFbZXvMaUivSNKE0uO2p
         VjkgHAjNRqucjOwH4H1+d5MljrZ1OLodWXPUpx7JFxjcmivEpct/YbbN5rw83bDZPQ
         gJSXGku2c6Yn+AWwWafPqIIrHgnsrKILLqyJIqjZShQRaHDng7AjPyJpHk7RJOku0+
         WT8qKoRn+iwKg==
Received: by mail-ed1-f53.google.com with SMTP id x9so4815540edd.0;
        Thu, 04 Mar 2021 12:05:00 -0800 (PST)
X-Gm-Message-State: AOAM532jDliFN93BCzIL8gUF/O0+LrFQfX4rkAluzPhMj7/FIRZ5J+qQ
        ENRQJJ8kz4cqTjxLznC44+5AFhxLpcRclaEHyw==
X-Google-Smtp-Source: ABdhPJyT+WJus7T3jwrxrdTRd/Zm7drWY1Nq415cI9il3xyb1hXROafInBX/zusYrRdtrHQ0uWkFNttElXzFgzzJpBM=
X-Received: by 2002:aa7:d3d8:: with SMTP id o24mr6306044edr.165.1614888299086;
 Thu, 04 Mar 2021 12:04:59 -0800 (PST)
MIME-Version: 1.0
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-8-git-send-email-shengjiu.wang@nxp.com> <20210210221704.GA2894134@robh.at.kernel.org>
 <CAA+D8ANOv91jr4381Acz1B2mZ6=Mx2J_2CMTGXmPKztv7bMjPA@mail.gmail.com>
In-Reply-To: <CAA+D8ANOv91jr4381Acz1B2mZ6=Mx2J_2CMTGXmPKztv7bMjPA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 4 Mar 2021 14:04:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK1uc82hfdE4yj0ye-D6vygiqWkDVW96NOb-8kEFVqHMg@mail.gmail.com>
Message-ID: <CAL_JsqK1uc82hfdE4yj0ye-D6vygiqWkDVW96NOb-8kEFVqHMg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] ASoC: dt-bindings: imx-rpmsg: Add binding doc for
 rpmsg machine driver
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 1:23 AM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
>
> On Thu, Feb 11, 2021 at 6:18 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sun, Feb 07, 2021 at 06:23:55PM +0800, Shengjiu Wang wrote:
> > > Imx-rpmsg is a new added machine driver for supporting audio on Cortex-M
> > > core. The Cortex-M core will control the audio interface, DMA and audio
> > > codec, setup the pipeline, the audio driver on Cortex-A core side is just
> > > to communitcate with M core, it is a virtual sound card and don't touch
> > > the hardware.
> >
> > I don't understand why there are 2 nodes for this other than you happen
> > to want to split this into 2 Linux drivers. It's 1 h/w thing.
>
> This one is for the sound card machine driver.  Another one is
> for the sound card cpu dai driver. so there are 2 nodes.

You are explaining this to me in terms of drivers. Explain it in terms
of h/w blocks.

Rob
