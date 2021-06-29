Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5A63B7457
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhF2OcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhF2OcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:32:01 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91ADC061760;
        Tue, 29 Jun 2021 07:29:32 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bu19so1180167lfb.9;
        Tue, 29 Jun 2021 07:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHqef71dDdDxk3wfRaTWaTfU7tVVIbFkB8emTOQrIgk=;
        b=DD6AvVlPOLU7jCcEcwbT5RmX4LwdW8BBJ1r3NutDgTTMwIquFn+u+OXkbRy9LbxE8G
         fD59LNz3i1LVSim55BZ05/m8x0MUQCZLuPcsZu/hks6xKbU9c19ApDrxAdZq6Dzs6nH4
         Ai2lFRKbuxmG+mU/irok5xdlcT1CimyvRK2LEjl/Lk5P42g3bXR6hWajugMgOhpDhufP
         OM9jNwrXjuWnOLhIeJ6n7EtffX5uwozOo4TsZlG2pJBvPop3acMXxu/AJV+AF3lEemFP
         Rm8scEMUp1BUhqgBuWVHmYI0FWy+kOPvR5xd+b/cGUkzB5daikJ3imAENjEv+ihJX/SS
         XfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHqef71dDdDxk3wfRaTWaTfU7tVVIbFkB8emTOQrIgk=;
        b=qMsEsWts1mv698Nz+o/yyUuH7V/Zd37aSrutAfyRtd3HQP38le+qJ6fz0NAhEw8YCy
         UdQUU685S44uk8c3yqskRJ4Yr5PjvbA4KFoNf96GO9YLalUK4JdT7iNKIlNUiynkA4GC
         iMmyDHsyjVY3L4QksVYFC7pU/P0//aThykjLZarnjY22KJbar3PxLLqNUH+K06CXlnx7
         8zDPlA8/EdFxkDydfjQnA1OFC9iPb1Eca/bUSBcFnWvljU+IJ8KMzlKWehmrOVaQPsuo
         K1tgRX7Lyyebtcc0dxqEiSCYSCMEGvmscwVHn2qlgu438UP+JOADG/pj7yYzOpFy3AFw
         NWQQ==
X-Gm-Message-State: AOAM532OESdyZxat1R9GcHBdqbkpQN9EGJH6DXWAH1BOCcwJJd5Xsu0h
        dDS9rFea7GwfPQ4qRdp8NqBkcm5kqrx2FPdvJtU=
X-Google-Smtp-Source: ABdhPJy513jd82VDfZeVelNPEbdavppAak0lBXBwcn8VKf5jzV3t/ROZl71UYC5G8yOhjjgNR0HhyjnTKnv3OV6GXYw=
X-Received: by 2002:a05:6512:219:: with SMTP id a25mr24912657lfo.295.1624976971092;
 Tue, 29 Jun 2021 07:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210604111005.6804-1-peng.fan@oss.nxp.com> <CAHCN7xKYooBQzREdoa8ybhQUBXxy6RPaFX9rp1keD7_HgnVA9Q@mail.gmail.com>
In-Reply-To: <CAHCN7xKYooBQzREdoa8ybhQUBXxy6RPaFX9rp1keD7_HgnVA9Q@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 29 Jun 2021 11:29:20 -0300
Message-ID: <CAOMZO5Bwmw7kjvqp253Xf3dafdG71p=nNy9XuqnJg2R4SD12tg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: add pgc/blk_ctl nodes
To:     Adam Ford <aford173@gmail.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Tue, Jun 29, 2021 at 10:36 AM Adam Ford <aford173@gmail.com> wrote:

> Any change you could add the references to pgc_otg1 and pgc_otg2 to
> their respective OTG nodes?  Without them, enabling OTG1 or OTG2 can
> result in a hang unless it was started in U-Boot.

There is a patch from Lucas doing that:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20200930155006.535712-12-l.stach@pengutronix.de/

Cheers
