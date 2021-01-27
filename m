Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FEB305E89
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhA0OnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbhA0Ome (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:42:34 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22473C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:41:54 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a10so2966605ejg.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DuOa7ZEsTI7Y364o/TcoZAKGbJr0jvsbyAw2/nr+qg4=;
        b=duXCWPaG3ZkgSVUzlFwMgG4NoT8oj+HYdl5VGOgUwN1C6zfjviGhPDVYvZ81cNFxmF
         6mERpEdHo36ackTZgSKHdTw01wWAPdgWmOh/Q/lP3bMdEGaiK5j5G+lOuJpBVb0/F/h2
         7EgR1Mqr1ZvGRvP1Kk2i1nxvj1qoiWuLEYmacafZ2yxmzDzdhdoJOPCIjTGkpFKHB+M0
         sjmiXHzlFZ+kiLSlchlSl9lIYVKEIXzbg9/FTXouutMU3Yn/nnZGYY9eFEUdl22IJzQO
         nxR6b+E1GUxgEM75eUSihWB71ahNsj2MoBWXaGpSuBwd3pKzoYlBjfw2wDLbiv1od1sx
         EH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DuOa7ZEsTI7Y364o/TcoZAKGbJr0jvsbyAw2/nr+qg4=;
        b=Xs8FdSyDnK2OVTHzLcxOzcDVmUV+uq/KI8bZrEhK7HjxbIDGUuoUs7s9lLBNUVUX2T
         xEW9ifL8MG2GVZ0PUMok8GFiwV+krvZlhq2wEpTRRu47xi4d1R5+MkZg6gjNmn/hUO96
         NBKk0677MuvuFk/Za7snawjFtgm2M2EpwbDc7VHFaVXJkBMTyvQm0rrF97XrKG2z1cGK
         uXCJ6pLtXSUiqBtFCPCzEsKEfIwBeAxJPFQQTuhIeVWLv7RoKwvsUzA0a4xmy2UG69lT
         j5s59CGglOtzzJKSG6hUM6EZbTuLdKeIS69Sn1ctfbXBLT9p8JvX3b2E7+EQDUx65Tsc
         YCng==
X-Gm-Message-State: AOAM530GpPmsCPU4cPuuRQ8O63MK5EA9HH0CFRVPt1taW7p/0Rw9Vcdb
        DwOJzLCTM+anJloTzm/6+zatpY1M3fKJ9+GKwwtucQ==
X-Google-Smtp-Source: ABdhPJysPwilf2kikwvGM0DJZGRBUU1uB0ZoL1FxDo8lL9H8tTMY2kUdkuafIucUFMixu3h8XhKrySdwI7H+CziTb0w=
X-Received: by 2002:a17:906:3146:: with SMTP id e6mr6787392eje.363.1611758512900;
 Wed, 27 Jan 2021 06:41:52 -0800 (PST)
MIME-Version: 1.0
References: <20210122185543.16554-1-digetx@gmail.com>
In-Reply-To: <20210122185543.16554-1-digetx@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 27 Jan 2021 15:41:42 +0100
Message-ID: <CAMpxmJW1V84a6JJ_nOcNOrPQD6q1BgYr=znZoWtzdoBvTyH3cA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Support building gpio-tegra driver as loadable module
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 7:59 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Hi,
>
> This small series adds modularization support to the gpio-tegra driver,
> i.e. driver now could be built as a loadable kernel module.
>
> Dmitry Osipenko (3):
>   gpio: tegra: Use debugfs_create_devm_seqfile()
>   gpio: tegra: Clean up whitespaces in tegra_gpio_driver
>   gpio: tegra: Support building driver as a loadable module
>
>  drivers/gpio/Kconfig      |  2 +-
>  drivers/gpio/gpio-tegra.c | 31 ++++++++++++++++---------------
>  2 files changed, 17 insertions(+), 16 deletions(-)
>
> --
> 2.29.2
>

Series applied, thanks!

Bartosz
