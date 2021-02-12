Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A07319BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhBLJ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhBLJ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:27:32 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291BBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 01:26:52 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id e18so10706297lja.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 01:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYyTdHiOphi5wy20sCohGohSDGJFzJ14qi5hSzM5U+A=;
        b=Wo5odOySF/CFjO72mwfuehexVpDt5boeTBrjIi8eYdCX5x91Ji2sDZLyQY0eiM1n7J
         JR2GkNIaK5Y3PyjM+xg4Dkaublh/xAdcOhoNGhuS5QTsZikUhv+DZprC9Q25ghrVeerl
         jh2sYwpMfJcWeG1pUt0h6qPLrHnYxwzUpkWdWKWmYwNcWDRRILxxRh/P87sZR8ZIHQMB
         dqqwC1BFHhlq+4x++uWHc6z4Cl4Pse2K7iluG4dEEQ0pCh6UylDjSgKVkQ2kr/SjbCQo
         exvFjK6ZWi2hKR9YxMWiLG449QDlyi1psLns9RExwklkzgPexbJ4O198qXtn4aOou7Ff
         m9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYyTdHiOphi5wy20sCohGohSDGJFzJ14qi5hSzM5U+A=;
        b=l7zGFEaQWDYO78E2ud5eB2tXraOrxpCuUeIhOfoLvkiB3b7lF+fiv6gMO/qsUG/2wZ
         RiVmOSpoyAO+hCRv8UCo1tJYCBuUoHzrPUPe0Sr/OCnNf+QSCtWqljjutnGGyO0ITuQE
         NJzkoiNgbiUJY0Br6nPMeotcc2TzfY/43zxFnOlLR5Cix+rLEUGvsHjPOT6Pa+xYnkzk
         ZZBgNpN4Bas7pcWXMQ9mpiQHXK7ZSp8lilHNL73FFw9IbLTF8BfCdT/IE44ZOXPD0gUm
         i9F98HKL7X0p8OeK/KPIeHypgjoIEMkRaCdHoxaAZiLN5NKfNVjQ4Ru2IciMdCX/SZIX
         Peow==
X-Gm-Message-State: AOAM532EWOdaHhldZ9I4Jgyak40MWlqt0xcLU3DcD7liT3+X1uRwZ7L6
        wewEBlBGikSpM5F7bQ3Azt45Rz04m67uhkrEUdy+FA==
X-Google-Smtp-Source: ABdhPJyTM3mAjXEWmeU9qHDaKPjX79dsGxohgA/kWmyN9gOGAk4Q6lBeaCJkUYRDfjmJdhz1GKgMtr5vBbKYhePpE30=
X-Received: by 2002:a2e:6c17:: with SMTP id h23mr1222875ljc.326.1613122010712;
 Fri, 12 Feb 2021 01:26:50 -0800 (PST)
MIME-Version: 1.0
References: <20210208135347.18494-1-o.rempel@pengutronix.de> <20210208135347.18494-3-o.rempel@pengutronix.de>
In-Reply-To: <20210208135347.18494-3-o.rempel@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Feb 2021 10:26:39 +0100
Message-ID: <CACRpkdZ5ZQDcy5RP=CVPJ14Lyktw_4yOuELJRweeDpPKRL3RVA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] counter: add IRQ or GPIO based event counter
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 2:53 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Add simple IRQ or GPIO base event counter. This device is used to measure
> rotation speed of some agricultural devices, so no high frequency on the
> counter pin is expected.
>
> The maximal measurement frequency depends on the CPU and system load. On
> the idle iMX6S I was able to measure up to 20kHz without count drops.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

From GPIO and interrupt point of view this driver looks good to me.
I don't know about the userspace interface etc.

Yours,
Linus Walleij
