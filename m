Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E90240F3EC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbhIQISX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhIQISW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:18:22 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFDEC061574;
        Fri, 17 Sep 2021 01:17:00 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h20so9417350ilj.13;
        Fri, 17 Sep 2021 01:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtpqFAJFQ9+m0BVdxSrQHgINETdk+aytTPKay73RJFM=;
        b=D+V+k1wWU97jD4bcghxFDK3XAVQhbAtctoqoiTJRe9RHKAPvrhzQM+cJkWTr3BmyFY
         0Ej5ykU1PbDnl1m/P+igxwe48lLzB33Yni2FR6i5KLKXqljQzwrxBZnI4zKP1/wZHkbA
         EtsqS8DodJQZoK9zKfALtG3QQLs9+ckcExYdx8jQgpwaOrGnW16UQGVYmFo3fSmy7hyb
         o0VKiohbgjAA1riT3klUAufSnlAk76fytjlm5uI/0sH5ihkkEOBxsMu+5GqAVkersxKa
         W8JWSIMndxhk1VPLy9RR/6WbNY5uGsNQdnni59e0rq5gdYNAhzZNLDEpDZuE0CGd3T6A
         8+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtpqFAJFQ9+m0BVdxSrQHgINETdk+aytTPKay73RJFM=;
        b=s+9rI2g6OLwM4jA8CCfvyaXhd2nfOzDvcM/JgFgGejViv6dAONGxFYj7GUwGIwa1Jj
         ddtK8V3jQbNu0q+M4OFA1vm2eq3MwU8QcUAnRwcCDcOSEblKNIEU0tT/4WKcQ7mU/6ne
         y63LTt5bqvLjN6kriGApk5JczFWU3xA9qKJ+GMxfqMQTvXMuHwH34HEO12IpGKxsFBuM
         xSSOX14ba8v4vWonrURnqIySi8zVx1ckU/xSG53jtcWF34P1D6XcWks8TKlEIhpmU691
         n7nL0iiqd4u+WogQ0m1znH4ucGFvvNnRCemlUs1fKkjqxDEmfbJTHccMT/pH1Q+joKRJ
         YQGg==
X-Gm-Message-State: AOAM532cseAj/eqcpB+mqDbXZOBWfxNQDBx3zQtD6Ft6KnuXcvrioI6y
        pwgs9aBXp07+O5UvjBrCcS3DWNgPDBazIXfTdPc=
X-Google-Smtp-Source: ABdhPJzfproym1KZEKvynMCWXL8DhJ5lXG110okss77gSgINn1wXfnxjLH1UgabPqqDBjQrXyUtpFWyGC5Xq6EE1JS0=
X-Received: by 2002:a05:6e02:964:: with SMTP id q4mr7280412ilt.290.1631866620219;
 Fri, 17 Sep 2021 01:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210818154449.1037-1-alistair@alistair23.me>
In-Reply-To: <20210818154449.1037-1-alistair@alistair23.me>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 17 Sep 2021 18:15:00 +1000
Message-ID: <CAKmqyKPsxNS1px4-+nFNNAm6MTYApASTZ_XdvL+adTBvBtqSpg@mail.gmail.com>
Subject: Re: [PATCH v11 00/10] Add support for the silergy,sy7636a
To:     Alistair Francis <alistair@alistair23.me>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 9:15 PM Alistair Francis <alistair@alistair23.me> wrote:
>
> This series applied on top of the "mfd: simple-mfd-i2c: Add support for
> registering devices via MFD cells" patch. Once "mfd: simple-mfd-i2c: Add
> support for registering devices via MFD cells" is merged this series is
> ready to go.
>
> v11:
>  - Address comments on hwmon
>  - Improve "mfd: simple-mfd-i2c: Add a Kconfig name" commit message
> v10:
>  - Use dev_get_regmap() instead of dev_get_drvdata()
> v9:
>  - Convert to use the simple-mfd-i2c instead
>
> Alistair Francis (10):
>   dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
>   mfd: simple-mfd-i2c: Add a Kconfig name
>   mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
>   regulator: sy7636a: Remove requirement on sy7636a mfd
>   thermal: sy7636a: Add thermal driver for sy7636a
>   hwmon: sy7636a: Add temperature driver for sy7636a
>   ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
>   ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
>   ARM: imx_v6_v7_defconfig: Enable backlight class devices
>   ARM: dts: imx7d: remarkable2: Enable lcdif

It doesn't look like "mfd: simple-mfd-i2c: Add support for registering
devices via MFD cells" has made it into 5.15, is something else
required?

Alistair

>
>  .../bindings/mfd/silergy,sy7636a.yaml         |  79 ++++++++++++
>  arch/arm/boot/dts/imx7d-remarkable2.dts       | 115 ++++++++++++++++++
>  arch/arm/configs/imx_v6_v7_defconfig          |   5 +
>  drivers/hwmon/Kconfig                         |  10 ++
>  drivers/hwmon/Makefile                        |   1 +
>  drivers/hwmon/sy7636a-hwmon.c                 |  77 ++++++++++++
>  drivers/mfd/Kconfig                           |   2 +-
>  drivers/mfd/simple-mfd-i2c.c                  |  12 ++
>  drivers/regulator/Kconfig                     |   1 -
>  drivers/regulator/sy7636a-regulator.c         |   2 +-
>  drivers/thermal/Kconfig                       |   6 +
>  drivers/thermal/Makefile                      |   1 +
>  drivers/thermal/sy7636a_thermal.c             |  94 ++++++++++++++
>  include/linux/mfd/sy7636a.h                   |  41 +++++++
>  14 files changed, 443 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
>  create mode 100644 drivers/hwmon/sy7636a-hwmon.c
>  create mode 100644 drivers/thermal/sy7636a_thermal.c
>  create mode 100644 include/linux/mfd/sy7636a.h
>
> --
> 2.31.1
>
