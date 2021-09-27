Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F9D41A30C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbhI0WeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbhI0WeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:34:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE2DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:32:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z24so84962279lfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SAV2dI3X88ydfOMXbonZID2jQP48rETdyvNKxKLYNPg=;
        b=iOQKOZoBWu6aAtqdhuJBCPRE0R9IxoWYPjReXHRRDRkl5u0y3z+S++TOtHmkW418HH
         k+AXre6ePRj3ux1vuM+IBe/IHdZp31blTPXkVv00rYvqmvbSVz2Puuo6XN9q/SU0yJSP
         U9AnY2+DFE+bV4bYhz5raBwMjZSqYV3kTXOscgQyeiH+MxKkNTk1/rSJdEQM5uRMNhrr
         NFwkFu84W+kT5iiMt7st56R0oBbwGZ0lQd9/XVCy83d27KY7VCu3pheHI0PzUyhOcIPt
         x3UhcbrX4yIJLF/u8CsrGeGbHhfBS4MXjrSNbyjuCAzqmOQZqbS4VqvYDx1a4f3rgLxj
         jWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAV2dI3X88ydfOMXbonZID2jQP48rETdyvNKxKLYNPg=;
        b=ASnhPiJmWBUSmUF3kjtODF9Ufw1O9gb4hInMlRFZRdQfNH7SZfL/HipjIOvkioz8Zx
         44c+xF5tYlnROt30NcYJNKZ+lZLRlqBiIOosdV4yYulCFBGUvK1xLIO0JRKRt1r3Dhw5
         2EZqNbTY1I4AV430+H2fcsLW3tpYIUX9thVhba2dt+jxNyZVq6EJFqIaz4oKScJ3+ojz
         uU8s0TI6ppojYZeByTnXl0D4YQ/EH5IDheU6wRixkPC1Z5gQ2DmsIDWy5+jhGo7mvbP+
         vUsv7tL76MeLz0I33dxcZbtmInpvE67TMdCJBNLC9xMsxkzGOqu3/1QGmlmdI74UCWym
         SpGA==
X-Gm-Message-State: AOAM53102hPCrpqfEKQCu1tMxy+rUJZZ2ln9At2dTtwsjaPpClzerYxC
        umbrOSqVTNfYqWo29839amF0+uJs/3boTl2dmPt/rw==
X-Google-Smtp-Source: ABdhPJxKf8OveAlrAasR+aFk/YGcU6+uIQU0IZmKf/y0+7GbA0Rb/fU7JxpeqlFoOuE6gM97daTIsD26XiHsH04vjDs=
X-Received: by 2002:a05:651c:213:: with SMTP id y19mr2270930ljn.273.1632781946357;
 Mon, 27 Sep 2021 15:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210924082851.2132068-1-claudiu.beznea@microchip.com>
In-Reply-To: <20210924082851.2132068-1-claudiu.beznea@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Sep 2021 00:31:50 +0200
Message-ID: <CAPDyKFptb5infBgd1zEQC03kH3Z2sO8zvxV6LMO1fLtk5NZFkw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: sdhci-of-at91: fix for shdci-of-at91
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sept 2021 at 10:29, Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:
>
> Hi,
>
> This series adds a fix for sdhci-of-at91 driver (patch 1/2). Along with
> it patch 2/2 replaces a while loop + timeout with read_poll_timeout().
>
> Changes in v2:
> - use read_poll_timeout() in patch 1/2
> - add patch 2/2
>
> Claudiu Beznea (2):
>   mmc: sdhci-of-at91: wait for calibration done before proceed
>   mmc: sdhci-of-at91: replace while loop with read_poll_timeout
>
>  drivers/mmc/host/sdhci-of-at91.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>

Applied for fixes and by adding tags for stable, thanks!

Kind regards
Uffe
