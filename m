Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42AE34C0BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 02:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhC2AzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 20:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhC2Ay7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 20:54:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567E9C061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 17:54:59 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h10so12348527edt.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 17:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVAc9b+mBnGmiPe0hQUBS5bq7gPTXTsIqeLgC0QKuYo=;
        b=NoS1GIebv3iSWHAId4v66ODhmcXKQ/qQgeX+r/F705yNSzRoWkVkukYHE2U4SXzj7l
         3idkz2/42j4ZbHW78CX53X7tItXmV94qnWB5OdZOyQnbEsoGPsYkSWpOSMDnWm16M77n
         hxLk9rcJsK2WKGOofwpCR6fzZNHzRZZeic4Bas0Ki4nLhez/wE3QZpZS5gvML/zDm3gi
         g9leOVIkOl3WZlwloo/rXhtFJIOSID1WTvNwZfezLQYLQIB7EwNVLn3S61HwpAQcPDRX
         zaOUJcL6r/q364sBH0DBnzDGmlTYrO8r0TFMDJUmBAMxfPzwh2rVjOLSrojRZRucPjUH
         TVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVAc9b+mBnGmiPe0hQUBS5bq7gPTXTsIqeLgC0QKuYo=;
        b=cEyYc79Kj9Rr23zMVBQ8I0sWAGmNQI/e158fxHxMc7suXa20WjWVKhRv/+DWTW3+EG
         0Mg8piDpR8EQyHQ9T6JCeaJis/YNqwtRBfmd9GD0dtIbOZfgF7ZLoXrSimljdJ4gT92+
         tAxhki4g/gvT+TBljdkwu0GgXnag4OomOfMG+rizbqt3dfYt/g5gZlW20cnjIFTs6Gp/
         Xulz4USS0og4Q5I09ahyZXy086PgO8wGaC0JDEi3gn+y8Nv31XQzYiA4xYIUS3EJGSXS
         2Fs5Fysh8kvPfogBM+0O3uzrEAYeumM4ehAxLNhxQ/E7TVQbd2vyFDr1043uZq/aH3Rj
         5byg==
X-Gm-Message-State: AOAM530ml4wlOtq1oEPiSed7oTqAGJJT43CsHG/WdkmLEEFM2ZJUyS+t
        023U75lxF0sJeE7Gu0dXRfvVOSb++IbRI/+kVLUAqQ==
X-Google-Smtp-Source: ABdhPJx+4A/Txkzyq838knHsu1E43Gon6mva2bR+kHkuk+1ju7bFnu+zuJhSeTQ6qkrvnEusq0RO4FBMrBSodVEvcoE=
X-Received: by 2002:a05:6402:10c9:: with SMTP id p9mr26382778edu.268.1616979297849;
 Sun, 28 Mar 2021 17:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-8-brad@pensando.io>
 <CACRpkdZr8qrQ+b15z_zRP3wAntQeW7T0Z515sUv6e2gL9GzDyg@mail.gmail.com>
In-Reply-To: <CACRpkdZr8qrQ+b15z_zRP3wAntQeW7T0Z515sUv6e2gL9GzDyg@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 28 Mar 2021 17:54:47 -0700
Message-ID: <CAK9rFnw6cM9UsNoD1-37JfM0n2h6fATSTZYqAP0DBhwwigqBzA@mail.gmail.com>
Subject: Re: [PATCH 7/8] arm64: dts: Add Pensando Elba SoC support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 12:52 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Mar 4, 2021 at 4:42 AM Brad Larson <brad@pensando.io> wrote:
>
> > Add Pensando common and Elba SoC specific device nodes
> > and corresponding binding documentation.
> >
> > Signed-off-by: Brad Larson <brad@pensando.io>
> (...)
> >  .../bindings/gpio/pensando,elba-spics.txt     |  24 ++
>
> Please use YAML schema for this.

In patchset v2 changed to YAML schema and passed dt_binding_check and
dtbs_check.
