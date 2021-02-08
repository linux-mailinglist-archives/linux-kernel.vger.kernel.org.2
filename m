Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CDF313237
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhBHMYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbhBHMG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:06:28 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E66DC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 04:05:48 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id g13so4583648uaw.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 04:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZWBJIaZ/bsVP6p7XHOvoxdJcCLoPklYQ4/+m3orfc4=;
        b=ZQCT0vdtAH18I54cmEsV7LzEgSzw9x7c4g7nvwzJL635j04pCobWhbKJOmCOiqN6r+
         5IkXAW8bGhbfC93gnmBHVgGR87pJ6HRwAa1IDLcZKt1Yqdr58G+VWlMgcoevYFCQquBw
         seer1lf9o+PtoGAZrIBT5QkB1awbktnaAuGJevTXBHBkyNvWitEHL8eSa5Vf8JJ1drVf
         Mw+g6Hg+zfhAPvbAJKEFMJppA9Vz3NcLyLueIlCcKFVOU/RunduQQ8lj1XD8s7xnpiJT
         r4l+03hhnI5FUihva78gdtAaat0pNPztOjdMYftJcbX6TtqwL1jrOz+spgRGcEzlPryj
         /cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZWBJIaZ/bsVP6p7XHOvoxdJcCLoPklYQ4/+m3orfc4=;
        b=aYSLAuIlNL0QLLhK6KKgb8O3N4FC0ELyQ4wkJX9LSlSErYNyDA+9fKxb4wCccuck8v
         LWnf3mAxnYMSPX4l2QeZ0EvFhUoSilUBFfC6gHZWvhcDAWEbwc05SbKBfVPkthAZSWhw
         MWZ6Cjxq6aXfyoqKAnumZnO+105206sbboA6x5C5PZ9KgNDvCRWz4n9+gWSNP6Q9Haex
         02as6K+e8X8qCanPaxOIIzwY3EA+DSxki6IXH0+QzNB7OxqVJ4/gLhy8cjrAKmJ+i4WX
         YHxnjWyHNnWoae4TRpsqF1Him6Y/4KU8+o06H/q6yX1XbhOkpXwxdlJt3hBHtglQfouk
         yvmw==
X-Gm-Message-State: AOAM530Egw5QmoHlP13ZkVes9DVfFg13bb6BiYIeHwH4qai+HBBRMtdB
        zUV2Ble2kLQh+IxreEpfW4ZibvDlDqG1XBaePejnVQ==
X-Google-Smtp-Source: ABdhPJwVrctWDibuLobFdPmbjaCLg1dsBCnjJJtNeM+WcG1vzq5+3yOxb/KoilqBgxHQtxtYVgdzhzPKRVER66jAF9Y=
X-Received: by 2002:ab0:2e8d:: with SMTP id f13mr9556269uaa.15.1612785946923;
 Mon, 08 Feb 2021 04:05:46 -0800 (PST)
MIME-Version: 1.0
References: <1611198593-16287-1-git-send-email-peng.fan@nxp.com> <DB6PR0402MB2760CA4A3D7DC4D5D6C3D81A88B09@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB2760CA4A3D7DC4D5D6C3D81A88B09@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Feb 2021 13:05:10 +0100
Message-ID: <CAPDyKFpWqVAzUwH_TEX7jyTFjZk3S4_9rBpSsdkghTfisSL7HA@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] imx esdhc dt/driver update
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Feb 2021 at 14:10, Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: [PATCH V2 0/4] imx esdhc dt/driver update
>
> Gentle ping..

I was expecting a new version from you to address the comment on the
DT bindings from Rob.

Otherwise this looks good to me.

Kind regards
Uffe

>
> Thanks,
> Peng.
>
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Patch V2:
> >  patch 1, 2, 3 is new
> >  patch 4 is not changed
> >
> > Peng Fan (4):
> >   dt-bindings: mmc: fsl-imx-esdhc: add pinctrl bindings
> >   dt-bindings: mmc: fsl-imx-esdhc: add clock bindings
> >   arm64: dts: imx8qxp: correct usdhc clock-names sequence
> >   mmc: sdhci-esdhc-imx: validate pinctrl before use it
> >
> >  .../bindings/mmc/fsl-imx-esdhc.yaml           | 36
> > +++++++++++++++++++
> >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 18 +++++-----
> >  drivers/mmc/host/sdhci-esdhc-imx.c            |  2 +-
> >  3 files changed, 46 insertions(+), 10 deletions(-)
> >
> > --
> > 2.28.0
>
