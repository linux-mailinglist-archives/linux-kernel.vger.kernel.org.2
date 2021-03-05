Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19A032DFCB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 03:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhCECzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 21:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCECzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 21:55:37 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72134C061574;
        Thu,  4 Mar 2021 18:55:37 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id l4so700981qkl.0;
        Thu, 04 Mar 2021 18:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B6K7R4Bd/k7pKUFwYYEqKbrQpzoj3M/+hPbpG9mugKo=;
        b=LVLoAGKOykm/jC9af7pN4kyhfFsAcpvm9VLGQ0CXg0Se/SR35Oao/hkwdMYuxntVC7
         J8PVTeW0iWrkuoJKaUfkJjFMyKNvIPNeP4toVjX1ZIFubifotU2p+sArdZJWyEnqPH75
         Y9aUcSuSflX0iOPbsFK769CWeZ7IC98sOu0IPwL3onUjFtgic42u1FpwAONNbuEifkTD
         30fd4+jhh3OvFhY6949/pvO0jes6AfNqJoyTQzov/lvXL4NYk8jkujPxpxY5nyGz3fPT
         LWkSuVWVkzTK+K2qNZOSVrOTr3P/MkvZI7UxiEM/FXLkgD9AHSXBbGIolCXSlxMAhqwi
         OUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B6K7R4Bd/k7pKUFwYYEqKbrQpzoj3M/+hPbpG9mugKo=;
        b=A7ryWaBx5aShGANWp4K/VYOf7XH3Ugz5UAnk0U5YWAf9wWDN5+nN07qbEqWs1HyiXu
         N66whSrlDP6Lk7aPEd5hg+sDPQOag7mWauEBdXhKwvTXDMj3GKU0OJQ3X/AjR1hiSea0
         eu07oZ2hFV0KFGFFfgDvAzytl4O5ra1V6czjVUzELjEw6JWSDW1Ds3dui8CDA684IypF
         s/C/+YaUPeTIDK2Aacwz14Hbql5x+1NwKCmn5NIVyYpsKKuvPPzinPxLApJy63nqVLcm
         D5hz1hpaOnmSd4SWBFvG4sq3coL5t0IHK55j7JeeO2bsE/DHd79s6yGG09tDSClRYR3t
         GtHQ==
X-Gm-Message-State: AOAM531AQJUTxH8bSw6pfXnwIGYaPsXjcJ9AEjnzsoXHXaCLdpddDgER
        BKMo0Zjeurk6siv7ywDlv1E+f2wpveZPDK76aEo=
X-Google-Smtp-Source: ABdhPJxRI1kuyUugmvglxFPMew6mIeAnrVcTj55/x338nxC4x/s5QaheI/U88N1H58YRzxifmLj0W6Tq5BJQQdJ62Go=
X-Received: by 2002:a37:a282:: with SMTP id l124mr7167285qke.37.1614912936574;
 Thu, 04 Mar 2021 18:55:36 -0800 (PST)
MIME-Version: 1.0
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-8-git-send-email-shengjiu.wang@nxp.com> <20210210221704.GA2894134@robh.at.kernel.org>
 <CAA+D8ANOv91jr4381Acz1B2mZ6=Mx2J_2CMTGXmPKztv7bMjPA@mail.gmail.com> <CAL_JsqK1uc82hfdE4yj0ye-D6vygiqWkDVW96NOb-8kEFVqHMg@mail.gmail.com>
In-Reply-To: <CAL_JsqK1uc82hfdE4yj0ye-D6vygiqWkDVW96NOb-8kEFVqHMg@mail.gmail.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 5 Mar 2021 10:55:25 +0800
Message-ID: <CAA+D8AOP9L7eNHFMYrTscz0tPKMqU8Y0H5BtqyURmduhHgvGtw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] ASoC: dt-bindings: imx-rpmsg: Add binding doc for
 rpmsg machine driver
To:     Rob Herring <robh@kernel.org>
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

Hi

On Fri, Mar 5, 2021 at 4:05 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Feb 18, 2021 at 1:23 AM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
> >
> > On Thu, Feb 11, 2021 at 6:18 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Sun, Feb 07, 2021 at 06:23:55PM +0800, Shengjiu Wang wrote:
> > > > Imx-rpmsg is a new added machine driver for supporting audio on Cortex-M
> > > > core. The Cortex-M core will control the audio interface, DMA and audio
> > > > codec, setup the pipeline, the audio driver on Cortex-A core side is just
> > > > to communitcate with M core, it is a virtual sound card and don't touch
> > > > the hardware.
> > >
> > > I don't understand why there are 2 nodes for this other than you happen
> > > to want to split this into 2 Linux drivers. It's 1 h/w thing.
> >
> > This one is for the sound card machine driver.  Another one is
> > for the sound card cpu dai driver. so there are 2 nodes.
>
> You are explaining this to me in terms of drivers. Explain it in terms
> of h/w blocks.
>

Yes, there is only 1 h/w block, which is (MU) message unit

As the sound card needs a cpu dai node and sound card node,
so from the driver's perspective, I use two nodes.

Seems It is hard to only use one node for my case.
or do you have any suggestions?

Best regards
Wang shengjiu
