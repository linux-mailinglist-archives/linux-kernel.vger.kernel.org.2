Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AFE34DF4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhC3D2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhC3D1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:27:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FCCC0613D9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 20:27:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b7so22586113ejv.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 20:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1Mep0NDTZqgj41CwSzTV/L+FLNZGsP0ABu2o9b8U30=;
        b=3iJ6rnxNoJ1aTUrQb8MBityRh32IAoO48UjECVfi4BfI7/zw8eIa5QZsOXEdPj0Ult
         Ty+5a/+z0tH9MGN4pMs0E1CwVUioqhcepi7Lu84N7r0PBy5kF9ickSommc4x+k/a2Q7B
         5E293VfrAtZ/le8pjgcG94Y36E9PUx/WExrGl7fcifPHy0mLzvlaUp7FheK3iZx4EuNi
         xLS+LonWNrdG4ZdbOnJAxJSrspZk93opFaXsRh4zZX/Fj+TzE1GWOpuunFDm3ojdS1fg
         kI34Wh6qDZgX/BJt7lnSbqWQ9Hr7UdJ4czc18A6HG2VK+wbwPnHSNukupFvn+R7FyiIC
         4ApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1Mep0NDTZqgj41CwSzTV/L+FLNZGsP0ABu2o9b8U30=;
        b=qmzHldK5PaRMhefAM27B9aDsthjkBEDSS3FJN3jP7x1yGNJveeRajgPMhlMUlSpWFk
         sFw5FL9m1m/R8zznhpCF7eo0bqpXOBwNw0XvkW5slzFOIC9Hio7w6kn15tTZEYAkGlxn
         19GcqYm0/5eKkrylqhgx1VxTbmENTsYXLXs5W1Q5MvwFx8r1YfwrOxl/CJh+Ca+97n5d
         GgSSIgAYvm0LR/5IC/oq1UcUp5dh0RtXYZQ7et7+2fu653Q9XSCPIyTJokgpoXPyFGZT
         hd4v4cfbfAU0ntRr0SfS+e1xqqSvpAnki7PHIU5QAjMq1wq0ZK1bo8pn+cUW9t+9OXyp
         oT1w==
X-Gm-Message-State: AOAM532PHmV0ft91oSXMoRsTQUaaGUU08/HUoygRWH3cVLTMSI1qvylm
        W+NKt/kdqGwU0e3jju/NDXW0greYhtHs/o6Xqf5V9Q==
X-Google-Smtp-Source: ABdhPJxJVT4ikpn8Ll3+BLlxrg5DXp62plos3RcvXhSBKDJOAEk7g5/fDnEiJIF4vigHrmnSsJ9PwiqWINiWEhcCWS8=
X-Received: by 2002:a17:906:e0d6:: with SMTP id gl22mr30956801ejb.444.1617074870919;
 Mon, 29 Mar 2021 20:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-5-brad@pensando.io>
 <CAHp75VeQmc5ZyQV9AHcq2wm0xxBXb7by7RhidrRyCzmtRkXBAg@mail.gmail.com>
In-Reply-To: <CAHp75VeQmc5ZyQV9AHcq2wm0xxBXb7by7RhidrRyCzmtRkXBAg@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Mon, 29 Mar 2021 20:27:40 -0700
Message-ID: <CAK9rFnxO6AUjjihZ3Y+tspUZqCWhNa5BH5EhK2x4mk8FJv0k7w@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] spidev: Add Pensando CPLD compatible
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 3:45 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Mar 29, 2021 at 5:01 AM Brad Larson <brad@pensando.io> wrote:
> >
> > Pensando Elba SoC platforms have a SPI connected CPLD
> > for platform management.
>
> And? It's not a good justification to spread the (debugging only)
> spidev interface.
>
> What tool is going to use it? Why can't you have a driver for that in
> the kernel?

The driver is in userspace and we need to instantiate /dev/spi0.N
in the /dev directory.  The CPLD includes a device id and version
id that userspace applications use to differentiate functionality on
different boards.  It wouldn't really be appropriate to use one of
the existing entries.

For example even with high pin count SoCs we are offloading
low speed functionality into the CPLD connected over SPI.  The
elba-asic-common.dtsi file shows a compatible string of
"pensando,cpld-rd1173" which does have a kernel driver we
intend to contribute later if there is interest.  This IP in the CPLD
is readily available from Lattice which provides two I2C Masters
which in our case we use for access to the network port transceivers.
What was missing in the kernel was a bridge driver that exposes
what looks like a standard I2C device to userspace where the
drivers/i2c/busses/i2c-rd1173.c handles the spi transfers to the
Lattice IP in the CPLD.

>
> --
> With Best Regards,
> Andy Shevchenko
